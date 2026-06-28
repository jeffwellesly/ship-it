'use client'

import { useState, useTransition } from 'react'
import { completeLesson } from './actions'

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
}

export default function LessonQuiz({ lessonId, questions, alreadyCompleted }: Props) {
  const [answers, setAnswers] = useState<Record<string, number>>({})
  const [submitted, setSubmitted] = useState(false)
  const [completed, setCompleted] = useState(alreadyCompleted)
  const [wrongIds, setWrongIds] = useState<Set<string>>(new Set())
  const [pending, startTransition] = useTransition()

  const allAnswered = questions.every((q) => answers[q.id] !== undefined)
  const isReviewing = completed || (submitted && wrongIds.size === 0)

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

    if (wrong.size === 0) {
      startTransition(async () => {
        await completeLesson(lessonId)
        setCompleted(true)
      })
    }
  }

  function handleRetry() {
    setAnswers({})
    setSubmitted(false)
    setWrongIds(new Set())
  }

  function choiceClass(q: Question, idx: number): string {
    const base =
      'flex items-start gap-3 p-3 rounded-lg border cursor-pointer transition-colors text-sm select-none'

    if (isReviewing) {
      if (idx === q.correct_choice_index)
        return `${base} bg-green-50 border-green-300 text-green-800 cursor-default`
      return `${base} bg-zinc-50 border-zinc-200 text-zinc-400 cursor-default`
    }

    if (submitted && wrongIds.has(q.id)) {
      if (idx === q.correct_choice_index)
        return `${base} bg-green-50 border-green-300 text-green-800 cursor-default`
      if (idx === answers[q.id])
        return `${base} bg-red-50 border-red-300 text-red-700 cursor-default`
      return `${base} bg-zinc-50 border-zinc-200 text-zinc-400 cursor-default`
    }

    if (answers[q.id] === idx) return `${base} bg-zinc-900 border-zinc-900 text-white`
    return `${base} bg-white border-zinc-200 text-zinc-700 hover:border-zinc-400`
  }

  return (
    <div className="mt-6">
      <div className="flex items-center gap-3 mb-5">
        <div className="h-px flex-1 bg-zinc-200" />
        <span className="text-xs font-medium text-zinc-400 uppercase tracking-wide">Quiz</span>
        <div className="h-px flex-1 bg-zinc-200" />
      </div>

      {completed && (
        <div className="mb-5 p-4 bg-green-50 border border-green-200 rounded-lg">
          <p className="text-sm font-medium text-green-800">
            {alreadyCompleted
              ? 'You already completed this lesson. Correct answers shown below.'
              : '✓ Lesson complete — +10 XP earned'}
          </p>
        </div>
      )}

      <div className="space-y-5">
        {questions.map((q, qIdx) => {
          const isWrong = submitted && wrongIds.has(q.id)
          return (
            <div
              key={q.id}
              className={`bg-white rounded-lg border p-5 transition-colors ${
                isWrong ? 'border-red-200' : 'border-zinc-200'
              }`}
            >
              <p className="font-medium text-zinc-900 mb-3">
                <span className="text-zinc-400 mr-2">{qIdx + 1}.</span>
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
                <p className="mt-2 text-xs text-red-500">
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
              className="px-4 py-2 rounded-lg bg-zinc-100 text-zinc-700 text-sm font-medium hover:bg-zinc-200 transition-colors"
            >
              Try again
            </button>
          ) : (
            <button
              onClick={handleSubmit}
              disabled={!allAnswered || pending}
              className="px-6 py-2 rounded-lg bg-zinc-900 text-white text-sm font-medium hover:bg-zinc-700 transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
            >
              {pending ? 'Saving...' : 'Check answers'}
            </button>
          )}
        </div>
      )}
    </div>
  )
}
