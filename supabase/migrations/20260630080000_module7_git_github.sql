-- Module 7: Git, GitHub, and Working Like a Real Builder
-- 12 lessons with >> pull quotes, [!] callouts, **bold** key terms, ALL CAPS headers, 2-space code blocks

do $$
declare
  v_course_id uuid;
  v_module_id uuid;
  v_l1 uuid; v_l2 uuid; v_l3 uuid; v_l4 uuid; v_l5 uuid; v_l6 uuid;
  v_l7 uuid; v_l8 uuid; v_l9 uuid; v_l10 uuid; v_l11 uuid; v_l12 uuid;
begin

  select id into v_course_id from courses where sort_order = 1;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 7: Git, GitHub, and Working Like a Real Builder',
    'Learn Git and GitHub by organizing, documenting, and publishing your project repo like a real builder.',
    7
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.1 — Git vs GitHub: Time Machine vs Cloud Portfolio
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Git vs GitHub: Time Machine vs Cloud Portfolio',
    1,
    $L71$Many beginners confuse Git and GitHub. They are related, but they are not the same thing.

**Git** is a tool on your computer. It tracks changes in your project. It lets you save checkpoints, compare versions, and go back if something breaks.

**GitHub** is a website where you can store your Git project online. It lets you share code, collaborate, review changes, and show your work.

>> Git is a time machine for your project. GitHub is cloud storage plus a public portfolio for your code.


ANALOGY

[!] Imagine writing a book. Git is the version history that saves each draft. GitHub is where you publish the drafts online, collaborate with editors, and show others your work. Without Git, you end up with files called final.doc, final2.doc, final_REAL.doc, final_REAL_latest.doc. Git avoids that mess.


KEY TERMS

**Git** — A version control tool that tracks project changes locally.

**GitHub** — An online platform for storing and sharing Git repositories.

**Version control** — A system that saves the history of changes.

**Repository** — A project folder tracked by Git.

**Commit** — A saved checkpoint in project history.


PRODUCT BUILDER VIEW

For a PM, founder, or beginner builder, GitHub is not just for engineers. It is proof of work. A clean GitHub repo can show: what you built, how you think, what tools you used, how your project evolved, and whether you can explain your work. That matters for portfolios.


IMPORTANT RELATIONSHIP

You can use Git without GitHub. But GitHub needs Git-style project history to be useful. Git works locally on your laptop. GitHub lives online.

  Your laptop (Git)
        ↓ push
  GitHub (online)$L71$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.2 — Repository: Your Project's Home
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Repository: Your Project''s Home',
    2,
    $L72$A **repository**, often called a repo, is a project folder tracked by Git.

When you turn a folder into a Git repo, Git starts watching changes inside it.

Examples:
  my-first-webpage/
  my-first-backend/
  portfolio-product/

The repo is your project's home.


LOCAL REPO VS REMOTE REPO

A **local repo** lives on your computer. A **remote repo** lives online, usually on GitHub.

You work locally. Then you push to GitHub.

  Your laptop repo
        ↓ push
  GitHub repo

Later, someone else can clone the GitHub repo and get a copy of your work.


RECOMMENDED STRUCTURE FOR THIS COURSE

By now you may have separate folders. For a cleaner portfolio project, we can create one combined folder:

  portfolio-product/
    frontend/
    backend/
    README.md
    .gitignore
    CLAUDE.md

This makes it clear that the frontend and backend belong to the same product.


BEGINNER RULE

[!] A repo should be easy for another person to understand. When someone opens your project, they should quickly know: what this project does, where the frontend code is, where the backend code is, how to run it, what tools it uses, and what is still missing. That is why structure matters.

>> A repository is not just a folder. It is a clear, organized home for your project and its history.$L72$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.3 — Commits: Saving Checkpoints
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Commits: Saving Checkpoints',
    3,
    $L73$A **commit** is a saved checkpoint in your project. Think of it like saying: "Save this version. It works."

Commits help you: track progress, understand what changed, go back if needed, explain your work, and collaborate with others.

A commit should usually represent one meaningful change.


THE BASIC COMMIT FLOW

  git status          ← see what changed
  git add .           ← prepare files
  git commit -m "Add project cards"    ← save checkpoint

git status shows what changed. git add . prepares changed files for commit. git commit -m saves the checkpoint with a message.


GOOD COMMIT MESSAGES

Good messages explain what changed:

  Add project cards to frontend
  Connect backend to Supabase
  Add contact form validation
  Fix mobile layout
  Update README setup steps

Bad messages:

  changes
  final
  stuff
  asdf

[!] A commit message should help future you understand the history. Write it for the reader who opens git log six months from now.


PRODUCT BUILDER RULE

Commit when you complete a working step: after adding a new section, after fixing a bug, after connecting an API, after updating README, after improving mobile layout. Do not wait until everything is perfect.

>> Real builders save checkpoints often. Small, clear commits are better than one huge unclear commit.$L73$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.4 — Status, Diff, and Log: Knowing What Changed
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Status, Diff, and Log: Knowing What Changed',
    4,
    $L74$Before saving work, you should know what changed. Git gives you three very useful commands:

  git status
  git diff
  git log --oneline


GIT STATUS

Shows the current state of your repo.

  git status

It tells you: which files changed, which files are staged, which files are untracked, and which branch you are on. Use this constantly.


GIT DIFF

Shows the actual line-by-line changes.

  git diff

Use this before committing. It helps you catch mistakes. You may notice you accidentally changed a file you did not mean to change.


GIT LOG --ONELINE

Shows recent commit history in a compact format.

  git log --oneline

Example output:
  a1b2c3d Add contact form validation
  e4f5g6h Connect backend to Supabase
  h7i8j9k Add project cards

This shows the story of your project.


PRODUCT BUILDER HABIT

[!] Before committing, ask yourself: What changed? Why did it change? Is this one clear checkpoint? Only then commit.


MINI EXERCISE

Run these three commands in order:
  git status
  git diff
  git log --oneline

Write down: what files changed, one actual code change you see, and what your last commit was.

>> git status tells you the state, git diff shows you the changes, git log shows you the story.$L74$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.5 — Branches: Safe Experiments
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Branches: Safe Experiments',
    5,
    $L75$A **branch** is a separate line of work. The main branch should stay stable. When you want to try a new feature or improvement, create a branch. That way, if the experiment fails, your main work is still safe.


ANALOGY

[!] Imagine your project is a road. The main road is stable. A branch is a side road where you can test a different path. If the side road is good, you merge it back into the main road. If it is bad, you abandon it and the main road is untouched.


COMMON BRANCH FLOW

Create and switch to a new branch:
  git switch -c improve-readme

Make changes, then commit:
  git add .
  git commit -m "Improve README setup instructions"

Switch back to main:
  git switch main

Merge the branch:
  git merge improve-readme


BRANCH NAMING

Good branch names describe the work:
  improve-readme
  add-contact-form
  fix-mobile-layout
  connect-supabase

Bad branch names:
  new
  test
  stuff
  final

>> Branch names should describe the work, just like commit messages.


WHY BRANCHES MATTER

Branches let you work without fear. You can ask Claude to make changes on a branch, then review before merging. This is much safer than making big changes directly on main.

After merging, you can delete the branch:
  git branch -d improve-readme$L75$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.6 — GitHub Remote: Push Your Work Online
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'GitHub Remote: Push Your Work Online',
    6,
    $L76$So far, Git history may live only on your computer. That is useful, but not enough. You also want your project online so others can see it and you have a backup.

A **remote** is the online location of your repo. To connect your local repo to GitHub, you add a remote.


THE FLOW

  Local repo on your laptop
        ↓ git push
  GitHub repo online

When you push, you send your commits to GitHub. When you pull, you bring changes from GitHub to your laptop.


COMMON COMMANDS

Check existing remotes:
  git remote -v

Add a remote named origin:
  git remote add origin YOUR_GITHUB_REPO_URL

Rename current branch to main:
  git branch -M main

Push first time and set tracking:
  git push -u origin main

After the first push, usually just:
  git push


BEGINNER GITHUB SETUP RULE

[!] When creating a GitHub repo for an existing local project: create an empty GitHub repo without README, .gitignore, or license. If your local project already has those files, adding them on GitHub too causes merge conflicts on first push.


COMMON MISTAKE

You create a GitHub repo with a README. Your local repo also has commits. When you push, Git complains because both histories are different. If this happens, do not panic. Ask Claude: "I created a GitHub repo with a README but my local repo also has commits. Git is giving me an error when I push. Explain what happened and help me fix it safely."

>> After your first push, refresh GitHub. You should see your files online.$L76$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.7 — README: Your Project's Front Door
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'README: Your Project''s Front Door',
    7,
    $L77$When someone opens your GitHub repo, the first thing they usually see is the README. Your README is your project's front door.

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

**Clear** — A beginner can understand what the project does.

**Honest** — It does not pretend the app is bigger than it is.

**Specific** — It says exactly what was built.

**Useful** — It helps someone run or review the project.

**Portfolio-friendly** — It explains what you learned.


COMMON MISTAKE

[!] Writing only "# My project" tells the reader nothing. Your README should make the project understandable even if the code is never opened. Think of it as a cover letter for your project.$L77$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.8 — .gitignore: What Not to Save
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    '.gitignore: What Not to Save',
    8,
    $L78$Not every file should go to GitHub. Some files are private. Some files are huge. Some files are generated automatically. Some files belong only on your computer.

That is why we use **.gitignore**. A .gitignore file tells Git: "Do not track these files."


MOST IMPORTANT RULE

Never commit secrets. Secrets include: API keys, passwords, database passwords, Supabase service role keys, private tokens, and .env files.

[!] If secrets go to GitHub, someone else may access your systems. Even if you delete the file later, Git history may still contain the secret.


COMMON .gitignore FOR THIS PROJECT

  node_modules/
  .env
  backend/.env
  backend/node_modules/
  .DS_Store

This covers: environment variable files, installed packages, and macOS system files.


WHY IGNORE NODE_MODULES?

node_modules contains installed packages and can be huge. You do not push it to GitHub. Instead you push package.json and package-lock.json. Then someone can run npm install to recreate node_modules on their machine.


IF YOU ACCIDENTALLY COMMIT A SECRET

Do not just delete it and think everything is okay. Git history may still contain the secret.

Safer steps:
  1. Stop using that key immediately
  2. Rotate or regenerate the key
  3. Remove it from the repo
  4. Ask for help cleaning Git history

Ask Claude: "I accidentally committed a .env file to GitHub. Explain the safest steps to fix this. Include rotating the key and removing the secret from Git history."

>> Check git status before every push. If .env appears, stop and fix it before continuing.$L78$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.9 — Pull Requests: Review Before Merging
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Pull Requests: Review Before Merging',
    9,
    $L79$A **pull request** (often called a PR) is a request to merge changes from one branch into another.

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

  4. Open GitHub — you will see a prompt to create a PR.

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

>> A pull request is how you say: "Here is what I changed. Here is why. Please review before we merge."$L79$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.10 — Issues: Track Work Like a Product Builder
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Issues: Track Work Like a Product Builder',
    10,
    $L710$GitHub is not only for code. You can also use **GitHub Issues** to track work.

An issue is a task, bug, idea, or improvement. For example:

  Improve mobile layout
  Add blog posts table
  Deploy frontend to Vercel
  Add authentication
  Fix contact form error message


WHY ISSUES MATTER

Without issues, your project improvements live in your head. That becomes messy. With issues, you can track: bugs, features, improvements, questions, and future ideas. This is how real teams work.


GOOD ISSUE STRUCTURE

  ## Problem
  The contact form success message is too easy to miss.

  ## Desired outcome
  After submission, the user should clearly see that
  the message was saved.

  ## Suggested solution
  Show a success card below the form with clear text.

  ## Acceptance criteria
  - Success message appears after valid submission
  - Error message appears after invalid submission
  - Message is readable on mobile


PRODUCT BUILDER RULE

[!] A good issue should explain the desired outcome, not just the task.

Weak: "Fix form."
Better: "Make contact form success and error messages clearer."
Best: "After submitting the contact form, users should clearly understand whether the message was saved or failed."

>> The best issues explain the outcome from the user's perspective, not just the technical task.


MINI EXERCISE

Create three GitHub issues for your project:
  1. Improve mobile layout
  2. Add blog section
  3. Deploy project online

For each, include: problem, desired outcome, and acceptance criteria.$L710$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.11 — Merge Conflicts: When Two Changes Collide
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Merge Conflicts: When Two Changes Collide',
    11,
    $L711$A **merge conflict** happens when Git cannot automatically combine changes. This usually happens when two branches edit the same part of the same file.

Git stops and says: "I need a human to decide which version to keep."

This sounds scary, but it is normal. Merge conflicts are not disasters. They are decision points.


ANALOGY

[!] Imagine two people edit the same sentence in a shared document. Person A writes: "This project teaches frontend and backend." Person B writes: "This project teaches full-stack product building." Git does not know which sentence is better. So it asks you to decide.


WHAT CONFLICT MARKERS LOOK LIKE

A conflicted file shows markers like this:

  <<<<<<< HEAD
  This project teaches frontend and backend.
  =======
  This project teaches full-stack product building.
  >>>>>>> improve-readme

The top part is one version. The bottom part is the other. You must edit the file manually and keep the final text you want.

Final cleaned version:
  This project teaches full-stack product building with
  frontend, backend, and database basics.

Then delete the conflict markers and save the file.


BASIC CONFLICT FIX FLOW

  1. Open the conflicted file
  2. Find the <<<<<<<, =======, and >>>>>>> markers
  3. Decide which version (or a combination) to keep
  4. Delete all three marker lines
  5. Save the file
  6. Run: git add . && git commit

>> Merge conflicts are not bugs. They are Git asking you a question. Stay calm, read the markers, and choose.


IF YOU ARE STUCK

Ask Claude: "I have a Git merge conflict. Explain what the conflict markers mean. Help me choose a clean final version, remove the markers, and complete the merge safely." You can paste the conflicted section directly into Claude.$L711$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.12 — Module Project: Publish a Clean GitHub Repo
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Module Project: Publish a Clean GitHub Repo',
    12,
    $L712$Now you will turn your learning project into a clean GitHub repo. Your GitHub repo is proof of work.

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

Next module: Module 8 — Deployment: From Laptop to the World.$L712$
  ) returning id into v_l12;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (12 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 7.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'Which one tracks project history on your computer?',
    '["Git","GitHub","Supabase","CSS"]',
    0
  );

  -- Q2 — Lesson 7.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What is a repository?',
    '["A project folder tracked by Git","A CSS color","A database password","A browser tab"]',
    0
  );

  -- Q3 — Lesson 7.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'What is a Git commit?',
    '["A saved checkpoint in project history","A deployed website","A database table","A CSS file"]',
    0
  );

  -- Q4 — Lesson 7.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'Which command shows the actual line-by-line changes before committing?',
    '["git diff","git push","git clone","git init"]',
    0
  );

  -- Q5 — Lesson 7.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'Why use a branch?',
    '["To safely work on changes without disturbing the stable main branch","To delete GitHub","To make CSS load faster","To create a database table"]',
    0
  );

  -- Q6 — Lesson 7.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'What does git push do?',
    '["Sends local commits to GitHub","Deletes a database","Opens VS Code","Changes HTML to CSS"]',
    0
  );

  -- Q7 — Lesson 7.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'Why is README important?',
    '["It is the first explanation people see when they open your repo","It makes buttons clickable","It replaces Git","It stores API keys"]',
    0
  );

  -- Q8 — Lesson 7.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'Why should .env be in .gitignore?',
    '["It may contain secret keys that should not be pushed to GitHub","It makes CSS faster","It makes GitHub public","It stores images"]',
    0
  );

  -- Q9 — Lesson 7.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'What is a pull request?',
    '["A request to review and merge changes from one branch into another","A database query","A CSS selector","A way to install Node.js"]',
    0
  );

  -- Q10 — Lesson 7.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'What is a GitHub issue useful for?',
    '["Tracking bugs, tasks, and improvements","Changing DNS automatically","Replacing the database","Writing CSS without code"]',
    0
  );

  -- Q11 — Lesson 7.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What does a merge conflict mean?',
    '["Git needs a human to decide how to combine changes","GitHub deleted your project","CSS failed to load","Supabase stopped working"]',
    0
  );

  -- Q12 — Lesson 7.12
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l12,
    'Before pushing your final project to GitHub, what should you always check?',
    '["That .env is not listed in git status","That all fonts are correct","That Supabase is turned off","That node_modules is pushed too"]',
    0
  );

end $$;
