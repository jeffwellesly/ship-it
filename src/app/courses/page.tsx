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

const RocketIcon = ({ color = 'white', size = 20 }: { color?: string; size?: number }) => (
  <svg xmlns="http://www.w3.org/2000/svg" width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
    <path d="M4 13a8 8 0 0 1 7 7 6 6 0 0 0 3 -5 9 9 0 0 0 6 -8 3 3 0 0 0 -3 -3 9 9 0 0 0 -8 6 6 6 0 0 0 -5 3" />
    <path d="M7 14a6 6 0 0 0 -3 6 6 6 0 0 0 6 -3" />
    <circle cx="15" cy="9" r="1" fill={color} stroke="none" />
  </svg>
)

const comingSoon = [
  {
    title: 'AI for everyone',
    description: 'Understand how AI models work, when to use them, and how to build with them.',
    icon: (
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#555" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M12 18v-5.25m0 0a6.01 6.01 0 0 0 1.5-.189m-1.5.189a6.01 6.01 0 0 1-1.5-.189m3.75 7.478a12.06 12.06 0 0 1-4.5 0m3.75 2.383a14.406 14.406 0 0 1-3 0M14.25 18v-.192c0-.983.658-1.823 1.508-2.316a7.5 7.5 0 1 0-7.517 0c.85.493 1.509 1.333 1.509 2.316V18" />
      </svg>
    ),
  },
  {
    title: 'ML for everyone',
    description: 'Go from zero to understanding machine learning models, data, and real-world applications.',
    icon: (
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#555" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M9.813 15.904 9 18.75l-.813-2.846a4.5 4.5 0 0 0-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 0 0 3.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 0 0 3.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 0 0-3.09 3.09ZM18.259 8.715 18 9.75l-.259-1.035a3.375 3.375 0 0 0-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 0 0 2.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 0 0 2.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 0 0-2.456 2.456Z" />
      </svg>
    ),
  },
]

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
    <div className="min-h-screen bg-[#0c0c0c]">

      {/* Nav */}
      <div className="border-b border-[#2a2a2e]">
        <div className="max-w-sm mx-auto px-7 py-[18px] flex items-center justify-between">
          <Link href="/dashboard" className="flex items-center gap-2">
            <span className="text-[16px] font-medium text-white">Ship It</span>
            <RocketIcon color="#9b93f0" size={16} />
          </Link>
          <div className="flex items-center gap-1.5 bg-[#1c1c1f] border border-[#3a2e1a] rounded-full px-3.5 py-1.5">
            <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#EF9F27" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M13 3l-7 10h6l-1 8 7-10h-6l1-8z" />
            </svg>
            <span className="text-[13px] font-medium text-[#FAC775]">{xp} XP</span>
          </div>
        </div>
      </div>

      <div className="max-w-sm mx-auto px-7 py-7">
        <h1 className="text-[26px] font-medium text-white mb-1">Your courses</h1>
        <p className="text-[13px] text-[#888] mb-6">Pick up where you left off.</p>

        <div className="space-y-3">

          {/* Active courses from DB */}
          {courses.map((course) => {
            const allLessons = course.modules.flatMap((m) => m.lessons)
            const total = allLessons.length
            const completed = allLessons.filter((l) => completedIds.has(l.id)).length
            const pct = total > 0 ? (completed / total) * 100 : 0
            const totalModules = course.modules.length
            const completedModules = course.modules.filter(
              (m) => m.lessons.length > 0 && m.lessons.every((l) => completedIds.has(l.id))
            ).length
            const currentId = findCurrentLessonId(course.modules, completedIds)
            const allDone = completed === total && total > 0

            return (
              <div key={course.id} className="bg-[#151517] border border-[#2a2a2e] rounded-2xl p-5">
                <div className="flex items-center gap-3 mb-4">
                  <div
                    className="w-10 h-10 rounded-[10px] flex items-center justify-center flex-shrink-0"
                    style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
                  >
                    <RocketIcon color="white" size={20} />
                  </div>
                  <div className="min-w-0">
                    <h2 className="text-[15px] font-medium text-white leading-snug">{course.title}</h2>
                    <p className="text-[12px] text-[#888] mt-0.5">{completedModules} of {totalModules} modules</p>
                  </div>
                </div>

                <p className="text-[12px] text-[#888] leading-relaxed mb-4">{course.description}</p>

                <div className="mb-4">
                  <div className="h-1 bg-[#1c1c1f] rounded-full overflow-hidden">
                    <div
                      className="h-full rounded-full transition-all"
                      style={{ width: `${pct}%`, background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
                    />
                  </div>
                  <p className="text-[11px] text-[#555] mt-1.5">{Math.round(pct)}% complete</p>
                </div>

                <Link
                  href={currentId ? `/lessons/${currentId}` : `/courses/${course.id}`}
                  className="block w-full text-center py-[11px] rounded-xl text-[14px] font-medium text-white hover:opacity-90 transition-opacity mb-2"
                  style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
                >
                  {completed === 0 ? 'Start course →' : allDone ? 'Review course' : 'Continue →'}
                </Link>

                <Link
                  href={`/courses/${course.id}`}
                  className="block w-full text-center text-[12px] text-[#555] hover:text-[#888] transition-colors"
                >
                  All modules
                </Link>
              </div>
            )
          })}

          {/* Coming soon courses */}
          {comingSoon.map((course) => (
            <div key={course.title} className="bg-[#151517] border border-[#2a2a2e] rounded-2xl p-5">
              <div className="flex items-center gap-3 mb-3">
                <div className="w-10 h-10 rounded-[10px] bg-[#1c1c1f] border border-[#2e2e32] flex items-center justify-center flex-shrink-0">
                  {course.icon}
                </div>
                <div className="min-w-0">
                  <h2 className="text-[15px] font-medium text-[#555] leading-snug">{course.title}</h2>
                  <p className="text-[12px] text-[#3a3a3a] mt-0.5">Coming soon</p>
                </div>
              </div>
              <p className="text-[12px] text-[#3a3a3a] leading-relaxed">{course.description}</p>
            </div>
          ))}

        </div>
      </div>

    </div>
  )
}
