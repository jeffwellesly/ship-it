import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'

export default async function Home() {
  const supabase = await createClient()
  const [{ data: softwareCourse }, { data: aimlCourse }] = await Promise.all([
    supabase.from('courses').select('id').eq('sort_order', 1).single(),
    supabase.from('courses').select('id').eq('sort_order', 2).single(),
  ])

  const [{ count: swCount }, { count: aimlCount }] = await Promise.all([
    supabase.from('modules').select('*', { count: 'exact', head: true }).eq('course_id', softwareCourse?.id ?? ''),
    supabase.from('modules').select('*', { count: 'exact', head: true }).eq('course_id', aimlCourse?.id ?? ''),
  ])

  const tracks = [
    {
      title: 'Software Development with Claude Code',
      subtitle: `${swCount ?? 0} modules · Git, APIs, databases, deployment, testing`,
      href: '/login',
    },
    {
      title: 'AI/ML for Builders',
      subtitle: `${aimlCount ?? 0} modules · LLMs, prompting, RAG, agents, AI strategy`,
      href: '/login',
    },
  ]

  const features = [
    { title: 'Plain English', subtitle: 'No jargon.' },
    { title: 'Build real things', subtitle: 'Ship actual projects.' },
    { title: 'Earn as you go', subtitle: 'XP and badges.' },
  ]

  return (
    <div className="min-h-screen bg-[#08090c] flex flex-col">
      {/* Header */}
      <header className="border-b border-white/5">
        <div className="max-w-5xl mx-auto w-full px-6 h-16 flex items-center justify-between">
          <Link href="/" className="flex items-center gap-2.5">
            <span className="w-7 h-7 rounded-md bg-blue-500 shrink-0" />
            <span className="font-serif text-sm font-bold tracking-wide text-white">SHIP IT</span>
          </Link>
          <div className="flex items-center gap-5">
            <Link href="/login" className="text-sm text-zinc-400 hover:text-zinc-200 transition-colors">
              Sign in
            </Link>
            <Link
              href="/login"
              className="rounded-lg bg-blue-500 hover:bg-blue-400 px-4 py-2 text-sm font-semibold text-white transition-colors"
            >
              Start free
            </Link>
          </div>
        </div>
      </header>

      {/* Hero */}
      <div className="flex-1">
        <div className="max-w-5xl mx-auto w-full px-6 pt-16 pb-20">
          <p className="text-xs font-bold text-blue-400 uppercase tracking-[0.15em] mb-5">
            For product builders
          </p>

          <h1 className="font-serif text-4xl md:text-5xl text-white leading-tight mb-6 max-w-2xl text-balance">
            &ldquo;The technical education product builders actually need.&rdquo;
          </h1>

          <p className="text-zinc-400 text-base max-w-xl mb-10 leading-relaxed">
            Not a bootcamp. Not a glossary. Structured tracks that teach software and AI the way a senior engineer would explain it to a smart PM.
          </p>

          {/* Feature cards */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 mb-8">
            {features.map((feature) => (
              <div key={feature.title} className="rounded-xl bg-[#12141a] border border-white/5 px-5 py-4">
                <p className="text-sm font-semibold text-white">{feature.title}</p>
                <p className="text-sm text-zinc-500 mt-0.5">{feature.subtitle}</p>
              </div>
            ))}
          </div>

          {/* Course rows */}
          <div className="flex flex-col gap-3">
            {tracks.map((track) => (
              <Link
                key={track.title}
                href={track.href}
                className="group flex items-center justify-between gap-4 rounded-xl bg-[#12141a] border border-white/5 hover:border-blue-500/40 transition-colors px-5 py-4"
              >
                <div className="flex items-center gap-4 min-w-0">
                  <span className="w-9 h-9 shrink-0 rounded-lg bg-blue-500" />
                  <div className="min-w-0">
                    <p className="text-sm font-semibold text-white truncate">{track.title}</p>
                    <p className="text-xs text-zinc-500 mt-0.5 truncate">{track.subtitle}</p>
                  </div>
                </div>
                <span className="shrink-0 rounded-lg bg-blue-500 group-hover:bg-blue-400 px-4 py-2 text-sm font-semibold text-white transition-colors">
                  Start now →
                </span>
              </Link>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}
