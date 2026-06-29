import Link from 'next/link'

export default function Home() {
  return (
    <div className="min-h-screen bg-zinc-950 flex flex-col items-center justify-center px-4">
      <div className="max-w-md w-full text-center">
        <div className="mb-10">
          <div className="inline-flex items-center justify-center w-14 h-14 rounded-2xl bg-gradient-to-br from-indigo-600 to-violet-700 text-2xl mb-6 shadow-lg shadow-indigo-900/40">
            🚀
          </div>
          <p className="text-xs font-bold text-indigo-400 uppercase tracking-widest mb-3">Ship It</p>
          <h1 className="text-4xl font-black text-white tracking-tight leading-tight">
            Build real software products, even if you&apos;ve never coded.
          </h1>
          <p className="mt-4 text-base text-zinc-400 leading-relaxed">
            No-jargon, hands-on courses for PMs, founders, and beginners. Learn how software, AI,
            and product building work by shipping real projects step by step.
          </p>
        </div>

        <div className="space-y-3">
          <Link
            href="/login"
            className="block w-full px-6 py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold transition-colors shadow-lg shadow-indigo-900/40"
          >
            Ship your first project
          </Link>
          <Link
            href="/login"
            className="block w-full px-6 py-3 rounded-xl border border-zinc-700 text-zinc-400 font-medium hover:bg-zinc-800 hover:text-zinc-200 transition-colors"
          >
            Sign in
          </Link>
        </div>
      </div>
    </div>
  )
}
