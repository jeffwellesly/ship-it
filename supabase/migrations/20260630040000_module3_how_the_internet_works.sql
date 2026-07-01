-- Module 3: How the Internet Works
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
    'Module 3: How the Internet Works',
    'Understand what happens when your browser opens a website — DNS, HTTP, HTTPS, APIs, latency, CDNs, and DevTools.',
    3
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.1 — What Happens When You Open a Website?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Happens When You Open a Website?',
    1,
    $L31$When you type a website address and press Enter, it feels instant.

But behind that simple action, many things happen.

Your computer has to answer questions like:

  1. Where is this website?
  2. Which server should I talk to?
  3. Is the connection safe?
  4. What exactly am I asking for?
  5. Did the server understand me?
  6. What data came back?
  7. How should the browser show it?

>> The internet is not magic. It is a fast conversation between computers.

Your **browser** asks. A **server** answers. Your browser turns the answer into a screen.


ANALOGY

[!] Imagine you open a food delivery app and search for biryani near you. Your app does not have every restaurant stored inside your phone. It asks a server. The server checks data, prepares a response, and sends it back. Then your app displays restaurant cards. You see a clean screen — but behind it, your app just had a structured conversation with another computer.


BIG PICTURE FLOW

  You click or search
        ↓
  Browser/app sends a request
        ↓
  Internet carries the request
        ↓
  Server receives it
        ↓
  Server prepares a response
        ↓
  Internet carries the response back
        ↓
  Browser/app displays the result


KEY TERMS

**Browser** — An app like Chrome, Safari, Edge, or Firefox that opens websites.

**Client** — The device or app asking for something. Your browser is usually the client.

**Server** — A computer that waits for requests and sends responses.

**Request** — The message sent by the client.

**Response** — The message sent back by the server.

**Internet** — The network that connects computers around the world.$L31$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.2 — Client and Server: The Basic Conversation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Client and Server: The Basic Conversation',
    2,
    $L32$Almost everything on the internet starts with a simple pattern.

>> Client asks. Server answers.

Your phone, laptop, browser, or app is usually the **client**.

A **server** is a computer somewhere else that is ready to answer requests.

When you open a website, the browser asks the server for files. When you search in an app, the app asks the server for data. When you submit a form, the app sends data to the server. When you log in, the app asks the server to check who you are.


EXAMPLES

Opening a website:

  Client: Give me the homepage.
  Server: Here is the HTML, CSS, and JavaScript.

Searching in a food delivery app:

  Client: Show restaurants near me.
  Server: Here are 20 restaurants with names, ratings, and images.

Submitting a contact form:

  Client sends: name, email, message.
  Server answers: Message received.


WHY THIS MATTERS

As a product builder, this helps you debug.

Instead of saying "the app is broken," you can say:
  "The button works, but the server response is failing."

That is how builders and engineers think.


KEY TERMS

**Frontend** — The part users see and touch. Usually runs in the browser or app.

**Backend** — The hidden part that runs on servers, handles logic, and talks to databases.

**Client-server model** — The common pattern where one system asks and another system answers.


[!] Your current webpage from Module 2 is still a local file. It does not yet talk to a server. In this module, you will change that — your page will make a real request to another system.$L32$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.3 — DNS: The Internet's Contact List
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'DNS: The Internet''s Contact List',
    3,
    $L33$Humans like names. Computers use addresses.

You type a website name. But the internet needs to know which computer that name points to.

That is where DNS comes in.

**DNS** stands for Domain Name System.

>> DNS is the internet's contact list. It translates human-friendly names into computer-friendly addresses.

[!] In your phone, you do not remember everyone's number. You tap "Mom" and your phone knows the actual number behind that name. DNS does the same thing for websites. You type a name like github.com, and DNS finds the server address behind it.


HOW DNS WORKS

  You type a website name
        ↓
  Your browser asks: What address belongs to this name?
        ↓
  DNS finds the address
        ↓
  Your browser contacts the server at that address


KEY TERMS

**Domain name** — The human-readable website name. Example: github.com

**IP address** — The numeric address of a computer on a network. Example: 142.250.190.14

**DNS** — The system that translates domain names into IP addresses.

**Cache** — Saved information used to avoid repeating the same lookup.


WHY DNS MATTERS

If DNS breaks, users may not reach your app — even if the server is working, the database is safe, and the code is fine. If the name does not point to the right place, users cannot find it.

This is why DNS is one of the first things engineers check when a website is unreachable.


ACTION STEP

Open your terminal and run:

  ping example.com

You may see an IP address next to the domain name. The concept matters more than the command. If ping does not work on your network, skip it.$L33$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.4 — HTTP: The Language of Web Requests
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'HTTP: The Language of Web Requests',
    4,
    $L34$Once your browser knows which server to contact, it needs a way to speak to it.

That language is **HTTP**.

HTTP stands for HyperText Transfer Protocol.

>> HTTP is the language clients and servers use to talk on the web.

[!] Imagine you are in a restaurant. You can ask the waiter different things: show me the menu, place this order, change my order, cancel my order. The waiter understands the type of request. HTTP works similarly — it has different request methods.


THE FOUR METHODS

**GET** — Read something.

Examples: load homepage, show restaurant list, view profile, see blog posts.

GET should not change data. It only asks for data.


**POST** — Create something new.

Examples: submit a contact form, create an account, place an order, post a comment.

POST sends data to the server.


**PUT** — Update something that already exists.

Examples: update profile, change delivery address, edit saved settings.


**DELETE** — Remove something.

Examples: delete a saved address, remove a comment, cancel a project.

DELETE should be handled carefully because it removes data.


SUMMARY

  GET    — Read   — Load restaurant list
  POST   — Create — Submit contact form
  PUT    — Update — Edit profile
  DELETE — Remove — Delete comment


WHY THIS MATTERS

Every product feature usually maps to one of these actions.

When scoping a feature, ask:
  Are we reading, creating, updating, or deleting data?

That one question makes technical conversations much clearer.


MINI EXERCISE

Match each action to an HTTP method:

  1. Load your profile
  2. Submit a new message
  3. Edit your bio
  4. Delete a saved project

Answers: GET, POST, PUT, DELETE$L34$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.5 — Status Codes: The Server's Reply
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Status Codes: The Server''s Reply',
    5,
    $L35$When a server responds to a request, it includes a **status code**.

A status code is a short number that tells you what happened.

You have probably seen this one:
  404

It means the page was not found. Status codes are not random — they are grouped into families.

>> Status codes tell you instantly where a problem is before you read a single line of code.


CODE FAMILIES

  2xx — Success
  3xx — Redirect
  4xx — Client-side problem
  5xx — Server-side problem


COMMON STATUS CODES

  200 — OK. It worked.
  201 — Created. Something new was created.
  301 — Moved permanently. The page moved to a new address.
  400 — Bad request. The request was not shaped correctly.
  401 — Unauthorized. You are not logged in.
  403 — Forbidden. You are logged in but not allowed.
  404 — Not found. The thing does not exist.
  429 — Too many requests. Slow down.
  500 — Internal server error. Server broke.
  503 — Service unavailable. Server temporarily unavailable.


[!] Imagine asking a waiter for food. 200 means "here is your food." 404 means "we do not have that dish." 401 means "please show your membership card first." 403 means "I know who you are, but you cannot enter this area." 500 means "something went wrong in the kitchen."


401 VS 403

**401 Unauthorized** — The system does not know who you are. You are not logged in.

**403 Forbidden** — The system knows who you are, but you do not have permission. For example: logged in as a normal user but trying to open an admin page.


WHY THIS MATTERS

Instead of saying "the app is broken," you can say:
  "The API is returning 401, so this may be an authentication issue."

Or:
  "The API is returning 500, so the request reached the server but the server failed."

That makes you much more effective in technical conversations.$L35$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.6 — HTTPS: The Sealed Envelope
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'HTTPS: The Sealed Envelope',
    6,
    $L36$You have probably noticed that websites start with:
  https://

That extra "s" means secure.

**HTTP** is the normal web conversation. **HTTPS** is the secure version.

Without security, sensitive information could be exposed as data travels through networks. With HTTPS, the conversation is encrypted.

>> HTTPS is like sending a sealed envelope. People may carry it, but they cannot read what is inside.

[!] HTTP is like sending a postcard. Anyone who handles it can read what is written. HTTPS scrambles the message so only the intended recipient — the browser and the server — can read it.


WHAT HTTPS PROTECTS

  Passwords
  Login tokens
  Payment information
  Personal messages
  Form submissions
  User data

Modern users expect HTTPS. Modern browsers warn users when a website is not secure.


WHAT THE LOCK ICON MEANS

When a browser shows a lock icon, it means:

  1. The connection is encrypted.
  2. The website has a valid certificate.
  3. Data sent between browser and server is protected in transit.

Important: the lock icon does not mean the business is trustworthy. A scam website can also use HTTPS. So HTTPS is necessary, but not a guarantee that everything is safe.


KEY TERMS

**HTTPS** — Secure version of HTTP.

**Encryption** — Scrambling information so others cannot read it.

**Certificate** — A digital proof that helps the browser trust the website connection.

**TLS** — The security system behind HTTPS.


PRODUCT EXAMPLE

If your app has a login page, it must use HTTPS. A login form over plain HTTP would be unsafe because the user's password could travel without protection. For a real product, HTTPS is not optional.$L36$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.7 — Latency: Why Speed Depends on Distance
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Latency: Why Speed Depends on Distance',
    7,
    $L37$Sometimes an app feels fast. Sometimes it feels slow.

One reason is **latency**.

Latency means delay.

In web products, latency is the time it takes for a request to travel, get handled, and come back.

Even though the internet feels instant, data still has to physically travel through cables and networks.

>> Distance matters. A server closer to the user usually responds faster than a server far away.

[!] Imagine asking a question. If your friend is sitting next to you, the answer comes quickly. If your friend is in another country, even a phone call may have delay. The same idea applies to computers — closer server usually means faster response.


WHAT MAKES A PAGE FEEL SLOW

A page may feel slow because of:

  1. DNS lookup time
  2. Connection time
  3. Server processing time
  4. Data transfer time
  5. Browser rendering time
  6. Too many large files
  7. Slow user internet

Speed is not one thing. It is many small delays added together.


PRODUCT EXAMPLE

A page may need many files: HTML, CSS, JavaScript, images, fonts, and API responses.

If each file takes time, the total load feels slow.

That is why builders care about file size, server location, CDNs, caching, image optimization, and frontend performance.


KEY TERMS

**Latency** — Delay between request and response.

**Round trip** — The request goes to the server and the response comes back.

**Server processing time** — Time the server spends doing work.

**Rendering time** — Time the browser spends drawing the page.$L37$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.8 — CDN: Files Stored Closer to Users
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'CDN: Files Stored Closer to Users',
    8,
    $L38$If users are spread across the world, should every user download files from one central server?

That would be slow.

A **CDN** helps solve this.

CDN stands for Content Delivery Network.

>> A CDN stores copies of files closer to users, so they load faster no matter where the user is.

[!] Imagine a bakery that sells bread across the country. If every customer had to get bread from one factory, delivery would be slow. Instead, the bakery sends bread to local stores. Customers pick it up nearby. A CDN works like those local stores — your website's images, CSS, and JavaScript can be served from a server near the user instead of a faraway origin server.


WHAT CDNS USUALLY CACHE

CDNs are good for files that do not change for every user:

  Images, CSS files, JavaScript files, fonts, videos, public documents.

CDNs are not for private user-specific data:

  Bank balance, private messages, personal order history, admin dashboard data.


KEY TERMS

**CDN** — A network of servers that stores copies of content closer to users.

**Origin server** — The main server where the original content lives.

**Edge server** — A CDN server closer to the user.

**Cache** — A saved copy of content.

**Static files** — Files that are usually the same for many users, like images, CSS, JavaScript, and fonts.


PRODUCT EXAMPLE

For a learning app like Ship It — good CDN use: course images, logo, CSS, JavaScript, public landing page assets.

Be careful with: user progress, user email, payment details, private submissions.

As a product builder, the main idea is:
  Put common files closer to users.$L38$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.9 — APIs: When Your Page Talks to Another System
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'APIs: When Your Page Talks to Another System',
    9,
    $L39$So far, your webpage mostly uses files on your computer.

But real products need to talk to other systems.

Examples:
  Weather app gets weather data.
  Food delivery app gets restaurant data.
  Learning app gets course progress.
  Payment page talks to payment processor.

This is where **APIs** come in.

API stands for Application Programming Interface.

>> An API is a structured way for one software system to talk to another.

[!] An API is like a restaurant menu. The menu tells you what you are allowed to order. You cannot walk into the kitchen and grab anything. You choose from the menu, and the kitchen prepares a response. Similarly, an API tells your app what requests are allowed, what information to send, and what response to expect.


WHAT IS JSON?

Many APIs send responses in a format called **JSON**.

JSON stands for JavaScript Object Notation. It looks like this:

  {
    "name": "Jeff",
    "role": "Builder",
    "learning": "Software development"
  }

JSON is easy for both humans and computers to read.


KEY TERMS

**API** — A structured way for software systems to communicate.

**Endpoint** — A specific API URL that does one job.

**JSON** — A common format for sending data between systems.

**fetch** — A JavaScript function that can make web requests from the browser.


BEGINNER FETCH EXAMPLE

In JavaScript, you can write:

  fetch("https://example.com/data")

This means: go ask this URL for data.

Real code needs to wait for the response and handle errors — you will build that in the module project.


IMPORTANT NOTE

Public test APIs can sometimes be unavailable or change behavior. If an API in this lesson does not work, ask Claude or ChatGPT:

  "Give me a current beginner-friendly public test API that supports browser fetch. I want to practice GET requests and display JSON data on a simple webpage."$L39$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.10 — DevTools: Seeing the Internet Conversation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'DevTools: Seeing the Internet Conversation',
    10,
    $L310$When your browser talks to a server, the conversation is usually invisible.

But you can see it.

Browsers include developer tools, often called **DevTools**.

>> DevTools let you inspect HTML, CSS, JavaScript errors, network requests, status codes, and API responses — all inside your browser.


THE NETWORK TAB

The Network tab shows what your browser requested and what came back.

You can see:
  Which files loaded
  Which requests failed
  How long requests took
  What status code came back
  What data came back from an API


HOW TO OPEN DEVTOOLS

In Chrome or Edge — right-click on any webpage, then click Inspect, then open the Network tab.

Mac shortcut:
  Command + Option + I

Windows shortcut:
  Ctrl + Shift + I

Then click Network and refresh the page. You will see requests appear.


WHAT YOU ARE LOOKING AT

Each row is one request.

  Name   — The file or API that was requested
  Status — The status code: 200, 404, 500...
  Type   — The kind of file: document, script, stylesheet, or fetch
  Size   — How much data came back
  Time   — How long it took


MINI EXERCISE

Open your Module 2 webpage. Open DevTools, go to Network, then refresh the page.

Look for:
  index.html
  style.css
  script.js

You should see your browser loaded these files.


PRODUCT BUILDER INTERPRETATION

If style.css shows 404 — your styling file was not found.

If script.js shows 404 — your JavaScript file was not found.

If an API request shows 500 — the server had an issue.

If an API request shows 401 — authentication may be missing.

This is how you move from "it is broken" to:
  "The CSS file is returning 404, so the page cannot load styles."

[!] If you are confused by what you see in the Network tab, take a screenshot and ask Claude or ChatGPT: "I am looking at the Network tab. Please explain what each visible request represents and what I should check."$L310$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.11 — Module Project: Add an Internet Request to Your Webpage
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Module Project: Add an Internet Request to Your Webpage',
    11,
    $L311$Now you will upgrade your first webpage.

You will add a button that fetches data from the internet and displays it on your page.

>> You are moving from a page that only lives on your computer to a page that can ask another system for data. That is a big step.


WHAT YOU WILL BUILD

Add a section called "Internet Request Demo" that includes:

  1. A button
  2. A loading message
  3. An API response area
  4. A status code display
  5. An error message if the request fails


STEP 1 — ADD HTML

In index.html, add this section:

  <section class="api-demo">
    <h2>Internet Request Demo</h2>
    <p>Click the button to ask a public API for sample data.</p>
    <button id="fetchButton">Fetch sample data</button>
    <p id="loadingMessage"></p>
    <pre id="apiResult"></pre>
  </section>


STEP 2 — ADD CSS

In style.css, add:

  .api-demo {
    margin-top: 32px;
    padding: 24px;
    border-radius: 16px;
    background: #15151f;
    border: 1px solid #2a2a3a;
  }

  .api-demo button {
    margin-top: 12px;
    padding: 12px 18px;
    border: none;
    border-radius: 10px;
    background: #6d5dfc;
    color: white;
    font-weight: 600;
    cursor: pointer;
  }

  #apiResult {
    margin-top: 16px;
    padding: 16px;
    border-radius: 12px;
    background: #0b0b10;
    color: #d8d8e8;
    overflow-x: auto;
  }


STEP 3 — ADD JAVASCRIPT

In script.js, add:

  const fetchButton = document.getElementById("fetchButton");
  const loadingMessage = document.getElementById("loadingMessage");
  const apiResult = document.getElementById("apiResult");

  fetchButton.addEventListener("click", async function () {
    loadingMessage.textContent = "Request sent. Waiting for response...";
    apiResult.textContent = "";

    try {
      const response = await fetch("https://jsonplaceholder.typicode.com/todos/1");
      const data = await response.json();

      loadingMessage.textContent = "Status: " + response.status;
      apiResult.textContent = JSON.stringify(data, null, 2);
    } catch (error) {
      loadingMessage.textContent = "Something went wrong.";
      apiResult.textContent = error.message;
    }
  });


WHAT THIS CODE DOES

fetchButton.addEventListener waits for the button to be clicked.

fetch("...") sends a GET request to the public API.

response.json() converts the response into JSON data JavaScript can use.

response.status shows the status code.

JSON.stringify(data, null, 2) displays the data neatly.

catch (error) handles failure — if something goes wrong, the page shows an error instead of silently failing.


STEP 4 — TEST IT

Open your webpage and click Fetch sample data.

You should see something like:

  {
    "userId": 1,
    "id": 1,
    "title": "delectus aut autem",
    "completed": false
  }


STEP 5 — INSPECT IN DEVTOOLS

Open DevTools, go to Network, then click the button again.

Look for the API request and check: Request URL, Status code, Response, Time taken.

This is the invisible internet conversation becoming visible.


FINAL CLAUDE CODE PROMPT

Give this to Claude Code:

  Upgrade my first webpage with an Internet Request Demo.

  Requirements:
  1. Add a section called Internet Request Demo
  2. Add a button called Fetch sample data
  3. When clicked, use JavaScript fetch to call a public test API
  4. Show a loading message while waiting
  5. Show the status code when the response returns
  6. Display the JSON response neatly on the page
  7. Show a friendly error message if the request fails
  8. Keep the code beginner-friendly
  9. Use only HTML, CSS, and JavaScript
  10. Explain which files you changed and what each change does


FINAL QA CHECKLIST

Before finishing, check:

  Does the webpage still load?
  Does the original button still work?
  Does the new fetch button appear?
  Does clicking it show a loading message?
  Does it show response data?
  Does it show a status code?
  Can you see the request in DevTools Network tab?
  Is the page still readable on mobile?
  Did you save all files?


SAVE WITH GIT

After it works, run:

  git status
  git add .
  git commit -m "Add internet request demo"


REFLECTION

Answer these before moving on:

  1. What is a client?
  2. What is a server?
  3. What does DNS do?
  4. What does HTTP do?
  5. What does a 404 mean?
  6. Why does HTTPS matter?
  7. What is latency?
  8. What does a CDN do?
  9. What is an API?
  10. What did your webpage fetch from the internet?$L311$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (lessons 1–10; lesson 11 is project, no quiz)
  -- ─────────────────────────────────────────────────────────────────
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values

  (v_l1,
   'When you open a website, your browser is mainly:',
   '["Answering requests","Asking for content","Storing files","Running the server"]',
   1),

  (v_l2,
   'In a website, the browser is usually the:',
   '["Database","Client","Server","Router"]',
   1),

  (v_l3,
   'What does DNS do?',
   '["Makes buttons purple","Converts domain names into server addresses","Stores user passwords","Writes JavaScript"]',
   1),

  (v_l4,
   'Which HTTP method is usually used to submit a new contact form?',
   '["GET","POST","DELETE","CSS"]',
   1),

  (v_l5,
   'What does a 500 status code usually mean?',
   '["User is not logged in","Page does not exist","Server had an internal error","Request was successful"]',
   2),

  (v_l6,
   'What is the main purpose of HTTPS?',
   '["Make buttons look better","Encrypt communication between browser and server","Make websites load images","Create Git commits"]',
   1),

  (v_l7,
   'What is latency?',
   '["The color of a button","The delay between request and response","A GitHub repository","A database table"]',
   1),

  (v_l8,
   'What is the main purpose of a CDN?',
   '["Store private passwords","Put copies of common files closer to users","Write backend code","Replace HTML"]',
   1),

  (v_l9,
   'What is an API?',
   '["A way for software systems to communicate","A CSS color","A Git commit","A laptop folder"]',
   0),

  (v_l10,
   'What does the Network tab in DevTools help you inspect?',
   '["Files and API requests loaded by the browser","Only button colors","Git commit history","Laptop battery health"]',
   0);

end;
$$;
