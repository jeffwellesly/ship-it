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

  const [{ data: lesson }, { data: questions }, { data: progress }, { data: profile }] = await Promise.all([
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
    supabase.from('profiles').select('total_xp').eq('id', user.id).single(),
  ])

  if (!lesson) notFound()

  const xp = profile?.total_xp ?? 0

  const mod = lesson.modules as unknown as {
    id: string
    title: string
    sort_order: number
    course_id: string
  } | null

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
    <div className="min-h-screen bg-[#0c0c0c]">

      {/* Nav */}
      <div className="border-b border-[#2a2a2e]">
        <div className="max-w-lg mx-auto px-7 py-[18px] flex items-center justify-between">
          <Link
            href={mod ? `/courses/${mod.course_id}` : '/courses'}
            className="text-[14px] text-[#888] hover:text-white transition-colors"
          >
            ← Back to course
          </Link>
          <div className="flex items-center gap-1.5 bg-[#1c1c1f] border border-[#3a2e1a] rounded-full px-3.5 py-1.5">
            <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#EF9F27" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M13 3l-7 10h6l-1 8 7-10h-6l1-8z" />
            </svg>
            <span className="text-[13px] font-medium text-[#FAC775]">{xp} XP</span>
          </div>
        </div>
      </div>

      <div className="max-w-lg mx-auto px-7 py-7">

        {/* Lesson content */}
        <div className="bg-[#151517] border border-[#2a2a2e] rounded-2xl p-7 mb-5">
          {mod && (
            <p className="text-[12px] font-medium tracking-[0.06em] text-[#9b93f0] mb-2">
              {mod.title}
            </p>
          )}
          <h1 className="text-[22px] font-medium text-white mb-5">{lesson.title}</h1>
          <div className="text-[14px] text-[#aaa] leading-relaxed whitespace-pre-wrap">
            {lesson.content}
          </div>
        </div>

        <LessonQuiz
          lessonId={lesson.id}
          questions={questions ?? []}
          alreadyCompleted={!!progress}
          nextLessonId={nextLessonId}
        />

      </div>
    </div>
  )
}
