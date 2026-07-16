import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import Link from 'next/link'
import CoinIcon from '@/components/CoinIcon'

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


const RocketIcon = ({ color = 'white', size = 20 }: { color?: string; size?: number }) => (
  <svg xmlns="http://www.w3.org/2000/svg" width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
    <path d="M4 13a8 8 0 0 1 7 7 6 6 0 0 0 3 -5 9 9 0 0 0 6 -8 3 3 0 0 0 -3 -3 9 9 0 0 0 -8 6 6 6 0 0 0 -5 3" />
    <path d="M7 14a6 6 0 0 0 -3 6 6 6 0 0 0 6 -3" />
    <circle cx="15" cy="9" r="1" fill={color} stroke="none" />
  </svg>
)


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
            <CoinIcon size={13} />
            <span className="text-[13px] font-medium text-[#FAC775]">{xp} Coins</span>
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
                  href={`/courses/${course.id}`}
                  className="block w-full text-center py-[11px] rounded-xl text-[14px] font-medium text-white hover:opacity-90 transition-opacity"
                  style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
                >
                  {completed === 0 ? 'Start course →' : allDone ? 'Review course' : 'Continue →'}
                </Link>
              </div>
            )
          })}


        </div>
      </div>

    </div>
  )
}
