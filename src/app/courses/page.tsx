import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import Link from 'next/link'

type LessonRef = { id: string; sort_order: number }
type ModuleRef = { id: string; sort_order: number; lessons: LessonRef[] }
type CourseRow = {
  id: string
  title: string
  description: string
  icon: string
  sort_order: number
  modules: ModuleRef[]
}

function findCurrentLessonId(modules: ModuleRef[], completedIds: Set<string>): string | null {
  const sorted = [...modules].sort((a, b) => a.sort_order - b.sort_order)
  let prevModuleComplete = true

  for (const mod of sorted) {
    const lessons = [...mod.lessons].sort((a, b) => a.sort_order - b.sort_order)
    const hasAny = lessons.some((l) => completedIds.has(l.id))
    const locked = !prevModuleComplete && !hasAny

    if (!locked) {
      let prevDone = true
      for (const lesson of lessons) {
        if (!completedIds.has(lesson.id) && prevDone) return lesson.id
        prevDone = completedIds.has(lesson.id)
      }
    }

    prevModuleComplete = lessons.every((l) => completedIds.has(l.id))
  }

  return null
}

export default async function CoursesPage() {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) redirect('/login')

  const [{ data: rawCourses }, { data: progress }, { data: profile }] = await Promise.all([
    supabase
      .from('courses')
      .select('id, title, description, icon, sort_order, modules(id, sort_order, lessons(id, sort_order))')
      .order('sort_order'),
    supabase.from('user_progress').select('lesson_id').eq('user_id', user.id),
    supabase.from('profiles').select('total_xp').eq('id', user.id).single(),
  ])

  const courses = (rawCourses as unknown as CourseRow[]) ?? []
  const completedIds = new Set(progress?.map((p) => p.lesson_id) ?? [])
  const xp = profile?.total_xp ?? 0

  return (
    <div className="min-h-screen bg-zinc-950">
      {/* Top bar */}
      <div className="border-b border-zinc-800 bg-zinc-900">
        <div className="max-w-2xl mx-auto px-4 py-4 flex items-center justify-between">
          <span className="text-lg font-black text-white tracking-tight">Ship It 🚀</span>
          <div className="flex items-center gap-2 bg-amber-400/10 border border-amber-400/30 rounded-full px-3 py-1.5">
            <span className="text-amber-400 text-sm">⚡</span>
            <span className="text-sm font-bold text-amber-300">{xp} XP</span>
          </div>
        </div>
      </div>

      <div className="max-w-2xl mx-auto px-4 py-8">
        <h1 className="text-2xl font-black text-white mb-1">Your courses</h1>
        <p className="text-sm text-zinc-400 mb-8">Pick up where you left off.</p>

        <div className="space-y-4">
          {courses.map((course) => {
            const allLessons = course.modules.flatMap((m) => m.lessons)
            const total = allLessons.length
            const completed = allLessons.filter((l) => completedIds.has(l.id)).length
            const pct = total > 0 ? (completed / total) * 100 : 0
            const currentId = findCurrentLessonId(course.modules, completedIds)
            const allDone = completed === total && total > 0

            return (
              <div
                key={course.id}
                className="rounded-2xl overflow-hidden border border-zinc-800 bg-zinc-900 shadow-xl"
              >
                {/* Card header — gradient */}
                <div className="bg-gradient-to-br from-indigo-600 to-violet-700 px-6 pt-7 pb-6">
                  <div className="text-5xl mb-3">{course.icon}</div>
                  <h2 className="text-xl font-black text-white leading-tight">{course.title}</h2>
                </div>

                {/* Card body */}
                <div className="p-6">
                  <p className="text-sm text-zinc-400 mb-5 leading-relaxed">{course.description}</p>

                  {/* Progress */}
                  <div className="mb-5">
                    <div className="flex items-center justify-between mb-2">
                      <span className="text-xs font-semibold text-zinc-400 uppercase tracking-wide">
                        Progress
                      </span>
                      <span className="text-xs font-bold text-indigo-400">
                        {completed}/{total} lessons
                      </span>
                    </div>
                    <div className="h-3 bg-zinc-800 rounded-full overflow-hidden">
                      <div
                        className="h-full bg-gradient-to-r from-indigo-500 to-violet-500 rounded-full transition-all duration-500"
                        style={{ width: `${pct}%` }}
                      />
                    </div>
                    <p className="text-right text-xs text-zinc-500 mt-1">{Math.round(pct)}% complete</p>
                  </div>

                  {/* CTA */}
                  <Link
                    href={currentId ? `/lessons/${currentId}` : `/courses/${course.id}`}
                    className="block w-full text-center bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 rounded-xl transition-colors text-sm shadow-lg shadow-indigo-900/40"
                  >
                    {completed === 0
                      ? 'Start course →'
                      : allDone
                        ? 'Review course'
                        : 'Continue →'}
                  </Link>

                  <Link
                    href={`/courses/${course.id}`}
                    className="block w-full text-center text-zinc-500 hover:text-zinc-300 text-xs mt-3 transition-colors"
                  >
                    View all modules
                  </Link>
                </div>
              </div>
            )
          })}
        </div>
      </div>
    </div>
  )
}
