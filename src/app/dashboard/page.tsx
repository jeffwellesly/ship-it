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

  return (
    <div className="min-h-screen flex items-center justify-center bg-zinc-50 px-4">
      <div className="w-full max-w-sm bg-white rounded-2xl shadow-sm border border-zinc-200 p-8">
        <h1 className="text-2xl font-semibold text-zinc-900 mb-1">Dashboard</h1>
        <p className="text-sm text-zinc-500 mb-6">
          Welcome, <span className="font-medium text-zinc-900">{profile?.display_name ?? user.email}</span>
        </p>

        <div className="mb-6 p-4 bg-zinc-50 rounded-xl border border-zinc-200 flex items-center justify-between">
          <span className="text-sm font-medium text-zinc-600">Total XP</span>
          <span className="text-2xl font-bold text-zinc-900">{xp}</span>
        </div>

        {userBadges && userBadges.length > 0 && (
          <div className="mb-6">
            <p className="text-xs font-medium text-zinc-400 uppercase tracking-wide mb-3">Badges</p>
            <div className="space-y-2">
              {userBadges.map((ub) => {
                const badge = ub.badges as { name: string; description: string; icon: string } | null
                if (!badge) return null
                return (
                  <div
                    key={badge.name}
                    className="flex items-center gap-3 p-3 rounded-lg bg-amber-50 border border-amber-100"
                  >
                    <span className="text-xl">{badge.icon}</span>
                    <div>
                      <p className="text-sm font-semibold text-amber-900">{badge.name}</p>
                      <p className="text-xs text-amber-700">{badge.description}</p>
                    </div>
                  </div>
                )
              })}
            </div>
          </div>
        )}

        <Link
          href="/lessons"
          className="block w-full text-center px-4 py-2 rounded-lg bg-zinc-900 text-white text-sm font-medium hover:bg-zinc-700 transition-colors mb-3"
        >
          Start learning →
        </Link>
        <LogoutButton />
      </div>
    </div>
  )
}
