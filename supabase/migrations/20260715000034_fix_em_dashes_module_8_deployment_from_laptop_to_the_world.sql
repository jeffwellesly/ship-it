-- Fix em dashes introduced by earlier typography-styling migrations.
-- Software Development with Claude Code / Module 8: Deployment: From Laptop to the World
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update lessons set content = $D81a3e240_4101_4789_8bee_39ff825d7eed$So far, your project works mostly on your computer. That is called **local development**. Local development is private. You can test quickly. You can break things safely. But other people cannot easily use your product.

**Deployment** means putting your product on the internet so other people can access it through a URL.

Before deployment:
  Only I can open it on my laptop.

After deployment:
  Anyone with the link can open it.

>> That is a major shift. You are no longer just practicing. You are shipping.


ANALOGY

[!] Building locally is like cooking in your home kitchen. Deployment is like opening a small restaurant. Now other people can walk in. That means you must think about: is it working, is it safe, is it clear, does the link open, does the backend respond, and are secrets protected?


KEY TERMS

**Local development:** Running the project on your own computer.

**Deployment:** Putting the project online.

**Hosting:** The service that runs your frontend or backend online.

**Production:** The live version users can access.

**Public URL:** A link other people can open.


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
  Supabase keys, backend environment variables, .env file$D81a3e240_4101_4789_8bee_39ff825d7eed$ where id = '81a3e240-4101-4789-8bee-39ff825d7eed';

update lessons set content = $Dd289d1a5_a497_43a0_9254_b9c387c546fa$You have probably used URLs like:
  http://localhost:3000

This is not a real internet URL. **localhost** means "this computer." When you open localhost:3000, your browser is talking to a server running on your own laptop.

That is useful for development. But if you send that link to a friend, it will not open your project. On their computer, localhost means their own computer, not yours.


ANALOGY

[!] Imagine saying "come to my house." That only works if the person knows your address. localhost is like saying "come here", but "here" means different things for different people. A public URL is like a real street address. Anyone can use it to find the place.


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

>> localhost means my own computer. A deployed frontend needs a real backend URL.$Dd289d1a5_a497_43a0_9254_b9c387c546fa$ where id = 'd289d1a5-a497-43a0-9254-b9c387c546fa';

update lessons set content = $Dd3f78a3f_ea43_4f2f_8bc2_280894a8ccc8$Your project has different parts. The frontend is mostly files: HTML, CSS, JavaScript, images. The backend is a running server: Express app, API routes, environment variables, database connection. These are deployed differently.


FRONTEND HOSTING

Frontend hosting serves your user interface. It sends files to the browser. When a user opens your frontend URL, the host sends those files. The browser displays the page. Frontend hosting is often simpler, the host just needs to deliver static files.


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

>> Frontend hosting serves files. Backend hosting runs live server code. Supabase hosts the database.$Dd3f78a3f_ea43_4f2f_8bc2_280894a8ccc8$ where id = 'd3f78a3f-ea43-4f2f-8bc2-280894a8ccc8';

update lessons set content = $D506a223d_d71a_4ec5_92fc_09aeb24fd4f7$When an app breaks on your laptop, you look at the terminal. When an app breaks online, you look at **logs**.

Logs are messages from your deployed app. They help you understand: did the app start, did it crash, which request failed, was an environment variable missing, did Supabase return an error?


ANALOGY

[!] Logs are like CCTV for your server. You cannot stand inside the hosted machine. But logs show what happened. Every hosting platform has a logs section, find it when things go wrong.


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

404, The route does not exist. Check endpoint path.
500, Backend received request but failed internally. Check logs.
CORS error, Browser blocked frontend-backend request. Check CORS settings.
Environment variable error, Backend cannot find required secret. Check hosting platform env settings.
Database error, Supabase query failed. Check table name, key, RLS, or schema.


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

>> Logs are how deployed apps communicate with you. Always check them before guessing.$D506a223d_d71a_4ec5_92fc_09aeb24fd4f7$ where id = '506a223d-d71a-4ec5-92fc-09aeb24fd4f7';

update lessons set content = $Df90223fb_6abf_4de5_8341_211afb0ba3c1$Now you will launch your first full-stack project.

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

Next module: Module 9, Testing and Quality: Ship Without Fear.$Df90223fb_6abf_4de5_8341_211afb0ba3c1$ where id = 'f90223fb-6abf-4de5-8341-211afb0ba3c1';
