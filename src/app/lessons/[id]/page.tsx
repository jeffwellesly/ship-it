import { createClient } from '@/lib/supabase/server'
import { redirect, notFound } from 'next/navigation'
import Link from 'next/link'
import LessonQuiz from './LessonQuiz'

export default async function LessonPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) redirect('/login')

  const [{ data: lesson }, { data: questions }, { data: progress }] = await Promise.all([
    supabase.from('lessons').select('*').eq('id', id).single(),
    supabase.from('questions').select('*').eq('lesson_id', id),
    supabase
      .from('user_progress')
      .select('lesson_id')
      .eq('user_id', user.id)
      .eq('lesson_id', id)
      .maybeSingle(),
  ])

  if (!lesson) notFound()

  return (
    <div className="min-h-screen bg-zinc-50">
      <div className="max-w-2xl mx-auto px-4 py-12">
        <Link
          href="/lessons"
          className="text-sm text-zinc-500 hover:text-zinc-900 transition-colors"
        >
          ← All lessons
        </Link>

        <div className="mt-6 bg-white rounded-lg border border-zinc-200 p-8">
          <p className="text-xs font-medium text-zinc-400 uppercase tracking-wide">
            {lesson.chapter}
          </p>
          <h1 className="mt-2 text-2xl font-bold text-zinc-900">{lesson.title}</h1>
          <div className="mt-6 text-zinc-700 leading-relaxed whitespace-pre-wrap text-[15px]">
            {lesson.content}
          </div>
        </div>

        {questions && questions.length > 0 && (
          <LessonQuiz
            lessonId={lesson.id}
            questions={questions}
            alreadyCompleted={!!progress}
          />
        )}
      </div>
    </div>
  )
}
