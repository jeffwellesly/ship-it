-- Fix em dashes introduced by earlier typography-styling migrations.
-- Software Development with Claude Code / Module 9: Testing and Quality: Ship Without Fear
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update lessons set content = $D520d8bef_6c43_4dfd_9e41_68c2dcab6ad2$Testing means checking whether your product behaves the way it should.

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

**Testing:** Checking whether the product behaves correctly.

**QA:** Quality Assurance. The process of checking product quality.

**Test case:** A specific scenario you test.

**Bug:** Something that does not behave as expected.

**Expected result:** What should happen.

**Actual result:** What really happened.


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
  flows I should test before sharing it publicly. Explain why each flow matters.$D520d8bef_6c43_4dfd_9e41_68c2dcab6ad2$ where id = '520d8bef-6c43-4dfd-9e41-68c2dcab6ad2';

update lessons set content = $D059bbc84_d70f_45df_b4c9_0f7d53496f3e$Backend tests check the API. Frontend tests check what the user experiences.

A frontend may call the backend correctly but still feel broken if:
  Button is hidden
  Error message is unclear
  Form does not reset after submit
  Layout breaks on mobile
  Success message disappears too quickly
  User cannot navigate with keyboard

Frontend testing asks: can the user successfully complete the task?


FLOW 1, VIEW PROJECTS

Steps:
  1. Open live frontend
  2. Scroll to projects
  3. Confirm project cards appear
  4. Check title, description, and layout

Expected:
  Projects appear clearly and are readable on desktop and mobile.


FLOW 2, SUBMIT CONTACT FORM

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


FLOW 3, INVALID CONTACT FORM

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
  navigation, and loading states.$D059bbc84_d70f_45df_b4c9_0f7d53496f3e$ where id = '059bbc84-d70f-45df-b4c9-0f7d53496f3e';

update lessons set content = $Dc35f8914_3ce0_4c98_a266_344ffb41fe6f$A bad bug report says:
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

**High:** Main product flow is broken.
  Example: Contact form cannot submit.

**Medium:** Important but workaround exists.
  Example: Mobile layout is cramped but usable.

**Low:** Small polish issue.
  Example: Button spacing looks slightly uneven.

[!] Severity matters because it guides priority. Fix High bugs before sharing the product. Medium and Low bugs can wait for a later pass.


CLAUDE PROMPT

Ask Claude:
  Turn this problem into a clear bug report:
  [describe the issue]

  Use sections for steps to reproduce, expected result, actual result,
  environment, evidence, and severity.$Dc35f8914_3ce0_4c98_a266_344ffb41fe6f$ where id = 'c35f8914-3ce0-4c98-a266-344ffb41fe6f';

update lessons set content = $D855bdb89_b110_4eb7_896e_500e46c4ad55$Now you will create a testing system for your project.

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

Next module: Module 10, Architecture: How Software Products Are Organized.$D855bdb89_b110_4eb7_896e_500e46c4ad55$ where id = '855bdb89-b110-4eb7-896e-500e46c4ad55';
