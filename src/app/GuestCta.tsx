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
        className="rounded-lg px-4 py-2 text-sm font-medium text-white disabled:opacity-50 hover:opacity-90 transition-opacity"
        style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
      >
        {loading ? 'Loading…' : 'Continue as guest'}
      </button>
      {error && <p className="text-xs text-red-400">{error}</p>}
    </div>
  )
}
