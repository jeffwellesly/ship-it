-- Fix em dashes introduced by earlier typography-styling migrations.
-- Software Development with Claude Code / Module 6: Databases: Where Products Remember Things
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update lessons set content = $Dbd81ad4e_9de7_479a_a090_944f2321766a$Many databases organize data like a spreadsheet. A spreadsheet has tabs, rows, and columns. A relational database has **tables**, **rows**, and **columns**.


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

**Table:** A collection of similar records.

**Row:** One record in a table.

**Column:** One field or property of a record.

**Primary key:** A unique ID for each row.

**Schema:** The structure of the database: tables, columns, types, and rules.


WHY IDs MATTER

Names can change. Emails can change. Titles can change. But an ID gives each row a stable identity.

[!] Project ID 1 stays the same even if the title changes from "My First Webpage" to "Personal Website." The ID is the stable anchor that other tables can point to safely.

>> A table stores similar records. A row is one record. A column is one field.$Dbd81ad4e_9de7_479a_a090_944f2321766a$ where id = 'bd81ad4e-9de7-479a-a090-944f2321766a';

update lessons set content = $D04b9410a_3bbd_4aa8_9963_5941255ca89a$Think about the backend you built in Module 5.

It could receive a contact form message and store it in a temporary list. But if you stopped the server and started it again, the message disappeared. That is because the message lived only in temporary memory.

Real products cannot work like that.

Imagine: you place an order and it disappears. You complete a lesson and your progress resets. You upload a profile photo and it vanishes. You pay for something and the system loses the record.

>> Users would lose trust immediately.

A database exists so software can remember things permanently.


TWO KINDS OF MEMORY

A product has two kinds of memory:

**Temporary memory:** Fast, active, but disappears when the program stops.

**Permanent memory:** Slower, organized, and survives restarts.

The database is permanent memory.


PRODUCT EXAMPLES

A learning app needs to remember: user accounts, course progress, completed lessons, quiz answers, payment status, and certificates.

A portfolio website may need to remember: blog posts, contact messages, project list, and newsletter signups.

A food delivery app needs to remember: users, restaurants, menus, orders, payments, delivery addresses, and reviews.

[!] Without a database, these products cannot be trusted.


KEY TERMS

**Database:** A system that stores data so software can retrieve it later.

**Data:** Information used by a product.

**Persistent:** Data that remains even after the app or server restarts.

**Record:** One saved item in a database, like one message or one project.$D04b9410a_3bbd_4aa8_9963_5941255ca89a$ where id = '04b9410a-3bbd-4aa8-9963-5941255ca89a';

update lessons set content = $Ddbde97f8_2f7a_4b3c_9ad8_08a1b89f867f$**SQL** stands for Structured Query Language. Just remember: SQL is a language used to talk to relational databases. With SQL you can read, add, update, delete, filter, and sort data.


THE MOST IMPORTANT SQL COMMANDS

SELECT, Show me data:

  SELECT * FROM projects;

Meaning: show me all projects.


WHERE, Only some data:

  SELECT * FROM projects
  WHERE status = 'complete';

Meaning: show only complete projects.


ORDER BY, Sort the data:

  SELECT * FROM projects
  ORDER BY created_at DESC;

Meaning: show projects, newest first.


INSERT, Add new data:

  INSERT INTO messages (name, email, message)
  VALUES ('Jeff', 'jeff@example.com', 'I want to learn.');

Meaning: save a new message.


UPDATE, Change existing data:

  UPDATE projects
  SET status = 'complete'
  WHERE id = 3;

Meaning: mark project 3 as complete.


DELETE, Remove data:

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

[!] You do not need to memorize the syntax today. Just understand what each command means in product terms. You will read and write these with Claude's help when you need them.$Ddbde97f8_2f7a_4b3c_9ad8_08a1b89f867f$ where id = 'dbde97f8-2f7a-4b3c-9ad8-08a1b89f867f';

update lessons set content = $Df89d9eb9_3dce_4225_b0e2_47b778432647$Real products usually have many types of data. A learning app may have: users, courses, modules, lessons, quiz answers, and progress records. These are related.

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

**Relationship:** A connection between tables.

**Primary key:** The unique ID in a table.

**Foreign key:** A column that points to an ID in another table.

**JOIN:** A SQL operation that combines related data from multiple tables.


FOR A LEARNING APP

A progress table may have: id, user_id, lesson_id, completed, completed_at.

user_id points to: the user who completed the lesson.
lesson_id points to: the lesson that was completed.

You do not need to master JOINs now. Just understand the idea: IDs connect tables, and JOINs bring related data together when needed.$Df89d9eb9_3dce_4225_b0e2_47b778432647$ where id = 'f89d9eb9-3dce-4225-b0e2-47b778432647';

update lessons set content = $D1141f2b7_8494_48fb_a232_5e3dfed17467$SQL databases are great when data is structured: users, orders, payments, lessons, messages, progress. These usually fit nicely into tables.

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

Document database, Flexible JSON-like data.
Key-value store, Very fast lookup by key.
Wide-column store, Huge scale event and time data.
Graph database, Relationships like social networks.


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
6. User accounts → SQL$D1141f2b7_8494_48fb_a232_5e3dfed17467$ where id = '1141f2b7-8494-48fb-a232-5e3dfed17467';

update lessons set content = $Dc7225cef_fa91_4bd6_85ec_3c32337bf644$Some data must be handled very carefully: money transfers, order placement, course payments, inventory reservations, wallet balances, certificate generation. If these break halfway, users can lose money, trust, or access.

Databases use important guarantees to prevent this. One famous set of guarantees is called **ACID**.


MONEY TRANSFER EXAMPLE

Imagine you transfer money from your account to a friend. Two things must happen:

  1. Subtract from your account
  2. Add to your friend's account

What if the server crashes after step 1 but before step 2? Your money disappears. That should never happen. A database **transaction** prevents this. Either both steps happen, or neither happens.


ACID IN SIMPLE WORDS

**A, Atomicity:** All or nothing. All steps succeed or none do.

**C, Consistency:** Rules are enforced. A user should not get course access if payment failed.

**I, Isolation:** Simultaneous actions do not mess each other up. Two users should not accidentally get the same last available ticket.

**D, Durability:** Once saved, it stays saved. Once the app says "payment successful," the record remains.


PRODUCT EXAMPLE

A user buys your course. Steps: payment succeeds, user gets course access, receipt is created.

[!] Without safe handling: payment could succeed but access not be granted. Or access granted but payment failed. Or a duplicate access record created. ACID-compliant databases handle this safely through transactions.

>> ACID helps databases handle important changes safely, especially when money, orders, or access are involved.$Dc7225cef_fa91_4bd6_85ec_3c32337bf644$ where id = 'c7225cef-fa91-4bd6-85ec-3c32337bf644';

update lessons set content = $D603a3b53_5d28_49cc_bbe0_f1cd08b1c4cd$Even with indexes, databases still do work. Some data is requested again and again: landing page course list, trending posts, popular products, public profile pages, frequently loaded settings.

Instead of asking the database every time, apps can use a **cache**. A cache stores a quick copy of an answer.


ANALOGY

[!] Imagine your grocery list is stored in a filing cabinet downstairs. Every time you cook, you go downstairs and open the cabinet. That is slow. So you put the most-used list on a sticky note on the fridge. Now it is fast. The sticky note is the cache. The filing cabinet is the database.


CACHE HIT VS CACHE MISS

**Cache hit:** The answer is already in cache. Fast.

**Cache miss:** The answer is not in cache. The app asks the database, gets the answer, and may store it in cache for next time.


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
Public blog post content → Cache can help.$D603a3b53_5d28_49cc_bbe0_f1cd08b1c4cd$ where id = '603a3b53-5d28-49cc-bbe0-f1cd08b1c4cd';

update lessons set content = $D783590ff_3332_4455_bbdf_2c01d4c4993a$Now we need a real database. We could install PostgreSQL ourselves, but that adds setup complexity. Instead, we will use **Supabase**.

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
  id, int8, identity, primary key
  title, text
  description, text
  status, text
  created_at, timestamp with time zone, default now()


SUGGESTED MESSAGES TABLE

Table name: messages

Columns and types:
  id, int8, identity, primary key
  name, text
  email, text
  message, text
  created_at, timestamp with time zone, default now()


MINI EXERCISE

Create a Supabase project. Then create the projects table. Insert 3 rows manually: My First Webpage, Internet Request Demo, Backend API. Then create the messages table and insert one test message. Confirm both tables appear in the Supabase dashboard.$D783590ff_3332_4455_bbdf_2c01d4c4993a$ where id = '783590ff-3332-4455-bbdf-2c01d4c4993a';

update lessons set content = $D8974b5c5_93a1_4253_baef_1556c31bd6df$Your backend from Module 5 used temporary memory. Now we will connect it to Supabase so data can survive server restarts.

Instead of:
  const projects = [];
  const messages = [];

We will use Supabase tables: projects and messages.


STEP 1, INSTALL SUPABASE CLIENT

In your backend project:

  npm install @supabase/supabase-js dotenv

@supabase/supabase-js lets your backend talk to Supabase.
dotenv lets your backend read secret values from a .env file.


STEP 2, CREATE .env FILE

Create a file called .env and add:

  SUPABASE_URL=your_supabase_project_url
  SUPABASE_KEY=your_supabase_key

Do not commit .env to GitHub.


STEP 3, ADD .gitignore

Create or update .gitignore and add:

  node_modules
  .env

This prevents secret keys and installed packages from being committed.


STEP 4, CREATE SUPABASE CLIENT

In your backend:

  require("dotenv").config();
  const { createClient } = require("@supabase/supabase-js");

  const supabase = createClient(
    process.env.SUPABASE_URL,
    process.env.SUPABASE_KEY
  );


STEP 5, REPLACE GET PROJECTS

  app.get("/api/projects", async (req, res) => {
    const { data, error } = await supabase
      .from("projects")
      .select("*")
      .order("created_at", { ascending: false });

    if (error) return res.status(500).json({ success: false, error: error.message });
    res.json(data);
  });


STEP 6, REPLACE POST MESSAGES

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

[!] "Cannot find module" error, run npm install. "relation does not exist", check your table name matches exactly. Permission or RLS error, ask Claude to explain RLS and help you set the smallest safe policy for local learning.

>> Before debugging code, verify that SUPABASE_URL and SUPABASE_KEY are correctly set in .env and that .env is not in your git history.$D8974b5c5_93a1_4253_baef_1556c31bd6df$ where id = '8974b5c5-93a1-4253-baef-1556c31bd6df';

update lessons set content = $D6f548c14_9f58_4401_928d_ab7e29bf1c8f$Now you will finish the database upgrade. Your product will no longer forget everything when the server restarts.

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

Next module: Module 7, Git, GitHub, and Working Like a Real Builder.$D6f548c14_9f58_4401_928d_ab7e29bf1c8f$ where id = '6f548c14-9f58-4401-928d-ab7e29bf1c8f';
