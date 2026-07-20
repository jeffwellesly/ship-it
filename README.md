# Ship It

A full-stack AI/ML course platform, built while learning to build full-stack apps with AI as a coding partner.

## What this project does

Ship It is an online course platform. Visitors can browse an AI/ML course made up of modules and lessons, work through it as a guest (no sign-up required) or sign in with GitHub to save progress, take quizzes at the end of most lessons, and track their progress on a gamified dashboard (levels, coins, completion state) that's backed by a real database.

## Why I built this

To understand how a real full-stack app fits together: how a frontend talks to a backend, how auth and user sessions actually work (including an anonymous "guest" flow, not just login/logout), how a Postgres database models and stores that kind of app state, and how to iterate on a live product with Claude Code as a building partner.

## Tech stack

Next.js (App Router), React, TypeScript, Supabase (Postgres database + auth — GitHub OAuth and anonymous guest sign-in), Tailwind CSS, Playwright, Git, GitHub, deployed on Vercel.

## How to run locally

```bash
npm install
```

Create a `.env.local` file in the project root:

```
NEXT_PUBLIC_SUPABASE_URL=your-supabase-project-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
```

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000).

Database schema and course content are managed as Supabase migrations in `supabase/migrations/` — apply them to your own Supabase project with `supabase db push`.

## What I learned

- How the Next.js App Router splits work between server and client components, and how server actions talk to the database
- How to model auth beyond simple login/logout — anonymous guest sessions that can later convert to a real account
- How to design a Postgres schema (courses → modules → lessons → quizzes → user progress) and ship changes to it safely via migrations
- How to use Git and GitHub to track a project's history and iterate in small, reviewable commits
- How to work with Claude Code as a building partner — describing what I want, reviewing what it changes, and catching issues before they ship

## Next improvements

- Add more course tracks beyond the current AI/ML course
- Add an email/password sign-in option alongside GitHub OAuth
- Further mobile polish on the dashboard and lesson pages
- Automated end-to-end test coverage for the quiz and progress-tracking flows
