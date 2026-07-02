'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import Link from 'next/link'

export default function LoginPage() {
  const router = useRouter()
  const supabase = createClient()

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

    const { error } = await supabase.auth.signUp({ email, password })
    if (error) {
      setError(error.message)
    } else {
      setMessage('Check your email for a confirmation link.')
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

  async function handleGuest() {
    setLoading(true)
    setError(null)
    const { error } = await supabase.auth.signInAnonymously()
    if (error) {
      setError(error.message)
      setLoading(false)
    } else {
      router.push('/dashboard')
      router.refresh()
    }
  }

  return (
    <div className="min-h-screen bg-[#0c0c0c] flex flex-col items-center justify-center px-4">

      {/* Logo */}
      <Link href="/" className="mb-8 flex flex-col items-center gap-2.5">
        <div
          className="w-12 h-12 rounded-[14px] flex items-center justify-center"
          style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
            <path d="M4 13a8 8 0 0 1 7 7 6 6 0 0 0 3 -5 9 9 0 0 0 6 -8 3 3 0 0 0 -3 -3 9 9 0 0 0 -8 6 6 6 0 0 0 -5 3" />
            <path d="M7 14a6 6 0 0 0 -3 6 6 6 0 0 0 6 -3" />
            <circle cx="15" cy="9" r="1" fill="white" stroke="none" />
          </svg>
        </div>
        <span className="text-[13px] font-medium uppercase tracking-[0.08em] text-[#9b93f0]">
          Ship It
        </span>
      </Link>

      {/* Card */}
      <div className="w-full max-w-[340px] bg-[#151517] border border-[#2a2a2e] rounded-2xl px-7 py-8">

        <h1 className="text-[22px] font-medium text-white mb-6">
          Create an account
        </h1>

        {error && (
          <div className="mb-4 rounded-xl bg-red-950/50 border border-red-800/60 px-4 py-3 text-[13px] text-red-300">
            {error}
          </div>
        )}
        {message && (
          <div className="mb-4 rounded-xl bg-emerald-950/50 border border-emerald-800/60 px-4 py-3 text-[13px] text-emerald-300">
            {message}
          </div>
        )}

        <form onSubmit={handleEmailSubmit} className="flex flex-col gap-4">
          <div>
            <label htmlFor="email" className="block text-[13px] text-[#aaa] mb-1.5">
              Email
            </label>
            <input
              id="email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              placeholder="you@example.com"
              className="w-full rounded-lg border border-[#2e2e32] bg-[#1c1c1f] px-3 py-2.5 text-[14px] text-zinc-100 placeholder-[#555] focus:outline-none focus:ring-1 focus:ring-[#7F77DD] focus:border-[#7F77DD]"
            />
          </div>
          <div>
            <label htmlFor="password" className="block text-[13px] text-[#aaa] mb-1.5">
              Password
            </label>
            <input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              placeholder="••••••••"
              className="w-full rounded-lg border border-[#2e2e32] bg-[#1c1c1f] px-3 py-2.5 text-[14px] text-zinc-100 placeholder-[#555] focus:outline-none focus:ring-1 focus:ring-[#7F77DD] focus:border-[#7F77DD]"
            />
          </div>
          <button
            type="submit"
            disabled={loading}
            className="w-full rounded-lg py-[11px] text-[14px] font-medium text-white disabled:opacity-50 transition-opacity hover:opacity-90"
            style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
          >
            {loading ? 'Loading…' : 'Sign up'}
          </button>
        </form>

        <div className="my-5 flex items-center gap-2.5">
          <div className="flex-1 h-px bg-[#2a2a2e]" />
          <span className="text-[12px] text-[#555]">or</span>
          <div className="flex-1 h-px bg-[#2a2a2e]" />
        </div>

        <button
          type="button"
          onClick={handleGitHub}
          disabled={loading}
          className="w-full flex items-center justify-center gap-2 rounded-lg border border-[#2e2e32] bg-[#1c1c1f] hover:bg-[#222225] py-2.5 text-[14px] text-[#ddd] disabled:opacity-50 transition-colors"
        >
          <svg viewBox="0 0 24 24" className="h-[17px] w-[17px] fill-current" aria-hidden="true">
            <path d="M12 0C5.37 0 0 5.37 0 12c0 5.3 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61-.546-1.385-1.335-1.755-1.335-1.755-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 21.795 24 17.295 24 12c0-6.63-5.37-12-12-12" />
          </svg>
          Continue with GitHub
        </button>

        <button
          type="button"
          onClick={handleGuest}
          disabled={loading}
          className="mt-3 w-full rounded-lg border border-[#2a2a2e] py-2.5 text-[13px] text-[#555] hover:text-[#888] hover:border-[#3a3a3e] disabled:opacity-50 transition-colors"
        >
          Continue as guest
        </button>
      </div>

    </div>
  )
}
