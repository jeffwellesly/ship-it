-- Module 5: Backend — The Kitchen You Never See
-- 11 lessons with >> pull quotes, [!] callouts, **bold** key terms, ALL CAPS headers, 2-space code blocks

do $$
declare
  v_course_id uuid;
  v_module_id uuid;
  v_l1 uuid; v_l2 uuid; v_l3 uuid; v_l4 uuid; v_l5 uuid;
  v_l6 uuid; v_l7 uuid; v_l8 uuid; v_l9 uuid; v_l10 uuid; v_l11 uuid;
begin

  select id into v_course_id from courses where sort_order = 1;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 5: Backend: The Kitchen You Never See',
    'Learn what happens behind the screen and build your first backend API with Node.js and Express.',
    5
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.1 — Backend: The Part Users Never See
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Backend: The Part Users Never See',
    1,
    $L51$Every software product has two sides.

The first side is the part users see. That is the **frontend**.

The second side is the part users do not see. That is the **backend**.

When you use a food delivery app, you see restaurant cards, a search bar, a cart, and a payment screen. That is frontend.

But behind the screen, the product also needs to check which restaurants are open, calculate delivery time, save your order, apply discounts, check payment status, update order tracking, and store your address. That is backend.

>> The frontend is the dining room. The backend is the kitchen.


ANALOGY

[!] Imagine a restaurant. The customer sees the menu, tables, waiter, plates, and bill. But behind the wall, a chef prepares food, staff checks inventory, the kitchen times each order, the billing system calculates the total, and the manager handles rules. The customer does not see all this. They only see the result. Software works the same way.


KEY TERMS

**Frontend** — The visible part of the product that users see and touch.

**Backend** — The hidden part that runs logic, handles requests, talks to databases, and sends responses.

**Server** — A computer that waits for requests and sends responses.

**Business logic** — The product rules written in code.

**Database** — Where data is stored long term.


PRODUCT EXAMPLE

In your personal website, the project cards, contact form, buttons, and styling are all frontend. The backend is what receives the contact form message, validates the email, stores the message, and sends a success response. Right now your form may look real but unless the message goes somewhere, it is only frontend. Once a backend receives and handles it, it becomes a real product flow.$L51$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.2 — What a Server Actually Does
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What a Server Actually Does',
    2,
    $L52$A server is a computer that waits for requests.

When a request arrives, it does four things in order.

>> Receive. Process. Get or save data. Respond.

That rhythm powers most products you use.


THE FOUR STEPS

STEP 1 — RECEIVE

The server receives a request. It may include: name, email, message, user ID, page information, or a token proving who the user is.


STEP 2 — PROCESS

The server runs logic. For a contact form: check if the email is valid, check if the message is not empty, check if the message is not too long. This is **business logic**.


STEP 3 — GET OR SAVE DATA

The server may talk to a database. For example: save this contact message, or load all projects. In this module, we will first store data in memory to keep things simple.


STEP 4 — RESPOND

The server sends a response back.

Success:
  {
    "success": true,
    "message": "Contact message received."
  }

Error:
  {
    "success": false,
    "error": "Email is required."
  }


KEY TERMS

**Request** — A message sent to the server.

**Response** — A message sent back from the server.

**Validation** — Checking whether input is acceptable.

**In-memory storage** — Temporary data stored while the server is running. It disappears when the server restarts.


PRODUCT FLOW

[!] When a user taps Submit on a contact form: the frontend sends form data → backend receives it → backend validates it → backend saves or rejects it → backend sends success or error → frontend shows message to user.$L52$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.3 — API: The Waiter Between Frontend and Backend
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'API: The Waiter Between Frontend and Backend',
    3,
    $L53$Your frontend should not directly touch the database. Your users should not directly access the server's internals. There needs to be a clean way for the frontend and backend to talk.

That clean communication layer is called an **API**.

API stands for Application Programming Interface.

In simple words: an API is a structured way for one software system to talk to another.


ANALOGY

[!] The customer does not enter the kitchen. The customer talks to the waiter. The waiter knows what the customer can order, how to send the order to the kitchen, and how to bring the response back. The API is the waiter.

Frontend: "I want to submit this contact form."
API: "Send POST /api/messages with name, email, and message."
Backend: "Received it, validated it, and stored it."
API response: "Message received."
Frontend: "Show success message."


API AS A CONTRACT

An API is also like a contract. It says: if you send this kind of request to this URL with this data, I will respond in this format.

  POST /api/messages

  Request:
  {
    "name": "Jeff",
    "email": "jeff@example.com",
    "message": "I want to learn."
  }

  Response:
  {
    "success": true,
    "message": "Message received."
  }

>> This agreement helps frontend and backend work together.


KEY TERMS

**API** — A structured communication layer between systems.

**API contract** — The expected request and response format.

**Request body** — Data sent with a request.

**Response body** — Data sent back by the server.

**API documentation** — The menu that explains what the API supports.


WHY APIS MATTER

APIs make software modular. The frontend team builds screens. The backend team builds logic. The database stores data. Other systems can connect. Everyone agrees on the API. That is how large products are built by many teams.$L53$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.4 — Endpoint: One Specific Job
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Endpoint: One Specific Job',
    4,
    $L54$An API is the whole communication system. An **endpoint** is one specific action inside that system.

Think of a restaurant. The menu is the whole API. One menu item is an endpoint.

  GET /api/projects   →   Return the project list.
  POST /api/messages  →   Create a new message.


THE ENDPOINT FORMULA

  HTTP method + URL path = endpoint

Examples:

  GET /api/projects
  POST /api/messages
  DELETE /api/messages/3

Same path with a different method can mean a different action.

  GET /api/messages    →   Show all messages.
  POST /api/messages   →   Create a new message.

The method matters.


COMMON ENDPOINTS

[!] GET /api/projects — Return all projects. GET /api/projects/1 — Return project with ID 1. POST /api/messages — Create a new contact message. DELETE /api/messages/1 — Delete message with ID 1.


PRODUCT EXAMPLE

For your portfolio site you may need:

  GET /api/projects    →   To load project cards on the page.
  POST /api/messages   →   To submit the contact form.

That is already enough for a simple real product.


COMMON CONFUSION

Question: Is /api/projects the endpoint?

Answer: Not fully. The full endpoint includes the method.

  GET /api/projects
  POST /api/projects

can do different things. Always state the method.

>> An endpoint is one specific API action, identified by its HTTP method and URL path together.$L54$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.5 — REST and JSON: The Backend Menu
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'REST and JSON: The Backend Menu',
    5,
    $L55$Most beginner APIs you meet will be REST APIs.

**REST** is a common style for designing APIs. You do not need to memorize the full theory now. Just remember: REST usually means predictable URLs, standard HTTP methods, and JSON responses.


REST AS A FIXED MENU

Imagine a restaurant with a clear menu. Each item has a name. Each order follows a known pattern. That is REST.

  GET /api/projects      →   Read all projects.
  POST /api/projects     →   Create a project.
  GET /api/projects/1    →   Read one project.
  DELETE /api/projects/1 →   Delete one project.

The pattern is predictable and clear.


JSON: THE DATA SHAPE

APIs usually send and receive data as **JSON**. JSON looks like JavaScript objects.

A single project:
  {
    "id": 1,
    "title": "My First Webpage",
    "description": "A beginner project."
  }

A list of projects:
  [
    { "id": 1, "title": "My First Webpage" },
    { "id": 2, "title": "Internet Request Demo" }
  ]

JSON is popular because it is easy for computers and fairly easy for humans to read.


REST + JSON EXAMPLE

Request:
  GET /api/projects

Response:
  [
    { "id": 1, "title": "My First Webpage", "status": "complete" },
    { "id": 2, "title": "Frontend Upgrade", "status": "complete" }
  ]

>> REST gives APIs predictable endpoints. JSON is the common format for the data inside them.


KEY TERMS

**REST** — A common style for designing predictable APIs.

**JSON** — A common data format for API requests and responses.

**Resource** — The thing the API works with, like projects, users, or messages.

**Stateless** — Each request includes the information needed to handle it.$L55$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.6 — Business Logic: Product Rules in Code
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Business Logic: Product Rules in Code',
    6,
    $L56$Backend is not just moving data around. The backend also enforces product rules.

These rules are called **business logic**.

Business logic means: "What should happen in this product, under these conditions?"


EXAMPLES

For a contact form:
  Email is required.
  Message cannot be empty.
  Message cannot be longer than 500 characters.

For a learning app:
  A lesson is complete only after the user answers the quiz.
  Progress should be saved for each user.

For a food delivery app:
  Restaurant must be open before accepting the order.
  Coupon can be used only once.

These rules usually live in the backend.

[!] Why backend? Because users can manipulate frontend code. The backend must be the trusted rule enforcer.


FRONTEND VS BACKEND VALIDATION

**Frontend validation** helps user experience. Example: show "email is required" before submitting.

**Backend validation** protects the system. Example: reject the request if email is missing, even if the frontend failed to catch it.

You need both. Never trust the frontend alone.


WHY THIS MATTERS

Your contact form frontend may check whether the user typed an email. But the backend must check again. Why? Because someone could bypass your webpage and send a request directly to your backend. The backend is the final guard.


EXAMPLE ERROR RESPONSE

If validation fails, the backend should return:

  Status: 400 Bad Request

  {
    "success": false,
    "error": "Email is required."
  }

>> Business logic is the product rules written in code. Backend is where important rules must be enforced.$L56$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.7 — Build Your First Backend with Claude Code
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Build Your First Backend with Claude Code',
    7,
    $L57$Now you will build your first backend.

This backend will run on your computer. It will not be public yet. That is okay. A local backend is how many real products start.

You will use Node.js, Express, JavaScript, and Claude Code. Express is a small backend framework for Node.js. A framework gives you helpful tools so you do not build everything from scratch.


WHAT YOU WILL BUILD

  GET /               →   Returns welcome message.
  GET /api/projects   →   Returns project list as JSON.
  POST /api/messages  →   Accepts contact form messages.
  GET /api/messages   →   Shows submitted messages (for learning).


STEP 1 — CREATE PROJECT FOLDER

In terminal:

  cd ~/Desktop
  mkdir my-first-backend
  cd my-first-backend
  code .


STEP 2 — CREATE CLAUDE.md

Create a file called CLAUDE.md and add:

  # My First Backend

  ## Goal
  Build a simple beginner backend API using Node.js and Express.

  ## Tech Stack
  Node.js, Express, JavaScript.

  ## Rules
  Keep it simple. Use in-memory data only.
  No database yet. Add helpful comments.


STEP 3 — ASK CLAUDE CODE TO BUILD IT

Run claude in terminal and paste:

  Build me a simple beginner backend API using Node.js and Express.

  Requirements:
  1. Create server.js with GET /, GET /api/projects, and POST /api/messages.
  2. GET /api/projects returns 3 sample projects as JSON.
  3. POST /api/messages validates name, email, and message.
  4. Missing fields return 400. Valid messages return 201.
  5. Add GET /api/messages to inspect submitted messages.
  6. Add beginner-friendly comments.
  7. Create package.json if needed.

  Before editing, explain your plan.
  After editing, tell me how to run and test it.


STEP 4 — INSTALL AND RUN

Follow Claude's instructions. Usually:

  npm install express
  node server.js

You should see:

  Server running on http://localhost:3000


STEP 5 — TEST IN BROWSER

Open:
  http://localhost:3000
  http://localhost:3000/api/projects

You should see JSON in the browser. You built a backend.

[!] If you see "Cannot find module 'express'" run: npm install express. If the port is already in use, ask Claude to help you safely stop the old server or use another port.$L57$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.8 — Connect Your Frontend to Your Backend
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Connect Your Frontend to Your Backend',
    8,
    $L58$Now you have two things: a frontend webpage and a backend API. The next step is to make them talk.

Your frontend can ask your backend for projects. Your frontend can send contact form messages to your backend. This is the beginning of a real product architecture.


THE FULL FLOW

  Frontend button clicked
        ↓
  JavaScript fetch sends request
        ↓
  Backend endpoint receives request
        ↓
  Backend validates or returns data
        ↓
  Backend sends JSON response
        ↓
  Frontend shows result


EXAMPLE: FETCH PROJECTS

Frontend JavaScript:

  async function loadProjects() {
    const response = await fetch("http://localhost:3000/api/projects");
    const projects = await response.json();
    console.log(projects);
  }

This asks your backend for GET /api/projects.


CORS NOTE

[!] Sometimes the browser blocks frontend-backend requests because they come from different origins. CORS stands for Cross-Origin Resource Sharing. It is a browser safety rule about which websites are allowed to call which servers. If you hit a CORS issue, ask Claude to help configure it safely for local development.


CLAUDE PROMPT FOR CONNECTING FRONTEND

In your frontend project, ask Claude:

  Connect my frontend webpage to my local backend.

  Backend:
  - GET http://localhost:3000/api/projects returns projects.
  - POST http://localhost:3000/api/messages accepts name, email, message.

  Requirements:
  1. Load projects from the backend and display as cards.
  2. Send contact form data to POST /api/messages.
  3. Show success or error message from the response.
  4. Keep code beginner-friendly and explain what changed.
  5. If there is a CORS issue, explain it and suggest the smallest safe local fix.


TESTING CHECKLIST

Is the backend running? Can you open http://localhost:3000/api/projects? Does the frontend load projects? Does the contact form submit? Does the backend return success or error? Can you see requests in DevTools Network tab? Can you see submitted messages at /api/messages?

>> Before debugging code, always check: is the backend server still running? If you closed the terminal running the server, the backend stopped. Start it again with node server.js.$L58$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.9 — Authentication vs Authorization
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Authentication vs Authorization',
    9,
    $L59$Two words confuse many beginners: authentication and authorization. They sound similar, but they mean different things.


AUTHENTICATION

**Authentication** means: "Who are you?"

Examples: login with email and password, login with Google, Face ID, OTP, magic link. Authentication proves identity.


AUTHORIZATION

**Authorization** means: "What are you allowed to do?"

Examples: free user can view 3 lessons, paid user can view all lessons, admin can manage users, viewer can only read reports. Authorization controls permission.


ANALOGY

[!] At an airport, your passport proves who you are — that is authentication. Your boarding pass decides which flight and gate you can access — that is authorization. You need both.


PRODUCT EXAMPLE

In Ship It:

Authentication: user signs in with email or Google.

Authorization: can this user access this course? Can this user edit course content? Can this user see the admin dashboard?


WHY THIS MATTERS

A product can know who you are but still show you things you should not see. That is an authorization bug.

Example: a normal learner should not access the admin dashboard. Even if they are logged in, they should not have admin permissions.

>> Authentication is identity. Authorization is permission. Never mix them up.


CLASSIFY THESE

1. User enters password.            →   Authentication
2. User clicks "Login with Google." →   Authentication
3. Admin can delete a course.       →   Authorization
4. Free user cannot access paid lesson. → Authorization
5. App checks if the token is valid. →  Authentication
6. User role is checked before opening billing page. → Authorization$L59$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.10 — Serverless: Backend Without Managing Servers
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Serverless: Backend Without Managing Servers',
    10,
    $L510$The word **serverless** is confusing. It does not mean there are no servers. Servers still exist. It means you do not manage them.

A cloud provider manages the servers, scaling, operating system, and infrastructure. You only write the function or logic.


ANALOGY

[!] A long time ago, factories had to build their own power plants. Now most factories plug into the power grid and pay for electricity they use. The power plant still exists — the factory just does not manage it. Serverless is similar. The servers still exist. You just do not manage them directly.


TRADITIONAL SERVER VS SERVERLESS

Traditional server:
  Runs all the time.
  You manage more infrastructure.
  You pay for server uptime.
  Good for long-running apps.

Serverless:
  Runs only when needed.
  Provider manages infrastructure.
  You often pay for usage only.
  Good for functions and event-based tasks.


PRODUCT EXAMPLE

In a personal website, a serverless function could handle:

  POST /api/contact

It runs only when someone submits the contact form. You do not need to keep a full server running all day just for occasional messages. Platforms like Vercel, Netlify, AWS Lambda, and Google Cloud Functions support this.


IMPORTANT TRADEOFF

Serverless is convenient but not perfect. Possible issues include cold starts, time limits, vendor-specific behavior, and harder debugging sometimes. It is not ideal for every workload.

Do not worry about all this now. Just understand the idea.

>> Serverless means you write backend logic without personally managing the server. The platform handles the infrastructure.


WHICH IS SERVERLESS-FRIENDLY?

Contact form submission — yes.
Image resize after upload — yes.
Sending a welcome email — yes.
Running a huge game server 24/7 — usually no.$L510$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.11 — Module Project: Build a Tiny Portfolio API
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Module Project: Build a Tiny Portfolio API',
    11,
    $L511$Now you will finish your first backend project.

This is not a full production backend. It is a learning backend. But it is real. It will receive requests, run logic, return JSON, validate input, and send status codes.

>> That is backend development.


FINAL PROJECT REQUIREMENTS

  1.  GET /
  2.  GET /api/projects
  3.  POST /api/messages
  4.  GET /api/messages
  5.  In-memory project list
  6.  In-memory message list
  7.  Validation for messages
  8.  JSON responses for everything
  9.  Correct status codes
  10. Beginner-friendly comments
  11. Git commit


FILE STRUCTURE

  my-first-backend/
    server.js
    package.json
    package-lock.json
    CLAUDE.md


FINAL CLAUDE CODE PROMPT

Give this to Claude Code:

  Review and improve my beginner backend API.

  Requirements:
  1. Node.js and Express, everything in server.js.
  2. GET / with a welcome JSON response.
  3. GET /api/projects with 3 sample projects.
  4. POST /api/messages validates name, email, and message.
  5. Missing fields return 400. Successful creation returns 201.
  6. GET /api/messages to inspect submitted messages.
  7. JSON for every response.
  8. Simple beginner comments.
  9. No database yet.
  10. Explain how to run and test every endpoint.


TEST WITH BROWSER

Open these URLs in your browser to test GET endpoints:
  http://localhost:3000/
  http://localhost:3000/api/projects
  http://localhost:3000/api/messages


TEST POST WITH CURL

  curl -X POST http://localhost:3000/api/messages \
    -H "Content-Type: application/json" \
    -d '{"name":"Jeff","email":"jeff@example.com","message":"First message."}'

Then verify it was stored:
  curl http://localhost:3000/api/messages


TEST VALIDATION

Try sending missing fields:
  curl -X POST http://localhost:3000/api/messages \
    -H "Content-Type: application/json" \
    -d '{"name":"Jeff"}'

You should receive a 400 error:
  { "success": false, "error": "Email and message are required." }


FINAL QA CHECKLIST

Does node server.js start the server?
Does GET / work?
Does GET /api/projects return JSON?
Does POST /api/messages create a message?
Does missing data return 400?
Does successful creation return 201?
Does GET /api/messages show submitted messages?
Are errors beginner-friendly?


SAVE WITH GIT

  git status
  git add .
  git commit -m "Build first backend API"


BADGE UNLOCKED

[!] You completed Module 5. You built your first backend API. You now understand: backend is the hidden part of software, a server receives and responds, APIs connect frontend and backend, endpoints are method plus URL path, REST APIs use predictable patterns, JSON is the common data format, business logic means product rules, backend validation protects the system, authentication is identity, authorization is permission, and serverless means you do not manage servers directly.

You are no longer building only screens. You are building the system behind the screen.

Next module: Module 6 — Databases: Where Products Remember Things.$L511$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 5.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'What is the backend?',
    '["The visible design of the page","The hidden part that handles logic, requests, and data","The color system","The GitHub profile"]',
    1
  );

  -- Q2 — Lesson 5.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What should a server do after receiving a contact form submission?',
    '["Immediately ignore it","Validate it, save or handle it, and send a response","Change the button color only","Delete the HTML file"]',
    1
  );

  -- Q3 — Lesson 5.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'What is an API?',
    '["A random JavaScript file","A structured way for software systems to communicate","A CSS animation","A laptop folder"]',
    1
  );

  -- Q4 — Lesson 5.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'What is an endpoint?',
    '["A specific API action identified by method and URL path","A font size","A GitHub username","A screen color"]',
    0
  );

  -- Q5 — Lesson 5.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'What format do REST APIs commonly use to send data?',
    '["JSON","PNG","CSS","Git"]',
    0
  );

  -- Q6 — Lesson 5.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'Why should the backend validate form data even if the frontend already does?',
    '["Because frontend can be bypassed","Because CSS needs it","Because Git requires it","Because browsers cannot display forms"]',
    0
  );

  -- Q7 — Lesson 5.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'What does running "node server.js" do?',
    '["Runs your backend server file","Opens GitHub","Deletes the project","Changes CSS"]',
    0
  );

  -- Q8 — Lesson 5.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'If your frontend cannot reach localhost:3000, what should you check first?',
    '["Button color","Whether the backend server is running","Font size","GitHub username"]',
    1
  );

  -- Q9a — Lesson 5.9 (authentication)
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'Authentication answers which question?',
    '["What color should the button be?","Who are you?","How large is the database?","Which CSS file loaded?"]',
    1
  );

  -- Q9b — Lesson 5.9 (authorization)
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'Authorization answers which question?',
    '["What are you allowed to do?","What is your password?","What is the font?","What is DNS?"]',
    0
  );

  -- Q10 — Lesson 5.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'Does serverless mean there are literally no servers?',
    '["Yes, there are no servers","No, it means you do not manage the servers directly","Yes, data is stored in the browser","No, it means servers are free"]',
    1
  );

  -- Q11 — Lesson 5.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What HTTP status code should POST /api/messages return when required fields are missing?',
    '["200 OK","201 Created","400 Bad Request","500 Server Error"]',
    2
  );

end $$;
