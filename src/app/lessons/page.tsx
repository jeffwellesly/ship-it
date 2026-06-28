import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import Link from 'next/link'

export default async function LessonsPage() {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) redirect('/login')

  const [{ data: lessons }, { data: progress }] = await Promise.all([
    supabase.from('lessons').select('id, chapter, title, sort_order').order('sort_order'),
    supabase.from('user_progress').select('lesson_id').eq('user_id', user.id),
  ])

  const completedIds = new Set(progress?.map((p) => p.lesson_id) ?? [])
  const total = lessons?.length ?? 0
  const completed = completedIds.size

  return (
    <div className="min-h-screen bg-zinc-50">
      <div className="max-w-2xl mx-auto px-4 py-12">
        <Link href="/dashboard" className="text-sm text-zinc-500 hover:text-zinc-900 transition-colors">
          ← Dashboard
        </Link>

        <div className="mt-6 mb-8">
          <p className="text-xs font-medium text-zinc-400 uppercase tracking-wide">Module 1</p>
          <h1 className="mt-1 text-2xl font-bold text-zinc-900">Internet Fundamentals</h1>
          <p className="mt-1 text-sm text-zinc-500">
            {completed} of {total} lessons complete
          </p>
          {total > 0 && (
            <div className="mt-3 h-1.5 bg-zinc-200 rounded-full overflow-hidden">
              <div
                className="h-full bg-zinc-900 rounded-full transition-all"
                style={{ width: `${(completed / total) * 100}%` }}
              />
            </div>
          )}
        </div>

        <div className="space-y-3">
          {lessons?.map((lesson) => {
            const done = completedIds.has(lesson.id)
            return (
              <Link
                key={lesson.id}
                href={`/lessons/${lesson.id}`}
                className="flex items-center gap-4 p-4 bg-white rounded-lg border border-zinc-200 hover:border-zinc-400 transition-colors group"
              >
                <div
                  className={`w-7 h-7 rounded-full flex items-center justify-center flex-shrink-0 text-sm font-medium transition-colors ${
                    done
                      ? 'bg-zinc-900 text-white'
                      : 'bg-zinc-100 text-zinc-500 group-hover:bg-zinc-200'
                  }`}
                >
                  {done ? '✓' : lesson.sort_order}
                </div>
                <span
                  className={`font-medium transition-colors ${
                    done ? 'text-zinc-400 line-through' : 'text-zinc-900'
                  }`}
                >
                  {lesson.title}
                </span>
                {!done && (
                  <span className="ml-auto text-zinc-300 group-hover:text-zinc-500 transition-colors">
                    →
                  </span>
                )}
              </Link>
            )
          })}
        </div>
      </div>
    </div>
  )
}
