import Link from 'next/link'

export default function Home() {
  return (
    <div className="min-h-screen bg-zinc-50 flex flex-col items-center justify-center px-4">
      <div className="max-w-md w-full text-center">
        <div className="mb-8">
          <div className="inline-flex items-center justify-center w-14 h-14 rounded-2xl bg-zinc-900 text-white text-2xl mb-6">
            🚀
          </div>
          <h1 className="text-4xl font-bold text-zinc-900 tracking-tight">Ship It</h1>
          <p className="mt-3 text-lg text-zinc-500">
            The PM crash course that actually teaches you how software works.
          </p>
        </div>

        <div className="space-y-3">
          <Link
            href="/login"
            className="block w-full px-6 py-3 rounded-lg bg-zinc-900 text-white font-medium hover:bg-zinc-700 transition-colors"
          >
            Get started
          </Link>
          <Link
            href="/login"
            className="block w-full px-6 py-3 rounded-lg border border-zinc-200 text-zinc-700 font-medium hover:border-zinc-400 transition-colors bg-white"
          >
            Sign in
          </Link>
        </div>

        <div className="mt-12 grid grid-cols-3 gap-4 text-center">
          <div className="p-4 bg-white rounded-lg border border-zinc-200">
            <div className="text-2xl font-bold text-zinc-900">6</div>
            <div className="text-xs text-zinc-500 mt-1">lessons</div>
          </div>
          <div className="p-4 bg-white rounded-lg border border-zinc-200">
            <div className="text-2xl font-bold text-zinc-900">10</div>
            <div className="text-xs text-zinc-500 mt-1">quiz questions</div>
          </div>
          <div className="p-4 bg-white rounded-lg border border-zinc-200">
            <div className="text-2xl font-bold text-zinc-900">~30m</div>
            <div className="text-xs text-zinc-500 mt-1">to complete</div>
          </div>
        </div>
      </div>
    </div>
  )
}
