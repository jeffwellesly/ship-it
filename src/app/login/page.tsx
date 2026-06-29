'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import Link from 'next/link'

export default function LoginPage() {
  const router = useRouter()
  const supabase = createClient()

  const [mode, setMode] = useState<'signin' | 'signup'>('signin')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [message, setMessage] = useState<string | null>(null)

  async function handleEmailSubmit(e: React.FormEvent) {
    e.preventDefault()
    setLoading(true)
    setError(null)
    setMessage(null)

    if (mode === 'signup') {
      const { error } = await supabase.auth.signUp({ email, password })
      if (error) {
        setError(error.message)
      } else {
        setMessage('Check your email for a confirmation link.')
      }
    } else {
      const { error } = await supabase.auth.signInWithPassword({ email, password })
      if (error) {
        setError(error.message)
      } else {
        router.push('/dashboard')
        router.refresh()
      }
    }

    setLoading(false)
  }

  async function handleGitHub() {
    setLoading(true)
    setError(null)
    const { error } = await supabase.auth.signInWithOAuth({
      provider: 'github',
      options: { redirectTo: `${window.location.origin}/auth/callback` },
    })
    if (error) {
      setError(error.message)
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-zinc-950 flex flex-col items-center justify-center px-4">
      {/* Logo */}
      <Link href="/" className="mb-8 flex flex-col items-center gap-2">
        <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-indigo-600 to-violet-700 flex items-center justify-center text-lg shadow-lg shadow-indigo-900/40">
          🚀
        </div>
        <span className="text-xs font-bold text-indigo-400 uppercase tracking-widest">Ship It</span>
      </Link>

      <div className="w-full max-w-sm bg-zinc-900 rounded-2xl border border-zinc-800 p-8">
        <h1 className="text-2xl font-black text-white mb-1">
          {mode === 'signin' ? 'Welcome back' : 'Create an account'}
        </h1>
        <p className="text-sm text-zinc-500 mb-6">
          {mode === 'signin' ? "Don't have an account? " : 'Already have an account? '}
          <button
            type="button"
            onClick={() => { setMode(mode === 'signin' ? 'signup' : 'signin'); setError(null); setMessage(null) }}
            className="font-semibold text-indigo-400 hover:text-indigo-300 transition-colors"
          >
            {mode === 'signin' ? 'Sign up' : 'Sign in'}
          </button>
        </p>

        {error && (
          <div className="mb-4 rounded-xl bg-red-950/50 border border-red-800 px-4 py-3 text-sm text-red-300">
            {error}
          </div>
        )}
        {message && (
          <div className="mb-4 rounded-xl bg-emerald-950/50 border border-emerald-800 px-4 py-3 text-sm text-emerald-300">
            {message}
          </div>
        )}

        <form onSubmit={handleEmailSubmit} className="flex flex-col gap-3">
          <div>
            <label htmlFor="email" className="block text-sm font-medium text-zinc-400 mb-1.5">
              Email
            </label>
            <input
              id="email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              placeholder="you@example.com"
              className="w-full rounded-xl border border-zinc-700 bg-zinc-800 px-3 py-2.5 text-sm text-zinc-100 placeholder-zinc-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
            />
          </div>
          <div>
            <label htmlFor="password" className="block text-sm font-medium text-zinc-400 mb-1.5">
              Password
            </label>
            <input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              placeholder="••••••••"
              className="w-full rounded-xl border border-zinc-700 bg-zinc-800 px-3 py-2.5 text-sm text-zinc-100 placeholder-zinc-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
            />
          </div>
          <button
            type="submit"
            disabled={loading}
            className="mt-1 w-full rounded-xl bg-indigo-600 hover:bg-indigo-500 py-2.5 text-sm font-bold text-white disabled:opacity-50 transition-colors shadow-lg shadow-indigo-900/40"
          >
            {loading ? 'Loading…' : mode === 'signin' ? 'Sign in' : 'Sign up'}
          </button>
        </form>

        <div className="my-5 flex items-center gap-3">
          <div className="flex-1 border-t border-zinc-800" />
          <span className="text-xs text-zinc-600">or</span>
          <div className="flex-1 border-t border-zinc-800" />
        </div>

        <button
          type="button"
          onClick={handleGitHub}
          disabled={loading}
          className="w-full flex items-center justify-center gap-2 rounded-xl border border-zinc-700 bg-zinc-800 hover:bg-zinc-700 py-2.5 text-sm font-medium text-zinc-300 disabled:opacity-50 transition-colors"
        >
          <svg viewBox="0 0 24 24" className="h-4 w-4 fill-current" aria-hidden="true">
            <path d="M12 0C5.37 0 0 5.37 0 12c0 5.3 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61-.546-1.385-1.335-1.755-1.335-1.755-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 21.795 24 17.295 24 12c0-6.63-5.37-12-12-12" />
          </svg>
          Continue with GitHub
        </button>
      </div>
    </div>
  )
}
