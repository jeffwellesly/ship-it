-- Module 2: Your First Webpage
-- 9 lessons with >> pull quotes, [!] callouts, **bold** key terms

do $$
declare
  v_course_id uuid;
  v_module_id uuid;
  v_l1 uuid; v_l2 uuid; v_l3 uuid; v_l4 uuid; v_l5 uuid;
  v_l6 uuid; v_l7 uuid; v_l8 uuid; v_l9 uuid;
begin

  select id into v_course_id from courses where sort_order = 1;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 2: Your First Webpage',
    'Build your first personal webpage using HTML, CSS, and JavaScript, with Claude Code as your building partner.',
    2
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.1 — What Is a Webpage?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is a Webpage?',
    1,
    $L21$>> A webpage is just a file that your browser knows how to read.

When you open a website, your browser receives files. The most important file is usually an HTML file.

HTML tells the browser: what text to show, what headings exist, where buttons are, where images go, and what links exist.

Then CSS tells the browser how those things should look. JavaScript tells the browser how those things should behave when the user clicks, types, scrolls, or interacts.

For your first webpage, we will keep it simple. You will create a page with your name, a short bio, a few interests, a button, simple styling, and one small interaction.

This may sound small, but it is a real webpage. Every large app started with the same basic idea: a screen shows something, a user does something, the screen responds.


MENTAL MODEL

[!] Think of a webpage like a small shop. HTML decides what exists in the shop — counter, shelves, signboard, products. CSS decides how the shop looks — colors, lighting, spacing, decoration. JavaScript decides what happens when someone interacts — door opens, bell rings, payment machine works. Without HTML, nothing exists. Without CSS, everything looks plain. Without JavaScript, nothing responds.


KEY TERMS

**Webpage** — A page shown by a browser.

**Browser** — An app like Chrome, Safari, Edge, or Firefox that reads website files and displays them.

**HTML file** — The main file that defines the structure of a webpage.

**Local file** — A file on your computer, not yet on the internet.

**Live website** — A webpage available on a public URL that anyone can visit.


WHAT WE ARE BUILDING FIRST

For now, your webpage will live only on your computer. That means only you can see it. Later, in the deployment module, you will put it online so anyone can visit it.$L21$
  ) returning id into v_l1;

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'What is a webpage?',
    '["A magical experience created by servers", "A file that your browser knows how to read", "A database record stored online", "A program running in the cloud"]',
    1
  );

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.2 — Create Your First HTML File
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Create Your First HTML File',
    2,
    $L22$Now we will create your first webpage manually.

Do not worry about making it beautiful yet. First, we need to make it exist.


STEP 1 — CREATE A NEW PROJECT FOLDER

Open your terminal. Go to your Desktop:

  cd ~/Desktop

Create a new folder and move into it:

  mkdir my-first-webpage
  cd my-first-webpage

Open it in VS Code:

  code .

If code . does not work, open VS Code manually and choose: File → Open Folder → Desktop → my-first-webpage


STEP 2 — CREATE index.html

Inside VS Code, create a new file called index.html and paste this code:

  <!DOCTYPE html>
  <html>
    <head>
      <title>My First Webpage</title>
    </head>
    <body>
      <h1>Hello, I am learning to build software.</h1>
      <p>This is my first webpage.</p>
    </body>
  </html>

Save the file.


STEP 3 — OPEN IT IN YOUR BROWSER

In the terminal, run:

  open index.html       (Mac)
  start index.html      (Windows)

If that does not work, right-click the file in VS Code and choose Reveal in Finder or Reveal in File Explorer, then double-click index.html.


WHAT JUST HAPPENED

[!] You created an HTML file. Your browser read the file. Your browser showed the heading and paragraph on screen. That is a webpage — simple, but real.


CODE EXPLANATION

DOCTYPE html — Tells the browser this is an HTML document.

html — Wraps the whole webpage.

head — Contains information about the page not directly shown on screen.

title — Appears in the browser tab.

>> body — Contains everything the user actually sees. Every visible element on the page lives here.

h1 — The main heading.

p — A paragraph.


COMMON MISTAKE

If the browser shows a blank page, check: Did you save the file? Is the file named exactly index.html? Did you paste the code inside the file? Did you open the correct file?$L22$
  ) returning id into v_l2;

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What part of the HTML page contains what users actually see?',
    '["head", "title", "body", "doctype"]',
    2
  );

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.3 — HTML, CSS, and JavaScript in Simple Words
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'HTML, CSS, and JavaScript in Simple Words',
    3,
    $L23$Every beginner should understand this clearly before writing more code.

>> HTML gives structure. CSS gives style. JavaScript gives behavior. That is the complete mental model of a webpage — and it never stops being true, no matter how complex the app.

You do not need to master all three today. You just need to understand what each one is responsible for.


HTML — WHAT EXISTS

HTML tells the browser what exists on the page: headings, paragraphs, buttons, images, links, forms, sections. HTML is like the **skeleton** of the page. Without HTML, the page has nothing to show.


CSS — HOW IT LOOKS

CSS tells the browser how the HTML should look: colors, font sizes, backgrounds, spacing, borders, rounded corners, shadows, layout. CSS is like the clothing and interior design of the page. Without CSS, the page still works, but it looks plain.


JAVASCRIPT — WHAT IT DOES

JavaScript tells the browser what should happen when the user interacts: button clicks, dark mode toggles, form validation, popups, counters, text changes. JavaScript is like the electricity of the page. Without JavaScript, the page can look nice but cannot do much.


PRODUCT EXAMPLE

[!] Imagine a food delivery app. The restaurant card shows a name, image, rating, delivery time, and order button. HTML creates those elements. CSS makes the card look clean and clickable. JavaScript handles what happens when you tap Order. That is frontend development in simple words.


MINI EXERCISE

Look at your current index.html. Find the h1 element. Change the text inside it to your name:

  <h1>Hello, I am Jeff.</h1>

Save and refresh the browser.


KEY TERMS

**HTML** — The layer that defines what exists on the page.

**CSS** — The layer that controls how the page looks.

**JavaScript** — The layer that controls what the page does.

**Frontend** — The visible part of a website or app that runs in the browser.$L23$
  ) returning id into v_l3;

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'Which layer makes a webpage interactive?',
    '["HTML", "CSS", "JavaScript", "The browser tab title"]',
    2
  );

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.4 — Make the Page Look Good with CSS
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Make the Page Look Good with CSS',
    4,
    $L24$Your webpage works, but it probably looks plain. That is normal.

HTML creates the structure, but CSS makes the page look designed. Now we will add CSS.


STEP 1 — CREATE A CSS FILE

In VS Code, create a new file called style.css and paste this:

  body {
    font-family: Arial, sans-serif;
    background: #0b0b10;
    color: white;
    text-align: center;
    padding: 80px 20px;
  }

  h1 {
    font-size: 42px;
    margin-bottom: 16px;
  }

  p {
    font-size: 20px;
    color: #c7c7d1;
  }

Save the file.


STEP 2 — CONNECT CSS TO HTML

Open index.html. Inside the head section, add this line:

  <link rel="stylesheet" href="style.css">

Save and refresh your browser.


WHAT CHANGED

The content is the same. But the page looks different.

>> You did not change what the page says. You changed how the page feels. That is the power of CSS.


CSS BASICS

A CSS rule has three parts.

**Selector** — Chooses what to style. Example: h1 selects all h1 headings.

**Property** — The visual attribute you want to change. Example: color

**Value** — The setting you give to that property. Example: white

Together: color: white — means "make the text white."


ANALOGY

[!] HTML is the room. CSS is the paint, lighting, furniture, spacing, and decoration. You can keep the same room and make it feel completely different just by changing the CSS. That is why designers and frontend engineers care so much about it.


MINI EXERCISE

Change the background color. In style.css, find:

  background: #0b0b10;

Change it to:

  background: #111827;

Save and refresh. You just changed the visual personality of the page.


COMMON MISTAKE

If your CSS does not apply, check: Is the file named exactly style.css? Did you save it? Is the link tag inside the head section of index.html? Are both files in the same folder?$L24$
  ) returning id into v_l4;

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'What does CSS mainly control?',
    '["Page structure", "Page appearance", "Browser history", "Git commits"]',
    1
  );

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.5 — Make the Page Respond with JavaScript
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Make the Page Respond with JavaScript',
    5,
    $L25$Your page now exists and looks better. But it does not respond to the user yet.

>> A real product responds. When a user clicks, types, submits, or scrolls, something happens. That is where JavaScript comes in.

For your first interaction, we will add a button. When the user clicks it, the page will show a message.


STEP 1 — ADD A BUTTON TO HTML

Open index.html. Inside the body, under the paragraph, add:

  <button id="helloButton">Click me</button>
  <p id="message"></p>

Also add this line just before the closing body tag:

  <script src="script.js"></script>

This connects JavaScript to your page.


STEP 2 — CREATE script.js

In VS Code, create a new file called script.js and paste this:

  const button = document.getElementById("helloButton");
  const message = document.getElementById("message");

  button.addEventListener("click", function () {
    message.textContent = "You clicked the button. Your page is alive.";
  });

Save and refresh the browser. Click the button.


WHAT JUST HAPPENED

[!] JavaScript found the button by its ID. JavaScript waited for a click. When the click happened, JavaScript changed the message on the page. Think of the button as a doorbell and JavaScript as the person inside waiting. When the user presses the doorbell, JavaScript hears it and responds.


KEY TERMS

**Element** — One piece of the webpage, like a button or paragraph.

**ID** — A unique name given to an HTML element so JavaScript can find it.

**Event** — Something the user does, like clicking or typing.

**Event listener** — JavaScript code that waits for a specific event to happen.

**DOM** — The live version of the webpage that JavaScript can read and change.


MINI EXERCISE

Change the message text. In script.js, find:

  message.textContent = "You clicked the button. Your page is alive.";

Change it to:

  message.textContent = "I just made my first interactive webpage.";

Save, refresh, and click again.


COMMON MISTAKE

If the button does nothing, check: Is script.js saved? Is the script tag included just before the closing body tag? Does the button ID in HTML match exactly what getElementById is looking for? Capitalization matters — helloButton is not the same as HelloButton.$L25$
  ) returning id into v_l5;

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'What does an event listener do?',
    '["Styles a button", "Waits for user actions like a click", "Creates a Git commit", "Opens GitHub"]',
    1
  );

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.6 — Build with Claude Code: Personal Profile Page
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Build with Claude Code: Personal Profile Page',
    6,
    $L26$So far, you created a simple webpage manually. Now we will use Claude Code as a building partner.

This is where the workflow changes. You do not need to write every line from memory. You need to describe what you want clearly, review what Claude creates, and ask for improvements.

>> You are the product builder. Claude is the implementation partner. Your job is to guide — describe what you want, review what comes back, and refine until it feels right.


THE BUILDER LOOP

[!] The most important habit in this lesson: Describe → Review → Refine → Save. Claude does not need to get everything perfect on the first try. Review the result like a product builder, ask for one improvement at a time, and keep iterating. This loop is how real software gets made.


STEP 1 — CREATE A CLAUDE.md FILE

If your project does not already have one, create a file called CLAUDE.md and paste this:

  # My First Webpage

  ## Project Goal
  This is a beginner personal webpage project.

  ## Learner Level
  The learner is new to coding. Explain all changes simply.

  ## Tech Stack
  Use only HTML, CSS, and JavaScript. No frameworks.

  ## Style
  Modern, clean, dark theme, simple centered layout.

  ## Working Rules
  Before making large changes, explain the plan.
  Keep the code simple and beginner-friendly.

Save the file.


STEP 2 — OPEN CLAUDE CODE

In the terminal inside your project folder, run:

  claude

If Claude Code is not installed yet, use the setup link from Module 1.


STEP 3 — GIVE CLAUDE THE BUILD PROMPT

Paste this into Claude Code:

  Improve this beginner webpage into a simple personal profile page.
  Use only HTML, CSS, and JavaScript.

  The page should include:
  1. My name as the main heading
  2. A short bio
  3. Three interest tags
  4. A button that changes a message when clicked
  5. A clean dark theme
  6. A centered card layout
  7. Rounded corners and subtle shadow
  8. Mobile-friendly styling

  Before editing files, explain your plan.
  After editing, tell me which files changed and what each file does.


STEP 4 — REVIEW AND REFINE

After Claude edits the files, open or refresh index.html. Ask yourself: Does the page look better? Is my name visible? Does the layout feel clean? Does the button work?

Do not blindly accept the output. Then ask Claude for one improvement:

  Make the profile card feel more premium but keep the code beginner-friendly. Improve spacing, button style, and interest tags. Do not add any frameworks.


PRODUCT BUILDER REVIEW CHECKLIST

Check: Is the page clear? Is the text readable? Does the button look clickable? Is there enough spacing? Does it work on a smaller browser width? Is the code still understandable?$L26$
  ) returning id into v_l6;

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'When building with Claude Code, what should you do after Claude makes changes?',
    '["Accept everything without checking", "Review the result and refine it", "Delete the project and start over", "Close the browser"]',
    1
  );

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.7 — Review, Refine, and Debug
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Review, Refine, and Debug',
    7,
    $L27$Sometimes your page will break. The button may stop working. The CSS may not load. The layout may look strange.

This is not failure. This is normal software building. The skill is not avoiding every mistake. The skill is learning how to describe the problem clearly.


THE DEBUGGING FORMULA

>> Describe the bug clearly: what you expected, what you actually saw, and what you changed. That one habit makes Claude ten times more useful.

Use this formula when asking for help:

  I expected [expected result].
  But I saw [actual result].
  I changed [what you changed].
  Please help me find the issue step by step.

Compare these two prompts:

Bad: "It is broken. Fix it." — Too vague. Claude has to guess.

Better: "The button appears on the page, but when I click it, the message does not change. Please check the HTML and JavaScript connection. Explain the likely cause before fixing it."


COMMON PROBLEM 1 — CSS NOT LOADING

Symptom: The page looks plain even though you wrote CSS.

Likely causes: CSS file name is wrong, CSS file not saved, HTML link is missing, CSS file is in a different folder.

[!] Ask Claude: "My CSS is not applying. The page still looks plain. Please help me check whether style.css is linked correctly in index.html and whether the file names match."


COMMON PROBLEM 2 — JAVASCRIPT NOT WORKING

Symptom: The button appears, but clicking does nothing.

Likely causes: script.js is not connected, ID names do not match, JavaScript has an error, file was not saved.


COMMON PROBLEM 3 — PAGE DOES NOT UPDATE

Symptom: You changed the file, but the browser still shows the old page.

Likely causes: File not saved, browser not refreshed, wrong file opened.


MINI EXERCISE — BREAK SOMETHING SAFELY

In index.html, temporarily change:

  <script src="script.js"></script>

to:

  <script src="wrong-file.js"></script>

Refresh the page and click the button. It should stop working. Now ask Claude to help you debug. Then change it back. This teaches you that bugs are understandable — they have causes, and causes can be found.


SCREENSHOT HELP

If you are stuck, take a screenshot and show it to Claude or ChatGPT. Ask: "I am stuck here. Look at this screenshot and tell me what is wrong and what I should do next." Modern builders do not guess blindly.$L27$
  ) returning id into v_l7;

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'Which debugging prompt gives Claude the best chance to help?',
    '["\"It is broken. Fix it.\"", "\"The button appears but clicking does nothing. Please check the HTML and JavaScript connection.\"", "\"Something went wrong.\"", "\"Help me please.\""]',
    1
  );

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.8 — Save Your Work with Git
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Save Your Work with Git',
    8,
    $L28$You built your first webpage. Now save a checkpoint.

Whenever your project reaches a working state, commit it with Git. That way, if a future change breaks the page, you can always see what changed.


STEP 1 — CHECK GIT STATUS

In your project folder, run:

  git status

Git will show which files changed. You should see index.html, style.css, script.js, and CLAUDE.md listed.


STEP 2 — ADD FILES

Run:

  git add .

This prepares all changed files for saving.


STEP 3 — COMMIT

Run:

  git commit -m "Build first personal webpage"

This saves a checkpoint.


>> Future you will thank present you for clear commit messages. They are the only record of why something changed.


COMMIT MESSAGES

[!] Good messages tell a story: "Build first personal webpage", "Add dark theme styling", "Add button interaction", "Fix mobile layout." Bad messages waste that story: "changes", "stuff", "final", "asdf." One day you will read old commits trying to understand what broke — make sure past-you was helpful.


STEP 4 — PUSH TO GITHUB (OPTIONAL)

If you have a GitHub repository set up, run:

  git push

This sends your local commits to GitHub for backup and sharing.


KEY TERMS

**git status** — Shows which files have changed since the last commit.

**git add .** — Prepares all changed files for saving.

**git commit -m "..."** — Saves a checkpoint with a descriptive message.

**git push** — Sends commits to GitHub.$L28$
  ) returning id into v_l8;

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'When should you make a Git commit?',
    '["Only at the very end of the project", "Whenever the project reaches a working checkpoint", "Before creating any file", "Never — just save the files"]',
    1
  );

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.9 — Module Project: Your First Personal Webpage  (no quiz)
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Module Project: Your First Personal Webpage',
    9,
    $L29$Now you will finish your first webpage. This does not need to be perfect. It needs to be complete, working, and understandable.

>> A shipped project is not the same as a perfect project. A shipped project is something real that works and can be improved later. Ship it.


FINAL PROJECT REQUIREMENTS

Your webpage should include:

  1. Your name
  2. A short bio
  3. Three interest tags
  4. A button that changes a message when clicked
  5. A clean visual design
  6. A dark theme
  7. Mobile-friendly layout
  8. Separate files for HTML, CSS, and JavaScript
  9. A CLAUDE.md file
  10. A Git commit


RECOMMENDED FILE STRUCTURE

  my-first-webpage/
    index.html
    style.css
    script.js
    CLAUDE.md


FINAL CLAUDE CODE PROMPT

Give this to Claude Code:

  Review my first webpage project.

  Check whether it has:
  1. index.html, style.css, script.js, CLAUDE.md
  2. A personal profile page with my name, bio, interest tags, and a working button
  3. Beginner-friendly code with comments
  4. Mobile-friendly styling
  5. No unnecessary frameworks

  First, show me a checklist of what is complete and what is missing.
  Then suggest only 3 improvements.
  Do not make changes until I approve.


FINAL QA CHECKLIST

Open the webpage in your browser and check: Does the page load? Is your name visible? Is the bio readable? Are the interest tags visible? Does the button work? Does the page look okay when the browser window is narrow? Are files saved? Did you make a Git commit?


[!] You completed Module 2. You now understand: HTML creates structure, CSS controls appearance, JavaScript adds behavior, Claude Code helps you build faster, debugging means describing the problem clearly, and Git saves working checkpoints. You did not just read about software — you made something real.$L29$
  ) returning id into v_l9;

end;
$$;
