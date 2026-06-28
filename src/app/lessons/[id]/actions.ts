'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'

export type NewBadge = { name: string; description: string; icon: string }

export type CompleteLessonResult =
  | { success: true; newBadges: NewBadge[] }
  | { error: string }

export async function completeLesson(lessonId: string): Promise<CompleteLessonResult> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return { error: 'Not authenticated' }

  const { data, error } = await supabase.rpc('award_lesson_completion', {
    p_user_id: user.id,
    p_lesson_id: lessonId,
  })

  if (error) return { error: error.message }

  revalidatePath('/lessons')
  revalidatePath(`/lessons/${lessonId}`)
  revalidatePath('/dashboard')

  return { success: true, newBadges: data.new_badges ?? [] }
}
