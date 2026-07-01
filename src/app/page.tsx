import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'

export default async function Home() {
  const supabase = await createClient()
  const { count } = await supabase
    .from('modules')
    .select('*', { count: 'exact', head: true })

  const moduleCount = count ?? 0

  const tracks = [
    {
      icon: (
        <svg viewBox="0 0 24 24" className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={1.8}>
          <path strokeLinecap="round" strokeLinejoin="round" d="M15.59 14.37a6 6 0 0 1-5.84 7.38v-4.8m5.84-2.58a14.98 14.98 0 0 0 6.16-12.12A14.98 14.98 0 0 0 9.631 8.41m5.96 5.96a14.926 14.926 0 0 1-5.841 2.58m-.119-8.54a6 6 0 0 0-7.381 5.84h4.8m2.581-5.84a14.927 14.927 0 0 0-2.58 5.84m2.699 2.7c-.103.021-.207.041-.311.06a15.09 15.09 0 0 1-2.448-2.448 14.9 14.9 0 0 1 .06-.312m-2.24 2.39a4.493 4.493 0 0 0-1.757 4.306 4.493 4.493 0 0 0 4.306-1.758M16.5 9a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0Z" />
        </svg>
      ),
      iconColor: 'text-violet-400',
      title: 'Software Development with Claude Code',
      subtitle: `${moduleCount} modules`,
      active: true,
      href: '/login',
    },
    {
      icon: (
        <svg viewBox="0 0 24 24" className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={1.8}>
          <path strokeLinecap="round" strokeLinejoin="round" d="M12 18v-5.25m0 0a6.01 6.01 0 0 0 1.5-.189m-1.5.189a6.01 6.01 0 0 1-1.5-.189m3.75 7.478a12.06 12.06 0 0 1-4.5 0m3.75 2.383a14.406 14.406 0 0 1-3 0M14.25 18v-.192c0-.983.658-1.823 1.508-2.316a7.5 7.5 0 1 0-7.517 0c.85.493 1.509 1.333 1.509 2.316V18" />
        </svg>
      ),
      iconColor: 'text-zinc-500',
      title: 'AI for everyone',
      subtitle: 'Coming soon',
      active: false,
      href: null,
    },
    {
      icon: (
        <svg viewBox="0 0 24 24" className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={1.8}>
          <path strokeLinecap="round" strokeLinejoin="round" d="M9.813 15.904 9 18.75l-.813-2.846a4.5 4.5 0 0 0-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 0 0 3.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 0 0 3.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 0 0-3.09 3.09ZM18.259 8.715 18 9.75l-.259-1.035a3.375 3.375 0 0 0-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 0 0 2.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 0 0 2.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 0 0-2.456 2.456Z" />
        </svg>
      ),
      iconColor: 'text-zinc-500',
      title: 'ML for everyone',
      subtitle: 'Coming soon',
      active: false,
      href: null,
    },
  ]

  return (
    <div className="min-h-screen bg-zinc-950 flex flex-col items-center justify-center px-6">
      <div className="max-w-3xl w-full text-center">

        {/* Brand label */}
        <p className="text-sm font-bold text-indigo-400 uppercase tracking-widest mb-5">Ship It</p>

        {/* Headline */}
        <h1 className="text-3xl md:text-4xl font-bold text-white leading-tight tracking-tight mb-4 text-balance">
          A learning platform for builders who don&apos;t code yet
        </h1>

        {/* Subheadline */}
        <p className="text-base text-zinc-400 mb-10">
          Pick a track. Learn the concept. Ship something real.
        </p>

        {/* Course cards */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 mb-8">
          {tracks.map((track) => {
            const card = (
              <div
                className={`text-left p-5 rounded-xl border transition-colors ${
                  track.active
                    ? 'bg-zinc-800 border-zinc-700 hover:border-zinc-500 cursor-pointer'
                    : 'bg-zinc-900 border-zinc-800 cursor-default'
                }`}
              >
                <span className={`mb-3 block ${track.iconColor}`}>{track.icon}</span>
                <p className={`font-semibold text-sm ${track.active ? 'text-white' : 'text-zinc-500'}`}>
                  {track.title}
                </p>
                <p className={`text-xs mt-0.5 ${track.active ? 'text-zinc-400' : 'text-zinc-600'}`}>
                  {track.subtitle}
                </p>
              </div>
            )

            return track.href ? (
              <Link key={track.title} href={track.href}>{card}</Link>
            ) : (
              <div key={track.title}>{card}</div>
            )
          })}
        </div>

        {/* Sign in */}
        <p className="text-sm text-zinc-600">
          Already have an account?{' '}
          <Link href="/login" className="text-zinc-400 hover:text-white transition-colors">
            Sign in
          </Link>
        </p>

      </div>
    </div>
  )
}
