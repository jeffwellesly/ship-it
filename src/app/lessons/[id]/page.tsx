import type { ReactNode } from 'react'
import { createClient } from '@/lib/supabase/server'
import { redirect, notFound } from 'next/navigation'
import Link from 'next/link'
import LessonQuiz from './LessonQuiz'

type ModuleLesson = { id: string; title: string; sort_order: number }

// Renders **bold** inline markdown
function renderInline(text: string): ReactNode[] {
  return text.split(/(\*\*[^*]+\*\*)/).map((part, i) =>
    part.startsWith('**') && part.endsWith('**')
      ? <strong key={i} className="font-semibold text-[#e0deff]">{part.slice(2, -2)}</strong>
      : part
  )
}

// Parses lesson content:
//   >> sentence        → pull quote (large, purple left border)
//   [!] sentence       → callout box (purple-tinted)
//   **term**           → bold key term inline
//   ALL CAPS line      → section label (muted, uppercase, small)
//   2-space indent     → monospace code block
//   blank line         → paragraph / block break
function LessonContent({ content }: { content: string }) {
  const blocks: ReactNode[] = []
  let paraLines: string[] = []
  let codeLines: string[] = []
  let key = 0

  const flushPara = () => {
    const text = paraLines.join(' ').trim()
    if (text) {
      blocks.push(
        <p key={key++} className="text-[15px] text-[#aaa] leading-[1.8] mb-5">
          {renderInline(text)}
        </p>
      )
    }
    paraLines = []
  }

  const flushCode = () => {
    if (codeLines.length === 0) return
    const stripped = codeLines.map(l => l.replace(/^ {2}/, ''))
    blocks.push(
      <div key={key++} className="my-3 rounded-lg bg-[#1c1c1f] border border-[#2e2e32] px-4 py-3 overflow-x-auto">
        {stripped.map((l, i) => (
          <p key={i} className="text-[13px] font-mono text-[#ccc] leading-relaxed whitespace-pre">{l || ' '}</p>
        ))}
      </div>
    )
    codeLines = []
  }

  for (const raw of content.split('\n')) {
    const line = raw.trimEnd()

    if (line.startsWith('>> ')) {
      flushPara(); flushCode()
      blocks.push(
        <blockquote key={key++} className="my-7 pl-5 border-l-[3px] border-[#7F77DD]">
          <p className="text-[19px] font-medium text-white leading-[1.55]">
            {renderInline(line.slice(3))}
          </p>
        </blockquote>
      )
    } else if (line.startsWith('[!] ')) {
      flushPara(); flushCode()
      blocks.push(
        <div
          key={key++}
          className="my-5 flex gap-3 rounded-xl border border-[#7F77DD]/20 px-4 py-4"
          style={{ background: 'rgba(127,119,221,0.07)' }}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="16" height="16"
            viewBox="0 0 24 24"
            fill="none"
            stroke="#9b93f0"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
            className="flex-shrink-0 mt-0.5"
            aria-hidden="true"
          >
            <circle cx="12" cy="12" r="10" />
            <path d="M12 16v-4m0-4h.01" />
          </svg>
          <p className="text-[14px] text-[#b8b4f0] leading-[1.7]">
            {renderInline(line.slice(4))}
          </p>
        </div>
      )
    } else if (line === '') {
      flushPara(); flushCode()
    } else if (line.startsWith('  ')) {
      // 2-space indent → code line; flush any pending prose first
      flushPara()
      codeLines.push(line)
    } else if (paraLines.length === 0 && codeLines.length === 0 && line.length >= 4 && !/[a-z]/.test(line)) {
      // Standalone ALL-CAPS line → section label
      blocks.push(
        <p key={key++} className="text-[11px] font-medium tracking-[0.08em] uppercase text-[#555] mt-7 mb-1.5">
          {line}
        </p>
      )
    } else {
      // Regular prose
      flushCode()
      paraLines.push(line)
    }
  }
  flushPara(); flushCode()
  flushPara()

  return <>{blocks}</>
}

export default async function LessonPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) redirect('/login')

  // Batch 1: lesson + questions + profile (no interdependencies)
  const [{ data: lesson }, { data: questions }, { data: profile }] = await Promise.all([
    supabase
      .from('lessons')
      .select('*, modules(id, title, sort_order, course_id)')
      .eq('id', id)
      .single(),
    supabase.from('questions').select('*').eq('lesson_id', id),
    supabase.from('profiles').select('total_xp').eq('id', user.id).single(),
  ])

  if (!lesson) notFound()

  const mod = lesson.modules as unknown as {
    id: string; title: string; sort_order: number; course_id: string
  } | null
  const modId = (lesson as Record<string, unknown>).module_id as string | null

  // Batch 2: all user progress + all lessons in this module
  const [{ data: allProgress }, { data: rawModuleLessons }] = await Promise.all([
    supabase.from('user_progress').select('lesson_id').eq('user_id', user.id),
    modId
      ? supabase.from('lessons').select('id, title, sort_order').eq('module_id', modId).order('sort_order')
      : Promise.resolve({ data: null as ModuleLesson[] | null, error: null }),
  ])

  const completedIds = new Set(allProgress?.map((p) => p.lesson_id) ?? [])
  const alreadyCompleted = completedIds.has(id)
  const xp = profile?.total_xp ?? 0

  const moduleLessons: ModuleLesson[] = (rawModuleLessons as ModuleLesson[] | null) ?? []
  const sortedLessons = [...moduleLessons].sort((a, b) => a.sort_order - b.sort_order)
  const currentIdx = sortedLessons.findIndex((l) => l.id === id)

  // Next lesson: next in module, or first lesson of next module
  let nextLessonId: string | null = null
  if (currentIdx !== -1 && currentIdx < sortedLessons.length - 1) {
    nextLessonId = sortedLessons[currentIdx + 1].id
  } else if (mod) {
    const { data: nextModule } = await supabase
      .from('modules')
      .select('id, lessons(id, sort_order)')
      .eq('course_id', mod.course_id)
      .gt('sort_order', mod.sort_order)
      .order('sort_order')
      .limit(1)
      .maybeSingle()

    if (nextModule) {
      const nml = nextModule.lessons as unknown as { id: string; sort_order: number }[]
      if (nml?.length) {
        nextLessonId = [...nml].sort((a, b) => a.sort_order - b.sort_order)[0].id
      }
    }
  }

  return (
    <div className="min-h-screen bg-[#0c0c0c]">

      {/* Nav */}
      <div className="border-b border-[#2a2a2e]">
        <div className="max-w-3xl mx-auto px-7 py-[18px] flex items-center justify-between">
          <Link
            href={mod ? `/courses/${mod.course_id}` : '/courses'}
            className="text-[14px] text-[#888] hover:text-white transition-colors"
          >
            ← Back to course
          </Link>
          <div className="flex items-center gap-1.5 bg-[#1c1c1f] border border-[#3a2e1a] rounded-full px-3.5 py-1.5">
            <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#EF9F27" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M13 3l-7 10h6l-1 8 7-10h-6l1-8z" />
            </svg>
            <span className="text-[13px] font-medium text-[#FAC775]">{xp} XP</span>
          </div>
        </div>
      </div>

      {/* Two-column layout */}
      <div className="max-w-3xl mx-auto px-7 py-7 flex gap-10 items-start">

        {/* Main content column */}
        <div className="flex-1 min-w-0">

          {/* Lesson content card */}
          <div className="bg-[#151517] border border-[#2a2a2e] rounded-2xl p-7 mb-5">

            {/* Breadcrumb */}
            {mod && (
              <div className="flex items-center gap-1.5 mb-4 min-w-0">
                <span className="text-[11px] font-medium tracking-[0.08em] text-[#7F77DD] uppercase whitespace-nowrap flex-shrink-0">
                  Module {mod.sort_order}
                </span>
                <span className="text-[11px] text-[#333] flex-shrink-0">·</span>
                <span className="text-[11px] text-[#555] truncate min-w-0">{mod.title}</span>
              </div>
            )}

            <h1 className="text-[22px] font-medium text-white mb-6">{lesson.title}</h1>

            <LessonContent content={(lesson as Record<string, unknown>).content as string ?? ''} />
          </div>

          <LessonQuiz
            lessonId={lesson.id}
            questions={questions ?? []}
            alreadyCompleted={alreadyCompleted}
            nextLessonId={nextLessonId}
            isGuest={user.is_anonymous ?? false}
          />
        </div>

        {/* Progress rail */}
        {sortedLessons.length > 0 && (
          <aside className="hidden md:block w-48 flex-shrink-0">
            <div className="sticky top-6">
              {mod && (
                <p className="text-[11px] font-medium tracking-[0.06em] text-[#9b93f0] uppercase mb-3">
                  {mod.title}
                </p>
              )}
              <div className="space-y-0.5">
                {sortedLessons.map((l) => {
                  const isDone = completedIds.has(l.id)
                  const isCurrent = l.id === id
                  return (
                    <Link
                      key={l.id}
                      href={`/lessons/${l.id}`}
                      className={`flex items-start gap-2.5 px-2.5 py-2 rounded-lg transition-colors ${
                        isCurrent ? 'bg-[#1c1c1f]' : 'hover:bg-[#151517]'
                      }`}
                    >
                      <div className="flex-shrink-0 mt-[3px]">
                        {isDone ? (
                          <div className="w-4 h-4 rounded-full bg-emerald-900/50 flex items-center justify-center">
                            <svg width="8" height="8" viewBox="0 0 12 12" fill="none" stroke="#34d399" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                              <path d="M2 6l3 3 5-5" />
                            </svg>
                          </div>
                        ) : isCurrent ? (
                          <div className="w-4 h-4 rounded-full border-2 border-[#7F77DD] flex items-center justify-center">
                            <div className="w-1.5 h-1.5 rounded-full bg-[#7F77DD]" />
                          </div>
                        ) : (
                          <div className="w-4 h-4 rounded-full border border-[#2e2e32]" />
                        )}
                      </div>
                      <span className={`text-[12px] leading-snug ${
                        isCurrent ? 'text-white' : isDone ? 'text-[#555]' : 'text-[#3a3a3a]'
                      }`}>
                        {l.title}
                      </span>
                    </Link>
                  )
                })}
              </div>
            </div>
          </aside>
        )}

      </div>
    </div>
  )
}
