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
  isGuest?: boolean
}

function CompletionBanner({ newBadges, nextLessonId, isGuest }: { newBadges: NewBadge[]; nextLessonId?: string | null; isGuest?: boolean }) {
  return (
    <div className="bg-[#151517] border border-[#2a2a2e] rounded-2xl overflow-hidden">
      <div className="px-5 py-4 border-b border-[#2a2a2e]">
        <p className="text-[16px] font-medium text-white">Lesson complete 🎉</p>
        <p className="text-[13px] text-[#888] mt-0.5">You&apos;re on a roll — keep going.</p>
      </div>
      <div className="px-5 py-4 flex items-center justify-between">
        <div className="flex items-baseline gap-1">
          <span className="text-[28px] font-medium text-[#FAC775]">+10</span>
          <span className="text-[13px] font-medium text-[#EF9F27]">XP</span>
        </div>
        {nextLessonId && (
          <Link
            href={`/lessons/${nextLessonId}`}
            className="px-5 py-2.5 rounded-xl text-[14px] font-medium text-white hover:opacity-90 transition-opacity"
            style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
          >
            Next lesson →
          </Link>
        )}
      </div>
      {isGuest && (
        <div className="px-5 py-4 border-t border-[#2a2a2e] flex items-center justify-between gap-4">
          <div>
            <p className="text-[13px] font-medium text-white">Save your progress</p>
            <p className="text-[12px] text-[#888] mt-0.5">Your XP and streaks are lost when you close the tab.</p>
          </div>
          <Link
            href="/login"
            className="shrink-0 px-4 py-2 rounded-lg border border-[#7F77DD]/50 text-[13px] font-medium text-[#9b93f0] hover:bg-[#7F77DD]/10 transition-colors"
          >
            Sign up free →
          </Link>
        </div>
      )}
      {newBadges.map((badge) => (
        <div
          key={badge.name}
          className="flex items-center gap-3 px-5 py-3.5 border-t border-[#2a2a2e] bg-[#1c1c1f]"
        >
          <div className="w-[34px] h-[34px] rounded-[10px] bg-[#3C3489] flex items-center justify-center flex-shrink-0 text-lg">
            {badge.icon}
          </div>
          <div>
            <p className="text-[13px] font-medium text-white">Badge unlocked: {badge.name}</p>
            <p className="text-[12px] text-[#888]">{badge.description}</p>
          </div>
        </div>
      ))}
    </div>
  )
}

function AlreadyCompletedBanner({ nextLessonId, hasQuestions }: { nextLessonId?: string | null; hasQuestions: boolean }) {
  return (
    <div className="flex items-center justify-between bg-[#1c1c1f] border border-[#2e2e32] rounded-xl px-4 py-3">
      <p className="text-[13px] text-[#888]">
        {hasQuestions ? '✓ Already completed — correct answers shown below.' : '✓ Already read.'}
      </p>
      {nextLessonId && (
        <Link
          href={`/lessons/${nextLessonId}`}
          className="text-[#9b93f0] hover:opacity-80 text-[13px] font-medium transition-opacity whitespace-nowrap ml-4"
        >
          Next →
        </Link>
      )}
    </div>
  )
}

export default function LessonQuiz({ lessonId, questions, alreadyCompleted, nextLessonId, isGuest }: Props) {
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
    const base = 'flex items-start gap-3 p-3 rounded-xl border text-[13px] cursor-pointer transition-all select-none'
    if (isReviewing) {
      if (idx === q.correct_choice_index)
        return `${base} bg-emerald-950/60 border-emerald-800 text-emerald-400 cursor-default`
      return `${base} bg-[#1c1c1f] border-[#2e2e32] text-[#555] cursor-default`
    }
    if (submitted && wrongIds.has(q.id)) {
      if (idx === q.correct_choice_index)
        return `${base} bg-emerald-950/60 border-emerald-800 text-emerald-400 cursor-default`
      if (idx === answers[q.id])
        return `${base} bg-red-950/60 border-red-800 text-red-400 cursor-default`
      return `${base} bg-[#1c1c1f] border-[#2e2e32] text-[#555] cursor-default`
    }
    if (answers[q.id] === idx)
      return `${base} bg-gradient-to-br from-[#7F77DD] to-[#534AB7] border-transparent text-white`
    return `${base} bg-[#1c1c1f] border-[#2e2e32] text-[#aaa] hover:border-[#555] hover:text-white`
  }

  // ── No-quiz lesson ──────────────────────────────────────────────
  if (!hasQuestions) {
    return (
      <div className="mt-5">
        {completed && !alreadyCompleted && (
          <CompletionBanner newBadges={newBadges} nextLessonId={nextLessonId} isGuest={isGuest} />
        )}
        {completed && alreadyCompleted && (
          <AlreadyCompletedBanner nextLessonId={nextLessonId} hasQuestions={false} />
        )}
        {!completed && (
          <button
            onClick={markComplete}
            disabled={pending}
            className="w-full py-[13px] rounded-xl text-[14px] font-medium text-white hover:opacity-90 transition-opacity disabled:opacity-40"
            style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
          >
            {pending ? 'Saving...' : 'Mark as read & continue →'}
          </button>
        )}
      </div>
    )
  }

  // ── Quiz lesson ─────────────────────────────────────────────────
  return (
    <div className="mt-5">
      <div className="flex items-center gap-3 mb-5">
        <div className="h-px flex-1 bg-[#2a2a2e]" />
        <span className="text-[11px] font-medium tracking-[0.06em] text-[#555]">QUIZ</span>
        <div className="h-px flex-1 bg-[#2a2a2e]" />
      </div>

      {completed && !alreadyCompleted && (
        <div className="mb-5">
          <CompletionBanner newBadges={newBadges} nextLessonId={nextLessonId} isGuest={isGuest} />
        </div>
      )}
      {completed && alreadyCompleted && (
        <div className="mb-5">
          <AlreadyCompletedBanner nextLessonId={nextLessonId} hasQuestions={true} />
        </div>
      )}

      <div className="space-y-3">
        {questions.map((q, qIdx) => {
          const isWrong = submitted && wrongIds.has(q.id)
          return (
            <div
              key={q.id}
              className={`bg-[#151517] rounded-2xl border p-5 ${isWrong ? 'border-red-800/60' : 'border-[#2a2a2e]'}`}
            >
              <p className="text-[14px] font-medium text-white mb-3">
                <span className="text-[#555] mr-2">{qIdx + 1}.</span>
                {q.question_text}
              </p>
              <div className="space-y-2">
                {q.choices.map((choice, idx) => (
                  <div
                    key={idx}
                    className={choiceClass(q, idx)}
                    onClick={() => handleSelect(q.id, idx)}
                  >
                    <span className="w-5 h-5 rounded-full border border-current flex items-center justify-center flex-shrink-0 mt-0.5 text-[11px] font-medium">
                      {String.fromCharCode(65 + idx)}
                    </span>
                    <span>{choice}</span>
                  </div>
                ))}
              </div>
              {isWrong && (
                <p className="mt-2.5 text-[12px] text-red-400">
                  Incorrect — the correct answer is highlighted above.
                </p>
              )}
            </div>
          )
        })}
      </div>

      {!completed && (
        <div className="mt-4">
          {submitted && wrongIds.size > 0 ? (
            <button
              onClick={handleRetry}
              className="px-5 py-2.5 rounded-xl bg-[#1c1c1f] border border-[#2e2e32] text-[#888] text-[13px] font-medium hover:text-white hover:border-[#555] transition-colors"
            >
              Try again
            </button>
          ) : (
            <button
              onClick={handleSubmit}
              disabled={!allAnswered || pending}
              className="px-6 py-2.5 rounded-xl text-[14px] font-medium text-white hover:opacity-90 transition-opacity disabled:opacity-30"
              style={{ background: 'linear-gradient(135deg,#7F77DD,#534AB7)' }}
            >
              {pending ? 'Saving...' : 'Check answers'}
            </button>
          )}
        </div>
      )}
    </div>
  )
}
