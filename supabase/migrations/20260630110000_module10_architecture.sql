-- Module 10: Architecture — How Software Products Are Organized
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
    'Module 10: Architecture: How Software Products Are Organized',
    'Understand how your frontend, backend, database, and deployment fit together as one system.',
    10
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.1 — What Software Architecture Means
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Software Architecture Means',
    1,
    $L101$Architecture sounds like a big word.

But the idea is simple.

**Software architecture** means: how the parts of a software product are organized and connected.

It is the big-picture plan of the product. Not just one button. Not just one file. Not just one database table.

Architecture asks:
  What are the main parts?
  What does each part do?
  How do they communicate?
  Where does data go?
  What happens when something fails?
  How can the product grow later?


ANALOGY

Think of building a house.

Before construction, you need a plan. The plan says:
  Where the rooms are
  Where the kitchen is
  Where the doors are
  Where electricity flows
  Where water flows
  What supports the structure

Software architecture is similar. It says:
  Where the frontend is
  Where the backend is
  Where the database is
  How requests move
  How data is stored
  How users access the product

Without architecture, the product becomes messy as it grows.


BEGINNER-FRIENDLY DEFINITION

Architecture is not about making things complicated.

Good architecture often means:
  Keep the system simple, clear, and easy to change.

For a beginner project, good architecture is not microservices, Kubernetes, or advanced cloud design.

Good architecture is:
  Clear folders
  Clear responsibilities
  Clear API endpoints
  Clear database tables
  Clear deployment setup
  Clear documentation

That is enough for your first product.


KEY TERMS

**Architecture** — The structure of a software system and how its parts connect.

**System** — The full product, including frontend, backend, database, hosting, and users.

**Component** — One part of the system.

**Responsibility** — What a part is supposed to do.

**Tradeoff** — A decision where you gain something but give up something else.


PRODUCT EXAMPLE

Your portfolio product has this architecture:

  User
   ↓
  Frontend
   ↓
  Backend API
   ↓
  Supabase Database

Each part has a job. Frontend shows the interface. Backend handles requests and rules. Database remembers data. Deployment platforms make the product available online.

That is architecture.

>> Architecture is not complexity for its own sake. It is clarity about how the system works.


MINI EXERCISE

Write your product in one sentence:
  My product helps users ______ by ______.

Example:
  My product helps visitors learn about my work and contact me by using a
  live portfolio website with a backend and database.

Then list the main parts: Frontend, Backend, Database, GitHub, Deployment.


CLAUDE PROMPT

Ask Claude:
  Explain software architecture using my portfolio-product app. Keep it
  simple. Identify the main parts of my system and what each part is
  responsible for.$L101$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.2 — The Full-Stack Map
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The Full-Stack Map',
    2,
    $L102$A full-stack product has multiple layers.

You already built many of them.

The stack usually looks like this:

  User
   ↓
  Frontend
   ↓
  Backend
   ↓
  Database

But a real deployed product also includes:
  GitHub
  Deployment platforms
  Environment variables
  Logs
  Testing
  Security rules

So the full system is bigger than just code.


SIMPLE FULL-STACK MAP

  User's browser
        ↓
  Frontend host
        ↓
  Backend API host
        ↓
  Supabase database

Code is stored in: GitHub.
Secrets are stored in: hosting platform environment variables.
Testing is documented in: TESTING.md.
Architecture is documented in: ARCHITECTURE.md.


WHAT EACH PART DOES

**User** — The person using your product. They click, type, read, submit, and navigate.

**Frontend** — The visible part. Shows hero section, project cards, contact form, buttons, messages, loading states, and error states.

**Backend** — The hidden logic layer. Handles API requests, validation, business rules, database communication, JSON responses, and errors.

**Database** — The memory layer. Stores projects, contact messages, blog posts later, user progress later.

**GitHub** — The code home. Stores frontend, backend, README, testing docs, and architecture docs.

**Deployment platforms** — They run your product online. Frontend host serves the user interface. Backend host runs the API. Supabase hosts the database.


PRODUCT BUILDER VIEW

When something breaks, the stack helps you debug.

Example: projects are not showing.

Ask:
  1. Did frontend load?
  2. Did frontend call backend?
  3. Did backend endpoint respond?
  4. Did backend query database?
  5. Did database return data?
  6. Did frontend display the data?

[!] This is architecture thinking. Without understanding the stack, you guess randomly. With it, you check systematically.


MINI EXERCISE

Draw your product stack using text:

  User
   ↓
  Frontend: ______
   ↓
  Backend: ______
   ↓
  Database: ______

Fill in your actual platform names. Example:

  User
   ↓
  Frontend: Vercel
   ↓
  Backend: Render
   ↓
  Database: Supabase


CLAUDE PROMPT

Ask Claude:
  Create a simple full-stack map for my product. Include user, frontend,
  backend, database, GitHub, deployment platforms, and environment
  variables. Explain it like I am a beginner.$L102$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.3 — Layers: Frontend, Backend, Database, Infrastructure
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Layers: Frontend, Backend, Database, Infrastructure',
    3,
    $L103$Good products separate responsibilities.

This means each layer has a clear job. Frontend should not do everything. Backend should not do everything. Database should not do everything.

Each part should do what it is best at.


FRONTEND LAYER

Responsible for:
  Showing screens
  Collecting user input
  Calling APIs
  Showing loading, success, and error states
  Making the product usable

The frontend should not store secret keys. The frontend should not be trusted to enforce important rules alone.


BACKEND LAYER

Responsible for:
  Receiving API requests
  Validating input
  Enforcing business logic
  Talking to the database
  Returning JSON
  Protecting secrets

The backend is the trusted middle layer. Users interact with the frontend, but the backend is where rules are enforced.


DATABASE LAYER

Responsible for:
  Storing data
  Retrieving data
  Enforcing database rules
  Maintaining relationships
  Keeping data persistent

The database should not decide the full product experience. It stores and protects data.


INFRASTRUCTURE LAYER

Responsible for:
  Hosting
  Deployment
  Environment variables
  Logs
  Domains
  HTTPS
  Scaling later

This is the layer that keeps the product online.


EXAMPLE: CONTACT FORM ACROSS LAYERS

Frontend:
  Collect name, email, message.
  Show loading state.
  Send request to backend.
  Show success or error.

Backend:
  Validate required fields.
  Check message length.
  Save to database.
  Return status code and JSON.

Database:
  Store the message row.
  Keep created_at timestamp.

Infrastructure:
  Host frontend and backend.
  Provide environment variables.
  Keep HTTPS enabled.
  Show logs if something fails.


BAD ARCHITECTURE EXAMPLE

Bad:
  Frontend directly stores secret database key.
  Frontend writes directly to database without rules.
  No backend validation.
  No error handling.
  No documentation.

Better:
  Frontend sends request to backend.
  Backend validates and protects secrets.
  Backend writes to database.
  Frontend shows clear result.

[!] When the frontend bypasses the backend, you lose the trusted validation layer. Users can submit anything — invalid data, duplicate requests, malformed input.


MINI EXERCISE

For each responsibility, choose the right layer:
  1. Show success message
  2. Validate contact form input
  3. Store contact message
  4. Keep Supabase key secret
  5. Serve live frontend URL
  6. Return JSON response

Answers: Frontend, Backend, Database, Backend/Infrastructure, Infrastructure, Backend.


CLAUDE PROMPT

Ask Claude:
  Review my app and separate responsibilities into frontend, backend,
  database, and infrastructure layers. Tell me if anything is in the
  wrong layer.$L103$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.4 — Data Flow: What Happens After a Click?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Data Flow: What Happens After a Click?',
    4,
    $L104$Architecture becomes easier when you trace one user action.

Let's use the contact form. The user clicks: Submit.

What happens next?


CONTACT FORM DATA FLOW

  User fills form
        ↓
  Frontend reads form values
        ↓
  Frontend sends POST request
        ↓
  Backend receives request
        ↓
  Backend validates fields
        ↓
  Backend writes message to Supabase
        ↓
  Supabase saves row
        ↓
  Backend returns success JSON
        ↓
  Frontend shows success message

That is a **data flow**. It shows how data moves through the system.


WHY DATA FLOW MATTERS

Data flow helps you debug.

If the message does not save, where is the problem?

Maybe:
  Frontend did not send request
  Backend URL is wrong
  CORS blocked request
  Backend validation failed
  Supabase key is missing
  Database table name is wrong
  RLS policy blocked insert
  Frontend did not show the success message

Without data flow, you guess. With data flow, you check step by step.

>> The data flow diagram is the most useful debugging tool that is not a tool.


ANOTHER EXAMPLE: LOAD PROJECTS

  User opens page
        ↓
  Frontend loads
        ↓
  Frontend calls GET /api/projects
        ↓
  Backend queries Supabase projects table
        ↓
  Supabase returns rows
        ↓
  Backend returns JSON
        ↓
  Frontend renders project cards

This is the read flow. Contact form is a write flow. Both matter.


KEY TERMS

**Data flow** — The path data takes through the system.

**Read flow** — A flow that loads data. Example: GET /api/projects.

**Write flow** — A flow that saves or changes data. Example: POST /api/messages.

**Source of truth** — The trusted place where the real data lives. For your project, Supabase is the source of truth for projects and messages.


MINI EXERCISE

Write the data flow for: user views project cards.

  User opens page
   ↓
  Frontend ______
   ↓
  Backend ______
   ↓
  Database ______
   ↓
  Frontend ______


CLAUDE PROMPT

Ask Claude:
  Create data flow diagrams in text for my app. Include:
  1. Loading project cards
  2. Submitting contact form
  3. Handling contact form error

  Keep it beginner-friendly.$L104$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.5 — API Contracts: Agreements Between Parts
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'API Contracts: Agreements Between Parts',
    5,
    $L105$The frontend and backend need to agree.

The frontend needs to know:
  Which endpoint to call
  Which method to use
  What data to send
  What response to expect
  What errors can happen

This agreement is called an **API contract**.


EXAMPLE API CONTRACT

Endpoint: POST /api/messages

Purpose: Save a contact form message.

Request body:
  {
    "name": "Jeff",
    "email": "jeff@example.com",
    "message": "I want to learn more."
  }

Success response:
  {
    "success": true,
    "message": "Message saved."
  }

Error response:
  {
    "success": false,
    "error": "Email is required."
  }

Status codes: 201 Created, 400 Bad Request, 500 Internal Server Error.


WHY API CONTRACTS MATTER

If the frontend expects:
  message

but backend returns:
  msg

the UI may break silently.

If the backend expects:
  email

but frontend sends:
  userEmail

validation may fail without a clear error.

API contracts prevent confusion. They make frontend and backend work together.

[!] Without an agreed contract, the frontend and backend can drift apart. One team changes a field name and the other product stops working. Contracts prevent silent breakage.


API CONTRACT SUMMARY

GET /health
  Purpose: Check if backend is running.
  Response: { "status": "ok", "message": "Backend is running" }
  Status: 200

GET /api/projects
  Purpose: Return project cards.
  Response: array of objects with id, title, description, status.
  Status: 200

POST /api/messages
  Purpose: Save contact form message.
  Request: { name, email, message }
  Success: { "success": true, "message": "Message saved." }
  Error: { "success": false, "error": "..." }
  Status: 201 on success, 400 on bad input


MINI EXERCISE

Add an API contract section to ARCHITECTURE.md. For each endpoint, include:
  Endpoint, Method, Purpose, Request body, Success response,
  Error response, Status codes.


CLAUDE PROMPT

Ask Claude:
  Create an API contract summary for my app. Include GET /health,
  GET /api/projects, and POST /api/messages. Use method, purpose,
  request body, success response, error response, and status codes.$L105$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.6 — Monolith vs Microservices: Start Simple
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Monolith vs Microservices: Start Simple',
    6,
    $L106$You may hear people talk about:
  monolith
  microservices
  serverless
  distributed systems

These sound advanced. For now, understand the basic idea.


MONOLITH

A **monolith** means the backend is one main app.

Example:
  One Express backend handles projects, messages, users, and blog posts.

For beginner products, this is usually good.

Why?
  Easier to understand
  Easier to debug
  Easier to deploy
  Less moving parts
  Faster to build


MICROSERVICES

**Microservices** means the product is split into many small services.

Example:
  User service
  Payment service
  Notification service
  Course service
  Progress service

This can help large teams and large systems. But it also adds complexity:
  More deployments
  More communication between services
  More failure points
  More monitoring
  More coordination
  More debugging


ANALOGY

[!] A small restaurant can run with one kitchen. That is like a monolith. A huge hotel may have separate kitchens for bakery, buffet, room service, and banquet. That is like microservices. If you open a small restaurant with ten separate kitchens on day one, you create unnecessary complexity before you even have customers.


BEGINNER RULE

Start simple.

For your first product:
  One frontend
  One backend
  One database

That is enough.

Do not split into microservices just to sound advanced. Architecture should solve real problems, not create new ones.

>> Build simply. Measure real problems. Then improve the bottleneck.


WHEN MICROSERVICES MAY MAKE SENSE LATER

Microservices may make sense when:
  Many teams work independently
  Parts need separate scaling
  One service changes much faster than others
  Failures need isolation
  The product is already large

Your portfolio product is not there yet. And that is okay.


COMPARISON

Monolith — Good for: simplicity, speed, beginner projects. Tradeoff: can get messy if not organized.

Microservices — Good for: large systems, many teams, independent scaling. Tradeoff: much more complexity.

Serverless functions — Good for: small event-based backend tasks. Tradeoff: platform limits and debugging complexity.


MINI EXERCISE

For your current project, choose monolith or microservices.

Recommended answer:
  Monolith.

Reason:
  The product is small, one builder can understand it, and simplicity
  is more valuable now.


CLAUDE PROMPT

Ask Claude:
  Explain whether my portfolio-product app should use a monolith,
  microservices, or serverless functions. Recommend the simplest
  architecture for my current stage and explain the tradeoffs.$L106$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.7 — Scalability: What If More Users Come?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Scalability: What If More Users Come?',
    7,
    $L107$**Scalability** means: can the product handle more users, more data, or more traffic?

A beginner may think:
  I should design for millions of users from day one.

Usually, no. That creates complexity before you need it.

A better question is:
  What is the next realistic level of growth?


SIMPLE SCALABILITY QUESTIONS

Ask:
  1. What happens if 10 people use it?
  2. What happens if 100 people use it?
  3. What happens if 1,000 people use it?
  4. What part gets slow first?
  5. What part costs more first?
  6. What part breaks first?

For your first project, 10–100 users is enough to think about.


WHAT USUALLY NEEDS SCALING?

Frontend: Usually easy to scale because static files can be served by platforms and CDNs.

Backend: May need scaling if many requests hit the API at once.

Database: May need indexing, better queries, or a bigger plan as data grows.

Images and files: May need storage or a CDN if you upload many media files.


EXAMPLE: YOUR PROJECT

If 100 people visit your portfolio, frontend, backend, and Supabase should probably be fine. No major scaling needed.

If 100,000 people visit:
  You may need better caching, rate limiting, stronger database rules,
  monitoring, better backend hosting, and spam protection on contact form.

But you do not need all of that today.


PREMATURE SCALING

Premature scaling means solving growth problems before you actually have them.

Example:
  Building microservices before having users.

This can slow you down significantly.

[!] The most common mistake in early-stage products is building for scale you do not have. Solve today's problems today. Build the architecture that handles your real user count, not an imagined future one.


MINI EXERCISE

Fill this out:
  If 100 users visit my product, I expect:
  Frontend: ______
  Backend: ______
  Database: ______
  Biggest risk: ______

Example:
  Frontend: should be fine
  Backend: should be fine
  Database: should be fine
  Biggest risk: contact form spam or broken deployment config


CLAUDE PROMPT

Ask Claude:
  Analyze my current product architecture for 100 users, 1,000 users,
  and 10,000 users. Tell me what would likely break first and what I
  should improve only when needed.$L107$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.8 — Reliability: What Can Break?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Reliability: What Can Break?',
    8,
    $L108$**Reliability** means: does the product keep working when things go wrong?

Products are made of many parts. Any part can fail.

The goal is not to prevent every possible failure. The goal is to understand likely failures and handle them well.


COMMON FAILURE POINTS

Frontend fails:
  Page does not load
  JavaScript error
  Button does nothing
  Mobile layout breaks

Backend fails:
  API is down
  Endpoint returns 500
  CORS blocks request
  Environment variables missing

Database fails:
  Table name wrong
  Permission issue
  Supabase unavailable
  RLS policy blocks write

Network fails:
  User loses internet
  Request times out
  Slow connection

Deployment fails:
  Wrong build command
  Wrong root folder
  Missing start command
  Wrong environment variables


WHAT GOOD PRODUCTS DO

Good products handle failure clearly.

Instead of a blank page:
  Projects could not load. Please try again.

Instead of a stuck form:
  We could not send your message. Please try again in a minute.

Instead of silent failure:
  Log the error on the backend.
  Show a safe message to the user.

[!] Silent failure is worse than a visible error. If the user cannot tell whether the form submitted, they will submit it multiple times. Show a clear state for every outcome.


RELIABILITY TOOLS

Beginner reliability tools available now:
  Health check endpoint
  Logs
  Error messages
  Manual QA checklist
  Regression checklist
  Git rollback
  Environment variable checklist
  README deployment notes

Advanced reliability tools for later:
  Monitoring and alerts
  Error tracking
  Automated backups
  Rate limiting
  Load testing


MINI EXERCISE

Create a failure map. For each part, write one failure and one response.

Example:
  Frontend failure: Projects do not load.
  User response: Show "Projects could not load. Please try again."
  Builder response: Check Network tab and backend logs.


CLAUDE PROMPT

Ask Claude:
  Create a reliability checklist for my product. Identify what can fail
  in frontend, backend, database, network, and deployment. For each
  failure, suggest a user-facing response and a builder debugging step.$L108$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.9 — Security Basics in Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Security Basics in Architecture',
    9,
    $L109$Security is a deep topic. You will not master it in one lesson.

But you must learn beginner safety rules.

Security is not something you add only at the end. Architecture decisions affect security.


RULE 1 — DO NOT EXPOSE SECRETS

Never put secret keys in frontend code. Never commit .env. Never paste service role keys into GitHub.

Secrets belong in backend environment variables or secure platform settings.


RULE 2 — VALIDATE ON THE BACKEND

Frontend validation helps users. Backend validation protects the system.

Never trust the frontend alone.

A user can bypass your webpage and send requests directly to your backend.

[!] Always validate on the server side. Frontend validation is a courtesy. Backend validation is a requirement.


RULE 3 — USE HTTPS

Your deployed frontend and backend should use HTTPS. This protects data while it travels between browser and server.


RULE 4 — BE CAREFUL WITH DATABASE PERMISSIONS

Supabase has security rules. Do not make private data publicly readable or writable without understanding the risk. For learning projects, keep data simple and avoid storing sensitive personal information.


RULE 5 — DO NOT STORE SENSITIVE DATA UNLESS NEEDED

Do not store:
  Passwords manually
  Payment details
  Government IDs
  Sensitive personal information

Use trusted services for authentication and payments later.


RULE 6 — HANDLE ERRORS SAFELY

Do not show users detailed internal errors like full stack traces, secret paths, or database internals.

Good user error:
  We could not save your message. Please try again.

Backend logs can have more detail. Users do not need internal details.

>> Users see error messages. Engineers see logs. Never mix them up.


PRODUCT EXAMPLE

For your contact form, safe enough for beginner:
  Store name, email, message, created_at.
  Validate required fields on the backend.
  Use backend to write to database.
  Keep keys out of GitHub.

Not safe:
  Put Supabase service role key in frontend.
  Store passwords manually.
  Expose admin endpoints publicly.
  Show full database errors to users.


MINI EXERCISE

Check your project:
  Is .env ignored?
  Are keys hardcoded anywhere?
  Does backend validate input?
  Does frontend call backend over HTTPS?
  Does README tell users not to commit secrets?


CLAUDE PROMPT

Ask Claude:
  Review my project architecture for beginner security issues. Check
  secrets, .env, frontend exposure, backend validation, Supabase
  permissions, CORS, and error messages. Give me the top risks in
  priority order.$L109$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.10 — Architecture Documents and Diagrams
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Architecture Documents and Diagrams',
    10,
    $L1010$A product is easier to understand when it is documented.

**Architecture documentation** explains the system.

It is useful for:
  Future you
  Teammates
  Recruiters
  Engineers
  Claude Code
  Debugging
  Portfolio review

You do not need a 50-page document. For your first product, one clear ARCHITECTURE.md file is enough.


WHAT GOOD ARCHITECTURE DOCS INCLUDE

  1. Product overview
  2. System diagram
  3. Main components
  4. Data flow
  5. API contracts
  6. Database tables
  7. Deployment setup
  8. Security notes
  9. Tradeoffs
  10. Future improvements


SIMPLE SYSTEM DIAGRAM

You can use text:

  User
   ↓
  Frontend
   ↓
  Backend API
   ↓
  Supabase Database

Or if your platform supports Mermaid diagrams:

  flowchart TD
    User[User Browser] --> Frontend[Frontend App]
    Frontend --> Backend[Backend API]
    Backend --> Database[Supabase Database]
    Backend --> Logs[Backend Logs]
    GitHub[GitHub Repo] --> Frontend
    GitHub --> Backend

If not, plain text is fine.


EXAMPLE ARCHITECTURE DOC SKELETON

  # Architecture

  ## Product Overview

  ## System Diagram

  ## Main Components

  ### Frontend
  ### Backend
  ### Database

  ## API Contracts

  ## Data Flows

  ## Security Notes

  ## Deployment

  ## Tradeoffs

  ## Future Improvements


TRADEOFFS SECTION

This is important. Good builders explain why they chose something.

Example:
  I used one simple Express backend instead of microservices because
  this is a small learning project. This keeps the system easier to
  understand, debug, and deploy.

That is strong product thinking. Recruiters and engineers notice it.

[!] The tradeoffs section is often the most impressive part of an architecture doc. Knowing why you made a decision shows maturity. Knowing you could have done it differently shows depth.

>> A clear ARCHITECTURE.md is a portfolio signal that you think in systems, not just files.


MINI EXERCISE

Create a first draft of ARCHITECTURE.md using this structure:
  Product overview
  System diagram
  Components
  Data flow
  API contracts
  Database tables
  Security notes
  Deployment
  Tradeoffs
  Future improvements


CLAUDE PROMPT

Ask Claude:
  Create an ARCHITECTURE.md file for my portfolio-product app. Include
  product overview, system diagram, components, data flows, API
  contracts, database tables, deployment setup, security notes,
  tradeoffs, and future improvements. Keep it beginner-friendly and
  portfolio-ready.$L1010$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.11 — Module Project: Create Your Product Architecture Document
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Module Project: Create Your Product Architecture Document',
    11,
    $L1011$Now you will create the architecture document for your product.

This is your system explanation. It should help someone understand:
  What you built
  How it works
  How the parts connect
  Where data goes
  How it is deployed
  What tradeoffs you made
  What you would improve next

A live link shows what you built. GitHub shows the code. README explains how to run it. TESTING.md shows quality thinking. ARCHITECTURE.md shows system thinking.

Together, these make your project much stronger.

>> Most beginners ship projects without explaining the system. ARCHITECTURE.md is what separates a portfolio piece from a demo.


FINAL PROJECT REQUIREMENTS

Create: ARCHITECTURE.md

It should include:
  1. Product overview
  2. System diagram
  3. Component responsibilities
  4. Data flow: load projects
  5. Data flow: submit contact message
  6. API contracts
  7. Database tables
  8. Deployment architecture
  9. Environment variables
  10. Security notes
  11. Reliability notes
  12. Tradeoffs
  13. Future improvements


FINAL CLAUDE CODE PROMPT

Give this to Claude Code:

  Create an ARCHITECTURE.md file for my portfolio-product project.

  Use my current project context:
  - Frontend displays project cards and contact form.
  - Backend is an Express API.
  - Backend has /health, /api/projects, and /api/messages.
  - Supabase stores projects and messages.
  - Frontend and backend are deployed separately.
  - GitHub stores the code.
  - Environment variables store Supabase config.
  - .env should not be committed.

  ARCHITECTURE.md should include:
  1. Product overview
  2. Simple system diagram
  3. Component responsibilities
  4. Data flow for loading projects
  5. Data flow for submitting contact form
  6. API contract summary
  7. Database table summary
  8. Deployment architecture
  9. Environment variables
  10. Security notes
  11. Reliability notes
  12. Tradeoffs
  13. Future improvements

  Keep it beginner-friendly, clear, and portfolio-ready.
  Do not exaggerate the product.
  Be honest that this is a learning project.


EXAMPLE SYSTEM DIAGRAM SECTION

  ## System Diagram

  User Browser
   ↓
  Frontend App
   ↓
  Backend API
   ↓
  Supabase Database

  The frontend handles the user interface.
  The backend handles API requests and validation.
  Supabase stores persistent data.


EXAMPLE DATA FLOW SECTION

  ## Data Flow: Submit Contact Message

  1. User fills the contact form.
  2. Frontend sends a POST request to /api/messages.
  3. Backend validates name, email, and message.
  4. Backend inserts the message into Supabase.
  5. Supabase stores the row.
  6. Backend returns success JSON.
  7. Frontend shows a success message.


EXAMPLE TRADEOFFS SECTION

  ## Tradeoffs

  This project uses a simple Express backend instead of microservices.

  Reason: The product is small and beginner-focused. A single backend is
  easier to understand, test, deploy, and debug.

  Future: If the product grows, separate services or serverless functions
  could be considered for authentication, notifications, or content
  management.


FINAL QA CHECKLIST

Check your ARCHITECTURE.md:
  Is the product overview clear?
  Is the system diagram easy to understand?
  Are frontend, backend, and database responsibilities clear?
  Are API endpoints documented?
  Are database tables explained?
  Are environment variables mentioned safely?
  Are security notes included?
  Are tradeoffs honest?
  Are future improvements realistic?
  Would a recruiter understand the project faster after reading it?


SAVE WITH GIT

  git status
  git add ARCHITECTURE.md
  git commit -m "Add architecture documentation"
  git push


[!] You completed Module 10. You now understand software architecture at a product-builder level.

You learned: architecture means how software parts are organized and connected, full-stack products include frontend, backend, database, code repo, deployment, and environment variables, each layer should have clear responsibilities, data flow helps you understand and debug user actions, API contracts keep frontend and backend aligned, simple architecture is usually better for beginner products, scalability should solve real growth problems not imagined ones, reliability means understanding what can break, security starts with good architecture choices, and architecture documents make your project easier to understand.

You now have more than a working project. You have a documented system.

Next: Final Capstone — Ship Your Portfolio Product.$L1011$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 10.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'What is software architecture?',
    '["Only the visual design of the page","How the parts of a software system are organized and connected","A Git commit message","A CSS animation"]',
    1
  );

  -- Q2 — Lesson 10.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'Where does long-term product data usually live?',
    '["Frontend CSS","Database","README only","Browser tab title"]',
    1
  );

  -- Q3 — Lesson 10.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'Which layer should protect secret API keys?',
    '["Public frontend code","Backend or hosting environment variables","CSS file","README screenshot"]',
    1
  );

  -- Q4 — Lesson 10.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'Why is data flow useful?',
    '["It helps trace where data moves and where bugs may happen","It only changes font size","It replaces GitHub","It deletes APIs"]',
    0
  );

  -- Q5 — Lesson 10.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'What is an API contract?',
    '["The agreement between frontend and backend about requests and responses","A CSS file","A GitHub branch","A database backup only"]',
    0
  );

  -- Q6 — Lesson 10.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'For a beginner portfolio product, what is usually the best architecture?',
    '["Simple monolith-style backend","Ten microservices","No database ever","Only screenshots"]',
    0
  );

  -- Q7 — Lesson 10.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'What does scalability mean?',
    '["Ability to handle more users, data, or traffic","Making every button larger","Writing longer README files","Deleting old tests"]',
    0
  );

  -- Q8 — Lesson 10.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'What is reliability?',
    '["The product''s ability to keep working or fail gracefully","Only the color of the page","A GitHub username","A SQL table name"]',
    0
  );

  -- Q9 — Lesson 10.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'Where should powerful secret keys never be placed?',
    '["Public frontend code","Secure backend environment variables","Hosting platform secret settings","Private local .env file"]',
    0
  );

  -- Q10 — Lesson 10.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'Why is ARCHITECTURE.md useful?',
    '["It explains how the product system is organized","It replaces the database","It automatically deploys the app","It hides bugs"]',
    0
  );

  -- Q11 — Lesson 10.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the main output of the Module 10 project?',
    '["ARCHITECTURE.md documenting system diagram, data flows, API contracts, and tradeoffs","A new CSS theme","A Git branch","A Supabase SQL table"]',
    0
  );

end $$;
