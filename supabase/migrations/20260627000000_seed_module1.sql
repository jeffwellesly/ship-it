-- Seed: Module 1 lessons and questions

-- MODULE 1 LESSONS
insert into lessons (chapter, title, sort_order, content) values
('Module 1: Internet Fundamentals', 'What Even Is Software?', 1,
'Open Robinhood on your phone. You tap "Buy" on a stock. A second later, you own a share.

What actually happened in that second? Your phone (the client) sent a request across the internet to a powerful computer sitting in a data center somewhere (the server). That server checked your account, talked to the stock exchange, recorded the trade, and sent a response back saying "done." Your phone just displayed the result.

That''s the entire shape of almost every app you''ve ever used: a client asks, a server answers. Everything else in this course is just zooming into the details of that one exchange.

PM takeaway: When engineers say "client-side" vs "server-side," they''re telling you where a piece of logic lives — on the user''s phone, or on a company-owned computer. That distinction decides who can see your data, how fast something feels, and what happens if you lose internet connection.'),

('Module 1: Internet Fundamentals', 'The Big Picture — What Happens When You Tap "Buy"', 2,
'Tapping "Buy" on Robinhood triggers a chain of invisible steps, all in well under a second:
1. Your phone finds Robinhood''s server (DNS)
2. Your phone "talks" to that server using an agreed language (HTTP)
3. That conversation is locked in an envelope no one else can read (HTTPS)
4. The data physically travels through cables and satellites (latency)
5. Robinhood likely has servers in multiple locations so this is fast for everyone, not just people near their main data center (CDNs)

We''re about to zoom into each of these five steps. By the end of this module, you''ll be able to explain — credibly, to an engineer — exactly why an order sometimes takes 200ms and sometimes takes 2 seconds.'),

('Module 1: Internet Fundamentals', 'DNS — Finding Robinhood''s Server', 3,
'The internet only understands numbers — addresses like 104.18.24.56 — not words like robinhood.com. DNS is the phone book that translates the name you type into the actual numeric address of Robinhood''s server.

How it works, in 4 hops:
- Your phone checks if it already knows the answer (fastest — cached from a recent visit)
- Your internet provider''s DNS server is asked next
- If neither knows, root servers (13 sets worldwide) point to who manages .com addresses
- Finally, Robinhood''s own authoritative DNS server gives the real, current answer

First-time lookup: 20-120ms. Cached: under 5ms — the difference between Robinhood feeling instant or slightly sluggish.

Real-world stakes: In October 2021, a DNS misconfiguration took down Facebook, Instagram, and WhatsApp for billions of users simultaneously — DNS is the very first domino. If a trading app''s DNS broke during a market crash, users literally couldn''t place trades to protect themselves. This is why DNS reliability is a board-level concern for any finance app.'),

('Module 1: Internet Fundamentals', 'HTTP — The Conversation Between Your Phone and Robinhood''s Server', 4,
'Once your phone finds Robinhood''s server, it needs a shared language to ask for things. That language is HTTP.

Analogy: Think of it like ordering at a restaurant. You (the client) don''t walk into the kitchen — you tell the waiter what you want, and the kitchen (the server) prepares it.

The 4 core HTTP methods map to CRUD:
- GET — "Show me my portfolio" (read)
- POST — "Place this buy order" (create)
- PUT — "Update my account settings" (update)
- DELETE — "Cancel this pending order" (delete)

PM relevance: Every feature you''d ever scope maps to one of these. A "Buy" button is a POST — and POST requests need duplicate-submission safeguards (you don''t want someone''s shaky thumb buying the same stock twice by accident). A "Cancel order" button is a DELETE — and deletes usually need a confirmation step, because they''re hard to undo.'),

('Module 1: Internet Fundamentals', 'HTTPS — Locking the Envelope', 5,
'HTTP alone sends data in plain text — anyone intercepting the connection (a hacker on public WiFi, for instance) could read your account number or trade details. HTTPS encrypts everything, so the same data travels the same route but is unreadable to anyone except your phone and Robinhood''s server.

The handshake, simplified:
1. Your phone says which encryption methods it supports
2. Robinhood''s server responds with its chosen method + a certificate proving it''s really Robinhood
3. Your phone verifies that certificate with a trusted authority
4. A secret key is exchanged, encrypted
5. From here on, the channel is secure

Real-world stakes: In 2011, a hacked certificate authority let attackers impersonate Google''s HTTPS certificate and intercept Gmail traffic for ~300,000 users — while browsers still showed the "secure" padlock. The lesson: the padlock means encrypted, not automatically safe. For something like Robinhood, where account numbers and trades are on the line, this distinction matters enormously.

Why it''s non-negotiable: Browsers actively block camera, location, and other sensitive permissions on non-HTTPS sites — and flag them as "Not Secure." No serious finance app could exist without it.'),

('Module 1: Internet Fundamentals', 'Latency & CDNs — Why Distance (Still) Costs You Money', 6,
'Data travels through fiber optic cables at about 200,000 km/s — fast, but not instant. If Robinhood''s only server is in Virginia and you''re trading from California, every single request pays a real round-trip cost. And a single trade screen isn''t one request — loading a price chart, your balance, and order confirmation can be 20-50 separate requests, each paying that same distance tax.

CDNs (Content Delivery Networks) solve part of this: instead of one server in Virginia serving the entire country, copies of static content (logos, charts, images) sit on servers spread across many cities — so a user in LA is served from a nearby server, not one 3,000 miles away.

Real-world stakes: In trading specifically, latency isn''t just a UX annoyance — milliseconds can be the difference between buying a stock at the price you saw and a slightly worse price after it moved. This is exactly why high-frequency trading firms pay enormous sums to place their servers physically inside stock exchange buildings — shaving off even a few milliseconds of cable distance translates directly into profit.');

-- MODULE 1 QUESTIONS
insert into questions (lesson_id, question_text, choices, correct_choice_index)
select id, 'In the Robinhood example, what is the "client"?',
  '["Your phone/app", "The server", "The stock exchange", "The internet cable"]'::jsonb, 0
from lessons where title = 'What Even Is Software?';

insert into questions (lesson_id, question_text, choices, correct_choice_index)
select id, 'True or False: the server is software running on your own phone',
  '["True", "False"]'::jsonb, 1
from lessons where title = 'What Even Is Software?';

insert into questions (lesson_id, question_text, choices, correct_choice_index)
select id, 'What does DNS actually do?',
  '["Encrypts your data", "Translates a domain name into an IP address", "Stores your password", "Speeds up your phone"]'::jsonb, 1
from lessons where title = 'DNS — Finding Robinhood''s Server';

insert into questions (lesson_id, question_text, choices, correct_choice_index)
select id, 'Why was the 2021 Facebook outage so severe?',
  '["A hacker stole data", "DNS failure broke access for billions across multiple apps at once", "The servers caught fire", "Too many users logged in at once"]'::jsonb, 1
from lessons where title = 'DNS — Finding Robinhood''s Server';

insert into questions (lesson_id, question_text, choices, correct_choice_index)
select id, 'Which HTTP method would "Place a buy order" use?',
  '["GET", "POST", "DELETE", "PUT"]'::jsonb, 1
from lessons where title = 'HTTP — The Conversation Between Your Phone and Robinhood''s Server';

insert into questions (lesson_id, question_text, choices, correct_choice_index)
select id, 'Why do POST requests need duplicate-submission safeguards on a trading app?',
  '["To make the app look fancy", "Because accidentally submitting twice could mean buying the same stock twice", "Because POST is slower than GET", "They don''t need any safeguards"]'::jsonb, 1
from lessons where title = 'HTTP — The Conversation Between Your Phone and Robinhood''s Server';

insert into questions (lesson_id, question_text, choices, correct_choice_index)
select id, 'What does HTTPS protect against?',
  '["Slow internet", "Someone intercepting and reading your data in transit", "Running out of storage", "Forgetting your password"]'::jsonb, 1
from lessons where title = 'HTTPS — Locking the Envelope';

insert into questions (lesson_id, question_text, choices, correct_choice_index)
select id, 'Does a padlock icon guarantee a site is fully safe?',
  '["Yes, always", "No, it only guarantees the connection is encrypted", "Only on weekends", "Only for banking sites"]'::jsonb, 1
from lessons where title = 'HTTPS — Locking the Envelope';

insert into questions (lesson_id, question_text, choices, correct_choice_index)
select id, 'What problem do CDNs solve?',
  '["Reducing distance/latency by serving content from servers closer to the user", "Encrypting passwords", "Creating backups", "Translating domain names"]'::jsonb, 0
from lessons where title = 'Latency & CDNs — Why Distance (Still) Costs You Money';

insert into questions (lesson_id, question_text, choices, correct_choice_index)
select id, 'Why does latency matter more for a trading app than a recipe blog?',
  '["It doesn''t matter more", "Price-sensitive actions can be affected by even small delays", "Recipes load faster naturally", "Trading apps use less data"]'::jsonb, 1
from lessons where title = 'Latency & CDNs — Why Distance (Still) Costs You Money';
