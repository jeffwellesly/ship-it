-- Fix em dashes introduced by earlier typography-styling migrations.
-- Software Development with Claude Code / Module 10: Architecture: How Software Products Are Organized
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update lessons set content = $D5988b131_b351_4aa9_b0e7_89ad956d5cc0$Architecture sounds like a big word.

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

**Architecture:** The structure of a software system and how its parts connect.

**System:** The full product, including frontend, backend, database, hosting, and users.

**Component:** One part of the system.

**Responsibility:** What a part is supposed to do.

**Tradeoff:** A decision where you gain something but give up something else.


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
  responsible for.$D5988b131_b351_4aa9_b0e7_89ad956d5cc0$ where id = '5988b131-b351-4aa9-b0e7-89ad956d5cc0';

update lessons set content = $De7633226_ff0f_489e_86b9_018e1dbf9abe$A full-stack product has multiple layers.

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

**User:** The person using your product. They click, type, read, submit, and navigate.

**Frontend:** The visible part. Shows hero section, project cards, contact form, buttons, messages, loading states, and error states.

**Backend:** The hidden logic layer. Handles API requests, validation, business rules, database communication, JSON responses, and errors.

**Database:** The memory layer. Stores projects, contact messages, blog posts later, user progress later.

**GitHub:** The code home. Stores frontend, backend, README, testing docs, and architecture docs.

**Deployment platforms:** They run your product online. Frontend host serves the user interface. Backend host runs the API. Supabase hosts the database.


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
  variables. Explain it like I am a beginner.$De7633226_ff0f_489e_86b9_018e1dbf9abe$ where id = 'e7633226-ff0f-489e-86b9-018e1dbf9abe';

update lessons set content = $Dff2fd1e6_b7c6_4170_a2c5_27dd4dc7cc97$Good products separate responsibilities.

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

[!] When the frontend bypasses the backend, you lose the trusted validation layer. Users can submit anything, invalid data, duplicate requests, malformed input.


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
  wrong layer.$Dff2fd1e6_b7c6_4170_a2c5_27dd4dc7cc97$ where id = 'ff2fd1e6-b7c6-4170-a2c5-27dd4dc7cc97';

update lessons set content = $D037c6cc5_bf3c_4610_b938_ddb7ca73e71d$Architecture becomes easier when you trace one user action.

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

**Data flow:** The path data takes through the system.

**Read flow:** A flow that loads data. Example: GET /api/projects.

**Write flow:** A flow that saves or changes data. Example: POST /api/messages.

**Source of truth:** The trusted place where the real data lives. For your project, Supabase is the source of truth for projects and messages.


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

  Keep it beginner-friendly.$D037c6cc5_bf3c_4610_b938_ddb7ca73e71d$ where id = '037c6cc5-bf3c-4610-b938-ddb7ca73e71d';

update lessons set content = $D90db33b5_4d02_4e63_8f88_3ac04d3e0998$You may hear people talk about:
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

Monolith, Good for: simplicity, speed, beginner projects. Tradeoff: can get messy if not organized.

Microservices, Good for: large systems, many teams, independent scaling. Tradeoff: much more complexity.

Serverless functions, Good for: small event-based backend tasks. Tradeoff: platform limits and debugging complexity.


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
  architecture for my current stage and explain the tradeoffs.$D90db33b5_4d02_4e63_8f88_3ac04d3e0998$ where id = '90db33b5-4d02-4e63-8f88-3ac04d3e0998';

update lessons set content = $Db35e4417_1828_4126_b491_43f672f08f73$Security is a deep topic. You will not master it in one lesson.

But you must learn beginner safety rules.

Security is not something you add only at the end. Architecture decisions affect security.


RULE 1, DO NOT EXPOSE SECRETS

Never put secret keys in frontend code. Never commit .env. Never paste service role keys into GitHub.

Secrets belong in backend environment variables or secure platform settings.


RULE 2, VALIDATE ON THE BACKEND

Frontend validation helps users. Backend validation protects the system.

Never trust the frontend alone.

A user can bypass your webpage and send requests directly to your backend.

[!] Always validate on the server side. Frontend validation is a courtesy. Backend validation is a requirement.


RULE 3, USE HTTPS

Your deployed frontend and backend should use HTTPS. This protects data while it travels between browser and server.


RULE 4, BE CAREFUL WITH DATABASE PERMISSIONS

Supabase has security rules. Do not make private data publicly readable or writable without understanding the risk. For learning projects, keep data simple and avoid storing sensitive personal information.


RULE 5, DO NOT STORE SENSITIVE DATA UNLESS NEEDED

Do not store:
  Passwords manually
  Payment details
  Government IDs
  Sensitive personal information

Use trusted services for authentication and payments later.


RULE 6, HANDLE ERRORS SAFELY

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
  priority order.$Db35e4417_1828_4126_b491_43f672f08f73$ where id = 'b35e4417-1828-4126-b491-43f672f08f73';

update lessons set content = $D79f810c9_3345_49f1_8cc7_233a0634a225$Now you will create the architecture document for your product.

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

Next: Final Capstone, Ship Your Portfolio Product.$D79f810c9_3345_49f1_8cc7_233a0634a225$ where id = '79f810c9-3345-49f1-8cc7-233a0634a225';
