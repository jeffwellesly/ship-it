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
  const completedCount = modules.reduce((acc, m) => acc + m.completedCount, 0)
  const pct = totalLessons > 0 ? (completedCount / totalLessons) * 100 : 0
  const totalModules = modules.length
  const completedModules = modules.filter((m) => m.complete).length
  const xp = profile?.total_xp ?? 0

  return (
    <div className="min-h-screen bg-[#0c0c0c]">

      {/* Nav */}
      <div className="border-b border-[#2a2a2e]">
        <div className="max-w-sm mx-auto px-7 py-[18px] flex items-center justify-between">
          <Link href="/courses" className="text-[14px] text-[#888] hover:text-white transition-colors">
            ← Courses
          </Link>
          <div className="flex items-center gap-1.5 bg-[#1c1c1f] border border-[#3a2e1a] rounded-full px-3.5 py-1.5">
            <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#EF9F27" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M13 3l-7 10h6l-1 8 7-10h-6l1-8z" />
            </svg>
            <span className="text-[13px] font-medium text-[#FAC775]">{xp} XP</span>
          </div>
        </div>
      </div>

      {/* Course header — full bleed gradient */}
      <div style={{ background: 'linear-gradient(135deg,#7F77DD,#3C3489)' }} className="px-7 py-8">
        <div className="max-w-sm mx-auto">
          <div className="w-12 h-12 rounded-[14px] bg-white/20 flex items-center justify-center mb-4">
            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M4 13a8 8 0 0 1 7 7 6 6 0 0 0 3 -5 9 9 0 0 0 6 -8 3 3 0 0 0 -3 -3 9 9 0 0 0 -8 6 6 6 0 0 0 -5 3" />
              <path d="M7 14a6 6 0 0 0 -3 6 6 6 0 0 0 6 -3" />
              <circle cx="15" cy="9" r="1" fill="white" stroke="none" />
            </svg>
          </div>
          <h1 className="text-[22px] font-medium text-white mb-1.5">{course.title}</h1>
          <p className="text-[13px] text-[#cfc9f7] mb-5 leading-relaxed">{course.description}</p>
          <div>
            <div className="flex items-center justify-between text-[12px] mb-1.5">
              <span className="text-[#cfc9f7]">{completedModules} of {totalModules} modules</span>
              <span className="text-white font-medium">{Math.round(pct)}%</span>
            </div>
            <div className="h-1 bg-white/20 rounded-full overflow-hidden">
              <div className="h-full bg-white/70 rounded-full transition-all" style={{ width: `${pct}%` }} />
            </div>
          </div>
        </div>
      </div>

      {/* Module list */}
      <div className="max-w-sm mx-auto px-7 py-6 space-y-3">
        {modules.map((mod) => (
          <div key={mod.id} className="bg-[#151517] border border-[#2a2a2e] rounded-2xl overflow-hidden">
            {/* Module header */}
            <div className="px-5 py-4 border-b border-[#2a2a2e]">
              <div className="flex items-start justify-between gap-3">
                <div className="min-w-0">
                  <p className="text-[11px] font-medium tracking-[0.06em] text-[#555] mb-0.5">
                    MODULE {mod.sort_order}
                  </p>
                  <h2 className="text-[15px] font-medium text-white leading-snug">{mod.title}</h2>
                </div>
                <span className={`text-[11px] font-medium px-2.5 py-1 rounded-full flex-shrink-0 mt-0.5 whitespace-nowrap ${
                  mod.complete
                    ? 'bg-emerald-900/40 text-emerald-400'
                    : 'bg-[#3C3489]/50 text-[#9b93f0]'
                }`}>
                  {mod.complete ? '✓ Done' : `${mod.completedCount}/${mod.lessons.length}`}
                </span>
              </div>
            </div>

            {/* Lessons */}
            <div>
              {mod.lessons.map((lesson, idx) => {
                const divider = idx < mod.lessons.length - 1 ? 'border-b border-[#2a2a2e]' : ''
                return (
                  <Link
                    key={lesson.id}
                    href={`/lessons/${lesson.id}`}
                    className={`flex items-center gap-3 px-5 py-3.5 hover:bg-[#1c1c1f] transition-colors ${divider}`}
                  >
                    {lesson.completed ? (
                      <div className="w-6 h-6 rounded-full bg-emerald-900/50 flex items-center justify-center text-emerald-400 text-xs flex-shrink-0">✓</div>
                    ) : (
                      <div className="w-6 h-6 rounded-full border border-[#9b93f0] flex items-center justify-center flex-shrink-0">
                        <div className="w-2 h-2 rounded-full bg-[#9b93f0]" />
                      </div>
                    )}
                    <span className={`flex-1 text-[13px] ${lesson.completed ? 'text-[#555]' : 'text-white'}`}>{lesson.title}</span>
                    {lesson.completed
                      ? <span className="text-[11px] font-medium text-[#3C3489]">+10 XP</span>
                      : <span className="text-[13px] text-[#9b93f0]">→</span>}
                  </Link>
                )
              })}
            </div>
          </div>
        ))}
      </div>

    </div>
  )
}
