import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import Link from 'next/link'
import LogoutButton from './LogoutButton'

export default async function DashboardPage() {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) redirect('/login')

  const [{ data: profile }, { data: userBadges }] = await Promise.all([
    supabase.from('profiles').select('total_xp, display_name').eq('id', user.id).single(),
    supabase
      .from('user_badges')
      .select('earned_at, badges(name, description, icon)')
      .eq('user_id', user.id)
      .order('earned_at'),
  ])

  const xp = profile?.total_xp ?? 0
  const name = profile?.display_name ?? user.email

  return (
    <div className="min-h-screen bg-[#0c0c0c]">

      {/* Navbar */}
      <div className="border-b border-[#2a2a2e]">
        <div className="max-w-sm mx-auto px-7 py-[18px] flex items-center justify-between">
          <Link href="/" className="flex items-center gap-2">
            <span className="text-[16px] font-medium text-white">Ship It</span>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#9b93f0" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M4 13a8 8 0 0 1 7 7 6 6 0 0 0 3 -5 9 9 0 0 0 6 -8 3 3 0 0 0 -3 -3 9 9 0 0 0 -8 6 6 6 0 0 0 -5 3" />
              <path d="M7 14a6 6 0 0 0 -3 6 6 6 0 0 0 6 -3" />
              <circle cx="15" cy="9" r="1" fill="#9b93f0" stroke="none" />
            </svg>
          </Link>
          <div className="flex items-center gap-1.5 bg-[#1c1c1f] border border-[#3a2e1a] rounded-full px-3.5 py-1.5">
            <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#EF9F27" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M13 3l-7 10h6l-1 8 7-10h-6l1-8z" />
            </svg>
            <span className="text-[13px] font-medium text-[#FAC775]">{xp} XP</span>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-sm mx-auto px-7 py-7">

        {/* Welcome */}
        <h1 className="text-[26px] font-medium text-white mb-1">Welcome back</h1>
        <p className="text-[13px] text-[#888] mb-6">{name}</p>

        {/* XP card */}
        <div
          className="rounded-2xl p-6 mb-5"
          style={{ background: 'linear-gradient(135deg,#7F77DD,#3C3489)' }}
        >
          <p className="text-[12px] font-medium tracking-[0.06em] text-[#cfc9f7] mb-1.5">TOTAL XP</p>
          <p className="text-[40px] font-medium text-white leading-none mb-1.5">{xp}</p>
          <p className="text-[13px] text-[#cfc9f7]">Keep completing lessons to earn more.</p>
        </div>

        {/* Badges */}
        <div className="bg-[#151517] border border-[#2a2a2e] rounded-2xl p-5 mb-5">
          <p className="text-[12px] font-medium tracking-[0.06em] text-[#888] mb-3.5">BADGES</p>
          {userBadges && userBadges.length > 0 ? (
            <div className="space-y-2.5">
              {userBadges.map((ub) => {
                const badge = ub.badges as unknown as { name: string; description: string; icon: string } | null
                if (!badge) return null
                return (
                  <div
                    key={badge.name}
                    className="flex items-center gap-3 bg-[#1c1c1f] border border-[#2e2e32] rounded-xl px-3.5 py-3"
                  >
                    <div className="w-[34px] h-[34px] rounded-[10px] bg-[#3C3489] flex items-center justify-center flex-shrink-0 text-lg">
                      {badge.icon}
                    </div>
                    <div>
                      <p className="text-[14px] font-medium text-white">{badge.name}</p>
                      <p className="text-[12px] text-[#888]">{badge.description}</p>
                    </div>
                  </div>
                )
              })}
            </div>
          ) : (
            <p className="text-[13px] text-[#555]">Complete lessons to earn badges.</p>
          )}
        </div>

        {/* CTA */}
        <Link
          href="/courses"
          className="block w-full text-center py-[13px] rounded-xl text-[14px] font-medium text-white mb-4 hover:opacity-90 transition-opacity"
          style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
        >
          Continue learning →
        </Link>

        <LogoutButton />

      </div>
    </div>
  )
}
