-- Module 8: Deployment — From Laptop to the World
-- 11 lessons with >> pull quotes, [!] callouts, **bold** key terms, ALL CAPS headers, 2-space code blocks

do $$
declare
  v_course_id uuid;
  v_module_id uuid;
  v_l1 uuid; v_l2 uuid; v_l3 uuid; v_l4 uuid; v_l5 uuid; v_l6 uuid;
  v_l7 uuid; v_l8 uuid; v_l9 uuid; v_l10 uuid; v_l11 uuid;
begin

  select id into v_course_id from courses where sort_order = 1;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 8: Deployment: From Laptop to the World',
    'Deploy your project so other people can open and use it through a live URL.',
    8
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.1 — What Deployment Means
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Deployment Means',
    1,
    $L81$So far, your project works mostly on your computer. That is called **local development**. Local development is private. You can test quickly. You can break things safely. But other people cannot easily use your product.

**Deployment** means putting your product on the internet so other people can access it through a URL.

Before deployment:
  Only I can open it on my laptop.

After deployment:
  Anyone with the link can open it.

>> That is a major shift. You are no longer just practicing. You are shipping.


ANALOGY

[!] Building locally is like cooking in your home kitchen. Deployment is like opening a small restaurant. Now other people can walk in. That means you must think about: is it working, is it safe, is it clear, does the link open, does the backend respond, and are secrets protected?


KEY TERMS

**Local development** — Running the project on your own computer.

**Deployment** — Putting the project online.

**Hosting** — The service that runs your frontend or backend online.

**Production** — The live version users can access.

**Public URL** — A link other people can open.


PRODUCT EXAMPLE

Your frontend may currently open like this:
  file:///Users/jeff/Desktop/project/index.html
or:
  http://localhost:5173

That works only for you. After deployment it may look like:
  https://your-project.vercel.app

That is public. Now you can put the link on your resume, LinkedIn, or portfolio.


WHAT SHOULD BE PUBLIC VS PRIVATE

Public:
  frontend page, project cards, contact form

Private:
  Supabase keys, backend environment variables, .env file$L81$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.2 — Localhost vs Public URL
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Localhost vs Public URL',
    2,
    $L82$You have probably used URLs like:
  http://localhost:3000

This is not a real internet URL. **localhost** means "this computer." When you open localhost:3000, your browser is talking to a server running on your own laptop.

That is useful for development. But if you send that link to a friend, it will not open your project. On their computer, localhost means their own computer, not yours.


ANALOGY

[!] Imagine saying "come to my house." That only works if the person knows your address. localhost is like saying "come here" — but "here" means different things for different people. A public URL is like a real street address. Anyone can use it to find the place.


LOCAL VS PUBLIC FLOW

Local flow:
  Browser on your laptop
        ↓
  Server on your laptop
        ↓
  Response to your laptop

Public deployment flow:
  User's browser
        ↓
  Internet
        ↓
  Hosted server
        ↓
  Response to user's browser


WHY THIS MATTERS

If your frontend code says:
  fetch("http://localhost:3000/api/projects")

it may work on your laptop. But after deployment it will fail for other users. Their browser will try to call their own localhost:3000. Your backend is not running there.

For deployed apps, your frontend must call the live backend URL:
  fetch("https://your-backend.onrender.com/api/projects")

[!] Before deploying, search your frontend code for every place that says "localhost." Each one must change to the live backend URL.

>> localhost means my own computer. A deployed frontend needs a real backend URL.$L82$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.3 — Frontend Hosting vs Backend Hosting
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Frontend Hosting vs Backend Hosting',
    3,
    $L83$Your project has different parts. The frontend is mostly files: HTML, CSS, JavaScript, images. The backend is a running server: Express app, API routes, environment variables, database connection. These are deployed differently.


FRONTEND HOSTING

Frontend hosting serves your user interface. It sends files to the browser. When a user opens your frontend URL, the host sends those files. The browser displays the page. Frontend hosting is often simpler — the host just needs to deliver static files.


BACKEND HOSTING

Backend hosting runs your server code. Your backend must be alive and listening for requests. When the frontend calls your backend, the host runs your Express app and returns JSON. Backend hosting must also know your environment variables.


DATABASE HOSTING

Your database is separate. In this course, Supabase hosts the database. So the final system looks like:

  User browser
        ↓
  Frontend host
        ↓
  Backend host
        ↓
  Supabase database

Each part has one job.


PRODUCT ARCHITECTURE

[!] GitHub stores your code. The frontend host serves your user interface. The backend host runs your API. Supabase stores your data. These are four separate systems working together.


LABEL THESE

index.html → Frontend.
server.js → Backend.
projects table → Database.
POST /api/messages → Backend endpoint.
style.css → Frontend.
Supabase URL → Database config and environment variable.

>> Frontend hosting serves files. Backend hosting runs live server code. Supabase hosts the database.$L83$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.4 — Build Step: Preparing Code for the Internet
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Build Step: Preparing Code for the Internet',
    4,
    $L84$Some projects can be deployed as simple files: index.html, style.css, script.js. These may not need a build step. But many modern frontend projects use tools like Vite, React, Next.js, TypeScript, or Tailwind. These tools often need a build command.

A **build step** prepares the project for production.


ANALOGY

[!] Development code is like ingredients in your kitchen. A production build is like packed food ready for delivery. The build step organizes, optimizes, and bundles everything for hosting.


COMMON BUILD COMMAND

  npm run build

This usually creates a production-ready folder called dist or build. The hosting platform serves that output folder instead of your raw source files.


HOW TO KNOW IF YOU NEED A BUILD STEP

Check your package.json. If it has:

  "scripts": {
    "build": "vite build"
  }

then the build command is: npm run build
and the output folder is: dist

If your frontend has no package.json, it is likely plain HTML, CSS, and JavaScript. No build step needed.


DO NOT GUESS

[!] Do not copy build settings from a tutorial without checking your own project. Your package.json is the source of truth. Ask Claude to inspect it if you are unsure.

Ask Claude:
  Check my frontend project and tell me whether it needs a build step
  for deployment. If yes, explain the build command and output folder.
  If no, explain why plain HTML/CSS/JS can be deployed directly.

>> Know your project before setting build settings on the hosting platform.$L84$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.5 — Environment Variables in Production
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Environment Variables in Production',
    5,
    $L85$Locally, your backend may use a .env file:

  SUPABASE_URL=your_supabase_url
  SUPABASE_KEY=your_supabase_key

That works on your computer. But your deployed backend cannot read the .env file from your laptop. The hosting platform needs those variables in its own settings.


ANALOGY

[!] Your local .env is like a private note on your desk. Your deployed app runs in someone else's building. It cannot read the note on your desk. So you must safely enter those values into the hosting platform's environment variable settings.


IMPORTANT RULE

Do not push .env to GitHub. Do not paste secret keys into frontend code. Do not hardcode secrets into server.js. Always use environment variables.


LOCAL VS PRODUCTION

Local: .env file on your computer.
Production: environment variables in hosting platform dashboard.

The code stays the same:
  process.env.SUPABASE_URL
  process.env.SUPABASE_KEY

Only the place where values are stored changes.


FRONTEND ENVIRONMENT VARIABLES

[!] Frontend environment variables are different. Anything included in frontend code can become visible to users in the browser. So do not put powerful secret keys in frontend environment variables. The backend holds secrets. The frontend should only use public-safe config like the API base URL.


CLASSIFY YOUR VARIABLES

Backend environment variables (secret, set in backend host):
  SUPABASE_URL
  SUPABASE_KEY
  PORT

Frontend configuration (public-safe):
  API_BASE_URL (the live backend URL)

>> Local .env is for your computer. Production environment variables must be set in the hosting platform.$L85$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.6 — Deploy the Frontend
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Deploy the Frontend',
    6,
    $L86$Now you will deploy the visible part of your product. For this course, use a beginner-friendly frontend host like Vercel. The exact dashboard steps may change over time, so always prefer official platform documentation.

The core idea stays the same:
  GitHub repo → Import project → Configure → Deploy → Get public URL


BEFORE DEPLOYING

Check:
  1. Frontend works locally
  2. Code is pushed to GitHub
  3. README exists
  4. .env is not pushed
  5. If using build tools, build works locally
  6. API URL is configurable, not hardcoded to localhost


DEPLOYMENT FLOW

  Open frontend hosting platform
        ↓
  Import GitHub repo
        ↓
  Choose frontend folder if needed
        ↓
  Set build command if needed
        ↓
  Set output folder if needed
        ↓
  Add frontend environment variables if needed
        ↓
  Deploy
        ↓
  Copy public URL


IF YOUR FRONTEND IS PLAIN HTML/CSS/JS

You may need to deploy the folder containing index.html, style.css, and script.js. No build command may be needed. Set the root directory to wherever index.html lives.


IF YOUR FRONTEND USES VITE

Common settings:
  Build command: npm run build
  Output directory: dist

But check your own project. Do not blindly copy settings. Ask Claude to inspect your package.json first.


COMMON ERRORS

[!] Wrong root directory: deployment succeeds but page is blank. Fix: set root directory to the frontend folder. Wrong build command: build fails. Fix: check package.json scripts. Still calling localhost: frontend loads but data fails. Fix: update API URL to live backend.

Ask Claude:
  Help me deploy my frontend project. Inspect my frontend folder and tell
  me: plain HTML or build-tool project? Does it need npm install? Does it
  need npm run build? What is the output directory? What environment
  variables are needed?$L86$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.7 — Deploy the Backend API
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Deploy the Backend API',
    7,
    $L87$Your frontend shows the product. Your backend does the hidden work. Now you need to deploy your backend API so it has a public URL.

After deployment, your endpoints become public:
  https://your-backend-host.com/api/projects
  https://your-backend-host.com/api/messages


BEFORE DEPLOYING BACKEND

Check:
  1. Backend runs locally
  2. package.json exists
  3. Start script exists
  4. .env is not pushed
  5. Environment variables are ready
  6. Supabase connection works locally
  7. Backend uses process.env.PORT


IMPORTANT: SUPPORT PLATFORM PORT

Many hosting platforms provide their own PORT. Your backend should support that:

  const PORT = process.env.PORT || 3000;

  app.listen(PORT, () => {
    console.log("Server running on port " + PORT);
  });

This allows the platform to choose the port.


ADD A START SCRIPT

In package.json you should have:

  "scripts": {
    "start": "node server.js"
  }

Hosting platforms often use this to start your backend.


BACKEND DEPLOYMENT FLOW

  Open backend hosting platform
        ↓
  Create new web service
        ↓
  Connect GitHub repo
        ↓
  Choose backend folder if needed
        ↓
  Set install command: npm install
        ↓
  Set start command: npm start
        ↓
  Add environment variables
        ↓
  Deploy → get backend URL


COMMON ERRORS

[!] Missing start command: platform does not know how to start app. Fix: add "start": "node server.js" to package.json. Wrong port: app starts locally but fails online. Fix: use process.env.PORT || 3000. Missing env variables: Supabase fails online. Fix: add SUPABASE_URL and SUPABASE_KEY in hosting platform settings. CORS error: frontend cannot call backend. Fix: allow your deployed frontend URL in backend CORS settings.

>> After deployment, open your live backend URL. If you see JSON, it is working.$L87$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.8 — Connect Live Frontend to Live Backend
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Connect Live Frontend to Live Backend',
    8,
    $L88$Now you have two live URLs: a frontend URL and a backend URL. But they are not automatically connected. Your frontend must know where the backend lives.

If your frontend still calls http://localhost:3000, it will fail for users.


THE FULL FLOW

  User opens live frontend
        ↓
  Frontend JavaScript calls live backend
        ↓
  Backend talks to Supabase
        ↓
  Backend returns JSON
        ↓
  Frontend displays result


EXAMPLE: REPLACE LOCALHOST

Old local code:
  const API_BASE_URL = "http://localhost:3000";

Live code:
  const API_BASE_URL = "https://your-live-backend-url";

Then use:
  fetch(API_BASE_URL + "/api/projects")
  fetch(API_BASE_URL + "/api/messages")

Use one place for the API base URL. If the backend URL ever changes, update one line.


CORS REMINDER

[!] Your backend may need to allow requests from your live frontend URL. CORS is a browser safety rule about which websites are allowed to call which servers. For local development you may allow http://localhost:5173. For production, allow your frontend public URL. Do not blindly allow everything for a real product.


TESTING CHECKLIST

Open your live frontend and check:
  1. Page loads
  2. Project cards load from backend
  3. Contact form submits
  4. Supabase receives the message
  5. No CORS errors in browser console
  6. Network tab shows live backend URL
  7. No request goes to localhost

[!] Testing only the homepage is a common mistake. Your homepage may load fine even if the backend connection is broken. You must test real product actions: load projects, submit contact form, check Supabase dashboard.$L88$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.9 — Logs, Errors, and Health Checks
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Logs, Errors, and Health Checks',
    9,
    $L89$When an app breaks on your laptop, you look at the terminal. When an app breaks online, you look at **logs**.

Logs are messages from your deployed app. They help you understand: did the app start, did it crash, which request failed, was an environment variable missing, did Supabase return an error?


ANALOGY

[!] Logs are like CCTV for your server. You cannot stand inside the hosted machine. But logs show what happened. Every hosting platform has a logs section — find it when things go wrong.


WHAT TO CHECK FIRST

If deployed backend fails:
  1. Did deployment complete successfully?
  2. Did install succeed?
  3. Did start command run?
  4. Did server listen on correct port?
  5. Are environment variables set?
  6. Is Supabase reachable?
  7. Are CORS settings correct?
  8. What do logs say?


ADD A HEALTH CHECK ENDPOINT

A health check is a simple route that confirms your backend is alive.

  app.get("/health", (req, res) => {
    res.json({
      status: "ok",
      message: "Backend is running"
    });
  });

Then open:
  https://your-backend-url/health

If it returns JSON, your backend is alive. This is the first thing to test after deploying.


COMMON ERROR PATTERNS

404 — The route does not exist. Check endpoint path.
500 — Backend received request but failed internally. Check logs.
CORS error — Browser blocked frontend-backend request. Check CORS settings.
Environment variable error — Backend cannot find required secret. Check hosting platform env settings.
Database error — Supabase query failed. Check table name, key, RLS, or schema.


DEBUGGING PROMPT

Ask Claude:
  My deployed backend is failing. Help me debug step by step.
  Frontend URL: [your URL]
  Backend URL: [your URL]
  Error message: [paste it]
  Logs: [paste them]
  What I expected: [describe]
  What happened: [describe]
  Tell me the likely cause and the next safest thing to check.

>> Logs are how deployed apps communicate with you. Always check them before guessing.$L89$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.10 — Custom Domains, HTTPS, and Trust
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Custom Domains, HTTPS, and Trust',
    10,
    $L810$A deployed project usually gets a default URL like:
  your-project.vercel.app
or:
  your-backend-host.com

That is enough for a first project. Later, you may want a **custom domain** like:
  yourname.com
or:
  shipitapp.com

A custom domain makes the product feel more professional.


HTTPS

**HTTPS** means the connection between browser and server is encrypted. Modern deployment platforms usually provide HTTPS automatically. Users expect it. Browsers may show warnings for unsafe pages. For anything involving forms, login, payments, or user data, HTTPS matters.

[!] If your hosting platform provides HTTPS automatically, you do not need to configure it manually. This is one area where beginner-friendly platforms save significant setup time.


DOMAIN MENTAL MODEL

A domain name is like a human-friendly address. DNS points that name to the right hosting platform. You learned DNS in Module 3. Now it becomes practical.

  Domain name
        ↓
  DNS settings
        ↓
  Hosting platform
        ↓
  Your deployed app


SHOULD YOU ADD A CUSTOM DOMAIN NOW?

For a beginner project, a custom domain is not required.

Good enough for MVP:
  your-project.vercel.app

Better for portfolio:
  projects.yourname.com

Best for later:
  a polished personal website with project links

>> Do not block shipping because of domain setup. First get the app deployed. Then improve the URL. Shipping a working product matters more than a perfect URL.$L810$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.11 — Module Project: Launch Your First Full-Stack Project
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Module Project: Launch Your First Full-Stack Project',
    11,
    $L811$Now you will launch your first full-stack project.

This is a major milestone. You are putting together: frontend, backend, database, GitHub, deployment, environment variables, and public URLs.

>> Not just coding. Shipping.


FINAL PROJECT REQUIREMENTS

  1.  GitHub repo pushed and clean
  2.  Frontend deployed with a live URL
  3.  Backend deployed with a live API URL
  4.  Supabase database connected
  5.  Frontend calling live backend (not localhost)
  6.  Contact form saving to Supabase
  7.  No requests to localhost
  8.  No .env file in GitHub
  9.  README updated with live frontend URL
  10. /health endpoint responding
  11. Final Git commit


RECOMMENDED ARCHITECTURE

  User
   ↓
  Frontend URL (frontend host)
   ↓
  Backend API URL (backend host)
   ↓
  Supabase Database

Code lives in: GitHub.
Secrets live in: hosting platform environment variables.
Not in: GitHub.


FINAL CLAUDE CODE PROMPT

Give this to Claude Code:

  Help me prepare and launch my first full-stack project.

  I have a frontend folder and a backend folder using Express.
  Backend connects to Supabase. Code is in GitHub.

  Before making changes, give me a deployment readiness checklist:
  1. Frontend has no hardcoded localhost URLs.
  2. Backend has npm start script.
  3. Backend uses process.env.PORT || 3000.
  4. Supabase keys are read from environment variables.
  5. .env is in .gitignore.
  6. README explains how to run locally.
  7. CORS can allow the deployed frontend URL.
  8. A /health endpoint exists.
  9. No obvious secrets in committed files.

  After I deploy, help me update:
  - API_BASE_URL in frontend
  - CORS allowed origin in backend
  - README with live links
  - Final QA checklist


DEPLOYMENT READINESS CHECKLIST

GitHub: code pushed, README exists, .gitignore exists, .env not visible, repo structure clear.

Frontend: works locally, does not hardcode localhost, correct build settings, points to live backend URL.

Backend: works locally, has package.json, has start script, uses process.env.PORT, uses environment variables, has /health, CORS configured.

Database: Supabase project exists, tables exist, backend can read and write.


TEST BACKEND DIRECTLY

Open in browser:
  LIVE_BACKEND_URL/health
  LIVE_BACKEND_URL/api/projects

Expected: JSON response.


TEST FRONTEND END TO END

Open live frontend and check:
  1. Page loads
  2. Projects load
  3. Contact form submits
  4. Success message appears
  5. Supabase dashboard shows new message row

Open DevTools Network tab. Confirm requests go to live backend URL, not localhost.


UPDATE README

Add a Live Demo section to README.md:

  ## Live demo
  Frontend: [your live frontend URL]
  Backend health check: [your live backend health URL]

  ## Deployment
  Frontend deployed on frontend hosting platform.
  Backend API deployed on backend hosting platform.
  Database hosted on Supabase.


FINAL GIT COMMIT

  git status
  git add .
  git commit -m "Deploy full-stack project"
  git push


BADGE UNLOCKED

[!] You completed Module 8. You deployed your first full-stack project.

You now understand: deployment puts your product online, localhost works only on your computer, frontend and backend need different hosting, production apps need environment variables set in the platform, live frontend must call live backend, logs help debug deployed apps, health checks confirm the backend is alive, and HTTPS and domains help users trust your product.

You now have a live project link. That is a real portfolio milestone.

Next module: Module 9 — Testing and Quality: Ship Without Fear.$L811$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 8.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'What does deployment mean?',
    '["Saving a Git commit","Making your project available online","Writing CSS","Creating a database table"]',
    1
  );

  -- Q2 — Lesson 8.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'Why should a deployed frontend avoid calling localhost:3000?',
    '["Because localhost points to the user''s own computer","Because CSS cannot use localhost","Because GitHub blocks it","Because databases do not use URLs"]',
    0
  );

  -- Q3 — Lesson 8.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'Which part usually runs API routes like GET /api/projects?',
    '["Backend","CSS","README","Git commit"]',
    0
  );

  -- Q4 — Lesson 8.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'What does a build step usually do?',
    '["Prepares production-ready files for deployment","Deletes the database","Changes GitHub password","Writes README automatically"]',
    0
  );

  -- Q5 — Lesson 8.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'Why can''t the deployed backend read your local .env file?',
    '["Because it runs on a different machine or platform","Because CSS blocks it","Because GitHub deletes JavaScript","Because databases cannot use variables"]',
    0
  );

  -- Q6 — Lesson 8.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'What is the main result of frontend deployment?',
    '["A public URL for the user interface","A database table","A Git conflict","A local-only server"]',
    0
  );

  -- Q7 — Lesson 8.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'Why should a backend use process.env.PORT || 3000?',
    '["Hosting platforms may provide their own port","CSS needs a port","GitHub requires it for README","Supabase deletes ports"]',
    0
  );

  -- Q8 — Lesson 8.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'After deployment, what should your frontend call?',
    '["The live backend API URL","localhost on the user''s machine","README.md","Git log"]',
    0
  );

  -- Q9 — Lesson 8.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'What are deployment logs useful for?',
    '["Understanding what happened inside the deployed app","Changing text color","Creating GitHub issues automatically","Writing SQL tables"]',
    0
  );

  -- Q10 — Lesson 8.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'What does a custom domain mainly improve?',
    '["Professionalism and easier sharing","JavaScript syntax","Git commits","Database schema"]',
    0
  );

  -- Q11 — Lesson 8.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the first endpoint you should test after deploying your backend?',
    '["/health to confirm the backend is alive","/api/delete to clear old data","/localhost to verify local connection","/readme to check documentation"]',
    0
  );

end $$;
