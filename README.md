# Ship It

Ship It is an online course platform focused on AI/ML education. Learners work through structured courses made up of modules and lessons, take quizzes, track progress, and level up as they go.

Built with [Next.js](https://nextjs.org) and [Supabase](https://supabase.com), deployed on [Vercel](https://vercel.com).

## Features

- **Courses, modules, and lessons** — content organized into a course → module → lesson hierarchy
- **Quizzes** — most lessons end with a quiz; completing it (or reading a no-quiz lesson) auto-advances to the next lesson
- **Guest mode** — visitors can start learning immediately via anonymous sign-in, no account required
- **Accounts** — GitHub OAuth sign-in for saving progress long-term
- **Progress tracking** — a gamified dashboard shows level, coins, and completion progress across courses

## Tech stack

- [Next.js](https://nextjs.org) (App Router) + [React](https://react.dev)
- [Supabase](https://supabase.com) — auth (GitHub OAuth + anonymous guest sign-in) and Postgres database
- [Tailwind CSS](https://tailwindcss.com)
- [Playwright](https://playwright.dev) for end-to-end tests
- [TypeScript](https://www.typescriptlang.org)

> **Note:** This project runs on a customized fork of Next.js with some non-standard APIs. See `AGENTS.md` if you're contributing and want the details.

## Getting started

### Prerequisites

- Node.js
- A [Supabase](https://supabase.com) project (or the [Supabase CLI](https://supabase.com/docs/guides/local-development) for local development)

### Setup

1. Install dependencies:

   ```bash
   npm install
   ```

2. Create a `.env.local` file in the project root with your Supabase credentials:

   ```bash
   NEXT_PUBLIC_SUPABASE_URL=your-supabase-project-url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
   ```

3. Run the development server:

   ```bash
   npm run dev
   ```

4. Open [http://localhost:3000](http://localhost:3000) in your browser.

### Other scripts

```bash
npm run build   # production build
npm run start   # run the production build locally
npm run lint    # lint the codebase
```

Database schema and course content live in `supabase/migrations/`. Apply them to your Supabase project with the [Supabase CLI](https://supabase.com/docs/guides/local-development/cli/getting-started):

```bash
supabase db push
```

## Project structure

```
src/
  app/
    page.tsx           # landing page
    courses/            # course list + course detail pages
    lessons/[id]/       # lesson pages, quizzes
    dashboard/           # logged-in user dashboard
    login/                # sign-in / guest entry
    auth/callback/         # Supabase auth callback
  components/           # shared UI components
  lib/supabase/          # Supabase client/server helpers
supabase/
  migrations/            # database schema + course content
```

## Deployment

The app is deployed on [Vercel](https://vercel.com). Pushes to `master` deploy automatically.
