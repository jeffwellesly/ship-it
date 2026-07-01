-- Module 6: Databases — Where Products Remember Things
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
    'Module 6: Databases: Where Products Remember Things',
    'Learn how software remembers data and connect your backend to a real database using Supabase.',
    6
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.1 — Why Databases Exist
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Why Databases Exist',
    1,
    $L61$Think about the backend you built in Module 5.

It could receive a contact form message and store it in a temporary list. But if you stopped the server and started it again, the message disappeared. That is because the message lived only in temporary memory.

Real products cannot work like that.

Imagine: you place an order and it disappears. You complete a lesson and your progress resets. You upload a profile photo and it vanishes. You pay for something and the system loses the record.

>> Users would lose trust immediately.

A database exists so software can remember things permanently.


TWO KINDS OF MEMORY

A product has two kinds of memory:

**Temporary memory** — Fast, active, but disappears when the program stops.

**Permanent memory** — Slower, organized, and survives restarts.

The database is permanent memory.


PRODUCT EXAMPLES

A learning app needs to remember: user accounts, course progress, completed lessons, quiz answers, payment status, and certificates.

A portfolio website may need to remember: blog posts, contact messages, project list, and newsletter signups.

A food delivery app needs to remember: users, restaurants, menus, orders, payments, delivery addresses, and reviews.

[!] Without a database, these products cannot be trusted.


KEY TERMS

**Database** — A system that stores data so software can retrieve it later.

**Data** — Information used by a product.

**Persistent** — Data that remains even after the app or server restarts.

**Record** — One saved item in a database, like one message or one project.$L61$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.2 — RAM vs Database: Whiteboard vs Filing Cabinet
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'RAM vs Database: Whiteboard vs Filing Cabinet',
    2,
    $L62$In Module 5, your backend may have used a JavaScript array like this:

  const messages = [];

That array lives in **RAM**. RAM is your computer's active working memory. RAM is fast. But RAM is temporary. When the server stops, RAM clears.

  Server stops → messages disappear

A database stores data in a more permanent way.

  Server stops → data still exists


ANALOGY

[!] RAM is like a whiteboard. You can write on it quickly. You can erase it quickly. But if someone wipes the board, everything is gone. A database is like a filing cabinet. It is more organized. It takes a little more effort to store and retrieve things. But the files remain there later.


SIDE BY SIDE

RAM: Very fast, does not survive restart. Good for temporary calculations and active state.

Database: Slower than RAM, survives restart. Good for orders, users, and messages.


PRODUCT EXAMPLE

Bad beginner version: store message in an array. Problem: server restart loses the message.

Better product version: store message in a database. Result: message remains saved.


CLASSIFY THESE

1. Current button click count before page refresh → RAM/state
2. User's saved email address → Database
3. Contact message submitted yesterday → Database
4. Temporary loading state → RAM/state
5. Completed lessons → Database

>> RAM is fast but temporary. A database is slower but persistent.$L62$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.3 — Tables, Rows, and Columns
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Tables, Rows, and Columns',
    3,
    $L63$Many databases organize data like a spreadsheet. A spreadsheet has tabs, rows, and columns. A relational database has **tables**, **rows**, and **columns**.


EXAMPLE: MESSAGES TABLE

Imagine your contact form saves messages. You create a table called messages with columns:

  id
  name
  email
  message
  created_at

Each submitted message becomes one row. Row 1 might be Jeff's message. Row 2 might be Sneha's message. Every row has an id, name, email, message, and created_at.


EXAMPLE: PROJECTS TABLE

Your portfolio projects live in a table called projects with columns:

  id
  title
  description
  status
  created_at

Row 1: My First Webpage, complete.
Row 2: Internet Request Demo, complete.
Row 3: Backend API, in progress.


KEY TERMS

**Table** — A collection of similar records.

**Row** — One record in a table.

**Column** — One field or property of a record.

**Primary key** — A unique ID for each row.

**Schema** — The structure of the database: tables, columns, types, and rules.


WHY IDs MATTER

Names can change. Emails can change. Titles can change. But an ID gives each row a stable identity.

[!] Project ID 1 stays the same even if the title changes from "My First Webpage" to "Personal Website." The ID is the stable anchor that other tables can point to safely.

>> A table stores similar records. A row is one record. A column is one field.$L63$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.4 — SQL: Asking Questions from Data
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'SQL: Asking Questions from Data',
    4,
    $L64$**SQL** stands for Structured Query Language. Just remember: SQL is a language used to talk to relational databases. With SQL you can read, add, update, delete, filter, and sort data.


THE MOST IMPORTANT SQL COMMANDS

SELECT — Show me data:

  SELECT * FROM projects;

Meaning: show me all projects.


WHERE — Only some data:

  SELECT * FROM projects
  WHERE status = 'complete';

Meaning: show only complete projects.


ORDER BY — Sort the data:

  SELECT * FROM projects
  ORDER BY created_at DESC;

Meaning: show projects, newest first.


INSERT — Add new data:

  INSERT INTO messages (name, email, message)
  VALUES ('Jeff', 'jeff@example.com', 'I want to learn.');

Meaning: save a new message.


UPDATE — Change existing data:

  UPDATE projects
  SET status = 'complete'
  WHERE id = 3;

Meaning: mark project 3 as complete.


DELETE — Remove data:

  DELETE FROM messages
  WHERE id = 2;

Meaning: delete message 2.


PRODUCT BUILDER TRANSLATION

SELECT → Load data.
INSERT → Save new data.
UPDATE → Edit existing data.
DELETE → Remove data.
WHERE → Filter data.
ORDER BY → Sort data.

[!] You do not need to memorize the syntax today. Just understand what each command means in product terms. You will read and write these with Claude's help when you need them.$L64$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.5 — Relationships: Connecting Data with IDs
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Relationships: Connecting Data with IDs',
    5,
    $L65$Real products usually have many types of data. A learning app may have: users, courses, modules, lessons, quiz answers, and progress records. These are related.

Example: a user completes a lesson. That progress record connects one user, one lesson, a completion status, and a completion time.

>> Relational databases are good at connecting data.


SIMPLE EXAMPLE

Users table:
  id=1, name=Jeff, email=jeff@example.com
  id=2, name=Sneha, email=sneha@example.com

Messages table:
  id=1, user_id=1, message=I want to learn.
  id=2, user_id=1, message=I shipped my first page.
  id=3, user_id=2, message=This is useful.

The messages table does not copy the full user details. It stores user_id. That connects each message to a user.


WHY NOT COPY EVERYTHING?

[!] Bad approach: every message row stores the full user name and email. If Jeff changes his email, you must update many rows. Better approach: the users table stores Jeff once. The messages table stores only user_id = 1. If the email changes, update one row in users. That is cleaner and safer.


KEY TERMS

**Relationship** — A connection between tables.

**Primary key** — The unique ID in a table.

**Foreign key** — A column that points to an ID in another table.

**JOIN** — A SQL operation that combines related data from multiple tables.


FOR A LEARNING APP

A progress table may have: id, user_id, lesson_id, completed, completed_at.

user_id points to: the user who completed the lesson.
lesson_id points to: the lesson that was completed.

You do not need to master JOINs now. Just understand the idea: IDs connect tables, and JOINs bring related data together when needed.$L65$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.6 — NoSQL: When Data Does Not Fit Neatly
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'NoSQL: When Data Does Not Fit Neatly',
    6,
    $L66$SQL databases are great when data is structured: users, orders, payments, lessons, messages, progress. These usually fit nicely into tables.

But not all data is neat. Sometimes data changes shape. That is where **NoSQL** can help. NoSQL databases are often more flexible.


ANALOGY

[!] A SQL database is like a strict spreadsheet. Every row follows the same columns. A NoSQL database is like a flexible notebook. One page can have a paragraph, another a checklist, another a sketch. The structure can vary page by page.


PRODUCT EXAMPLE

Imagine a food delivery app.

A pizza menu may have: sizes, toppings, crust type.
A biryani menu may have: serving size, spice level, add-ons.
A juice menu may have: fruit type, ice level, sugar level.

Forcing all of these into one rigid table can become awkward. A document-style NoSQL database can store flexible menu shapes more naturally.


TYPES OF NOSQL

Document database — Flexible JSON-like data.
Key-value store — Very fast lookup by key.
Wide-column store — Huge scale event and time data.
Graph database — Relationships like social networks.


SQL VS NOSQL

Use SQL when: data is structured, relationships matter, consistency is critical.

Use NoSQL when: data shape varies a lot, scale patterns are unusual, speed and flexibility matter more.

>> Use SQL for most beginner products. For your Ship It course project, SQL through Supabase is the right learning choice.


CLASSIFY THESE

1. Bank transactions → SQL
2. Contact form messages → SQL
3. Learning app progress → SQL
4. Flexible restaurant menus → NoSQL can help
5. Product catalog with changing attributes → NoSQL can help
6. User accounts → SQL$L66$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.7 — ACID: Why Important Data Should Not Break
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'ACID: Why Important Data Should Not Break',
    7,
    $L67$Some data must be handled very carefully: money transfers, order placement, course payments, inventory reservations, wallet balances, certificate generation. If these break halfway, users can lose money, trust, or access.

Databases use important guarantees to prevent this. One famous set of guarantees is called **ACID**.


MONEY TRANSFER EXAMPLE

Imagine you transfer money from your account to a friend. Two things must happen:

  1. Subtract from your account
  2. Add to your friend's account

What if the server crashes after step 1 but before step 2? Your money disappears. That should never happen. A database **transaction** prevents this. Either both steps happen, or neither happens.


ACID IN SIMPLE WORDS

**A — Atomicity** — All or nothing. All steps succeed or none do.

**C — Consistency** — Rules are enforced. A user should not get course access if payment failed.

**I — Isolation** — Simultaneous actions do not mess each other up. Two users should not accidentally get the same last available ticket.

**D — Durability** — Once saved, it stays saved. Once the app says "payment successful," the record remains.


PRODUCT EXAMPLE

A user buys your course. Steps: payment succeeds, user gets course access, receipt is created.

[!] Without safe handling: payment could succeed but access not be granted. Or access granted but payment failed. Or a duplicate access record created. ACID-compliant databases handle this safely through transactions.

>> ACID helps databases handle important changes safely, especially when money, orders, or access are involved.$L67$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.8 — Indexing: Finding Data Fast
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Indexing: Finding Data Fast',
    8,
    $L68$Imagine a textbook with 600 pages. You want to find the topic "HTTP status codes." Without an index, you may scan every page. That is slow. With an index, you jump directly to the right page.

Databases use **indexes** for the same reason. An index helps the database find rows faster.


PRODUCT EXAMPLE

Imagine your messages table has 1 million rows. You ask:

  SELECT * FROM messages
  WHERE email = 'jeff@example.com';

Without an index, the database may check every row. With an index on email, it can find matching rows much faster.


WHAT SHOULD BE INDEXED?

Usually index columns you search or sort by often:

  email
  created_at
  user_id
  slug
  status

For a blog: slug is useful because users open posts by URL slug.
For a learning app: user_id and lesson_id are useful for checking progress.


WHY NOT INDEX EVERYTHING?

[!] Indexes have a cost. They use storage. They make writes slightly slower because the database must update the index too. Index what you search often. Do not index random columns just because you can.


GOOD INDEX CANDIDATES

For messages: email, created_at.
For projects: status, created_at.
For blog posts: slug, published, created_at.

>> An index helps a database find frequently searched data faster, but too many indexes can slow down writes.$L68$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.9 — Caching: Remembering Popular Answers
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Caching: Remembering Popular Answers',
    9,
    $L69$Even with indexes, databases still do work. Some data is requested again and again: landing page course list, trending posts, popular products, public profile pages, frequently loaded settings.

Instead of asking the database every time, apps can use a **cache**. A cache stores a quick copy of an answer.


ANALOGY

[!] Imagine your grocery list is stored in a filing cabinet downstairs. Every time you cook, you go downstairs and open the cabinet. That is slow. So you put the most-used list on a sticky note on the fridge. Now it is fast. The sticky note is the cache. The filing cabinet is the database.


CACHE HIT VS CACHE MISS

**Cache hit** — The answer is already in cache. Fast.

**Cache miss** — The answer is not in cache. The app asks the database, gets the answer, and may store it in cache for next time.


PRODUCT EXAMPLE

Your Ship It app may show the same course list to many users. Instead of querying the database every single time, you can cache the course list for a short time. A public course card can be cached. A private progress dashboard should not be carelessly cached for everyone.


IMPORTANT WARNING

[!] Caching creates a new problem: what if the cached answer becomes old? You update a course title, but users still see the old title because the cache has not refreshed. This is called cache invalidation. The hard question is: when should the sticky note be replaced?

>> Do not start with caching. Start with a working database. Add caching only when there is a real performance problem.


CHOOSE CACHE OR DATABASE

Public landing page course list → Cache can help.
Private payment status → Database, source of truth.
Trending posts every 5 minutes → Cache can help.
User password hash → Database, securely.
Public blog post content → Cache can help.$L69$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.10 — Supabase: PostgreSQL Without Managing Infrastructure
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Supabase: PostgreSQL Without Managing Infrastructure',
    10,
    $L610$Now we need a real database. We could install PostgreSQL ourselves, but that adds setup complexity. Instead, we will use **Supabase**.

Supabase gives you a PostgreSQL database with a web dashboard. In simple words: Supabase lets beginners create real database tables without managing database infrastructure manually.


WHY SUPABASE IS USEFUL FOR BEGINNERS

Supabase gives you: a hosted PostgreSQL database, a visual table editor, API access, authentication tools, Row Level Security, a dashboard to view data, and a JavaScript client library.

You can create tables visually and connect them to your app. This is perfect for a first real project.


IMPORTANT SAFETY NOTE

[!] Supabase projects include API keys. Some keys are safe for frontend use with proper security rules. Some keys are powerful and must stay secret. Never commit API keys to GitHub. Never expose service role keys in frontend code. Use environment variables. If you are unsure, ask Claude to explain which keys are safe to use where.


TABLES TO CREATE

For this module, create:
  projects
  messages

Optional later:
  blog_posts


SUGGESTED PROJECTS TABLE

Table name: projects

Columns and types:
  id          — int8, identity, primary key
  title       — text
  description — text
  status      — text
  created_at  — timestamp with time zone, default now()


SUGGESTED MESSAGES TABLE

Table name: messages

Columns and types:
  id         — int8, identity, primary key
  name       — text
  email      — text
  message    — text
  created_at — timestamp with time zone, default now()


MINI EXERCISE

Create a Supabase project. Then create the projects table. Insert 3 rows manually: My First Webpage, Internet Request Demo, Backend API. Then create the messages table and insert one test message. Confirm both tables appear in the Supabase dashboard.$L610$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.11 — Connect Your Backend to Supabase
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Connect Your Backend to Supabase',
    11,
    $L611$Your backend from Module 5 used temporary memory. Now we will connect it to Supabase so data can survive server restarts.

Instead of:
  const projects = [];
  const messages = [];

We will use Supabase tables: projects and messages.


STEP 1 — INSTALL SUPABASE CLIENT

In your backend project:

  npm install @supabase/supabase-js dotenv

@supabase/supabase-js lets your backend talk to Supabase.
dotenv lets your backend read secret values from a .env file.


STEP 2 — CREATE .env FILE

Create a file called .env and add:

  SUPABASE_URL=your_supabase_project_url
  SUPABASE_KEY=your_supabase_key

Do not commit .env to GitHub.


STEP 3 — ADD .gitignore

Create or update .gitignore and add:

  node_modules
  .env

This prevents secret keys and installed packages from being committed.


STEP 4 — CREATE SUPABASE CLIENT

In your backend:

  require("dotenv").config();
  const { createClient } = require("@supabase/supabase-js");

  const supabase = createClient(
    process.env.SUPABASE_URL,
    process.env.SUPABASE_KEY
  );


STEP 5 — REPLACE GET PROJECTS

  app.get("/api/projects", async (req, res) => {
    const { data, error } = await supabase
      .from("projects")
      .select("*")
      .order("created_at", { ascending: false });

    if (error) return res.status(500).json({ success: false, error: error.message });
    res.json(data);
  });


STEP 6 — REPLACE POST MESSAGES

  app.post("/api/messages", async (req, res) => {
    const { name, email, message } = req.body;
    if (!name || !email || !message) {
      return res.status(400).json({ success: false, error: "All fields required." });
    }
    const { data, error } = await supabase
      .from("messages")
      .insert([{ name, email, message }])
      .select();
    if (error) return res.status(500).json({ success: false, error: error.message });
    res.status(201).json({ success: true, message: "Message saved.", data });
  });


COMMON ERRORS

[!] "Cannot find module" error — run npm install. "relation does not exist" — check your table name matches exactly. Permission or RLS error — ask Claude to explain RLS and help you set the smallest safe policy for local learning.

>> Before debugging code, verify that SUPABASE_URL and SUPABASE_KEY are correctly set in .env and that .env is not in your git history.$L611$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.12 — Module Project: Make Your Product Remember
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Module Project: Make Your Product Remember',
    12,
    $L612$Now you will finish the database upgrade. Your product will no longer forget everything when the server restarts.

You are moving from: a demo backend with in-memory storage, to: a backend connected to a real database.

>> That is how real products work.


FINAL PROJECT REQUIREMENTS

  1.  Supabase project created
  2.  projects table created
  3.  messages table created
  4.  3 sample projects inserted
  5.  Backend connected to Supabase
  6.  GET /api/projects reads from database
  7.  POST /api/messages saves to database
  8.  .env used for keys
  9.  .env added to .gitignore
  10. Clear error handling
  11. Frontend still connected to backend
  12. Git commit saved


FILE STRUCTURE

  my-first-backend/
    server.js
    package.json
    package-lock.json
    CLAUDE.md
    .env           (local only, not in GitHub)
    .gitignore


FINAL CLAUDE CODE PROMPT

Give this to Claude Code:

  Review my backend and database setup. I want my product to
  remember data using Supabase.

  Check:
  1. Supabase client installed.
  2. dotenv installed.
  3. server.js reads SUPABASE_URL and SUPABASE_KEY from .env.
  4. .env is in .gitignore.
  5. GET /api/projects reads from the projects table.
  6. POST /api/messages validates and saves to the messages table.
  7. Backend returns helpful JSON errors.
  8. No secret keys are hardcoded.

  Show me a checklist of what is complete and what is missing.
  Do not edit files until I approve.


TEST: PROJECTS

Open in browser:
  http://localhost:3000/api/projects

You should see data from Supabase.


TEST: MESSAGE INSERT

  curl -X POST http://localhost:3000/api/messages \
    -H "Content-Type: application/json" \
    -d '{"name":"Jeff","email":"jeff@example.com","message":"Testing Supabase."}'

Then check the Supabase dashboard. You should see the new row.


TEST: RESTART

Stop backend. Start it again: node server.js. Open /api/messages. If your messages are still there, your product remembers.

[!] Before committing, run git status and make sure .env is not listed. If .env appears, stop and ask Claude for help before pushing to GitHub.


FINAL QA CHECKLIST

Database: Supabase project exists, tables exist, columns correct, sample data inserted.
Backend: server starts, env variables load, GET projects works, POST messages works, no hardcoded keys.
Frontend: project cards load, contact form submits, success message appears.
Security: .env in .gitignore, no service role key in frontend code.


SAVE WITH GIT

  git status
  git add .
  git commit -m "Connect backend to Supabase database"


BADGE UNLOCKED

You completed Module 6. You made your product remember.

You now understand: databases store persistent data, RAM is temporary, SQL databases use tables and rows and columns, SQL lets you read and insert and update and delete, relationships connect tables using IDs, NoSQL helps when data is flexible, ACID protects important operations, indexes help find data faster, caches store popular answers temporarily, and Supabase gives you a real database without managing infrastructure.

Your backend is no longer a temporary demo. It is connected to a real database.

Next module: Module 7 — Git, GitHub, and Working Like a Real Builder.$L612$
  ) returning id into v_l12;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (12 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 6.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'Why do products need databases?',
    '["To make buttons colorful","To remember data permanently","To replace HTML","To open VS Code"]',
    1
  );

  -- Q2 — Lesson 6.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What happens to data stored only in RAM when the server restarts?',
    '["It becomes faster","It usually disappears","It goes to GitHub","It becomes CSS"]',
    1
  );

  -- Q3 — Lesson 6.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'In a database table, what is a row?',
    '["One saved record","A CSS style","A browser tab","A Git branch"]',
    0
  );

  -- Q4 — Lesson 6.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'Which SQL command is used to read data from a table?',
    '["SELECT","DELETE","INSERT","UPDATE"]',
    0
  );

  -- Q5 — Lesson 6.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'What is a foreign key?',
    '["A column that points to a row in another table","A CSS class","A GitHub password","A browser shortcut"]',
    0
  );

  -- Q6 — Lesson 6.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'Which database style is usually better for structured data like users, orders, and payments?',
    '["SQL","NoSQL","CSS","DNS"]',
    0
  );

  -- Q7 — Lesson 6.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'What does Atomicity mean in ACID?',
    '["The database uses atoms","All steps succeed or none do","The page loads faster","CSS becomes smaller"]',
    1
  );

  -- Q8 — Lesson 6.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'What does a database index help with?',
    '["Finding data faster","Making buttons round","Starting VS Code","Encrypting HTTPS"]',
    0
  );

  -- Q9 — Lesson 6.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'What is a cache?',
    '["A quick stored copy of data used to avoid repeated work","A CSS file","A GitHub branch","A browser password"]',
    0
  );

  -- Q10 — Lesson 6.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'What is Supabase useful for in this course?',
    '["Creating a hosted PostgreSQL database with a beginner-friendly dashboard","Changing button colors","Replacing the browser","Writing Git commits automatically"]',
    0
  );

  -- Q11 — Lesson 6.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'Why should .env be added to .gitignore?',
    '["To hide secret keys from GitHub","To make CSS faster","To delete the database","To change the browser"]',
    0
  );

  -- Q12 — Lesson 6.12
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l12,
    'After connecting to Supabase, how do you confirm messages are truly saved?',
    '["Stop and restart the server, then check if messages still appear","Refresh the browser CSS","Delete the .env file","Push to GitHub"]',
    0
  );

end $$;
