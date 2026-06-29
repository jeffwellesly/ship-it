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
    supabase
      .from('lessons')
      .select('*, modules(id, title, sort_order, course_id)')
      .eq('id', id)
      .single(),
    supabase.from('questions').select('*').eq('lesson_id', id),
    supabase
      .from('user_progress')
      .select('lesson_id')
      .eq('user_id', user.id)
      .eq('lesson_id', id)
      .maybeSingle(),
  ])

  if (!lesson) notFound()

  const mod = lesson.modules as unknown as {
    id: string
    title: string
    sort_order: number
    course_id: string
  } | null

  // Find next lesson: same module first, then first lesson of the next module
  let nextLessonId: string | null = null
  if (mod) {
    const { data: nextInModule } = await supabase
      .from('lessons')
      .select('id')
      .eq('module_id', mod.id)
      .gt('sort_order', lesson.sort_order)
      .order('sort_order')
      .limit(1)
      .maybeSingle()

    if (nextInModule) {
      nextLessonId = nextInModule.id
    } else {
      const { data: nextModule } = await supabase
        .from('modules')
        .select('id, lessons(id, sort_order)')
        .eq('course_id', mod.course_id)
        .gt('sort_order', mod.sort_order)
        .order('sort_order')
        .limit(1)
        .maybeSingle()

      if (nextModule) {
        const nml = nextModule.lessons as unknown as { id: string; sort_order: number }[]
        if (nml?.length) {
          nextLessonId = [...nml].sort((a, b) => a.sort_order - b.sort_order)[0].id
        }
      }
    }
  }

  return (
    <div className="min-h-screen bg-zinc-950">
      <div className="max-w-2xl mx-auto px-4 py-10">
        <Link
          href={mod ? `/courses/${mod.course_id}` : '/courses'}
          className="text-sm text-zinc-500 hover:text-zinc-300 transition-colors"
        >
          ← Back to course
        </Link>

        <div className="mt-6 bg-zinc-900 rounded-2xl border border-zinc-800 p-8">
          {mod && (
            <p className="text-xs font-bold text-indigo-400 uppercase tracking-widest mb-1">
              {mod.title}
            </p>
          )}
          <h1 className="mt-1 text-2xl font-black text-zinc-100">{lesson.title}</h1>
          <div className="mt-6 text-zinc-300 leading-relaxed whitespace-pre-wrap text-[15px]">
            {lesson.content}
          </div>
        </div>

        {questions && questions.length > 0 && (
          <LessonQuiz
            lessonId={lesson.id}
            questions={questions}
            alreadyCompleted={!!progress}
            nextLessonId={nextLessonId}
          />
        )}
      </div>
    </div>
  )
}
