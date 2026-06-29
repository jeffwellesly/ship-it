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
        {/* Welcome */}
        <div className="mb-8">
          <h1 className="text-2xl font-black text-white">Welcome back</h1>
          <p className="text-zinc-400 text-sm mt-1">{name}</p>
        </div>

        {/* XP card */}
        <div className="bg-gradient-to-br from-indigo-600 to-violet-700 rounded-2xl p-6 mb-4">
          <p className="text-indigo-200 text-xs font-bold uppercase tracking-widest mb-1">Total XP</p>
          <p className="text-5xl font-black text-white">{xp}</p>
          <p className="text-indigo-200 text-sm mt-1">Keep completing lessons to earn more.</p>
        </div>

        {/* Badges */}
        {userBadges && userBadges.length > 0 && (
          <div className="bg-zinc-900 border border-zinc-800 rounded-2xl p-5 mb-4">
            <p className="text-xs font-bold text-zinc-500 uppercase tracking-widest mb-3">Badges</p>
            <div className="space-y-2">
              {userBadges.map((ub) => {
                const badge = ub.badges as unknown as { name: string; description: string; icon: string } | null
                if (!badge) return null
                return (
                  <div
                    key={badge.name}
                    className="flex items-center gap-3 p-3 rounded-xl bg-amber-950/30 border border-amber-900/40"
                  >
                    <span className="text-2xl">{badge.icon}</span>
                    <div>
                      <p className="text-sm font-bold text-amber-300">{badge.name}</p>
                      <p className="text-xs text-amber-500">{badge.description}</p>
                    </div>
                  </div>
                )
              })}
            </div>
          </div>
        )}

        {/* CTA */}
        <Link
          href="/courses"
          className="block w-full text-center bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 rounded-xl transition-colors text-sm shadow-lg shadow-indigo-900/40 mb-3"
        >
          Continue learning →
        </Link>

        <LogoutButton />
      </div>
    </div>
  )
}
