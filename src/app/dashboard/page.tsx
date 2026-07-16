import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import Link from 'next/link'
import LogoutButton from './LogoutButton'
import CoinIcon from '@/components/CoinIcon'

type LessonRef = { id: string; title: string; sort_order: number }
type ModuleRef = { id: string; sort_order: number; lessons: LessonRef[] }
type CourseRef = { id: string; sort_order: number; modules: ModuleRef[] }

export default async function DashboardPage() {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) redirect('/login')

  const [{ data: profile }, { data: userBadges }, { data: progress }, { data: rawCourses }] = await Promise.all([
    supabase.from('profiles').select('total_xp, display_name').eq('id', user.id).single(),
    supabase.from('user_badges').select('id').eq('user_id', user.id),
    supabase.from('user_progress').select('lesson_id').eq('user_id', user.id),
    supabase
      .from('courses')
      .select('id, sort_order, modules(id, sort_order, lessons(id, title, sort_order))')
      .order('sort_order'),
  ])

  const xp = profile?.total_xp ?? 0
  const name = profile?.display_name ?? user.email
  const isGuest = user.is_anonymous ?? false
  const badgeCount = userBadges?.length ?? 0

  const completedIds = new Set(progress?.map((p) => p.lesson_id) ?? [])
  const doneCount = completedIds.size

  const COINS_PER_LEVEL = 50
  const LEVEL_TITLES = ['Beginner', 'Novice', 'Apprentice', 'Builder', 'Practitioner', 'Specialist', 'Expert', 'Master', 'Pro', 'Legend']
  const level = Math.floor(xp / COINS_PER_LEVEL) + 1
  const levelTitle = LEVEL_TITLES[Math.min(level - 1, LEVEL_TITLES.length - 1)]
  const coinsIntoLevel = xp % COINS_PER_LEVEL

  const courses = ((rawCourses as unknown as CourseRef[]) ?? [])
    .slice()
    .sort((a, b) => a.sort_order - b.sort_order)
    .map((c) => ({
      ...c,
      modules: [...c.modules]
        .sort((a, b) => a.sort_order - b.sort_order)
        .map((m) => ({ ...m, lessons: [...m.lessons].sort((a, b) => a.sort_order - b.sort_order) })),
    }))

  let nextUp: { lessonId: string; lessonTitle: string; moduleNumber: number; lessonNumber: number } | null = null
  findNext: for (const course of courses) {
    for (const mod of course.modules) {
      for (const lesson of mod.lessons) {
        if (!completedIds.has(lesson.id)) {
          nextUp = { lessonId: lesson.id, lessonTitle: lesson.title, moduleNumber: mod.sort_order, lessonNumber: lesson.sort_order }
          break findNext
        }
      }
    }
  }

  return (
    <div className="min-h-screen bg-[#0c0c0c]">

      {/* Navbar */}
      <div className="border-b border-[#2a2a2e]">
        <div className="max-w-sm mx-auto px-7 py-[18px] flex items-center justify-between">
          <Link href="/" className="text-[16px] font-medium text-white">Ship It</Link>
          <div className="flex items-center gap-1.5 bg-[#1c1c1f] border border-[#3a2e1a] rounded-full px-3.5 py-1.5">
            <CoinIcon size={13} />
            <span className="text-[13px] font-medium text-[#FAC775]">{xp} Coins</span>
          </div>
        </div>
      </div>

      {/* Guest banner */}
      {isGuest && (
        <div className="border-b border-[#2a2a2e]">
          <div className="max-w-sm mx-auto px-7 py-3 flex items-center justify-between gap-3">
            <p className="text-[13px] text-[#888]">Guest · progress won&apos;t save</p>
            <Link href="/login" className="shrink-0 text-[13px] font-medium text-[#9b93f0] hover:opacity-80 transition-opacity">
              Sign up →
            </Link>
          </div>
        </div>
      )}

      {/* Content */}
      <div className="max-w-sm mx-auto px-7 py-7">

        {/* Identity */}
        <div className="flex items-center gap-3 mb-6">
          <div
            className="w-11 h-11 rounded-xl flex-shrink-0"
            style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
          />
          <div className="min-w-0">
            <h1 className="text-[19px] font-medium text-white leading-snug truncate">{name}</h1>
            <p className="text-[12px] text-[#666]">Level {level} · {levelTitle}</p>
          </div>
        </div>

        {/* Level progress */}
        <div className="bg-[#151517] border border-[#2a2a2e] rounded-2xl p-5 mb-5">
          <div className="flex items-center justify-between mb-2.5">
            <p className="text-[11px] font-semibold tracking-[0.08em] text-[#9b93f0] uppercase">Level progress</p>
            <p className="text-[12px] text-[#666]">{coinsIntoLevel} / {COINS_PER_LEVEL} coins</p>
          </div>
          <div className="h-1.5 bg-[#0c0c0c] rounded-full overflow-hidden mb-5">
            <div
              className="h-full rounded-full transition-all"
              style={{ width: `${(coinsIntoLevel / COINS_PER_LEVEL) * 100}%`, background: 'linear-gradient(90deg,#7F77DD,#534AB7)' }}
            />
          </div>
          <div className="grid grid-cols-3 gap-3">
            <div className="bg-[#1c1c1f] border border-[#2a2a2e] rounded-xl py-4 text-center">
              <p className="text-[22px] font-semibold text-white leading-none mb-1">{xp}</p>
              <p className="text-[10px] font-medium tracking-[0.04em] text-[#666] uppercase">Coins</p>
            </div>
            <div className="bg-[#1c1c1f] border border-[#2a2a2e] rounded-xl py-4 text-center">
              <p className="text-[22px] font-semibold text-white leading-none mb-1">{badgeCount}</p>
              <p className="text-[10px] font-medium tracking-[0.04em] text-[#666] uppercase">Badges</p>
            </div>
            <div className="bg-[#1c1c1f] border border-[#2a2a2e] rounded-xl py-4 text-center">
              <p className="text-[22px] font-semibold text-white leading-none mb-1">{doneCount}</p>
              <p className="text-[10px] font-medium tracking-[0.04em] text-[#666] uppercase">Done</p>
            </div>
          </div>
        </div>

        {/* Next up */}
        <p className="text-[12px] font-medium tracking-[0.06em] text-[#666] uppercase mb-2.5">Next up</p>
        <div className="relative bg-[#151517] border border-[#2a2a2e] rounded-2xl p-5 pl-6 mb-5 overflow-hidden">
          <div className="absolute left-0 top-0 bottom-0 w-1 bg-[#7F77DD]" />
          {nextUp ? (
            <>
              <p className="text-[15px] font-medium text-white leading-snug mb-1">{nextUp.lessonTitle}</p>
              <p className="text-[12px] text-[#666]">Module {nextUp.moduleNumber} · Lesson {nextUp.lessonNumber}</p>
            </>
          ) : (
            <>
              <p className="text-[15px] font-medium text-white leading-snug mb-1">All caught up!</p>
              <p className="text-[12px] text-[#666]">You&apos;ve completed every lesson.</p>
            </>
          )}
        </div>

        {/* CTA */}
        <Link
          href={nextUp ? `/lessons/${nextUp.lessonId}` : '/courses'}
          className="block w-full text-center py-[13px] rounded-xl text-[14px] font-medium text-white mb-4 hover:opacity-90 transition-opacity"
          style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
        >
          {nextUp ? (doneCount === 0 ? 'Begin your quest →' : 'Continue →') : 'Review courses →'}
        </Link>

        <LogoutButton />

      </div>
    </div>
  )
}
