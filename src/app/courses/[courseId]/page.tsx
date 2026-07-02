import { createClient } from '@/lib/supabase/server'
import { redirect, notFound } from 'next/navigation'
import Link from 'next/link'

type RawLesson = { id: string; title: string; sort_order: number }
type RawModule = { id: string; title: string; description: string; sort_order: number; lessons: RawLesson[] }

type LessonWithStatus = RawLesson & { completed: boolean }
type ModuleWithStatus = Omit<RawModule, 'lessons'> & {
  lessons: LessonWithStatus[]
  complete: boolean
  completedCount: number
}

function computeStatuses(rawModules: RawModule[], completedIds: Set<string>): ModuleWithStatus[] {
  return [...rawModules]
    .sort((a, b) => a.sort_order - b.sort_order)
    .map((mod) => {
      const lessons = [...mod.lessons]
        .sort((a, b) => a.sort_order - b.sort_order)
        .map((l) => ({ ...l, completed: completedIds.has(l.id) }))
      const completedCount = lessons.filter((l) => l.completed).length
      return { ...mod, lessons, complete: completedCount === lessons.length && lessons.length > 0, completedCount }
    })
}

export default async function CourseDetailPage({
  params,
}: {
  params: Promise<{ courseId: string }>
}) {
  const { courseId } = await params
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) redirect('/login')

  const [{ data: course }, { data: rawModules }, { data: progress }, { data: profile }] =
    await Promise.all([
      supabase.from('courses').select('id, title, description, icon').eq('id', courseId).single(),
      supabase
        .from('modules')
        .select('id, title, description, sort_order, lessons(id, title, sort_order)')
        .eq('course_id', courseId)
        .order('sort_order'),
      supabase.from('user_progress').select('lesson_id').eq('user_id', user.id),
      supabase.from('profiles').select('total_xp').eq('id', user.id).single(),
    ])

  if (!course) notFound()

  const completedIds = new Set(progress?.map((p) => p.lesson_id) ?? [])
  const modules = computeStatuses((rawModules as unknown as RawModule[]) ?? [], completedIds)
  const totalLessons = modules.flatMap((m) => m.lessons).length
  const completedLessons = modules.reduce((acc, m) => acc + m.completedCount, 0)
  const pct = totalLessons > 0 ? (completedLessons / totalLessons) * 100 : 0
  const totalModules = modules.length
  const completedModules = modules.filter((m) => m.complete).length
  const xp = profile?.total_xp ?? 0

  // First incomplete module index (for default open + CTA)
  const currentModuleIdx = modules.findIndex((m) => !m.complete)
  const openIdx = currentModuleIdx === -1 ? 0 : currentModuleIdx
  const currentModule = modules[openIdx]
  const firstIncompleteLesson = currentModule?.lessons.find((l) => !l.completed) ?? currentModule?.lessons[0]

  return (
    <div className="min-h-screen bg-[#0c0c0c] pb-28">

      {/* Nav */}
      <div className="border-b border-[#1e1e22]">
        <div className="max-w-sm mx-auto px-7 py-[18px] flex items-center justify-between">
          <Link href="/courses" className="flex items-center gap-1.5 text-[13px] text-[#888] hover:text-white transition-colors">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M15 18l-6-6 6-6" />
            </svg>
            Courses
          </Link>
          <div className="flex items-center gap-1.5 bg-[#1c1c1f] border border-[#3a2e1a] rounded-full px-3.5 py-1.5">
            <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#EF9F27" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M13 3l-7 10h6l-1 8 7-10h-6l1-8z" />
            </svg>
            <span className="text-[13px] font-medium text-[#FAC775]">{xp} XP</span>
          </div>
        </div>
      </div>

      {/* Compact hero */}
      <div className="max-w-sm mx-auto px-7 py-7 border-b border-[#1e1e22]">
        <div className="flex gap-4 items-start">
          <div
            className="w-[52px] h-[52px] rounded-[14px] flex items-center justify-center flex-shrink-0"
            style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)', boxShadow: '0 4px 20px rgba(127,119,221,0.3)' }}
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M4 13a8 8 0 0 1 7 7 6 6 0 0 0 3 -5 9 9 0 0 0 6 -8 3 3 0 0 0 -3 -3 9 9 0 0 0 -8 6 6 6 0 0 0 -5 3" />
              <path d="M7 14a6 6 0 0 0 -3 6 6 6 0 0 0 6 -3" />
              <circle cx="15" cy="9" r="1" fill="white" stroke="none" />
            </svg>
          </div>
          <div className="flex-1 min-w-0">
            <p className="text-[11px] font-semibold tracking-[0.07em] text-[#9b93f0] uppercase mb-1">
              {completedModules === 0 ? 'Start learning' : `${completedModules} of ${totalModules} modules done`}
            </p>
            <h1 className="text-[20px] font-medium text-white leading-snug mb-1.5">{course.title}</h1>
            <p className="text-[13px] text-[#666] leading-relaxed mb-4">{course.description}</p>
            <div className="flex items-center gap-3">
              <div className="flex-1 h-[5px] bg-[#1e1e22] rounded-full overflow-hidden">
                <div
                  className="h-full rounded-full transition-all"
                  style={{ width: `${pct}%`, background: 'linear-gradient(90deg,#7F77DD,#534AB7)' }}
                />
              </div>
              <span className="text-[12px] text-[#555] flex-shrink-0">{completedModules} of {totalModules} modules</span>
            </div>
          </div>
        </div>
      </div>

      {/* Module list */}
      <div className="max-w-sm mx-auto px-7 py-5 flex flex-col gap-2">
        {modules.map((mod, i) => {
          return (
            <details
              key={mod.id}
              className="group bg-[#151517] border border-[#2a2a2e] rounded-[14px] overflow-hidden"
            >
              <summary className="px-[18px] py-4 flex items-center justify-between gap-3 cursor-pointer list-none select-none hover:bg-[#1a1a1d] transition-colors">
                <div className="flex items-center gap-3 min-w-0">
                  {/* Number badge */}
                  <div
                    className="w-8 h-8 rounded-[10px] flex items-center justify-center flex-shrink-0 text-[13px] font-semibold text-white"
                    style={mod.complete
                      ? { background: '#1a3a2a', color: '#34d399' }
                      : { background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }
                    }
                  >
                    {mod.complete
                      ? <svg width="14" height="14" viewBox="0 0 12 12" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><path d="M2 6l3 3 5-5" /></svg>
                      : mod.sort_order
                    }
                  </div>
                  <div className="min-w-0">
                    <p className="text-[14px] font-medium text-white leading-snug">
                      {mod.title.replace(/^Module\s+\d+\s*[:\-]\s*/i, '')}
                    </p>
                    <p className="text-[12px] text-[#555] mt-0.5">{mod.lessons.length} lessons</p>
                  </div>
                </div>
                <div className="flex items-center gap-2 flex-shrink-0">
                  <span className={`text-[11px] font-medium px-2.5 py-1 rounded-full whitespace-nowrap ${
                    mod.complete
                      ? 'bg-emerald-900/30 text-emerald-400'
                      : 'text-[#9b93f0] bg-[#1e1b3a]'
                  }`}>
                    {mod.complete ? '✓ Done' : `${mod.completedCount}/${mod.lessons.length}`}
                  </span>
                  <svg
                    xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24"
                    fill="none" stroke="#555" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"
                    className="transition-transform duration-200 group-open:rotate-180 flex-shrink-0"
                    aria-hidden="true"
                  >
                    <path d="M6 9l6 6 6-6" />
                  </svg>
                </div>
              </summary>

              {/* Lessons */}
              <div className="border-t border-[#2a2a2e]">
                {mod.lessons.map((lesson, idx) => (
                  <Link
                    key={lesson.id}
                    href={`/lessons/${lesson.id}`}
                    className={`flex items-center gap-3 px-[18px] py-3.5 hover:bg-[#1c1c1f] transition-colors ${
                      idx < mod.lessons.length - 1 ? 'border-b border-[#2a2a2e]' : ''
                    }`}
                  >
                    {lesson.completed ? (
                      <div className="w-5 h-5 rounded-full bg-emerald-900/50 flex items-center justify-center flex-shrink-0">
                        <svg width="8" height="8" viewBox="0 0 12 12" fill="none" stroke="#34d399" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                          <path d="M2 6l3 3 5-5" />
                        </svg>
                      </div>
                    ) : (
                      <div className="w-5 h-5 rounded-full border border-[#9b93f0]/50 flex items-center justify-center flex-shrink-0">
                        <div className="w-1.5 h-1.5 rounded-full bg-[#9b93f0]/50" />
                      </div>
                    )}
                    <span className={`flex-1 text-[13px] leading-snug ${lesson.completed ? 'text-[#444]' : 'text-[#ccc]'}`}>
                      {lesson.title}
                    </span>
                    {lesson.completed
                      ? <span className="text-[11px] text-[#3C3489] font-medium flex-shrink-0">+10 XP</span>
                      : <span className="text-[13px] text-[#555] flex-shrink-0">→</span>
                    }
                  </Link>
                ))}
              </div>
            </details>
          )
        })}
      </div>

      {/* Sticky CTA */}
      {firstIncompleteLesson && (
        <div className="fixed bottom-0 left-0 right-0 px-7 pb-7 pt-4" style={{ background: 'linear-gradient(to top, #0c0c0c 70%, transparent)' }}>
          <div className="max-w-sm mx-auto">
            <Link
              href={`/lessons/${firstIncompleteLesson.id}`}
              className="block w-full text-center py-[13px] rounded-xl text-[14px] font-medium text-white hover:opacity-90 transition-opacity"
              style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)', boxShadow: '0 4px 20px rgba(127,119,221,0.25)' }}
            >
              {completedLessons === 0
                ? `Start Module ${currentModule.sort_order} →`
                : `Continue Module ${currentModule.sort_order} →`}
            </Link>
          </div>
        </div>
      )}

    </div>
  )
}
