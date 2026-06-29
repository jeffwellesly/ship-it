'use client'

import { useState, useTransition } from 'react'
import Link from 'next/link'
import { completeLesson, type NewBadge } from './actions'

type Question = {
  id: string
  question_text: string
  choices: string[]
  correct_choice_index: number
}

type Props = {
  lessonId: string
  questions: Question[]
  alreadyCompleted: boolean
  nextLessonId?: string | null
}

function CompletionBanner({ newBadges, nextLessonId }: { newBadges: NewBadge[]; nextLessonId?: string | null }) {
  return (
    <div className="rounded-2xl overflow-hidden border border-emerald-800">
      <div className="bg-gradient-to-r from-emerald-700 to-teal-700 px-6 py-5">
        <p className="text-xl font-black text-white">🎉 Lesson complete!</p>
        <p className="text-emerald-200 text-sm mt-1">You&apos;re on a roll — keep going.</p>
      </div>
      <div className="bg-zinc-900 border-t border-emerald-800 px-6 py-4 flex items-center justify-between">
        <div className="flex items-baseline gap-1">
          <span className="text-3xl font-black text-amber-400">+10</span>
          <span className="text-sm font-bold text-amber-500">XP</span>
        </div>
        {nextLessonId && (
          <Link
            href={`/lessons/${nextLessonId}`}
            className="bg-indigo-600 hover:bg-indigo-500 text-white font-bold px-5 py-2.5 rounded-xl text-sm transition-colors"
          >
            Next lesson →
          </Link>
        )}
      </div>
      {newBadges.map((badge) => (
        <div
          key={badge.name}
          className="px-6 py-4 border-t border-amber-900/40 flex items-center gap-3 bg-amber-950/30"
        >
          <span className="text-3xl">{badge.icon}</span>
          <div>
            <p className="text-sm font-bold text-amber-300">Badge unlocked: {badge.name}</p>
            <p className="text-xs text-amber-500">{badge.description}</p>
          </div>
        </div>
      ))}
    </div>
  )
}

function AlreadyCompletedBanner({ nextLessonId, hasQuestions }: { nextLessonId?: string | null; hasQuestions: boolean }) {
  return (
    <div className="p-4 bg-zinc-800 border border-zinc-700 rounded-xl flex items-center justify-between">
      <p className="text-sm text-zinc-400">
        {hasQuestions ? '✓ Already completed — correct answers shown below.' : '✓ Already read.'}
      </p>
      {nextLessonId && (
        <Link
          href={`/lessons/${nextLessonId}`}
          className="text-indigo-400 hover:text-indigo-300 text-sm font-bold transition-colors whitespace-nowrap ml-4"
        >
          Next →
        </Link>
      )}
    </div>
  )
}

export default function LessonQuiz({ lessonId, questions, alreadyCompleted, nextLessonId }: Props) {
  const [answers, setAnswers] = useState<Record<string, number>>({})
  const [submitted, setSubmitted] = useState(false)
  const [completed, setCompleted] = useState(alreadyCompleted)
  const [wrongIds, setWrongIds] = useState<Set<string>>(new Set())
  const [newBadges, setNewBadges] = useState<NewBadge[]>([])
  const [pending, startTransition] = useTransition()

  const hasQuestions = questions.length > 0
  const allAnswered = questions.every((q) => answers[q.id] !== undefined)
  const isReviewing = completed || (submitted && wrongIds.size === 0)

  function markComplete() {
    startTransition(async () => {
      const result = await completeLesson(lessonId)
      if ('success' in result) setNewBadges(result.newBadges)
      setCompleted(true)
    })
  }

  function handleSelect(questionId: string, index: number) {
    if (isReviewing) return
    setAnswers((prev) => ({ ...prev, [questionId]: index }))
  }

  function handleSubmit() {
    const wrong = new Set<string>()
    for (const q of questions) {
      if (answers[q.id] !== q.correct_choice_index) wrong.add(q.id)
    }
    setSubmitted(true)
    setWrongIds(wrong)
    if (wrong.size === 0) markComplete()
  }

  function handleRetry() {
    setAnswers({})
    setSubmitted(false)
    setWrongIds(new Set())
  }

  function choiceClass(q: Question, idx: number): string {
    const base =
      'flex items-start gap-3 p-3 rounded-xl border cursor-pointer transition-colors text-sm select-none'
    if (isReviewing) {
      if (idx === q.correct_choice_index)
        return `${base} bg-emerald-950/60 border-emerald-700 text-emerald-300 cursor-default`
      return `${base} bg-zinc-800 border-zinc-700 text-zinc-500 cursor-default`
    }
    if (submitted && wrongIds.has(q.id)) {
      if (idx === q.correct_choice_index)
        return `${base} bg-emerald-950/60 border-emerald-700 text-emerald-300 cursor-default`
      if (idx === answers[q.id])
        return `${base} bg-red-950/60 border-red-700 text-red-300 cursor-default`
      return `${base} bg-zinc-800 border-zinc-700 text-zinc-500 cursor-default`
    }
    if (answers[q.id] === idx) return `${base} bg-indigo-600 border-indigo-500 text-white`
    return `${base} bg-zinc-800 border-zinc-700 text-zinc-300 hover:border-zinc-500`
  }

  // ── No-quiz lesson ──────────────────────────────────────────────
  if (!hasQuestions) {
    return (
      <div className="mt-6">
        {completed && !alreadyCompleted && (
          <CompletionBanner newBadges={newBadges} nextLessonId={nextLessonId} />
        )}
        {completed && alreadyCompleted && (
          <AlreadyCompletedBanner nextLessonId={nextLessonId} hasQuestions={false} />
        )}
        {!completed && (
          <button
            onClick={markComplete}
            disabled={pending}
            className="w-full py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-sm transition-colors disabled:opacity-50 disabled:cursor-not-allowed shadow-lg shadow-indigo-900/40"
          >
            {pending ? 'Saving...' : 'Mark as read & continue →'}
          </button>
        )}
      </div>
    )
  }

  // ── Quiz lesson ─────────────────────────────────────────────────
  return (
    <div className="mt-6">
      <div className="flex items-center gap-3 mb-5">
        <div className="h-px flex-1 bg-zinc-800" />
        <span className="text-xs font-bold text-zinc-500 uppercase tracking-widest">Quiz</span>
        <div className="h-px flex-1 bg-zinc-800" />
      </div>

      {completed && !alreadyCompleted && (
        <div className="mb-5">
          <CompletionBanner newBadges={newBadges} nextLessonId={nextLessonId} />
        </div>
      )}
      {completed && alreadyCompleted && (
        <div className="mb-5">
          <AlreadyCompletedBanner nextLessonId={nextLessonId} hasQuestions={true} />
        </div>
      )}

      <div className="space-y-4">
        {questions.map((q, qIdx) => {
          const isWrong = submitted && wrongIds.has(q.id)
          return (
            <div
              key={q.id}
              className={`bg-zinc-900 rounded-2xl border p-5 transition-colors ${
                isWrong ? 'border-red-800' : 'border-zinc-800'
              }`}
            >
              <p className="font-semibold text-zinc-100 mb-3">
                <span className="text-zinc-500 mr-2">{qIdx + 1}.</span>
                {q.question_text}
              </p>
              <div className="space-y-2">
                {q.choices.map((choice, idx) => (
                  <div
                    key={idx}
                    className={choiceClass(q, idx)}
                    onClick={() => handleSelect(q.id, idx)}
                  >
                    <span className="w-5 h-5 rounded-full border border-current flex items-center justify-center flex-shrink-0 mt-0.5 text-xs font-bold">
                      {String.fromCharCode(65 + idx)}
                    </span>
                    <span>{choice}</span>
                  </div>
                ))}
              </div>
              {isWrong && (
                <p className="mt-2 text-xs text-red-400">
                  Incorrect — the correct answer is highlighted above.
                </p>
              )}
            </div>
          )
        })}
      </div>

      {!completed && (
        <div className="mt-5">
          {submitted && wrongIds.size > 0 ? (
            <button
              onClick={handleRetry}
              className="px-4 py-2.5 rounded-xl bg-zinc-800 text-zinc-300 text-sm font-bold hover:bg-zinc-700 transition-colors"
            >
              Try again
            </button>
          ) : (
            <button
              onClick={handleSubmit}
              disabled={!allAnswered || pending}
              className="px-6 py-2.5 rounded-xl bg-indigo-600 text-white text-sm font-bold hover:bg-indigo-500 transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
            >
              {pending ? 'Saving...' : 'Check answers'}
            </button>
          )}
        </div>
      )}
    </div>
  )
}
