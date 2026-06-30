import { createClient } from '@/lib/supabase/server'
import { redirect, notFound } from 'next/navigation'
import Link from 'next/link'

type LessonStatus = 'completed' | 'available' | 'locked'

type RawLesson = { id: string; title: string; sort_order: number }
type RawModule = { id: string; title: string; description: string; sort_order: number; lessons: RawLesson[] }

type LessonWithStatus = RawLesson & { status: LessonStatus }
type ModuleWithStatus = Omit<RawModule, 'lessons'> & {
  lessons: LessonWithStatus[]
  locked: boolean
  complete: boolean
  completedCount: number
}

function computeStatuses(rawModules: RawModule[], completedIds: Set<string>): ModuleWithStatus[] {
  const modules = [...rawModules].sort((a, b) => a.sort_order - b.sort_order)
  let prevModuleComplete = true

  return modules.map((mod) => {
    const lessons = [...mod.lessons].sort((a, b) => a.sort_order - b.sort_order)
    const hasAny = lessons.some((l) => completedIds.has(l.id))
    const locked = !prevModuleComplete && !hasAny

    let prevDone = true
    const lessonsWithStatus: LessonWithStatus[] = lessons.map((lesson) => {
      let status: LessonStatus
      if (completedIds.has(lesson.id)) {
        status = 'completed'
        prevDone = true
      } else if (locked || !prevDone) {
        status = 'locked'
        prevDone = false
      } else {
        status = 'available'
        prevDone = false
      }
      return { ...lesson, status }
    })

    const complete = lessons.every((l) => completedIds.has(l.id))
    prevModuleComplete = complete

    return { ...mod, lessons: lessonsWithStatus, locked, complete, completedCount: lessons.filter((l) => completedIds.has(l.id)).length }
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
          <div className="text-4xl mb-3">{course.icon}</div>
          <h1 className="text-[22px] font-medium text-white mb-1.5">{course.title}</h1>
          <p className="text-[13px] text-[#cfc9f7] mb-5 leading-relaxed">{course.description}</p>
          <div>
            <div className="flex items-center justify-between text-[12px] mb-1.5">
              <span className="text-[#cfc9f7]">{completedCount} of {totalLessons} lessons</span>
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
          <div
            key={mod.id}
            className={`bg-[#151517] border border-[#2a2a2e] rounded-2xl overflow-hidden transition-opacity ${mod.locked ? 'opacity-40' : ''}`}
          >
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
                    : mod.locked
                      ? 'bg-[#1c1c1f] text-[#555]'
                      : 'bg-[#3C3489]/50 text-[#9b93f0]'
                }`}>
                  {mod.complete ? '✓ Done' : mod.locked ? 'Locked' : `${mod.completedCount}/${mod.lessons.length}`}
                </span>
              </div>
            </div>

            {/* Lessons */}
            {!mod.locked && (
              <div>
                {mod.lessons.map((lesson, idx) => {
                  const notLast = idx < mod.lessons.length - 1
                  const divider = notLast ? 'border-b border-[#2a2a2e]' : ''

                  if (lesson.status === 'completed') {
                    return (
                      <Link
                        key={lesson.id}
                        href={`/lessons/${lesson.id}`}
                        className={`flex items-center gap-3 px-5 py-3.5 hover:bg-[#1c1c1f] transition-colors ${divider}`}
                      >
                        <div className="w-6 h-6 rounded-full bg-emerald-900/50 flex items-center justify-center text-emerald-400 text-xs flex-shrink-0">✓</div>
                        <span className="flex-1 text-[13px] text-[#555]">{lesson.title}</span>
                        <span className="text-[11px] font-medium text-[#3C3489]">+10 XP</span>
                      </Link>
                    )
                  }

                  if (lesson.status === 'available') {
                    return (
                      <Link
                        key={lesson.id}
                        href={`/lessons/${lesson.id}`}
                        className={`flex items-center gap-3 px-5 py-3.5 hover:bg-[#1c1c1f] transition-colors ${divider}`}
                      >
                        <div className="w-6 h-6 rounded-full border border-[#9b93f0] flex items-center justify-center flex-shrink-0">
                          <div className="w-2 h-2 rounded-full bg-[#9b93f0]" />
                        </div>
                        <span className="flex-1 text-[13px] text-white">{lesson.title}</span>
                        <span className="text-[13px] text-[#9b93f0]">→</span>
                      </Link>
                    )
                  }

                  // locked
                  return (
                    <div
                      key={lesson.id}
                      className={`flex items-center gap-3 px-5 py-3.5 cursor-not-allowed ${divider}`}
                    >
                      <div className="w-6 h-6 rounded-full bg-[#1c1c1f] flex items-center justify-center flex-shrink-0">
                        <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="#555" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                          <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                          <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                        </svg>
                      </div>
                      <span className="flex-1 text-[13px] text-[#555]">{lesson.title}</span>
                    </div>
                  )
                })}
              </div>
            )}
          </div>
        ))}
      </div>

    </div>
  )
}
