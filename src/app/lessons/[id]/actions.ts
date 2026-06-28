'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'

export async function completeLesson(lessonId: string): Promise<{ success?: true; error?: string }> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return { error: 'Not authenticated' }

  const { error } = await supabase
    .from('user_progress')
    .insert({ user_id: user.id, lesson_id: lessonId })

  if (error) {
    if (error.code === '23505') return { success: true } // already completed, unique constraint
    return { error: error.message }
  }

  const { data: profile } = await supabase
    .from('profiles')
    .select('total_xp')
    .eq('id', user.id)
    .single()

  await supabase
    .from('profiles')
    .update({ total_xp: (profile?.total_xp ?? 0) + 10 })
    .eq('id', user.id)

  revalidatePath('/lessons')
  revalidatePath(`/lessons/${lessonId}`)
  return { success: true }
}
