-- Mark up lessons 1.2–1.9 with >> pull quotes, [!] callouts, and **bold** key terms.

-- ─────────────────────────────────────────────────────────────────
-- LESSON 1.2 — The Five Terminal Commands You Actually Need
-- ─────────────────────────────────────────────────────────────────
update lessons set content = $L2$
>> You do not need to learn hundreds of terminal commands to start building software.

For now, you only need five. These five commands help you answer five simple questions:

  1. Where am I?
  2. What is here?
  3. How do I go somewhere else?
  4. How do I create a folder?
  5. How do I create a simple file?

That is enough to start.


COMMAND 1 — pwd

  pwd

Means: "Print **working directory**."
In plain words: "Show me where I am."

A **directory** is just another word for folder. If the terminal shows /Users/jeff, you are inside your personal home folder.


COMMAND 2 — ls

  ls

Means: "**List**."
In plain words: "Show me what is inside this folder."

You may see: Desktop, Documents, Downloads, Pictures — the same folders you see visually, just shown as text.


COMMAND 3 — cd

  cd Desktop

Means: "**Change directory**."
In plain words: "Go into the Desktop folder."

  cd ..       ← go one level back
  cd ~        ← go back to your home folder


COMMAND 4 — mkdir

  mkdir ship-it-workshop

Means: "**Make directory**."
In plain words: "Create a new folder called ship-it-workshop."


COMMAND 5 — echo

  echo "I started shipping today" > started.txt

Means: "Write this text into a file."

This creates a file called started.txt and puts the sentence inside it.

To read it back:
  cat started.txt


BUILD EXERCISE

Run these commands one by one:

  cd ~/Desktop
  mkdir ship-it-workshop
  cd ship-it-workshop
  echo "I started shipping today" > started.txt
  cat started.txt

You created a real project folder. You moved into it. You created a real file. You read it using the terminal. These are real actions developers do every day.


[!] If you see "No such file or directory" — it usually means the folder name is wrong, or you are in the wrong location. Ask Claude: "I am getting 'No such file or directory' in my terminal. Help me check where I am and what folder names exist."
$L2$ where title = 'The Five Terminal Commands You Actually Need';


-- ─────────────────────────────────────────────────────────────────
-- LESSON 1.3 — VS Code: Your Workbench
-- ─────────────────────────────────────────────────────────────────
update lessons set content = $L3$Now you have a project folder.

But writing software directly inside the terminal is not comfortable. You need a place where you can see files, edit code, open a terminal, search, and organize your work.

That place is **VS Code**.

**VS Code** is a **code editor**. A code editor is like Microsoft Word, but for software. It helps you write code, catch mistakes, organize files, and run commands.

>> Think of VS Code as your workbench. Every builder needs a surface where they keep their tools and do their work.

[!] If you are a carpenter, you need a bench where you keep your tools and wood. If you are a chef, you need a kitchen counter where you prepare food. If you are building software, VS Code is that same surface — the place where everything comes together.


SETUP NOTE

If you do not have VS Code installed yet, use the official download link in Lesson 1.9 (Tool Links and Setup Help) at the end of this module.


WHAT YOU SEE IN VS CODE

**File Explorer** — Shows the files and folders in your project.

**Editor** — The center area where you write and edit files.

**Terminal** — A terminal built into VS Code, so you do not need to switch apps.

**Extensions** — Add-ons that make VS Code more powerful.


ACTION STEP

Open VS Code, then open your ship-it-workshop folder.

Option 1 — From VS Code:
  Open VS Code → File → Open Folder → choose Desktop/ship-it-workshop

Option 2 — From terminal (if the code command works):
  cd ~/Desktop/ship-it-workshop
  code .

The dot means "open the current folder."


TINY BUILD TASK

Create a new file in VS Code called notes.txt

Inside it, write:
  VS Code is my software workbench.

Save the file.


WHY THIS MATTERS

From now on, most of your building will happen inside VS Code. The terminal helps you give commands. VS Code helps you see and edit your project. Claude Code helps you build faster. Together, they form your workshop.


COMMON MISTAKE

If code . does not work, that is okay. Just open the folder manually from VS Code. You do not need to fix this immediately.
$L3$ where title = 'VS Code: Your Workbench';


-- ─────────────────────────────────────────────────────────────────
-- LESSON 1.4 — Git: Your Time Machine
-- ─────────────────────────────────────────────────────────────────
update lessons set content = $L4$When you build software, you will make changes constantly.

Some changes will improve the project. Some changes will break it. That is normal.

The dangerous way to work is to keep creating files like:
  project-final
  project-final-v2
  project-final-real
  project-final-latest-new

This becomes messy very fast. **Git** solves this problem.

>> Git is a time machine for your project. It lets you save checkpoints — and go back to any of them if something breaks.

**Git** is a **version control system**. In plain words: it tracks every change you make. Each saved checkpoint is called a **commit**. If something breaks later, you can look back and see exactly what changed, and restore it.


ANALOGY

[!] Imagine you are playing a video game. Before entering a difficult level, you save the game. If you lose, you do not start from the beginning — you return to the saved checkpoint. Git does the same thing for software. Every commit is a save point you can return to.


KEY TERMS

**Git** — Tool that tracks changes in your project.

**Repository** — A project folder that Git is tracking.

**Commit** — A saved checkpoint of your project.

**git init** — Command that tells Git to start tracking a folder.

**git status** — Command that shows what changed.


SETUP NOTE

If git --version does not work, use the official link in Lesson 1.9 (Tool Links and Setup Help).


ACTION STEP

Inside the VS Code terminal, run:
  git --version

If Git is installed, you will see a version number.

Make sure you are inside your project folder:
  cd ~/Desktop/ship-it-workshop

Then run:
  git init

This starts tracking your ship-it-workshop folder.

Now run:
  git status

Git will show you which files exist and what has not been saved yet.


FIRST COMMIT

Run:
  git add .
  git commit -m "Start Ship It workshop"

git add . tells Git: "Prepare all changed files for saving."
git commit -m "..." tells Git: "Save this checkpoint with this message."


COMMON MISTAKE

If Git asks for your name and email, run:
  git config --global user.name "Your Name"
  git config --global user.email "your-email@example.com"

Use the same email you plan to use for GitHub.
$L4$ where title = 'Git: Your Time Machine';


-- ─────────────────────────────────────────────────────────────────
-- LESSON 1.5 — GitHub: Your Cloud Portfolio
-- ─────────────────────────────────────────────────────────────────
update lessons set content = $L5$**Git** works on your computer. **GitHub** is where your Git project lives online.

Git and GitHub are related, but they are not the same thing.

**Git** is the tool that tracks changes. **GitHub** is the website where your tracked project can be stored, shared, reviewed, and shown to others.

[!] Think of Git like saving versions on your laptop. Think of GitHub like putting those versions in the cloud — backed up, visible to others, and accessible from anywhere.


WHY GITHUB MATTERS

GitHub helps with three things:

1. **Backup** — Your code is not only on your laptop.
2. **Sharing** — You can send your project link to others.
3. **Portfolio** — Recruiters, collaborators, and future teammates can see what you built.

For this course, GitHub is important because the goal is not just to learn. The goal is to ship and show proof.

>> A live project and a clean GitHub profile is much stronger than saying "I am learning tech." It is evidence.


SETUP NOTE

If you do not have a GitHub account yet, use the official link in Lesson 1.9 (Tool Links and Setup Help).


KEY TERMS

**GitHub repository** — Online home for your project.

**README** — The front page of your project. It explains what the project is.

**Push** — Send local commits from your computer to GitHub.

**Pull request** — A request to merge code changes. You will learn this later.


ACTION STEP

Create a GitHub account if you do not have one.

Then create a new repository called:
  ship-it-workshop

Keep it public if you want it to become portfolio proof. For now, do not worry about making it perfect. You are just learning what GitHub is.


IMPORTANT SAFETY NOTE

Do not upload secret keys, passwords, API keys, or private documents to GitHub. GitHub is powerful, but public repositories are visible to others.
$L5$ where title = 'GitHub: Your Cloud Portfolio';


-- ─────────────────────────────────────────────────────────────────
-- LESSON 1.6 — Node.js and npm: The Engine and the Parts Store
-- ─────────────────────────────────────────────────────────────────
update lessons set content = $L6$Soon you will build websites and apps using JavaScript.

JavaScript originally became popular because browsers understand it. That means JavaScript can run inside Chrome, Safari, Edge, or Firefox.

But modern builders also use JavaScript outside the browser. That is where **Node.js** comes in.

**Node.js** lets JavaScript run on your computer, not just inside a browser. This matters because many modern web tools depend on Node.js.

[!] Think of JavaScript as a recipe language. The browser is one kitchen where that recipe can be cooked. Node.js is another kitchen — same recipe language, different place to run it.

>> Builders reuse reliable parts instead of starting from zero every time. That is the whole idea behind npm.


WHAT IS npm?

**npm** is the **package manager** that comes with Node.js.

A **package** is reusable code someone else has already written.

Imagine you are building a house. You do not make every brick yourself. You buy bricks, pipes, wires, screws, and windows from suppliers. npm is like the parts store for software.

Need a date picker? There may be a package. Need a chart? There may be a package. Need a tool to create a website? There may be a package.


SETUP NOTE

If node --version or npm --version does not work yet, install Node.js LTS using the official link in Lesson 1.9 (Tool Links and Setup Help).


ACTION STEP

Check if Node.js is installed:
  node --version

Check if npm is installed:
  npm --version

If both show version numbers, you are ready.


WHICH VERSION TO INSTALL?

Install the **LTS** version of Node.js. **LTS** means Long-Term Support — the stable version meant for most users. Avoid experimental or "current" versions when you are just learning.
$L6$ where title = 'Node.js and npm: The Engine and the Parts Store';


-- ─────────────────────────────────────────────────────────────────
-- LESSON 1.7 — Claude Code: Your AI Building Partner
-- ─────────────────────────────────────────────────────────────────
update lessons set content = $L7$Until recently, learning to build software required spending a lot of time memorizing syntax before you could make anything useful.

That has changed.

Now you can describe what you want in plain English, and an AI coding tool can help create files, explain code, fix bugs, and suggest next steps.

**Claude Code** is one such tool. It runs inside your project folder — which means it can look at your actual files and help you change them, not just answer general questions.

But Claude Code is not magic. You are still the builder. You decide what you want. Claude helps you implement it. You review the result. Then you refine it.

>> That loop — Describe → Review → Refine → Repeat — is the most important habit in this course. Master it and you can build almost anything.


SETUP NOTE

If the claude command does not work yet, use the official Claude Code docs linked in Lesson 1.9 (Tool Links and Setup Help). You can also ask Claude or ChatGPT for the latest setup steps for your operating system.


WHAT CLAUDE CODE CAN HELP WITH

  - Understand a project
  - Create files
  - Edit code
  - Explain errors
  - Run commands
  - Write documentation
  - Suggest improvements
  - Help use Git
  - Debug problems


WHAT YOU SHOULD NOT DO

Do not blindly accept everything. Do not run commands you do not understand. Do not paste secret keys into prompts. Do not ask Claude to make huge changes without first asking it to explain the plan.

Good builders use AI like a smart teammate, not like an autopilot.


ACTION STEP

Inside your ship-it-workshop folder, start Claude Code:
  claude

If this is your first time, follow the login steps.

Once inside, ask:
  "What files are in this project, and what does each file do?"

Then ask:
  "Create a CLAUDE.md file for this project. The project is called Ship It Workshop. The learner is a beginner. Always explain commands before running them. Keep the tone simple, practical, and encouraging."


KEY CONCEPT — CLAUDE.md

[!] A CLAUDE.md file is like an onboarding document for your AI teammate. When a new person joins a team, you explain what the project is, what the goal is, what tools you use, and what mistakes to avoid. CLAUDE.md does the same thing for Claude — giving project context so it does not have to guess.


SUGGESTED CLAUDE.md CONTENT

  # Ship It Workshop

  ## Project Goal
  This is a beginner project for learning how to build software with AI assistance.

  ## Learner Level
  The learner is new to coding. Explain concepts simply and avoid unnecessary jargon.

  ## Working Style
  Before changing files, explain the plan.
  Before running commands, explain what the command does.
  Use small steps. Prefer simple solutions over advanced architecture.

  ## Tech Stack
  For now, this project uses basic text files, terminal commands, Git, and VS Code.

  ## Tone
  Friendly, clear, practical, and confidence-building.


SCREENSHOT HELP HABIT

If you are stuck on a screen, error, install step, or confusing message, take a screenshot and show it to Claude or ChatGPT.

Ask: "I am stuck here. Look at this screenshot and tell me exactly what is happening and what I should click or type next. Explain it like I am a beginner."

You do not need to guess blindly. This is how modern builders learn faster.
$L7$ where title = 'Claude Code: Your AI Building Partner';


-- ─────────────────────────────────────────────────────────────────
-- LESSON 1.8 — Workshop Verification
-- ─────────────────────────────────────────────────────────────────
update lessons set content = $L8$Before building real projects, check that your workshop is ready.

A software workshop has a few basic tools:

  **VS Code** — Where you edit files.
  **Terminal** — Where you run commands.
  **Git** — Where you save checkpoints.
  **GitHub** — Where you store and share projects online.
  **Node.js** — Where JavaScript can run outside the browser.
  **npm** — Where reusable code packages come from.
  **Claude Code** — Your AI building partner.
  **CLAUDE.md** — Your project instruction file for Claude.

>> If these are in place, you are not a beginner anymore. You have a real workshop — the same one professional builders use every day.


VERIFICATION COMMANDS

Run these in the VS Code terminal:

  pwd
  ls
  git --version
  node --version
  npm --version

Then check that your folder contains:
  started.txt
  notes.txt
  CLAUDE.md

Run:
  git status

If Git shows changes, save them:
  git add .
  git commit -m "Complete workshop setup"


FINAL CLAUDE PROMPT FOR THIS MODULE

Ask Claude:
  "Review my current project folder. Check whether I have:
   1. started.txt
   2. notes.txt
   3. CLAUDE.md
   4. Git initialized
   5. At least one commit

   Explain what is complete and what is missing. Do not make changes until you show me the checklist."


[!] You do not need every tool installed perfectly before moving forward. Learn what each tool is first — then install it when you actually need it. Understanding comes before setup.


YOUR FINAL FOLDER

  ship-it-workshop/
    started.txt
    notes.txt
    CLAUDE.md

Git should be initialized with at least two commits:
  "Start Ship It workshop"
  "Complete workshop setup"
$L8$ where title = 'Workshop Verification';


-- ─────────────────────────────────────────────────────────────────
-- LESSON 1.9 — Tool Links and Setup Help
-- ─────────────────────────────────────────────────────────────────
update lessons set content = $L9$In this module you came across a few tools. You do not need to memorize where to find them. Use the official links below whenever you are ready.

>> You do not need to install everything perfectly before understanding the ideas. Whenever a tool appears in this course, learn what it is first — then install it when you need it.


OFFICIAL DOWNLOAD LINKS

**VS Code** (code editor):
  https://code.visualstudio.com/download

**Git** (version control):
  https://git-scm.com/install

**Node.js** (choose the LTS version):
  https://nodejs.org/en/download

**GitHub** (cloud code storage):
  https://github.com

**Claude Code** (AI coding assistant):
  https://docs.anthropic.com/en/docs/claude-code/getting-started


HOW TO CHECK IF TOOLS ARE INSTALLED

Open Terminal (Mac) or PowerShell/Terminal (Windows) and run:

  git --version
  node --version
  npm --version
  claude

If you see version numbers or Claude Code opens, the setup is working.


ASK CLAUDE FOR THE LATEST SETUP STEPS

Tool websites and installation steps can change. When you are ready to install a tool, ask Claude or ChatGPT:

  "I am setting up my computer to learn software development. I use [Mac/Windows].
   Please give me the latest official installation steps for [tool name].
   Only use the official website. Tell me which version to choose and how to verify the installation worked."


IF YOU GET STUCK

Take a screenshot and show it to Claude or ChatGPT. Ask:

  "I am stuck on this installation screen. I am trying to install [tool name] on [Mac/Windows].
   Please look at the screenshot and tell me exactly what to click next. Explain in simple steps."

This is a normal part of learning. Do not guess randomly.


[!] Only download from official websites. Avoid random download buttons, unknown blogs, unofficial installers, or YouTube description links from unknown creators. When unsure, ask: "Is this the official website for downloading [tool name]?"
$L9$ where title = 'Tool Links and Setup Help';
