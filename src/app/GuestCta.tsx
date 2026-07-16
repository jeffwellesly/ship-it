'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'

export default function GuestCta() {
  const router = useRouter()
  const supabase = createClient()
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  async function handleGuest() {
    setLoading(true)
    setError(null)
    const { error } = await supabase.auth.signInAnonymously()
    if (error) {
      setError(error.message)
      setLoading(false)
    } else {
      router.push('/courses')
      router.refresh()
    }
  }

  return (
    <div className="flex flex-col items-end gap-1.5">
      <button
        type="button"
        onClick={handleGuest}
        disabled={loading}
        className="rounded-lg px-4 py-2 text-sm font-medium text-zinc-300 border border-zinc-700 hover:border-zinc-500 hover:text-white disabled:opacity-50 transition-colors"
      >
        {loading ? 'Loading…' : 'Continue as guest'}
      </button>
      {error && <p className="text-xs text-red-400">{error}</p>}
    </div>
  )
}
