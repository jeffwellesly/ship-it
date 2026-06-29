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

    return {
      ...mod,
      lessons: lessonsWithStatus,
      locked,
      complete,
      completedCount: lessons.filter((l) => completedIds.has(l.id)).length,
    }
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
    <div className="min-h-screen bg-zinc-950">
      {/* Top bar */}
      <div className="border-b border-zinc-800 bg-zinc-900">
        <div className="max-w-2xl mx-auto px-4 py-4 flex items-center justify-between">
          <Link
            href="/courses"
            className="text-sm text-zinc-400 hover:text-white transition-colors flex items-center gap-1"
          >
            ← All courses
          </Link>
          <div className="flex items-center gap-2 bg-amber-400/10 border border-amber-400/30 rounded-full px-3 py-1.5">
            <span className="text-amber-400 text-sm">⚡</span>
            <span className="text-sm font-bold text-amber-300">{xp} XP</span>
          </div>
        </div>
      </div>

      {/* Course header */}
      <div className="bg-gradient-to-br from-indigo-600 to-violet-700 px-4 py-10">
        <div className="max-w-2xl mx-auto">
          <div className="text-5xl mb-3">{course.icon}</div>
          <h1 className="text-2xl font-black text-white leading-tight mb-2">{course.title}</h1>
          <p className="text-indigo-200 text-sm mb-5">{course.description}</p>
          <div>
            <div className="flex items-center justify-between text-xs font-semibold mb-1.5">
              <span className="text-indigo-300">
                {completedCount} of {totalLessons} lessons complete
              </span>
              <span className="text-white">{Math.round(pct)}%</span>
            </div>
            <div className="h-2.5 bg-indigo-900/60 rounded-full overflow-hidden">
              <div
                className="h-full bg-white/80 rounded-full transition-all duration-500"
                style={{ width: `${pct}%` }}
              />
            </div>
          </div>
        </div>
      </div>

      {/* Modules */}
      <div className="max-w-2xl mx-auto px-4 py-6 space-y-4">
        {modules.map((mod) => (
          <div
            key={mod.id}
            className={`rounded-2xl overflow-hidden border ${
              mod.locked ? 'border-zinc-800 opacity-60' : 'border-zinc-800'
            } bg-zinc-900`}
          >
            {/* Module header */}
            <div
              className={`px-5 py-4 border-b ${
                mod.complete
                  ? 'bg-emerald-950/50 border-emerald-900/50'
                  : mod.locked
                    ? 'bg-zinc-900 border-zinc-800'
                    : 'bg-indigo-950/40 border-indigo-900/30'
              }`}
            >
              <div className="flex items-start justify-between gap-3">
                <div className="min-w-0">
                  <p className="text-xs font-bold text-zinc-500 uppercase tracking-widest mb-1">
                    Module {mod.sort_order}
                  </p>
                  <h2 className="font-black text-zinc-100 leading-tight">{mod.title}</h2>
                  <p className="text-sm text-zinc-400 mt-1 leading-relaxed">{mod.description}</p>
                </div>
                <span
                  className={`text-xs font-bold px-2.5 py-1 rounded-full whitespace-nowrap flex-shrink-0 ${
                    mod.complete
                      ? 'bg-emerald-900/60 text-emerald-300'
                      : mod.locked
                        ? 'bg-zinc-800 text-zinc-500'
                        : 'bg-indigo-900/60 text-indigo-300'
                  }`}
                >
                  {mod.complete
                    ? '✓ Complete'
                    : mod.locked
                      ? '🔒 Locked'
                      : `${mod.completedCount}/${mod.lessons.length}`}
                </span>
              </div>
            </div>

            {/* Lesson list — hidden if module locked */}
            {!mod.locked && (
              <div className="divide-y divide-zinc-800">
                {mod.lessons.map((lesson) => {
                  if (lesson.status === 'completed') {
                    return (
                      <Link
                        key={lesson.id}
                        href={`/lessons/${lesson.id}`}
                        className="flex items-center gap-3 px-5 py-3.5 bg-emerald-950/30 hover:bg-emerald-950/50 transition-colors group"
                      >
                        <div className="w-7 h-7 rounded-full bg-emerald-600 flex items-center justify-center flex-shrink-0 text-white text-xs font-bold">
                          ✓
                        </div>
                        <span className="flex-1 text-sm font-medium text-zinc-400 line-through">
                          {lesson.title}
                        </span>
                        <span className="text-xs font-bold text-emerald-600 bg-emerald-900/40 px-2 py-0.5 rounded-full">
                          +10 XP
                        </span>
                      </Link>
                    )
                  }

                  if (lesson.status === 'available') {
                    return (
                      <Link
                        key={lesson.id}
                        href={`/lessons/${lesson.id}`}
                        className="flex items-center gap-3 px-5 py-4 bg-zinc-900 border-l-4 border-indigo-500 hover:bg-zinc-800 transition-colors group"
                      >
                        <div className="w-7 h-7 rounded-full border-2 border-indigo-500 flex items-center justify-center flex-shrink-0">
                          <div className="w-2.5 h-2.5 rounded-full bg-indigo-500" />
                        </div>
                        <span className="flex-1 text-sm font-bold text-zinc-100">
                          {lesson.title}
                        </span>
                        <span className="text-indigo-400 text-sm font-bold group-hover:translate-x-0.5 transition-transform">
                          →
                        </span>
                      </Link>
                    )
                  }

                  // locked
                  return (
                    <div
                      key={lesson.id}
                      className="flex items-center gap-3 px-5 py-3.5 bg-zinc-900 cursor-not-allowed"
                    >
                      <div className="w-7 h-7 rounded-full bg-zinc-800 flex items-center justify-center flex-shrink-0 text-zinc-600 text-xs">
                        🔒
                      </div>
                      <span className="flex-1 text-sm font-medium text-zinc-600">
                        {lesson.title}
                      </span>
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
