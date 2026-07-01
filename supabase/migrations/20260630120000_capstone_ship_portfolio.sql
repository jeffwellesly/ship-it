-- Final Capstone: Ship Your Portfolio Product
-- 10 milestones (stored as lessons) with completion quizzes

do $$
declare
  v_course_id uuid;
  v_module_id uuid;
  v_m1 uuid; v_m2 uuid; v_m3 uuid; v_m4 uuid; v_m5 uuid;
  v_m6 uuid; v_m7 uuid; v_m8 uuid; v_m9 uuid; v_m10 uuid;
begin

  select id into v_course_id from courses where sort_order = 1;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Final Capstone: Ship Your Portfolio Product',
    'Bring everything together and ship a live full-stack portfolio product with frontend, backend, database, deployment, and documentation.',
    11
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- MILESTONE 1 — Product Brief: Decide What You Are Shipping
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Product Brief: Decide What You Are Shipping',
    1,
    $LC1$Before building, define the product clearly.

A builder should not start with random code.

A builder starts with:
  What am I building?
  Who is it for?
  What should it do?
  What is the smallest version worth shipping?


YOUR CAPSTONE PRODUCT

Your capstone is a personal portfolio product.

It should help someone understand:
  Who you are
  What you are learning
  What you built
  How you think
  How to contact you

This is not just a personal website. It is proof that you understand full-stack product building.

>> A product brief forces you to think before you code. Thinking first is how real builders work.


PRODUCT BRIEF TEMPLATE

Create this in your README or a notes file:

  # Product Brief

  ## Product Name
  Portfolio Product

  ## One-Line Description
  A personal portfolio product that showcases my projects, learning
  notes, and contact form using a frontend, backend, and database.

  ## Target User
  Recruiters, hiring managers, classmates, founders, and anyone who
  wants to understand what I can build.

  ## User Problem
  People cannot easily see my product-building skills from a resume alone.

  ## Product Solution
  A live portfolio product that shows my projects, explains my learning,
  and lets visitors contact me.

  ## Core Features
  - Home page
  - About section
  - Projects section
  - Blog or learning notes section
  - Contact form
  - Live deployment
  - GitHub documentation

  ## Success Criteria
  The product is successful if someone can open the live URL, understand
  what I built, view my projects, read my notes, and submit a message.


COMPLETION CHECK

Your product brief is complete when you can clearly answer:
  What is this product?
  Who is it for?
  What problem does it solve?
  What are the core features?
  How will you know if it works?


CLAUDE PROMPT

Ask Claude:
  Help me write a clear product brief for my capstone portfolio product.

  The product should:
  1. Show who I am
  2. Show projects I built
  3. Include learning notes or blog posts
  4. Include a contact form
  5. Use frontend, backend, database, GitHub, and deployment
  6. Be honest that this is a learning project
  7. Sound professional for a portfolio

  Keep it beginner-friendly and concise.$LC1$
  ) returning id into v_m1;

  -- ─────────────────────────────────────────────────────────────────
  -- MILESTONE 2 — Scope: Choose the Right MVP
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Scope: Choose the Right MVP',
    2,
    $LC2$A common beginner mistake is trying to build everything at once.

Do not do that.

Your capstone MVP should be small, clear, and shippable.

**MVP** means Minimum Viable Product.

In simple words:
  The smallest useful version worth sharing.


MUST-HAVE FEATURES

Your capstone must include:
  Home page
  About section
  Projects section
  Blog or notes section
  Contact form
  Backend API
  Supabase database
  Live frontend URL
  Live backend URL
  GitHub repo
  README
  TESTING.md
  ARCHITECTURE.md


NICE-TO-HAVE (only after must-haves are complete)

  Dark/light mode
  Admin page
  Authentication
  Project filters
  Blog search
  Animations
  Analytics
  Custom domain
  Email notification


DO NOT ADD YET

Avoid these for the first capstone:
  Payments
  Complex authentication
  Multiple user roles
  AI chatbot
  Real-time chat
  Advanced dashboards
  Mobile app
  Microservices

These are good later, but not needed now.

[!] Every feature you add now is a deployment, testing, and debugging burden. Ship the simple version first. Improve after real users give feedback.


MVP RULE

Use this rule:
  If removing this feature still leaves a useful product,
  it is not required for MVP.

>> Scope creep kills more products than bad code. Lock your MVP before you write a single line.


CLAUDE PROMPT

Ask Claude:
  Help me define the MVP scope for my capstone portfolio product.

  Separate features into:
  1. Must-have
  2. Nice-to-have
  3. Do-not-build-yet

  Keep the MVP small enough to ship.
  Warn me if I am adding unnecessary complexity.$LC2$
  ) returning id into v_m2;

  -- ─────────────────────────────────────────────────────────────────
  -- MILESTONE 3 — Frontend: Build the Portfolio Experience
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Frontend: Build the Portfolio Experience',
    3,
    $LC3$Your frontend is what visitors see first.

It should be clean, clear, and easy to understand.

The goal is not fancy design. The goal is trust.

A visitor should quickly understand:
  Who is this person?
  What did they build?
  What can I click?
  How do I contact them?


REQUIRED FRONTEND SECTIONS

HEADER
  Name or logo
  Navigation links
  Optional theme toggle

HERO SECTION
  Name
  Short positioning statement
  Primary CTA

  Example:
    Hi, I am Jeff.
    I build product ideas into working software prototypes.
    [View my projects]

ABOUT SECTION
  Short bio
  What you are learning
  What kind of products you want to build

PROJECTS SECTION
  Each project card should include:
    Project title
    Short description
    Tech used
    Status
    Link if available

BLOG OR LEARNING NOTES SECTION
  Each post card should include:
    Title
    Short summary
    Topic
    Date

CONTACT SECTION
  Name field
  Email field
  Message field
  Submit button
  Success state
  Error state
  Loading state

FOOTER
  Built with Ship It
  GitHub link
  Live project note


SUGGESTED HERO COPY

  Hi, I am Jeff.

  I am learning to build real software products with AI, code, and
  product thinking.

  This portfolio is my first full-stack product.

  [View my projects]     [Read my learning notes]


QUALITY CHECKS

When your frontend is done, verify:
  Is the main purpose clear in under 5 seconds?
  Can a visitor find my projects without scrolling past two screens?
  Is the contact form visible without hunting?
  Does the layout work on mobile?
  Are loading, success, error, and empty states handled?


CLAUDE PROMPT

Ask Claude:
  Build or improve the frontend for my capstone portfolio product.

  Requirements:
  1. Use semantic HTML.
  2. Create sections for Header, Hero, About, Projects, Blog or
     Learning Notes, Contact, and Footer.
  3. Make the design clean, modern, and beginner-friendly.
  4. Use reusable cards for projects and posts.
  5. Make the layout mobile-first and responsive.
  6. Add loading, success, error, and empty states where needed.
  7. Keep the code simple.
  8. Do not add frameworks unless the project already uses one.
  9. Explain every file changed.

  Before editing, show me the plan.$LC3$
  ) returning id into v_m3;

  -- ─────────────────────────────────────────────────────────────────
  -- MILESTONE 4 — Backend: Build the Product API
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Backend: Build the Product API',
    4,
    $LC4$The backend is the hidden system that powers the product.

For this capstone, your backend should support:
  Loading projects
  Loading blog posts or notes
  Submitting contact messages
  Checking backend health


REQUIRED ENDPOINTS

GET /health
  Purpose: Confirm backend is running.
  Response: { "status": "ok", "message": "Backend is running" }

GET /api/projects
  Purpose: Return project cards.
  Response: array of project objects.

GET /api/posts
  Purpose: Return blog posts or learning notes.
  Response: array of post objects.

POST /api/messages
  Purpose: Save a contact form message.
  Request: { name, email, message }
  Success: { "success": true, "message": "Message saved." }
  Error: { "success": false, "error": "Name, email, and message are required." }


OPTIONAL ENDPOINT

GET /api/messages
  Purpose: Learning or debug only. Lets you inspect submitted messages.
  Note: For a real public product, you would protect this endpoint.


API RESPONSE EXAMPLES

GET /api/projects response:
  [
    {
      "id": 1,
      "title": "My First Webpage",
      "description": "Built with HTML, CSS, and JavaScript.",
      "status": "complete"
    }
  ]

GET /api/posts response:
  [
    {
      "id": 1,
      "title": "What I Learned About APIs",
      "summary": "How frontend and backend talk.",
      "topic": "Backend",
      "created_at": "2026-06-30"
    }
  ]


BACKEND CHECKLIST

Before connecting to frontend:
  /health returns 200 JSON
  /api/projects returns an array
  /api/posts returns an array
  /api/messages with valid body returns 201
  /api/messages with missing fields returns 400
  No secrets hardcoded
  process.env.PORT used
  npm start script exists


CLAUDE PROMPT

Ask Claude:
  Build or improve the backend API for my capstone portfolio product.

  Requirements:
  1. Use Express.
  2. Add GET /health.
  3. Add GET /api/projects.
  4. Add GET /api/posts.
  5. Add POST /api/messages with validation.
  6. Return clear JSON responses with correct status codes.
  7. Connect to Supabase for projects, posts, and messages.
  8. Use environment variables.
  9. Do not expose secrets.
  10. Keep the code beginner-friendly.
  11. Explain every endpoint.

  Before editing, show the plan.$LC4$
  ) returning id into v_m4;

  -- ─────────────────────────────────────────────────────────────────
  -- MILESTONE 5 — Database: Store Projects, Posts, and Messages
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Database: Store Projects, Posts, and Messages',
    5,
    $LC5$Your capstone should not hardcode everything.

At least some product content should come from the database.

For this capstone, use three Supabase tables:
  projects
  posts
  messages


PROJECTS TABLE

Columns:
  id
  title
  description
  status
  created_at

Optional: tech, live_url, github_url.


POSTS TABLE

Columns:
  id
  title
  summary
  topic
  created_at

Optional: content, published.


MESSAGES TABLE

Columns:
  id
  name
  email
  message
  created_at


SAMPLE PROJECT ROWS

  My First Webpage
  Internet Request Demo
  Backend API
  Supabase Database Connection
  Deployed Portfolio Product


SAMPLE POST ROWS

  What I Learned About HTML, CSS, and JavaScript
  How Frontend and Backend Talk
  Why Databases Matter
  What Deployment Means
  How I Tested My First Product


DATABASE CHECKLIST

  projects table exists with at least 3 rows
  posts table exists with at least 3 rows
  messages table is ready for contact form data
  Backend can read from projects
  Backend can read from posts
  Backend can write to messages
  No security rules exposing sensitive data

[!] Your projects and posts data is the content of your portfolio. Add rows that are honest about where you are in your learning. You do not need to pretend you shipped ten production apps.


CLAUDE PROMPT

Ask Claude:
  Help me create the Supabase database schema for my capstone.

  I need tables for:
  1. projects
  2. posts
  3. messages

  For each table, give:
  - Column names
  - Recommended data types
  - Which fields are required
  - Sample rows
  - Any beginner security notes

  Keep it simple and beginner-friendly.$LC5$
  ) returning id into v_m5;

  -- ─────────────────────────────────────────────────────────────────
  -- MILESTONE 6 — Connect Everything Together
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Connect Everything Together',
    6,
    $LC6$Now connect the system.

Your frontend should not just show static content. It should call your backend. Your backend should read and write Supabase. Supabase should store the data.

This is the complete product loop.


PROJECTS FLOW

  Frontend loads page
   ↓
  Frontend calls GET /api/projects
   ↓
  Backend queries Supabase projects table
   ↓
  Backend returns JSON
   ↓
  Frontend displays project cards


POSTS FLOW

  Frontend loads posts section
   ↓
  Frontend calls GET /api/posts
   ↓
  Backend queries Supabase posts table
   ↓
  Backend returns JSON
   ↓
  Frontend displays post cards


CONTACT FLOW

  User submits contact form
   ↓
  Frontend sends POST /api/messages
   ↓
  Backend validates data
   ↓
  Backend saves message to Supabase
   ↓
  Backend returns success or error
   ↓
  Frontend shows message to user


CONNECTION CHECKLIST

  API_BASE_URL is one variable (not scattered)
  localhost is not hardcoded for production
  Projects load from backend
  Posts load from backend
  Contact form submits to backend
  Contact form shows loading state
  Contact form shows success state
  Contact form shows error state
  Empty states show when no data

[!] The most common connection bug: the frontend still uses a hardcoded localhost URL after deployment. Test on the live URL, not just locally, after connecting.

>> One variable for the API base URL. Change it in one place, and all requests update.


CLAUDE PROMPT

Ask Claude:
  Connect my capstone frontend to my backend API.

  Requirements:
  1. Load projects from GET /api/projects.
  2. Load posts from GET /api/posts.
  3. Submit contact form to POST /api/messages.
  4. Show loading, empty, success, and error states.
  5. Use one API_BASE_URL value.
  6. Do not hardcode localhost for production.
  7. Explain what changed.

  Before editing, show the connection plan.$LC6$
  ) returning id into v_m6;

  -- ─────────────────────────────────────────────────────────────────
  -- MILESTONE 7 — Test the Full Product
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Test the Full Product',
    7,
    $LC7$Before sharing your product, test it.

Do not just say: looks good.

Check the main flows. Record the results.


FINAL TEST CASES

TEST 1 — Live page opens
  Expected: Frontend loads without obvious errors.
  Status: Pass / Fail

TEST 2 — Projects load
  Expected: Project cards appear from backend/database.
  Status: Pass / Fail

TEST 3 — Posts load
  Expected: Blog or learning note cards appear.
  Status: Pass / Fail

TEST 4 — Contact form success
  Expected: Valid message submits and appears in Supabase.
  Status: Pass / Fail

TEST 5 — Contact form error
  Expected: Missing email or message shows clear error.
  Status: Pass / Fail

TEST 6 — Mobile layout
  Expected: Page is readable and usable on mobile width.
  Status: Pass / Fail

TEST 7 — No localhost
  Expected: Live frontend does not call localhost.
  Status: Pass / Fail

TEST 8 — Backend health
  Expected: GET /health returns success JSON.
  Status: Pass / Fail


UPDATE TESTING.MD

After running tests, update TESTING.md with capstone QA results.

Add a section:

  ## Capstone QA Results
  Date:
  Test 1 — Live page opens: Pass
  Test 2 — Projects load: Pass
  Test 3 — Posts load: Pass
  Test 4 — Contact form success: Pass
  Test 5 — Contact form error: Pass
  Test 6 — Mobile layout: Pass
  Test 7 — No localhost: Pass
  Test 8 — Backend health: Pass

  Known issues:
  [List any problems found and whether they are Low/Medium/High severity]


CLAUDE PROMPT

Ask Claude:
  Create a final capstone QA checklist for my portfolio product.

  Include:
  1. Frontend checks
  2. Backend checks
  3. Supabase checks
  4. Contact form checks
  5. Mobile checks
  6. Accessibility checks
  7. Deployment checks
  8. No localhost checks
  9. README checks
  10. GitHub safety checks

  Keep it practical.$LC7$
  ) returning id into v_m7;

  -- ─────────────────────────────────────────────────────────────────
  -- MILESTONE 8 — Deploy the Product
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Deploy the Product',
    8,
    $LC8$Now deploy the final version.

You need:
  Frontend live URL
  Backend live URL
  Supabase database
  GitHub repo

Recommended setup:
  Frontend → Vercel
  Backend → Render or Railway
  Database → Supabase
  Code → GitHub

But the exact platform is less important than understanding the architecture. Use what you know or what the official docs recommend.


FRONTEND DEPLOYMENT CHECKLIST

  Frontend deployed
  Live URL works
  Calls live backend URL (not localhost)
  Mobile layout works
  Console shows no obvious errors


BACKEND DEPLOYMENT CHECKLIST

  Backend deployed
  /health works
  /api/projects works
  /api/posts works
  /api/messages works
  Environment variables configured
  CORS allows live frontend URL


DATABASE CHECKLIST

  Supabase tables exist
  Data loads from projects and posts
  Messages save correctly


GITHUB CHECKLIST

  README updated with live links
  No .env file in repo
  No secrets in any committed file
  Final commit pushed


DEPLOYMENT READINESS RULE

Before deploying, confirm:
  Frontend uses process.env.NEXT_PUBLIC_API_URL or equivalent
  Backend uses process.env.SUPABASE_URL and SUPABASE_KEY
  Backend uses process.env.PORT || 3000
  .env is in .gitignore
  npm start script exists in backend package.json

[!] Environment variables in the hosting platform dashboard must match the names your code expects. A mismatch causes silent failures with no code error.


CLAUDE PROMPT

Ask Claude:
  Help me prepare my capstone project for final deployment.

  Check:
  1. Frontend is ready to deploy.
  2. Backend is ready to deploy.
  3. Environment variables are not hardcoded.
  4. .env is ignored.
  5. API base URL points to the live backend.
  6. CORS allows the live frontend.
  7. Backend has /health.
  8. README can be updated with live links.

  Give me a step-by-step deployment readiness checklist.
  Do not assume platform dashboard details because they may change.
  Tell me to use official docs if the UI looks different.$LC8$
  ) returning id into v_m8;

  -- ─────────────────────────────────────────────────────────────────
  -- MILESTONE 9 — Polish GitHub and Documentation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Polish GitHub and Documentation',
    9,
    $LC9$A live product is good.

A live product with clear documentation is much stronger.

Your GitHub repo should help people understand your work without you having to explain it.


README.MD SHOULD INCLUDE

  Project name
  Live demo link
  What the product does
  Why you built it
  Tech stack
  Project structure
  How to run locally
  Environment variable note
  What you learned
  Future improvements


TESTING.MD SHOULD INCLUDE

  Manual QA checklist
  API tests
  Frontend tests
  Regression checklist
  Capstone QA results
  Known issues
  Pre-ship checklist


ARCHITECTURE.MD SHOULD INCLUDE

  System diagram
  Frontend responsibilities
  Backend responsibilities
  Database tables
  API contracts
  Data flows
  Deployment architecture
  Security notes
  Tradeoffs
  Future improvements


PORTFOLIO SUMMARY

Add a short paragraph you can paste anywhere:

  I built a full-stack portfolio product to learn how modern software
  products work end to end. The project includes a responsive frontend,
  Express backend API, Supabase database, deployed frontend and backend,
  GitHub documentation, testing checklist, and architecture notes.

>> This summary is what you put in LinkedIn, your resume description, and your cover letters. Get comfortable explaining it out loud.


DOCUMENTATION QUALITY CHECKLIST

  README is readable without knowing me personally
  Live demo link is correct and accessible
  Tech stack is honest
  Instructions to run locally are clear
  TESTING.md has actual test results, not just a template
  ARCHITECTURE.md is readable by someone who did not build the product
  No secrets visible anywhere in the repo


CLAUDE PROMPT

Ask Claude:
  Review my GitHub repo and make it portfolio-ready.

  Check:
  1. README clarity
  2. TESTING.md completeness
  3. ARCHITECTURE.md clarity
  4. Project structure
  5. Live demo links
  6. No secrets exposed
  7. Clear future improvements
  8. Professional but honest wording

  Suggest improvements before editing.$LC9$
  ) returning id into v_m9;

  -- ─────────────────────────────────────────────────────────────────
  -- MILESTONE 10 — Final Demo: Present What You Shipped
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Final Demo: Present What You Shipped',
    10,
    $LC10$A builder should be able to demo the product.

Not just show screens. Explain:
  What I built
  Why I built it
  How it works
  What I learned
  What I would improve next

This is important for interviews, portfolio reviews, and founder conversations.


DEMO SCRIPT

Use this structure:

  This is my capstone portfolio product.

  I built it to understand how full-stack software products work end
  to end.

  The frontend shows my profile, projects, learning notes, and contact
  form.

  The backend is an Express API with endpoints for projects, posts,
  messages, and a health check.

  The database is Supabase, where projects, posts, and contact messages
  are stored.

  The product is deployed with a live frontend and backend.

  I also documented testing and architecture so someone can understand
  how the system works.

  The biggest thing I learned is how frontend, backend, database,
  deployment, GitHub, and testing fit together as one product.


INTERVIEW-STYLE ANSWERS

Q: What did you build?
A: I built a full-stack portfolio product with a responsive frontend,
   backend API, Supabase database, live deployment, and documentation.
   It shows my projects and learning notes and lets visitors submit
   contact messages.

Q: What was the hardest part?
A: The hardest part was connecting the live frontend to the deployed
   backend and making sure environment variables, CORS, and Supabase
   worked correctly.

Q: What would you improve next?
A: Next I would add authentication, an admin page for managing posts,
   better spam protection for the contact form, and stronger monitoring.


FINAL REFLECTION QUESTIONS

Answer these:
  1. What did you ship?
  2. Who is this product for?
  3. What frontend features did you build?
  4. What backend endpoints did you build?
  5. What data does Supabase store?
  6. How does the contact form work end to end?
  7. What did you deploy?
  8. What did you test?
  9. What did you document?
  10. What was the hardest part?
  11. What did Claude Code help with?
  12. What did you still need to understand yourself?
  13. What would you improve next?
  14. What is your live URL?
  15. What is your GitHub repo URL?


[!] You completed the Ship It capstone.

You did not just watch lessons. You shipped a real product.

You built:
  A frontend users can see
  A backend that handles requests
  A database that remembers data
  A deployed product with a live URL
  A GitHub repo with documentation
  A testing plan
  An architecture document

You now understand the full journey:
  Idea → Frontend → Backend → Database → GitHub → Deployment → Testing → Architecture → Shipped Product

This is the foundation of software product building. You are no longer just learning tech. You are learning to ship.


CLAUDE PROMPT

Ask Claude:
  Help me write a 60-second demo script for my capstone portfolio product.

  Include:
  1. What I built
  2. Why I built it
  3. How it works
  4. Tech stack
  5. What I learned
  6. What I would improve next

  Make it sound clear, confident, and honest.$LC10$
  ) returning id into v_m10;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (10 total, one per milestone)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Milestone 1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_m1,
    'What is the purpose of a product brief?',
    '["To define what you are building and for whom before writing code","To add animations to the frontend","To set up DNS records","To create microservices"]',
    0
  );

  -- Q2 — Milestone 2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_m2,
    'What does MVP stand for and mean?',
    '["Minimum Viable Product — the smallest useful version worth sharing","Maximum Visual Polish — the best-looking version","Main Verified Process — the tested code path","Most Visible Page — the homepage"]',
    0
  );

  -- Q3 — Milestone 3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_m3,
    'What should a portfolio hero section make clear?',
    '["Who you are and what you build","Only the color palette used","The database schema","The Git branch name"]',
    0
  );

  -- Q4 — Milestone 4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_m4,
    'What is the purpose of GET /health?',
    '["Confirm the backend is running and reachable","Delete all database rows","Reset the frontend","Change the CSS theme"]',
    0
  );

  -- Q5 — Milestone 5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_m5,
    'What are the three main Supabase tables in this capstone?',
    '["projects, posts, messages","users, sessions, tokens","pages, styles, scripts","headers, footers, navbars"]',
    0
  );

  -- Q6 — Milestone 6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_m6,
    'What is the complete product loop?',
    '["Frontend calls backend, backend reads or writes database, database returns data, frontend displays result","Frontend directly writes to database","Backend serves HTML pages directly","Database calls the frontend"]',
    0
  );

  -- Q7 — Milestone 7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_m7,
    'Why should you test the live URL after deployment, not just locally?',
    '["The live product may call different URLs and environment variables than your local version","Local testing is always wrong","CSS only works online","Supabase only accepts deployed connections"]',
    0
  );

  -- Q8 — Milestone 8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_m8,
    'Where should secret environment variables like SUPABASE_KEY be stored for a deployed app?',
    '["In the hosting platform environment variable settings","In README.md","In a public frontend file","In a Git commit message"]',
    0
  );

  -- Q9 — Milestone 9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_m9,
    'What makes a GitHub repo portfolio-ready?',
    '["Clear README with live link, TESTING.md, ARCHITECTURE.md, and no exposed secrets","Only the source code files","A single long commit message","Microservices architecture"]',
    0
  );

  -- Q10 — Milestone 10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_m10,
    'What should a 60-second product demo explain?',
    '["What you built, how it works, what you learned, and what you would improve next","Only the color choices","Only the database schema","Only the Git commit history"]',
    0
  );

end $$;
