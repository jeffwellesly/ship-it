-- Module 9: Testing and Quality — Ship Without Fear
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
    'Module 9: Testing and Quality: Ship Without Fear',
    'Learn how to test your product, catch bugs, and ship with more confidence.',
    9
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.1 — What Testing Really Means
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Testing Really Means',
    1,
    $L91$Testing means checking whether your product behaves the way it should.

Testing is not about proving your product is perfect.

No product is perfect.

**Testing is about reducing risk** before users experience problems.

A beginner may think:
  If the page opens, it works.

But a builder asks:
  Does the full user flow work?
  What happens if the user enters bad data?
  What happens if the backend is down?
  Does it work on mobile?
  Does it still work after my latest change?

That is testing.

>> Testing is not a perfectionism exercise. It is a confidence-building exercise.


ANALOGY

Testing is like checking your car before a long drive.

You do not inspect every atom.

But you check important things:
  Fuel
  Tires
  Brakes
  Lights
  Route
  Warning signs

Software testing is similar. You check the important product flows before shipping.


KEY TERMS

**Testing** — Checking whether the product behaves correctly.

**QA** — Quality Assurance. The process of checking product quality.

**Test case** — A specific scenario you test.

**Bug** — Something that does not behave as expected.

**Expected result** — What should happen.

**Actual result** — What really happened.


PRODUCT EXAMPLE

For your portfolio product, important flows may be:
  1. User opens live frontend
  2. User sees project cards
  3. User submits contact form
  4. Backend receives the message
  5. Supabase saves the message
  6. User sees success message

If this flow works, the core product works. If this flow breaks, the product feels broken.


MINI EXERCISE

Write your product's top 3 flows. Example:
  1. View projects
  2. Submit contact form
  3. Load live deployed page on mobile

Then answer: which one is most important?


CLAUDE PROMPT

Ask Claude:
  Look at my portfolio-product app and identify the 5 most important user
  flows I should test before sharing it publicly. Explain why each flow matters.$L91$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.2 — Happy Path: The Main Flow Should Work
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Happy Path: The Main Flow Should Work',
    2,
    $L92$The **happy path** is the normal successful flow.

It is what should happen when everything goes well.

Example:
  A user opens your site.
  They view your projects.
  They fill the contact form correctly.
  They click submit.
  They see a success message.
  The message appears in Supabase.

That is the happy path.


HAPPY PATH EXAMPLE

Feature:
  Contact form

Happy path:
  1. User enters name
  2. User enters valid email
  3. User enters message
  4. User clicks Submit
  5. Frontend sends request to backend
  6. Backend validates data
  7. Backend saves message to Supabase
  8. Backend returns success
  9. Frontend shows success message


WHY HAPPY PATH MATTERS

If the happy path fails, the main product is broken.

Before testing rare cases, first test the normal case.

Beginner rule:
  First make the normal flow work.
  Then test what can go wrong.


TEST CASE FORMAT

Use this simple format:

  Test case:
  Submit contact form successfully

  Steps:
  1. Open live frontend
  2. Enter name
  3. Enter email
  4. Enter message
  5. Click Submit

  Expected result:
  Success message appears.
  Message is saved in Supabase.

  Actual result:
  [Fill this after testing]

  Status:
  Pass / Fail


MINI EXERCISE

Create one happy path test case for viewing project cards:

  Test case: View project cards
  Steps:
  1. Open live frontend
  2. Wait for page to load
  3. Look at project section

  Expected result:
  At least 3 project cards appear with title and description.

  Actual result: [Fill after testing]
  Status: Pass / Fail


CLAUDE PROMPT

Ask Claude:
  Create happy path test cases for my app. Include project loading,
  contact form submission, and backend health check. Use steps, expected
  result, actual result, and pass/fail status.$L92$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.3 — Edge Cases: What If the User Does Something Weird?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Edge Cases: What If the User Does Something Weird?',
    3,
    $L93$Users do not always behave exactly as expected.

They may:
  Leave fields empty
  Type a very long message
  Use an invalid email
  Click submit multiple times
  Open the site on a small phone
  Lose internet connection
  Refresh during loading

These are **edge cases**.

An edge case is not the normal flow, but it can still happen. Good products handle edge cases gracefully.

>> Do not blame users for doing unexpected things. Design for it.


CONTACT FORM EDGE CASES

For your contact form, test:
  1. Empty name
  2. Empty email
  3. Invalid email format
  4. Empty message
  5. Very long message
  6. Submit button clicked twice
  7. Backend not reachable
  8. Slow internet
  9. Message with special characters
  10. Mobile screen


EXAMPLE EDGE CASE TEST

  Test case:
  Submit contact form with empty email

  Steps:
  1. Open live frontend
  2. Enter name
  3. Leave email empty
  4. Enter message
  5. Click Submit

  Expected result:
  User sees clear error message.
  Message is not saved to database.

  Actual result: [Fill after testing]
  Status: Pass / Fail


PRODUCT BUILDER RULE

A user who makes a mistake should understand what happened and how to fix it.

Bad error:
  Error.

Better error:
  Please enter your email before submitting.

[!] If a user makes the same mistake repeatedly, the product may not be communicating clearly enough. The error message is the product.


MINI EXERCISE

Write 5 edge cases for your app using this format:
  If the user does [action], the product should [expected behavior].

Example:
  If the user submits an empty contact form, the product should show a
  clear error and not save the message.


CLAUDE PROMPT

Ask Claude:
  List edge cases for my portfolio-product app. Focus on project loading,
  contact form submission, mobile layout, slow backend, and invalid user input.$L93$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.4 — Error States: When Things Go Wrong
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Error States: When Things Go Wrong',
    4,
    $L94$Products fail sometimes.

The backend may be down. The database may reject a request. The internet may be slow. The user may submit invalid data.

A good product does not pretend failure never happens. A good product shows clear **error states**.


COMMON ERROR STATES

For your app, possible errors include:
  Projects failed to load.
  Contact form submission failed.
  Email is missing.
  Message is too long.
  Backend is not reachable.
  Database save failed.
  User is offline.

Each error should tell the user what happened and what to do next.


BAD VS GOOD ERROR MESSAGES

Bad:
  Something went wrong.

Better:
  We could not send your message. Please check your internet and try again.

Bad:
  400

Better:
  Please enter your name, email, and message before submitting.

Bad:
  500 server error

Better:
  The server had trouble saving your message. Please try again in a few minutes.


LOADING STATE

Before success or error, there is often loading.

Example:
  Sending your message...

This tells users the app is working. Without a loading state, users may click repeatedly.

[!] No loading state is itself a bug. If the user cannot tell whether something is happening, they will assume it is broken.


EMPTY STATE

Sometimes there is no data.

Example:
  No projects added yet.

This is better than showing a blank section.


PRODUCT STATE TYPES

Most product screens need four states:
  1. Loading state
  2. Success state
  3. Error state
  4. Empty state

>> These four states are not optional. They are the difference between a product that feels broken and one that feels trustworthy.


MINI EXERCISE

Check your project cards section.
What should users see if no projects load?
  No projects available yet. Please check back later.

Check your contact form.
What should users see while submitting?
  Sending your message...


CLAUDE PROMPT

Ask Claude:
  Review my frontend for loading, success, error, and empty states.
  Suggest clear beginner-friendly messages for each state.
  Do not make code changes until I approve.$L94$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.5 — Manual QA: Testing Like a Real User
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Manual QA: Testing Like a Real User',
    5,
    $L95$**Manual QA** means testing the product yourself like a real user.

This is not random clicking. It is a structured walkthrough.

You test important flows and record what happens.

Manual QA is powerful because humans notice things automated tests may miss:
  Confusing wording
  Bad spacing
  Mobile awkwardness
  Button not obvious
  Error message unclear
  Page feels slow
  Flow feels broken

>> Automated tests check logic. Humans check experience.


MANUAL QA CHECKLIST

PAGE LOAD
  Does the live frontend open?
  Does the page load quickly?
  Is the main purpose clear?

PROJECT CARDS
  Do projects appear?
  Are titles readable?
  Does layout work on mobile?

CONTACT FORM
  Can user enter name?
  Can user enter email?
  Can user enter message?
  Does submit work?
  Does success message appear?

BACKEND
  Does /health work?
  Does /api/projects return JSON?
  Does form submission save to Supabase?

MOBILE
  Does text fit?
  Are buttons easy to tap?
  Do cards stack properly?

ACCESSIBILITY
  Can you use Tab key?
  Is focus visible?
  Are buttons and links clear?


TESTING DEVICE SIZES

At minimum test:
  Desktop width
  Tablet width
  Mobile width

Use Chrome DevTools device toolbar for mobile preview. Also test on your actual phone if possible.


MINI EXERCISE

Create a TESTING.md file. Add:

  # Testing Notes

  ## Manual QA Checklist

  - [ ] Live frontend opens
  - [ ] Project cards load
  - [ ] Contact form submits successfully
  - [ ] Empty form shows error
  - [ ] Backend health endpoint works
  - [ ] Mobile layout works
  - [ ] Keyboard navigation works
  - [ ] No requests go to localhost


CLAUDE PROMPT

Ask Claude:
  Create a manual QA checklist for my deployed portfolio-product app.
  Include desktop, mobile, frontend, backend, database, error states,
  and accessibility checks.$L95$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.6 — Backend API Testing
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Backend API Testing',
    6,
    $L96$Your backend has endpoints. Each endpoint should be tested.

For your app, common endpoints may be:
  GET /health
  GET /api/projects
  POST /api/messages

Backend testing means checking:
  Does the endpoint respond?
  Is the status code correct?
  Is the JSON shape correct?
  Does validation work?
  Are errors clear?


TEST GET /HEALTH

Expected:
  {
    "status": "ok",
    "message": "Backend is running"
  }

Status code: 200


TEST GET /API/PROJECTS

Expected:
  Status: 200
  Response: list of projects

Each project should have: id, title, description, status.


TEST POST /API/MESSAGES

Valid request:
  {
    "name": "Jeff",
    "email": "jeff@example.com",
    "message": "Testing my backend."
  }

Expected:
  Status: 201
  Message saved to Supabase
  Success response returned

Invalid request (missing fields):
  {
    "name": "Jeff"
  }

Expected:
  Status: 400
  Clear validation error
  No message saved

[!] Status codes communicate intent. 200 means OK. 201 means created. 400 means the client sent bad data. 500 means the server failed. These are not arbitrary numbers.


TEST WITH CURL

Health:
  curl https://YOUR_BACKEND_URL/health

Projects:
  curl https://YOUR_BACKEND_URL/api/projects

Valid message:
  curl -X POST https://YOUR_BACKEND_URL/api/messages \
    -H "Content-Type: application/json" \
    -d '{"name":"Jeff","email":"jeff@example.com","message":"Testing."}'

Invalid message:
  curl -X POST https://YOUR_BACKEND_URL/api/messages \
    -H "Content-Type: application/json" \
    -d '{"name":"Jeff"}'


API TEST CASE FORMAT

  Endpoint: POST /api/messages
  Scenario: Missing email
  Request: Name present, email missing, message present
  Expected result: Status 400, error explains email is required, not saved
  Actual result: [Fill after testing]
  Status: Pass / Fail


CLAUDE PROMPT

Ask Claude:
  Create API test cases for my Express backend. Include GET /health,
  GET /api/projects, valid POST /api/messages, and invalid POST
  /api/messages. Use expected status codes and expected JSON.$L96$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.7 — Frontend Testing
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Frontend Testing',
    7,
    $L97$Backend tests check the API. Frontend tests check what the user experiences.

A frontend may call the backend correctly but still feel broken if:
  Button is hidden
  Error message is unclear
  Form does not reset after submit
  Layout breaks on mobile
  Success message disappears too quickly
  User cannot navigate with keyboard

Frontend testing asks: can the user successfully complete the task?


FLOW 1 — VIEW PROJECTS

Steps:
  1. Open live frontend
  2. Scroll to projects
  3. Confirm project cards appear
  4. Check title, description, and layout

Expected:
  Projects appear clearly and are readable on desktop and mobile.


FLOW 2 — SUBMIT CONTACT FORM

Steps:
  1. Enter name
  2. Enter email
  3. Enter message
  4. Click submit
  5. Wait for response

Expected:
  Loading message appears.
  Success message appears.
  Form does not feel stuck.
  Message is saved in Supabase.


FLOW 3 — INVALID CONTACT FORM

Steps:
  1. Leave email empty
  2. Click submit

Expected:
  Clear error message appears.
  User knows what to fix.
  No message is saved.


VISUAL QUALITY CHECKS

Ask:
  Is the main CTA obvious?
  Are buttons easy to tap?
  Is text readable?
  Do cards align?
  Is spacing comfortable?
  Does the page feel trustworthy?
  Does the design break on mobile?


ACCESSIBILITY CHECKS

Test with keyboard:
  1. Press Tab
  2. Move through links and buttons
  3. Press Enter on buttons and links
  4. Confirm focus is visible

[!] If you cannot see where the keyboard focus is, fix it. Invisible focus is an accessibility failure. Some users navigate entirely by keyboard.

>> Backend tests prove the engine works. Frontend tests prove the car feels driveable.


CLAUDE PROMPT

Ask Claude:
  Create frontend test cases for my live app. Include project loading,
  contact form success, contact form error, mobile layout, keyboard
  navigation, and loading states.$L97$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.8 — Regression Testing: Don't Break What Worked
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Regression Testing: Don''t Break What Worked',
    8,
    $L98$A **regression** is when something that used to work breaks after a new change.

Example:
  You improve the contact form design.
  But now the submit button no longer works.
  That is a regression.

**Regression testing** means checking old important flows after making new changes.


ANALOGY

Imagine fixing your car's AC.

After the repair, you should still check:
  Does the car start?
  Do brakes work?
  Do lights work?

You fixed one thing, but you do not want to break another.

Software is the same.

[!] Regression bugs are often invisible until a real user finds them. Run your regression checklist after every major change so you find them first.


REGRESSION TEST CHECKLIST

After any change, recheck:
  Live page opens
  Projects load
  Contact form submits
  Invalid form shows error
  Backend health works
  No localhost requests
  Mobile layout works

This checklist protects your product.


WHEN TO RUN REGRESSION TESTS

Run regression tests after:
  Claude Code makes a big change
  You update API URLs
  You change form code
  You change database logic
  You deploy a new version
  You merge a branch
  You fix a bug


MINI EXERCISE

Add this to TESTING.md:

  ## Regression Checklist

  Run this after major changes:

  - [ ] Live frontend opens
  - [ ] Projects load
  - [ ] Contact form submits successfully
  - [ ] Invalid contact form shows error
  - [ ] Backend /health works
  - [ ] No requests go to localhost
  - [ ] Mobile layout works
  - [ ] Keyboard navigation works

>> Regression testing is how teams stay confident as a product grows. Without it, every change is a gamble.


CLAUDE PROMPT

Ask Claude:
  Create a regression checklist for my app. It should cover the features
  that must not break after future changes.$L98$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.9 — Bug Reports: Explain Problems Clearly
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Bug Reports: Explain Problems Clearly',
    9,
    $L99$A bad bug report says:
  It does not work.

That is not useful.

A good bug report explains:
  What you expected
  What actually happened
  Steps to reproduce
  Environment
  Screenshot or error message
  Severity

Good bug reports help you, Claude Code, and engineers fix problems faster.

>> A bug report is not a complaint. It is a clear description of the gap between expectation and reality.


BUG REPORT TEMPLATE

Use this format:

  ## Bug title
  Short clear title.

  ## Steps to reproduce
  1. Open...
  2. Click...
  3. Enter...
  4. Submit...

  ## Expected result
  What should happen?

  ## Actual result
  What happened instead?

  ## Environment
  - Browser:
  - Device:
  - Frontend URL:
  - Backend URL:

  ## Screenshot or error
  Paste screenshot, console error, or network error.

  ## Severity
  Low / Medium / High


EXAMPLE BUG REPORT

  ## Contact form shows success but message is not saved

  ## Steps to reproduce
  1. Open live frontend
  2. Enter name, email, and message
  3. Click Submit
  4. Check Supabase messages table

  ## Expected result
  Success message appears and message is saved in Supabase.

  ## Actual result
  Success message appears, but no new row appears in Supabase.

  ## Environment
  Browser: Chrome. Device: MacBook.
  Frontend URL: live frontend URL.
  Backend URL: live backend URL.

  ## Screenshot or error
  No console error visible.

  ## Severity
  High


SEVERITY LEVELS

**High** — Main product flow is broken.
  Example: Contact form cannot submit.

**Medium** — Important but workaround exists.
  Example: Mobile layout is cramped but usable.

**Low** — Small polish issue.
  Example: Button spacing looks slightly uneven.

[!] Severity matters because it guides priority. Fix High bugs before sharing the product. Medium and Low bugs can wait for a later pass.


CLAUDE PROMPT

Ask Claude:
  Turn this problem into a clear bug report:
  [describe the issue]

  Use sections for steps to reproduce, expected result, actual result,
  environment, evidence, and severity.$L99$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.10 — Pre-Ship Quality Checklist
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Pre-Ship Quality Checklist',
    10,
    $L910$Before sharing your project, run a **pre-ship checklist**.

This is what real builders do.

You do not need to test everything. But you should test the important things.


PRODUCT
  Main purpose is clear
  Primary CTA is obvious
  Main user flow works
  Error messages are clear
  Empty states are not confusing


FRONTEND
  Live frontend opens
  Mobile layout works
  Text is readable
  Buttons look clickable
  Keyboard focus is visible
  No obvious console errors


BACKEND
  /health endpoint works
  /api/projects returns JSON
  /api/messages accepts valid data
  Invalid data returns clear 400 error
  Server logs do not show repeated errors


DATABASE
  Supabase tables exist
  Contact form saves messages
  No unwanted test data shown publicly
  Security rules understood at beginner level


DEPLOYMENT
  Frontend uses live backend URL
  No requests go to localhost
  Environment variables set in hosting platform
  .env is not in GitHub
  README has live links


PORTFOLIO
  README explains the project
  GitHub repo is clean
  Live link works
  Known limitations are honest
  Next improvements are listed


QUALITY MINDSET

Shipping does not mean perfect.

Shipping means:
  Useful enough.
  Tested enough.
  Clear enough.
  Safe enough.
  Ready for feedback.

That is how real products improve.

>> The goal of a pre-ship checklist is not perfection. It is confidence that the important things work.


CLAUDE PROMPT

Ask Claude:
  Create a pre-ship quality checklist for my portfolio-product app.
  Include frontend, backend, database, deployment, security basics,
  README, and portfolio presentation.$L910$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.11 — Module Project: Create a Testing System for Your Product
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Module Project: Create a Testing System for Your Product',
    11,
    $L911$Now you will create a testing system for your project.

This does not need to be complex. It needs to be useful.

Your goal is to make testing repeatable.

Instead of asking: what should I check?

You will have a clear checklist.

>> Testing once is good. Testing repeatably is a system.


FINAL PROJECT REQUIREMENTS

Create or update: TESTING.md

It should include:
  1. Product flows
  2. Happy path test cases
  3. Edge case test cases
  4. Error state checklist
  5. Manual QA checklist
  6. Backend API test cases
  7. Frontend test cases
  8. Regression checklist
  9. Bug report template
  10. Pre-ship checklist

Optional:
  11. Simple automated backend tests


RECOMMENDED TESTING.MD STRUCTURE

  # Testing Plan

  ## Product Flows

  ## Happy Path Tests

  ## Edge Case Tests

  ## Error States

  ## Manual QA Checklist

  ## Backend API Tests

  ## Frontend Tests

  ## Regression Checklist

  ## Bug Report Template

  ## Pre-Ship Checklist

  ## Known Issues


FINAL CLAUDE CODE PROMPT

Give this to Claude Code:

  Create a TESTING.md file for my portfolio-product project.

  Include:
  1. Product flows
  2. Happy path test cases
  3. Edge case test cases
  4. Error state checklist
  5. Manual QA checklist
  6. Backend API tests
  7. Frontend test cases
  8. Regression checklist
  9. Bug report template
  10. Pre-ship checklist
  11. Known issues section

  Use my app context:
  - Frontend shows project cards
  - Backend has /health, /api/projects, and /api/messages
  - Contact form saves messages to Supabase
  - App is deployed with live frontend and live backend URLs

  Keep it beginner-friendly and practical. Do not overcomplicate it.


OPTIONAL AUTOMATED BACKEND TESTS PROMPT

  Add simple automated backend tests for my Express API.

  Requirements:
  1. Keep tests beginner-friendly.
  2. Test GET /health.
  3. Test GET /api/projects.
  4. Test POST /api/messages with missing fields returns 400.
  5. Do not require real production data if avoidable.
  6. Explain how to run the tests.
  7. Add a test script to package.json.
  8. Do not break the existing backend.

  Before editing, explain the plan and any packages you need.


FINAL TESTING RUN

After creating TESTING.md, run through:
  1. Live frontend opens
  2. Projects load
  3. Contact form valid submission works
  4. Contact form invalid submission shows error
  5. Backend /health works
  6. Backend /api/projects works
  7. Supabase receives message
  8. Mobile layout works
  9. No localhost requests
  10. README live links work

Record pass/fail for each.


SAVE WITH GIT

  git status
  git add TESTING.md
  git commit -m "Add testing plan"
  git push

If you added automated tests:
  git add .
  git commit -m "Add backend API tests"
  git push


[!] You completed Module 9. You now know how to test before shipping.

You learned: testing reduces risk, happy paths check normal successful flows, edge cases check unusual but possible situations, error states help users recover, manual QA tests real user experience, backend API tests check endpoints and status codes, frontend tests check what users see and do, regression testing protects old working features, good bug reports help problems get fixed faster, and pre-ship checklists make quality repeatable.

You are no longer just building and hoping. You are building, checking, fixing, and shipping with confidence.

Next module: Module 10 — Architecture: How Software Products Are Organized.$L911$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 9.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'What is the main goal of testing?',
    '["To prove the product is perfect","To reduce risk and check important behavior","To make the logo bigger","To replace GitHub"]',
    1
  );

  -- Q2 — Lesson 9.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What is the happy path?',
    '["The normal successful user flow","A broken error case","A Git branch","A CSS animation"]',
    0
  );

  -- Q3 — Lesson 9.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'What is an edge case?',
    '["An unusual but possible situation the product should handle","A normal successful flow","A database table","A deployment URL"]',
    0
  );

  -- Q4 — Lesson 9.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'What should a product show while waiting for a backend response?',
    '["Nothing","A loading state","A GitHub issue","A database schema"]',
    1
  );

  -- Q5 — Lesson 9.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'What is manual QA?',
    '["Structured human testing of the product","A database type","A Git commit command","A CSS selector"]',
    0
  );

  -- Q6 — Lesson 9.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'What should invalid contact form data usually return?',
    '["400 Bad Request","200 OK always","A CSS file","A Git branch"]',
    0
  );

  -- Q7 — Lesson 9.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'Frontend testing mainly checks:',
    '["What the user sees and experiences","Only database tables","Only Git commits","Only DNS settings"]',
    0
  );

  -- Q8 — Lesson 9.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'What is regression testing?',
    '["Rechecking old working features after new changes","Creating a database table","Writing only CSS","Deleting old commits"]',
    0
  );

  -- Q9 — Lesson 9.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'Which bug report is better?',
    '["Broken.","When I submit the contact form with valid data, I expect a success message and a saved row, but I get a 500 error.","It does not work.","CSS is wrong."]',
    1
  );

  -- Q10 — Lesson 9.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'What is the purpose of a pre-ship checklist?',
    '["To check important quality items before sharing the product","To delete the app","To replace the database","To avoid GitHub"]',
    0
  );

  -- Q11 — Lesson 9.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the main output of the Module 9 project?',
    '["A TESTING.md file documenting test cases, QA checklists, and bug report templates","A new CSS theme","A Git branch","A Supabase SQL table"]',
    0
  );

end $$;
