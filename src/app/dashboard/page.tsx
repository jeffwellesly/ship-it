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

  return (
    <div className="min-h-screen flex items-center justify-center bg-zinc-50 px-4">
      <div className="w-full max-w-sm bg-white rounded-2xl shadow-sm border border-zinc-200 p-8">
        <h1 className="text-2xl font-semibold text-zinc-900 mb-2">Dashboard</h1>
        <p className="text-sm text-zinc-500 mb-6">
          Welcome, <span className="font-medium text-zinc-900">{user.email}</span>
        </p>
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
