-- Fix em dashes introduced by earlier typography-styling migrations.
-- Software Development with Claude Code / Module 7: Git, GitHub, and Working Like a Real Builder
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update lessons set content = $Deec7fd25_8222_4d88_aea0_f0c178bf7ab4$Many beginners confuse Git and GitHub. They are related, but they are not the same thing.

**Git** is a tool on your computer. It tracks changes in your project. It lets you save checkpoints, compare versions, and go back if something breaks.

**GitHub** is a website where you can store your Git project online. It lets you share code, collaborate, review changes, and show your work.

>> Git is a time machine for your project. GitHub is cloud storage plus a public portfolio for your code.


ANALOGY

[!] Imagine writing a book. Git is the version history that saves each draft. GitHub is where you publish the drafts online, collaborate with editors, and show others your work. Without Git, you end up with files called final.doc, final2.doc, final_REAL.doc, final_REAL_latest.doc. Git avoids that mess.


KEY TERMS

**Git:** A version control tool that tracks project changes locally.

**GitHub:** An online platform for storing and sharing Git repositories.

**Version control:** A system that saves the history of changes.

**Repository:** A project folder tracked by Git.

**Commit:** A saved checkpoint in project history.


PRODUCT BUILDER VIEW

For a PM, founder, or beginner builder, GitHub is not just for engineers. It is proof of work. A clean GitHub repo can show: what you built, how you think, what tools you used, how your project evolved, and whether you can explain your work. That matters for portfolios.


IMPORTANT RELATIONSHIP

You can use Git without GitHub. But GitHub needs Git-style project history to be useful. Git works locally on your laptop. GitHub lives online.

  Your laptop (Git)
        ↓ push
  GitHub (online)$Deec7fd25_8222_4d88_aea0_f0c178bf7ab4$ where id = 'eec7fd25-8222-4d88-aea0-f0c178bf7ab4';

update lessons set content = $Def033e30_3c16_422f_81d6_f2e51b3e9c19$When someone opens your GitHub repo, the first thing they usually see is the README. Your README is your project's front door.

A bad README makes the project feel unfinished. A good README tells people: what the project is, why you built it, what it does, what tools you used, how to run it, what you learned, and what you will improve next.

>> For portfolio projects, README matters a lot.


WHAT A GOOD README INCLUDES

  # Portfolio Product
  A beginner full-stack product built while learning with AI.

  ## What this project does
  Users can view project cards, submit contact messages,
  load data from the backend, and save messages to a database.

  ## Why I built this
  To understand how frontend, backend, APIs, and databases
  work together.

  ## Tech stack
  HTML, CSS, JavaScript, Node.js, Express, Supabase, Git, GitHub

  ## How to run locally
  Frontend: open frontend/index.html in the browser.
  Backend: cd backend && npm install && node server.js
  Create backend/.env with SUPABASE_URL and SUPABASE_KEY.

  ## What I learned
  How frontend and backend communicate through APIs.
  How databases store persistent data.
  How Git tracks project history.
  How to use Claude Code as a building partner.

  ## Next improvements
  Deploy frontend and backend.
  Add authentication.
  Improve mobile design.


WHAT MAKES A GOOD README

**Clear:** A beginner can understand what the project does.

**Honest:** It does not pretend the app is bigger than it is.

**Specific:** It says exactly what was built.

**Useful:** It helps someone run or review the project.

**Portfolio-friendly:** It explains what you learned.


COMMON MISTAKE

[!] Writing only "# My project" tells the reader nothing. Your README should make the project understandable even if the code is never opened. Think of it as a cover letter for your project.$Def033e30_3c16_422f_81d6_f2e51b3e9c19$ where id = 'ef033e30-3c16-422f-81d6-f2e51b3e9c19';

update lessons set content = $D09576426_f69b_492a_a446_6f98c6aab78f$A **pull request** (often called a PR) is a request to merge changes from one branch into another.

Usually: feature branch → main branch.

A PR lets you review changes before adding them to the stable version. Even if you work alone, PRs are useful practice.


WHY PRS MATTER

PRs help you: explain what changed, review files before merging, catch mistakes, practice professional workflow, and build a visible project history. Real teams use PRs for every change to production.


SIMPLE PR FLOW

  1. Create a branch:
     git switch -c improve-readme

  2. Make changes and commit:
     git add .
     git commit -m "Improve README setup guide"

  3. Push branch to GitHub:
     git push -u origin improve-readme

  4. Open GitHub, you will see a prompt to create a PR.

  5. Write a description and create the PR.

  6. Review the file changes.

  7. Merge into main.


WHAT A GOOD PR DESCRIPTION INCLUDES

  ## What changed
  - Improved README setup instructions
  - Added project structure section
  - Added environment variable note

  ## Why
  The repo should be easier for reviewers to understand.

  ## How I tested
  - Checked README preview on GitHub
  - Confirmed no .env file is included


PRODUCT BUILDER VIEW

[!] PRs are not only technical. They are communication. A good PR explains what changed, why it matters, how it was tested, and what risks exist. This is exactly how product builders should think about every change.

>> A pull request is how you say: "Here is what I changed. Here is why. Please review before we merge."$D09576426_f69b_492a_a446_6f98c6aab78f$ where id = '09576426-f69b-492a-a446-6f98c6aab78f';

update lessons set content = $D2bbc52f5_9cef_44bb_97b0_e03d6f18b8b7$Now you will turn your learning project into a clean GitHub repo. Your GitHub repo is proof of work.

It should show: you built something real, you understand frontend, backend, and database basics, you can explain your project, you can work with Git properly, and you know not to expose secrets.

>> This does not need to be perfect. It needs to be clear, safe, and honest.


FINAL PROJECT REQUIREMENTS

  1.  Clear repo name (recommendation: portfolio-product)
  2.  Frontend folder
  3.  Backend folder
  4.  README at the root
  5.  .gitignore at the root
  6.  No .env file visible on GitHub
  7.  Clean commit messages
  8.  At least one branch created
  9.  At least one pull request created and merged
  10. At least three issues created
  11. Final push to GitHub


RECOMMENDED PROJECT STRUCTURE

  portfolio-product/
    frontend/
      index.html
      style.css
      script.js
    backend/
      server.js
      package.json
      package-lock.json
      .gitignore
    README.md
    .gitignore
    CLAUDE.md


FINAL CLAUDE CODE PROMPT

Give this to Claude Code:

  Help me prepare my project for GitHub as a clean portfolio repo.

  I have a frontend project and a backend project with Supabase.

  Goal: create a clean repo called portfolio-product.

  Requirements:
  1. Organize into frontend/ and backend/ folders.
  2. Keep code working after moving files.
  3. Create or improve README.md at the root.
  4. Add a root .gitignore covering node_modules and .env files.
  5. Make sure .env and node_modules are not tracked.
  6. Do not expose Supabase keys or secrets.
  7. Suggest clean commit messages.
  8. Help me create a branch for README improvement.
  9. Help me push the repo to GitHub.
  10. Help me create 3 GitHub issues for future improvements.

  Before moving or editing files, explain the plan and risks.


FINAL GIT WORKFLOW

  git status                          ← confirm .env is not included
  git add .
  git commit -m "Prepare portfolio product repo"
  git switch -c improve-readme        ← create branch
  git add README.md
  git commit -m "Improve README documentation"
  git push -u origin improve-readme   ← push branch
  # create PR on GitHub, merge it
  git switch main
  git pull origin main


FINAL QA CHECKLIST

Git: commits are clear, branch was created, PR was created and merged, git status is clean.

GitHub: repo is visible online, README displays properly, issues are created, no .env file visible, no API keys visible.

Project: frontend files present, backend files present, structure is understandable, README explains how to run locally.

Safety: .env ignored, node_modules ignored, Supabase service role key not exposed, no passwords committed.


BADGE UNLOCKED

[!] You completed Module 7. You now know how to work like a real builder.

You learned: Git tracks project history, GitHub stores and shares your work online, repositories are project homes, commits are meaningful checkpoints, branches make experiments safer, remotes connect local work to GitHub, README files explain your project, .gitignore protects secrets and avoids clutter, pull requests help review changes, issues help track product work, and merge conflicts are normal and fixable.

Your project is no longer just sitting on your laptop. It is organized, documented, and visible on GitHub.

Next module: Module 8, Deployment: From Laptop to the World.$D2bbc52f5_9cef_44bb_97b0_e03d6f18b8b7$ where id = '2bbc52f5-9cef-44bb-97b0-e03d6f18b8b7';
