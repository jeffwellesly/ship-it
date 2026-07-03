-- AI/ML for Builders — Module 26: AI Case Studies, Interview Answers, and Practice Questions
-- 33 lessons — the capstone module: converting the whole course into case studies, interview answers, and practice drills

do $$
declare
  v_course_id uuid;
  v_module_id uuid;
  v_l1  uuid; v_l2  uuid; v_l3  uuid; v_l4  uuid; v_l5  uuid; v_l6  uuid;
  v_l7  uuid; v_l8  uuid; v_l9  uuid; v_l10 uuid; v_l11 uuid; v_l12 uuid;
  v_l13 uuid; v_l14 uuid; v_l15 uuid; v_l16 uuid; v_l17 uuid; v_l18 uuid;
  v_l19 uuid; v_l20 uuid; v_l21 uuid; v_l22 uuid; v_l23 uuid; v_l24 uuid;
  v_l25 uuid; v_l26 uuid; v_l27 uuid; v_l28 uuid; v_l29 uuid; v_l30 uuid;
  v_l31 uuid; v_l32 uuid; v_l33 uuid;
begin

  select id into v_course_id from courses where sort_order = 2;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 26: AI Case Studies, Interview Answers, and Practice Questions',
    'The capstone module — five full product case studies, a ten-question interview answer bank, practice-question drills, reusable PM answer templates, and a final capstone project that turn everything in this course into interview-ready judgment.',
    26
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.1 — Why This Module Matters, and The PM Way to Talk About AI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Why This Module Matters, and The PM Way to Talk About AI',
    1,
    $M26L1$WHY THIS MODULE MATTERS

You have now learned the building blocks — ML basics, regression, classification, trees and forests, clustering, simulation, neural networks, CNNs, RNNs/LSTMs, transformers, evaluation and MLOps, recommendation systems, experimentation, LLMs, prompting, RAG, agents, fine-tuning, safety, AI UX, AI strategy, and AI architecture.

The question now is: can you explain all of this like a strong product manager?

This module converts technical understanding into product case studies, interview answers, portfolio stories, business recommendations, PM frameworks, and practice questions.

**The goal is not to sound like an ML engineer. The goal is to sound like a PM who understands AI deeply enough to build useful, safe, measurable products.**

[!] This is a review-and-practice module, not a new-concepts module — treat it as rehearsal for real interviews and real case studies.


THE PM WAY TO TALK ABOUT AI

A weak AI PM answer starts with the model: "we can use GPT and vector embeddings."

A strong AI PM answer starts with the user problem: "support agents spend too much time searching policy and drafting replies. I would build a policy-grounded support copilot that retrieves approved sources, drafts responses, and requires agent approval before sending. I would measure handle time, agent acceptance, CSAT, and wrong-answer rate."

>> Problem, then workflow, then AI role, then data, then UX, then evaluation, then guardrails, then business impact — that chain is the spine of every strong AI PM answer in this module.$M26L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.2 — The Master AI PM Framework, Part 1: Problem, Workflow, and AI Role
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The Master AI PM Framework, Part 1: Problem, Workflow, and AI Role',
    2,
    $M26L2$THE MASTER AI PM FRAMEWORK

Use this ten-step framework for almost any AI product question. This lesson covers the first three steps.

STEP 1: DEFINE THE USER PROBLEM

Who is the user? What pain do they have? Why does it matter?

STEP 2: MAP THE WORKFLOW

What happens today? Where is the bottleneck? Where can AI help?

STEP 3: CHOOSE THE AI ROLE

Should AI summarize, retrieve, draft, classify, extract, recommend, predict, or take action?

[!] Naming the AI's role in one word — summarize, retrieve, draft, classify, extract, recommend, predict, act — forces clarity before any architecture discussion starts.

>> Every strong answer names the user problem, the workflow, and the AI's specific role before it ever mentions a model or a technology.$M26L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.3 — The Master AI PM Framework, Part 2: Data, Architecture, and UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The Master AI PM Framework, Part 2: Data, Architecture, and UX',
    3,
    $M26L3$STEP 4: IDENTIFY DATA AND CONTEXT

What does AI need to know? User input, documents, policies, customer records, product data, historical examples, live APIs.

STEP 5: CHOOSE ARCHITECTURE

Possible options: prompt-only, RAG, fine-tuning, tool calling, agent, traditional ML, recommendation system, human-in-the-loop.

STEP 6: DESIGN UX

How will the user interact? Chat, button, copilot panel, inline suggestion, agent workflow, approval screen.

[!] Architecture and UX are chosen after data is scoped — you cannot pick RAG vs. fine-tuning vs. tools until you know what context the AI actually needs.

>> This course has already covered every one of these architecture options in earlier modules — this framework is where they get applied to real problems instead of studied in isolation.$M26L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.4 — The Master AI PM Framework, Part 3: Metrics, Guardrails, Rollout, and Learning
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The Master AI PM Framework, Part 3: Metrics, Guardrails, Rollout, and Learning',
    4,
    $M26L4$STEP 7: DEFINE METRICS

Measure user value, business value, AI quality, safety, cost, and adoption.

STEP 8: ADD GUARDRAILS

Protect against hallucination, privacy leaks, wrong actions, unsafe outputs, prompt injection, bias, and over-automation.

STEP 9: ROLL OUT SAFELY

Use offline evaluation, shadow mode, pilot, human review, A/B test, gradual rollout, monitoring, and a kill switch.

STEP 10: LEARN AND IMPROVE

Use feedback, evals, monitoring, and user research.

[!] "User problem first. Model choice later." is the one-line summary of all ten steps.

>> The five case studies, ten interview answers, and five templates that follow in this module are all instances of this same ten-step shape — once you know the framework, you can generate a strong answer to almost any AI PM question.$M26L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.5 — Case Study 1: Support Copilot — Product Problem and AI Solution
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 1: Support Copilot — Product Problem and AI Solution',
    5,
    $M26L5$PRODUCT PROBLEM

Support agents spend too much time reading long tickets, searching policies, and drafting replies. This causes slow response time, inconsistent answers, agent fatigue, higher support cost, and lower customer satisfaction.

AI SOLUTION

Build a support copilot inside the support console. The copilot can summarize the customer issue, identify intent and urgency, retrieve relevant policy, draft a response, suggest the next best action, flag risky cases, and escalate when needed.

[!] Notice the solution is scoped to specific capabilities — summarize, retrieve, draft, flag, escalate — rather than "an AI chatbot." That specificity is what makes it a strong PM answer.

>> This is the same support copilot build example introduced in Module 25 — now reframed as a full case study you can walk an interviewer through end to end.$M26L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.6 — Case Study 1: Support Copilot — Architecture and UX Design
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 1: Support Copilot — Architecture and UX Design',
    6,
    $M26L6$BEST ARCHITECTURE

Use RAG for approved policy, tool calling for order/account data, prompting for response format and tone, human approval before sending, guardrails to block unsupported promises, and logging for audit and QA.

**Do not let the AI answer from memory. Do not let it promise refunds unless policy and account data confirm eligibility.**

UX DESIGN

Inside the ticket view, show the customer issue summary, relevant policy source, suggested next step, draft reply, risk flags, an edit button, an approve/send button, and an escalate button.

[!] The agent should stay in control — the UX is designed around review and approval, not blind trust.

>> Architecture without the right UX fails just as often as UX without the right architecture — this case study pairs both deliberately.$M26L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.7 — Case Study 1: Support Copilot — Metrics and Interview Answer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 1: Support Copilot — Metrics and Interview Answer',
    7,
    $M26L7$METRICS

Business metrics: average handle time, first response time, resolution time, cost per ticket, support volume handled per agent.

Quality metrics: agent acceptance rate, edit distance, policy accuracy, wrong-answer rate, escalation correctness.

Customer metrics: CSAT, reopen rate, complaint rate.

Safety metrics: unsupported refund promise rate, privacy leak rate, high-risk case escalation rate.

INTERVIEW ANSWER VERSION

"If I were building an AI support copilot, I would not start with a generic chatbot. I would start with the agent workflow. The biggest pain is usually reading ticket history, finding the right policy, and drafting a compliant reply. I would use RAG over approved policy docs, tools for order/account data, and an LLM to draft the response. Initially, I would keep the system human-in-the-loop, so the AI drafts and the agent approves. I would measure handle time, agent acceptance, CSAT, wrong-answer rate, and policy compliance. Guardrails would include source citations, escalation for high-risk cases, and blocking unsupported refund promises."

[!] Notice the four metric categories — business, quality, customer, safety — cover the full picture, not just one dimension.

>> This interview answer is the template: state the workflow insight first, then architecture, then rollout posture, then metrics, then guardrails — in that order.$M26L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.8 — Case Study 2: Internal Knowledge Assistant — Product Problem and AI Solution
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 2: Internal Knowledge Assistant — Product Problem and AI Solution',
    8,
    $M26L8$PRODUCT PROBLEM

Employees waste time searching across scattered documents, wikis, Slack threads, PDFs, and old process pages. This causes slow onboarding, repeated questions, outdated answers, poor process compliance, and knowledge trapped across teams.

AI SOLUTION

Build an internal knowledge assistant that answers questions from approved company sources — for example, "what is the process for launching a new vendor?" or "who owns this internal process?"

[!] The user problem here is fragmentation and staleness of knowledge, not a lack of intelligence — that framing determines everything about the architecture that follows.

>> Compare this to the support copilot in the previous case study — same RAG-based approach, but a completely different user and a completely different risk profile.$M26L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.9 — Case Study 2: Internal Knowledge Assistant — Architecture and Key Risks
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 2: Internal Knowledge Assistant — Architecture and Key Risks',
    9,
    $M26L9$BEST ARCHITECTURE

Use RAG. Ingest approved documents, chunk documents, create embeddings, store in a vector database, add metadata (owner, version, team, permission, date), retrieve relevant chunks, answer with citations, and respect user permissions.

KEY RISKS

Outdated documents, wrong source retrieved, permission leaks, conflicting policies, fake citations, and employees over-trusting answers.

[!] "Employees over-trusting answers" is a risk even when the system works exactly as designed — over-trust is a UX and communication problem, not just an accuracy problem.

>> Every risk in this list maps back to a layer from Module 25 — source freshness maps to versioning, permission leaks map to permission-aware retrieval, and fake citations map to output guardrails.$M26L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.10 — Case Study 2: Internal Knowledge Assistant — Metrics and Interview Answer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 2: Internal Knowledge Assistant — Metrics and Interview Answer',
    10,
    $M26L10$METRICS

Retrieval quality: recall@K, citation correctness, source relevance.

Product value: time to answer, search success rate, employee satisfaction, reduced repeated questions, source click-through.

Safety: permission leak rate, outdated-source usage, no-answer refusal accuracy.

INTERVIEW ANSWER VERSION

"For an internal knowledge assistant, I would use RAG rather than fine-tuning because the main problem is access to current company knowledge. The system should retrieve approved documents, respect permissions, and answer with citations. The hardest product challenges are not only model quality, but source quality, document freshness, access control, and trust. I would measure time to answer, search success, citation correctness, helpfulness, and permission failures."

[!] "No-answer refusal accuracy" is a real metric — a good knowledge assistant should be measured on how well it says "I don't know" when sources don't support an answer, not only on how well it answers.

>> This interview answer opens with a RAG-vs-fine-tuning judgment call — that pairing is common enough in interviews that it deserves its own answer, covered two lessons from now in the interview answer bank.$M26L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.11 — Case Study 3: AI Refund Agent — Product Problem and AI Solution
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 3: AI Refund Agent — Product Problem and AI Solution',
    11,
    $M26L11$PRODUCT PROBLEM

Refund requests are repetitive, but some are risky. The current process — read complaint, check order, check policy, decide eligibility, create the refund workflow, reply to customer — is time-consuming, and wrong refunds can cost money and damage trust.

AI SOLUTION

Build a refund agent that handles low-risk cases and escalates risky ones. The agent can understand refund intent, ask for a missing order ID, look up the order, retrieve policy, check eligibility, draft a response, create a return label for approved low-risk cases, and escalate exceptions.

[!] Notice the solution explicitly separates "handle" from "escalate" — a refund agent that tries to handle everything is a liability, not a feature.

>> This is the same refund agent build example from Module 25 — the case-study format now adds the product framing and interview-ready language around it.$M26L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.12 — Case Study 3: AI Refund Agent — Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 3: AI Refund Agent — Architecture',
    12,
    $M26L12$BEST ARCHITECTURE

Use intent classification, an order lookup tool, policy RAG, deterministic business rules, tool permissions, approval gates, audit logs, human escalation, and a kill switch.

**Do not rely only on the LLM for refund decisions. Use deterministic rules for thresholds.**

Example thresholds: under $50 and clearly eligible, auto-create a return label; $50 to $500, require human approval; above $500 or unclear policy, escalate.

[!] The dollar thresholds are not the important part — the important part is that a fixed rule, not the model's judgment, decides which tier a case falls into.

>> This threshold pattern is the deterministic-rules-vs-AI decision from Module 25, applied concretely: AI drafts and recommends, rules gate what can happen automatically.$M26L12$
  ) returning id into v_l12;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.13 — Case Study 3: AI Refund Agent — Metrics and Interview Answer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 3: AI Refund Agent — Metrics and Interview Answer',
    13,
    $M26L13$METRICS

Efficiency: resolution time, manual workload reduction, cost per refund request.

Quality: correct eligibility decision, human override rate, escalation quality.

Safety: wrong refund rate, duplicate refund rate, unauthorized action rate, policy violation rate.

Customer: CSAT, complaint rate, reopen rate.

INTERVIEW ANSWER VERSION

"For a refund agent, I would be careful not to over-automate too early. I would first map the refund workflow and separate low-risk from high-risk cases. The agent can read the request, check order data through tools, retrieve policy through RAG, and draft a recommendation. For low-value clear cases, it may create a return label; for high-value or unclear cases, it should escalate. I would enforce thresholds in code, not just prompts. Metrics would include resolution time, correct eligibility, wrong refund rate, CSAT, and unsafe action rate."

[!] "I would enforce thresholds in code, not just prompts" is the single most interview-relevant line in this answer — it signals you understand that prompts are not a reliable enforcement mechanism.

>> Four metric categories again — efficiency, quality, safety, customer — the same shape as the support copilot case study, reused because it works for any AI feature with real-world consequences.$M26L13$
  ) returning id into v_l13;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.14 — Case Study 4: AI Analytics Assistant — Product Problem and AI Solution
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 4: AI Analytics Assistant — Product Problem and AI Solution',
    14,
    $M26L14$PRODUCT PROBLEM

Business users want answers from data, but they may not know SQL, metric definitions, or dashboard structure. This makes analysts a bottleneck, delays business teams, slows reports, and risks metric misunderstanding and wrong conclusions.

AI SOLUTION

Build an analytics assistant that answers business questions using trusted data tools. For a question like "why did conversion drop last week?" a good assistant should understand the question, find the metric definition, generate or call a query, retrieve real data, summarize results, separate facts from hypotheses, link to the source dashboard/query, and avoid claiming causality without evidence.

[!] "Avoid claiming causality without evidence" belongs in the solution description itself, not just the guardrails — it is a core part of what makes this a trustworthy product, not an add-on.

>> This is the fourth of five case studies in this module — notice each one pairs a workflow bottleneck with a specific, scoped AI role, never a vague "AI-powered" pitch.$M26L14$
  ) returning id into v_l14;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.15 — Case Study 4: AI Analytics Assistant — Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 4: AI Analytics Assistant — Architecture',
    15,
    $M26L15$BEST ARCHITECTURE

Use RAG for metric definitions, tool/database access for actual numbers, SQL generation with validation, permission checks, human review for executive reports, and a UX that clearly shows the query and source.

**Do not let the model invent numbers.**

[!] This is the same SQL-validator pattern from Module 25's analytics build example — the model proposes a query, and a separate validation step checks it before real data is touched.

>> An analytics assistant is one of the clearest cases in this whole course for why "the model is not the source of truth" — the database is, and the model's job is to reach it correctly.$M26L15$
  ) returning id into v_l15;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.16 — Case Study 4: AI Analytics Assistant — Metrics and Interview Answer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 4: AI Analytics Assistant — Metrics and Interview Answer',
    16,
    $M26L16$METRICS

Quality: correct SQL/query rate, correct metric definition usage, wrong-number rate, analyst approval rate.

Product value: time to insight, dashboard usage, business user satisfaction, analyst workload reduction.

Safety: permission violation rate, unsupported-causality claim rate, data leak rate.

INTERVIEW ANSWER VERSION

"For an analytics assistant, the LLM should not be the source of truth for numbers. It should use tools to query trusted data and RAG to retrieve metric definitions. The UX should show the query, source, and metric definition. It should separate observed facts from possible explanations and avoid causal claims unless there is experiment evidence. I would measure query correctness, time to insight, analyst acceptance, wrong-number rate, and decision usefulness."

[!] "Unsupported-causality claim rate" is worth remembering as a named metric — it is specific to analytics AI and rarely appears in generic AI metric lists.

>> Notice this interview answer never mentions a specific model or vendor — it stays entirely at the level of architecture and product judgment, which is exactly what a strong PM answer should do.$M26L16$
  ) returning id into v_l16;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.17 — Case Study 5: AI Learning Coach — Product Problem and AI Solution
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 5: AI Learning Coach — Product Problem and AI Solution',
    17,
    $M26L17$PRODUCT PROBLEM

Learners often struggle because they do not know what to study next, how to practice, or where they are weak. This produces generic lessons, low engagement, no personalized practice, learners getting stuck, learners not knowing their progress, and teachers unable to personalize at scale.

AI SOLUTION

Build an AI learning coach that explains concepts, asks questions, gives practice, and adapts based on learner performance — explaining topics simply, generating practice questions, giving hints, identifying weak areas, summarizing progress, recommending the next lesson, adjusting difficulty, and providing feedback.

[!] This case study describes the exact kind of product this course itself is an example of — a lesson-and-quiz platform with adaptive elements.

>> The fifth and final case study in this module — after this, the module shifts from case studies into interview answer banks, practice questions, and templates.$M26L17$
  ) returning id into v_l17;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.18 — Case Study 5: AI Learning Coach — Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 5: AI Learning Coach — Architecture',
    18,
    $M26L18$BEST ARCHITECTURE

Use an LLM for explanation and feedback, RAG for approved course content, recommendation logic for the next lesson, user progress tracking, quiz scoring, safety filters for inappropriate content, and human/teacher review for high-stakes assessment.

[!] Grounding the coach in approved course content via RAG — rather than letting the model invent curriculum freely — is the single design choice that keeps a learning coach trustworthy.

>> This architecture combines four patterns from earlier in the course: RAG for content grounding, a recommendation system for next-lesson logic, traditional scoring for quizzes, and human review for the highest-stakes assessments.$M26L18$
  ) returning id into v_l18;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.19 — Case Study 5: AI Learning Coach — Metrics and Interview Answer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Case Study 5: AI Learning Coach — Metrics and Interview Answer',
    19,
    $M26L19$METRICS

Learning metrics: lesson completion, quiz improvement, skill mastery, practice frequency, time to understand a concept.

Engagement metrics: weekly active learners, session length, retention, return rate.

Quality metrics: explanation helpfulness, answer correctness, hallucination rate, student satisfaction.

INTERVIEW ANSWER VERSION

"For an AI learning coach, I would not let the model freely invent curriculum. I would ground it in approved course content using RAG, then use the LLM to explain, quiz, and give feedback in simple language. I would personalize based on progress and mistakes, but keep the learning path controlled. Metrics would include completion, quiz improvement, retention, helpfulness, and answer correctness."

[!] Three metric categories here — learning, engagement, quality — instead of the four used in prior case studies, because a learning coach has no real-world action risk the way a refund agent or support copilot does.

>> This closes the five-case-study arc: support copilot, knowledge assistant, refund agent, analytics assistant, learning coach — five different user problems, the same ten-step framework applied to each.$M26L19$
  ) returning id into v_l19;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.20 — Interview Answers: Choosing AI and RAG vs. Fine-Tuning
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Interview Answers: Choosing AI and RAG vs. Fine-Tuning',
    20,
    $M26L20$QUESTION: HOW WOULD YOU DECIDE WHETHER TO USE AI IN A PRODUCT?

Strong answer: "I would start with the user problem, not the technology. First, I would map the workflow and identify where users lose time, make errors, or need better decisions. Then I would ask whether AI is actually needed — for example, does the task involve language, messy input, search, summarization, prediction, recommendation, or multi-step work? If the problem can be solved with rules or normal software, I would not force AI. If AI is useful, I would define the AI role, required data, UX, success metrics, guardrails, and rollout plan."

Short version: **"AI is worth using when it improves a real workflow measurably and safely."**


QUESTION: RAG VS. FINE-TUNING — WHEN WOULD YOU USE EACH?

Strong answer: "I would use RAG when the model needs current, private, or company-specific knowledge, especially if users need citations. For example, policy Q&A should use RAG because policies change. I would use fine-tuning when the model already has the needed knowledge but needs to behave more consistently for a repeated task, such as classification, extraction, structured output, or brand tone."

[!] Simple memory: RAG gives knowledge at answer time; fine-tuning changes behavior.

>> These two questions open the interview answer bank because they are the two most commonly asked "when would you use X" questions in AI PM interviews.$M26L20$
  ) returning id into v_l20;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.21 — Interview Answers: Evaluating LLM Features and Reducing Hallucination
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Interview Answers: Evaluating LLM Features and Reducing Hallucination',
    21,
    $M26L21$QUESTION: HOW WOULD YOU EVALUATE AN LLM FEATURE?

Strong answer: "I would evaluate at three levels: output quality, system behavior, and product impact. Output quality includes factuality, completeness, relevance, tone, and format. System behavior includes whether it retrieved the right sources, used tools correctly, refused unsafe requests, and escalated risky cases. Product impact includes time saved, task completion, adoption, satisfaction, and business metrics. I would use a golden dataset, human evaluation rubric, automated checks, red-team testing, and online monitoring."


QUESTION: HOW WOULD YOU REDUCE HALLUCINATION?

Strong answer: "I would first identify where hallucination risk matters. Then I would ground the model using RAG or tools, require citations for source-based answers, instruct the model to say when information is missing, and use output validation for unsupported claims. For high-risk workflows, I would add human review. I would also test no-answer cases, conflicting-source cases, and outdated-source traps in the golden dataset."

[!] "Conflicting-source cases" and "outdated-source traps" are specific golden-dataset test types worth naming by name in an interview — generic answers rarely mention them.

>> The three-level evaluation structure — output quality, system behavior, product impact — works as a template for evaluating almost any AI feature, not just LLM ones.$M26L21$
  ) returning id into v_l21;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.22 — Interview Answers: Designing Agents Safely and Measuring ROI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Interview Answers: Designing Agents Safely and Measuring ROI',
    22,
    $M26L22$QUESTION: HOW WOULD YOU DESIGN AN AI AGENT SAFELY?

Strong answer: "I would start by mapping the workflow and classifying actions by risk. Read-only tools can be automated earlier, while write actions need approvals and audit logs. I would define scope, tool permissions, escalation rules, deterministic constraints, and rollback. I would launch in stages: internal test, shadow mode, draft-only, low-risk automation, then broader rollout. Metrics would include task completion, correct tool use, human override, unsafe action rate, cost, latency, and user satisfaction."


QUESTION: HOW WOULD YOU MEASURE ROI OF AN AI FEATURE?

Strong answer: "I would first establish the baseline: current time, cost, error rate, conversion, or satisfaction. Then I would estimate the value AI creates through productivity, quality, revenue, cost reduction, or risk reduction. I would subtract model cost, engineering cost, human review, monitoring, and maintenance. I would measure cost per successful task, not just token cost. Finally, I would validate ROI through a pilot or A/B test."

[!] "Cost per successful task, not just token cost" is a phrase worth memorizing verbatim — it is the single line most likely to distinguish a strong answer from a weak one on this question.

>> Notice the agent-safety answer's staged rollout — internal test, shadow mode, draft-only, low-risk automation, broader rollout — is the same five-stage ladder from Module 25's deployment architecture lesson.$M26L22$
  ) returning id into v_l22;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.23 — Interview Answers: Human-in-the-Loop and Building AI Products from Scratch
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Interview Answers: Human-in-the-Loop and Building AI Products from Scratch',
    23,
    $M26L23$QUESTION: WHEN SHOULD AI BE HUMAN-IN-THE-LOOP?

Strong answer: "Human-in-the-loop is important when mistakes are costly, output is customer-facing, money or access is affected, legal/compliance risk exists, or model confidence is low. For example, a support copilot can draft replies, but agents should approve before sending. Over time, if low-risk cases show consistently high accuracy, we can gradually automate them while keeping escalation for exceptions."


QUESTION: HOW WOULD YOU BUILD AN AI PRODUCT FROM SCRATCH?

Strong answer: "I would follow a structured process. First, define the user problem and workflow. Second, decide the AI role: summarize, retrieve, draft, classify, recommend, or act. Third, identify required data and source of truth. Fourth, choose architecture — prompt-only, RAG, tools, fine-tuning, or agent. Fifth, design UX with user control, sources, edits, and approval. Sixth, define metrics and guardrails. Seventh, evaluate with a golden dataset. Finally, launch gradually with monitoring and rollback."

[!] The "build an AI product from scratch" answer is just the ten-step master framework from earlier in this module, condensed to seven spoken sentences — practice saying it out loud until it's fluent.

>> "Gradually automate while keeping escalation for exceptions" is the same idea as the refund agent's tiered thresholds — a recurring pattern worth recognizing across every case study in this module.$M26L23$
  ) returning id into v_l23;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.24 — Interview Answers: Biggest AI Risks and Choosing Model Size
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Interview Answers: Biggest AI Risks and Choosing Model Size',
    24,
    $M26L24$QUESTION: WHAT ARE THE BIGGEST RISKS IN AI PRODUCTS?

Strong answer: "The biggest risks are hallucination, privacy leakage, prompt injection, unsafe tool use, bias, over-reliance, weak evaluation, and poor source quality. For agents, wrong actions are especially risky. The mitigation depends on risk level: RAG and citations for grounding, permission-aware retrieval for privacy, tool restrictions for agents, human review for high-risk cases, red-team testing, monitoring, audit logs, and a kill switch."


QUESTION: HOW WOULD YOU CHOOSE BETWEEN A SMALL MODEL AND A LARGE MODEL?

Strong answer: "I would evaluate models on the actual task, not just generic benchmarks. A large model may be better for complex reasoning or messy tasks, but a smaller model may be cheaper and faster for classification, extraction, routing, or high-volume workflows. I would compare quality, latency, cost, safety, structured output reliability, and business impact using a golden dataset. **The goal is to use the smallest, fastest, cheapest model that safely meets the quality bar.**"

[!] Notice each named risk in the first answer maps directly to a named mitigation — that pairing structure, risk then matching control, is what makes a risk answer sound rigorous instead of just alarming.

>> This closes the ten-question interview answer bank — five pairs of questions, each pairing a "how would you..." judgment question with a concrete, memorizable answer.$M26L24$
  ) returning id into v_l24;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.25 — Product Sense Practice Questions: Design and Strategy
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Product Sense Practice Questions: Design and Strategy',
    25,
    $M26L25$AI PRODUCT DESIGN QUESTIONS

Practice answering these using the ten-step framework — user problem, workflow, AI role, data needed, UX, metrics, guardrails, and rollout for each: design an AI assistant for customer support agents; design an AI tutor for middle-school students; design an AI feature for a travel planning app; design an AI copilot for sales reps; design an AI assistant for doctors to summarize patient visits; design an AI search product for internal company documents; design an AI feature for a personal finance app; design an AI shopping assistant; design an AI feature for a project management tool; design an AI feature for a recruiting platform.

[!] Do not skip straight to architecture on any of these — say the user problem out loud first, every single time, until it becomes automatic.


AI STRATEGY QUESTIONS

Practice answering: your CEO wants to "add AI" — how do you identify the best use cases? How would you prioritize AI opportunities across support, sales, product, and operations? How would you decide whether to build or buy an AI solution? How would you measure AI ROI? How would you create an AI roadmap for a SaaS company? How would you move from AI pilots to scaled AI adoption? How would you decide which AI features should be premium? How would you evaluate an AI vendor? How would you define AI governance for a startup? How would you avoid AI for AI's sake?

>> These ten design prompts and ten strategy prompts are meant to be practiced out loud, not just read — treat each one as a two-minute spoken drill.$M26L25$
  ) returning id into v_l25;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.26 — Product Sense Practice Questions: Execution, Metrics, and Technical Judgment
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Product Sense Practice Questions: Execution, Metrics, and Technical Judgment',
    26,
    $M26L26$AI EXECUTION QUESTIONS

Practice answering: your AI chatbot gives wrong answers, what do you do? Your RAG system retrieves wrong documents, how do you debug? Users do not trust AI answers, how do you improve trust? AI output is good but too slow, what do you do? AI cost is too high, what do you do? Support agents are not using the AI copilot, how do you diagnose? Your AI agent took the wrong action, what is your response plan? A fine-tuned model improved tone but reduced accuracy, what do you do? AI summary misses important details, how do you improve it? Leadership wants full automation, but quality is not ready, how do you push back?


AI METRICS QUESTIONS

Practice answering: what metrics would you use for an AI support copilot, an AI search product, an AI analytics assistant, an AI agent, and a recommendation system? What metrics would you use for AI-generated content? What guardrail metrics would you track for customer-facing AI? How would you measure hallucination rate, cost per successful task, and whether AI improves user trust?

[!] Execution questions are diagnostic — a strong answer always starts with "first, I would identify the failure mode," not with a guessed fix.


AI TECHNICAL JUDGMENT QUESTIONS

Practice answering: when would you use RAG, fine-tuning, tools, an agent, traditional ML instead of an LLM, or deterministic rules instead of AI? How do embeddings work in simple words? What is a vector database? How does a transformer help LLMs? What is the difference between prediction and causation?

>> Three question types in one lesson — execution, metrics, technical judgment — because interviewers often blend all three into a single follow-up chain after your initial case study answer.$M26L26$
  ) returning id into v_l26;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.27 — PM Answer Templates: Feature Proposal and Debugging
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Answer Templates: Feature Proposal and Debugging',
    27,
    $M26L27$TEMPLATE: AI FEATURE PROPOSAL

Use this structure when proposing any new AI feature: state the user problem, the current workflow, the AI role (summarize/retrieve/draft/classify/recommend/act), the data and tools needed, the UX, the architecture (prompt/RAG/tools/fine-tuning/agent/human review), the success metrics, the quality metrics, the guardrail metrics, the rollout plan (offline eval, shadow mode, pilot, A/B test), and the main risks with their mitigations.

[!] This template is the ten-step master framework rewritten as a fill-in-the-blank script — use it to structure any freeform "design an AI feature for X" answer under time pressure.


TEMPLATE: AI DEBUGGING ANSWER

When diagnosing a failing AI feature: first identify the failure mode — bad prompt, missing context, bad retrieval, wrong source, wrong model, tool failure, permission issue, weak UX, no human review, or poor data quality. Then inspect logs — user input, prompt version, retrieved sources, tool calls, model output, guardrail decisions, human feedback. Then fix the root cause — improve the prompt, retrieval, or chunking; add metadata filters, tools, or validation; add human review; change the model; improve source data. Finally, add test cases to the golden dataset so the failure does not repeat.

>> "Add test cases to the golden dataset so the failure does not repeat" is the line every debugging answer should end on — it shows the fix is systemic, not a one-off patch.$M26L27$
  ) returning id into v_l27;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.28 — PM Answer Templates: Safety, RAG, and Agent Answers
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Answer Templates: Safety, RAG, and Agent Answers',
    28,
    $M26L28$TEMPLATE: AI SAFETY ANSWER

First classify the risk level. If the AI affects money, access, legal, health, employment, safety, or customer communication, require stronger controls: RAG/source grounding, permission checks, human approval, tool restrictions, output validation, escalation rules, audit logs, red-team testing, monitoring, rollback, and a kill switch.

**The goal is not to block AI, but to match autonomy to evidence and risk.**


TEMPLATE: RAG ANSWER

State why RAG fits — the model needs current or company-specific knowledge. Describe the pipeline: ingest approved documents, chunk them, create embeddings, store them in a vector database, retrieve relevant chunks for the user question, answer from those sources, show citations, and refuse or escalate when sources are insufficient. Close with metrics: retrieval quality, citation correctness, answer accuracy, helpfulness, and permission failures.


TEMPLATE: AGENT ANSWER

Justify the agent only if the task is multi-step and requires tools. Define allowed tools, read vs. write actions, approval gates, escalation rules, state/memory, audit logs, rollback, and a kill switch. Start in shadow mode, then draft-only, then limited low-risk automation. Close with metrics: task completion, correct tool use, unsafe action rate, human override rate, latency, cost, and user satisfaction.

[!] These three templates — safety, RAG, agent — are the ones most likely to come up as a rapid-fire follow-up after a case study, so they benefit from being memorized as fixed shapes.

>> Five templates across these two lessons — feature proposal, debugging, safety, RAG, agent — cover nearly every follow-up question an interviewer can ask after your opening case study answer.$M26L28$
  ) returning id into v_l28;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.29 — Capstone Practice Project: The Prompt and What to Include
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Capstone Practice Project: The Prompt and What to Include',
    29,
    $M26L29$CAPSTONE: DESIGN AN AI SUPPORT COPILOT

Use this as your final practice prompt: "Design an AI support copilot for a company that receives 100,000 support tickets per month. Agents spend too much time searching policies and writing replies. Leadership wants to reduce support cost without hurting customer satisfaction."

Your answer should include: the user problem, the current workflow, the AI workflow, the architecture, the UX, the data needed, the RAG design, the tool design, the human review approach, the metrics, the guardrails, the rollout plan, the risks, an ROI estimate, and a leadership summary.

[!] Fifteen required elements is a lot to hold in your head live — write them down before you start speaking, then work through them in order.

>> This capstone deliberately reuses the support copilot scenario from the first case study in this module — the difference now is that you generate the full fifteen-part answer yourself before checking it against the sample in the next lesson.$M26L29$
  ) returning id into v_l29;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.30 — Capstone Practice Project: Sample Answer Walkthrough
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Capstone Practice Project: Sample Answer Walkthrough',
    30,
    $M26L30$Sample answer: "I would build a support copilot inside the agent console. The main user is the support agent, and the key pain is time spent reading long ticket histories, searching policy, and drafting responses. The AI should summarize the ticket, retrieve the relevant approved policy, check order/account data through tools, draft a response, and flag risky cases.

The architecture would use RAG for policy grounding, order lookup tools for live customer data, a prompt template for tone and format, output validation to block unsupported promises, and human approval before sending. I would start with draft-only mode, not full automation.

The UX would show the customer issue summary, the policy source, the draft reply, risk flags, and approve/edit/escalate options. The agent should be able to verify sources quickly and edit before sending.

Success metrics would include average handle time, resolution time, agent acceptance rate, CSAT, and cost per ticket. Quality metrics would include policy accuracy, citation correctness, edit distance, and wrong-answer rate. Guardrail metrics would include unsupported refund promises, privacy leaks, escalation misses, and unsafe output rate.

I would launch with offline evaluation on a golden dataset, then internal pilot, then shadow mode, then limited rollout to a small group of agents. If quality and CSAT stay strong, I would expand gradually. The ROI would come from time saved per ticket multiplied by ticket volume, minus model cost, review cost, monitoring, and maintenance."

[!] Compare this sample against your own capstone answer from the previous lesson — the goal is not to match it word for word, but to check that you covered all fifteen required elements.

>> This sample answer is longer than any single interview answer earlier in this module because a capstone combines all of them — feature proposal, RAG design, safety posture, and ROI — into one continuous narrative.$M26L30$
  ) returning id into v_l30;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.31 — Final Course Summary: What You Now Know
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Final Course Summary: What You Now Know',
    31,
    $M26L31$WHAT YOU NOW KNOW

After completing this course, you should be able to explain the following.

Core ML: what ML is, regression, classification, decision trees, random forests, clustering, simulation, imbalanced data, neural networks, CNNs, RNNs/LSTMs, transformers, recommendations, evaluation, deployment, and experimentation.

AI and GenAI: what AI and GenAI are, what LLMs are, prompting, RAG, embeddings, vector databases, agents, tool calling, fine-tuning, model selection, AI safety, AI UX, AI strategy, and AI architecture.

PM skills: choosing the right AI approach, defining metrics, designing AI UX, evaluating hallucination, explaining RAG, explaining agents, measuring ROI, talking to engineers, talking to leadership, and answering AI PM interview questions.

[!] If any item on these three lists feels unfamiliar, that is a signal to revisit the specific module it came from rather than move forward uncertain.

>> Twenty-five modules of technical building blocks and product judgment are now behind you — the next two lessons distill all of it down to what actually needs to stay memorized.$M26L31$
  ) returning id into v_l31;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.32 — The Most Important Ideas to Remember
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The Most Important Ideas to Remember',
    32,
    $M26L32$1. **START WITH THE PROBLEM, NOT THE MODEL.** Bad: "let's use AI." Good: "which workflow is slow, expensive, risky, or painful?"

2. **AI IS NOT ALWAYS THE ANSWER.** Sometimes use rules, traditional software, traditional ML, search, better UX, or a better process instead.

3. **RAG IS FOR KNOWLEDGE.** Use RAG when answers need trusted, current, or private sources.

4. **FINE-TUNING IS FOR BEHAVIOR.** Use fine-tuning when you need consistent output for a repeated task.

5. **TOOLS ARE FOR LIVE FACTS AND ACTIONS.** Use tools when AI needs to check systems or do work.

6. **AGENTS ARE FOR MULTI-STEP WORKFLOWS.** Use agents only when tools, state, planning, and controls are needed.

7. **EVALUATION IS NON-NEGOTIABLE.** Do not trust demos — use golden datasets, human evals, automated checks, red-team tests, and monitoring.

8. **GUARDRAILS PROTECT TRUST.** Use permissions, citations, validation, approvals, audit logs, and rollback.

9. **UX DETERMINES ADOPTION.** AI must fit naturally into the user workflow.

10. **ROI MUST BE MEASURABLE.** Measure workflow improvement, not AI feature count.

[!] These ten ideas are the load-bearing walls of this entire course — everything else is detail hung on this frame.

>> Notice these ten ideas map almost one-to-one onto the ten-step master framework from earlier in this module — that is not a coincidence, it is the same judgment restated as principles instead of steps.$M26L32$
  ) returning id into v_l32;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 26.33 — The Final Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The Final Memory Shortcut',
    33,
    $M26L33$For any AI product, remember this full chain: **user problem, then workflow, then AI role, then data/context, then architecture, then UX, then metrics, then guardrails, then rollout, then ROI.**

If you can explain these ten things clearly, for any product, in any interview, you will sound like a strong AI product manager.

[!] This is the same ten-link chain that opened this module in Lesson 1 — it opened this module and it closes it, because it is the one idea worth carrying forward above all others.

>> The final PM question: **does this AI product solve a real workflow problem better than the old way, safely, measurably, and with user trust?** Every case study, every interview answer, and every template in this module is just a different way of answering that one question.$M26L33$
  ) returning id into v_l33;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (33 total, one per lesson) — Part 1: Q1-Q17
  -- ─────────────────────────────────────────────────────────────────

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'A PM answers "how would you use AI here?" by saying "we can use GPT and vector embeddings." What does this lesson say is wrong with opening that way?',
    '["A weak AI PM answer starts with the model — a strong answer starts with the user problem, then works through workflow, AI role, data, UX, evaluation, guardrails, and business impact","Nothing is wrong — naming the specific model and technique first is the strongest way to open any AI PM answer","GPT and vector embeddings are never appropriate technology choices to mention in an interview","Starting with the model is fine as long as the answer is technically accurate"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'A candidate is asked to design an AI feature and immediately starts describing which model and which vector database to use. According to the first three steps of the master framework, what should have come first?',
    '["Defining the user problem, mapping the current workflow and its bottleneck, and choosing the AI''s specific role (summarize, retrieve, draft, classify, extract, recommend, predict, or act) before any technology is named","Choosing the model, since model selection is step 1 of the framework","Designing the UX, since interface design should always precede problem definition","Nothing needs to come first — architecture and problem definition can be decided in any order"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'A team picks RAG as their architecture before figuring out what data or context the AI actually needs. What does this lesson say about that ordering?',
    '["Architecture and UX should be chosen after data is scoped — you cannot pick RAG vs. fine-tuning vs. tools until you know what context the AI actually needs","Architecture should always be chosen first, before identifying what data or context is required","Data and context only matter for fine-tuning decisions, not for RAG or tool-calling decisions","UX should be designed before the user problem is defined, and architecture chosen after that"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'A team ships an AI feature with metrics but no plan for gradual rollout, monitoring, or a kill switch. Which steps of the master framework does this describe skipping?',
    '["Step 9, rolling out safely with offline evaluation, shadow mode, pilot, human review, A/B testing, gradual rollout, monitoring, and a kill switch, and step 10, learning and improving from feedback and monitoring","Step 1, defining the user problem, which is the only step that matters for a safe launch","Step 5, choosing architecture, since architecture choice alone determines rollout safety","None of the steps were skipped, since metrics alone are sufficient for a safe launch"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'In the support copilot case study, what is identified as the root cause of the product problem?',
    '["Support agents spend too much time reading long tickets, searching policies, and drafting replies, which causes slow response time, inconsistent answers, agent fatigue, higher support cost, and lower customer satisfaction","The company does not have a chatbot on its website, which is the primary cause of poor customer satisfaction","Agents are not using AI at all, which is inherently the root problem regardless of workflow","Customers are submitting too many tickets, and the goal is to reduce ticket volume through AI"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'In the support copilot case study, why does the lesson say the AI should not promise refunds unless policy and account data confirm eligibility, and not answer from memory?',
    '["Because RAG for approved policy, tools for order/account data, and output guardrails exist specifically to keep the copilot grounded in real sources rather than the model''s unverified memory, protecting against unsupported promises","Because customer-facing AI should never mention refunds under any circumstances, even when eligibility is confirmed by policy and account data","Because answering from memory is always more accurate than retrieving from policy documents","Because the UX design, not the architecture, is solely responsible for preventing unsupported promises"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'The support copilot interview answer covers business, quality, customer, and safety metrics. What does this lesson say about why all four categories matter together?',
    '["Covering business, quality, customer, and safety metrics together gives the full picture of an AI feature''s impact, rather than measuring only one dimension like speed or cost in isolation","Only business metrics like handle time and cost per ticket actually matter for evaluating a support copilot","Safety metrics are optional extras that can be skipped once quality metrics look acceptable","Customer metrics like CSAT are redundant once quality metrics like wrong-answer rate are tracked"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'In the internal knowledge assistant case study, what is the actual root cause behind employees wasting time searching for answers?',
    '["Knowledge is fragmented and stale — scattered across documents, wikis, Slack threads, PDFs, and old process pages — rather than any lack of underlying intelligence in the organization","Employees lack the intelligence needed to find answers on their own, regardless of how the knowledge is organized","There are too few employees to answer questions quickly, and AI is needed to add headcount","The company has no internal documentation at all, so an assistant must generate policy from scratch"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'The internal knowledge assistant''s key risks include "employees over-trusting answers." Why does this lesson call this a risk even when the system works exactly as designed?',
    '["Over-trust is a UX and communication problem, not just an accuracy problem — even a well-functioning system can be trusted more than its actual reliability warrants if the UX doesn''t clearly communicate confidence and sourcing","Over-trust is not actually a risk, and this framing was included only for completeness","This risk only applies to systems that are frequently wrong, not to well-functioning ones","Over-trust can only be solved by improving retrieval accuracy, not by any UX or communication change"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'Why does this lesson say "no-answer refusal accuracy" is a real metric for the internal knowledge assistant, not just an accuracy afterthought?',
    '["A good knowledge assistant should be measured on how well it says \"I don''t know\" when sources don''t support an answer, not only on how well it answers when sources do exist","Refusal accuracy is not actually measurable and should not be tracked as a metric","An assistant should never refuse to answer, so refusal accuracy is not a relevant concept","Refusal accuracy only matters for customer-facing assistants, not internal knowledge tools"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'In the refund agent case study, what does this lesson say about a design that tries to have the AI handle every refund request itself?',
    '["The solution deliberately separates \"handle\" from \"escalate\" — a refund agent that tries to handle everything is a liability, not a feature","Handling every refund request automatically is the ideal design, since it maximizes automation coverage","Escalation should only be used for requests the model cannot understand linguistically, not for high-risk cases","A refund agent should never be allowed to handle any case automatically, even low-risk ones"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l12,
    'The refund agent architecture enforces dollar thresholds (under $50 auto-approved, $50-$500 needs human approval, above $500 escalates). What does this lesson say is the important takeaway from this example?',
    '["The specific dollar amounts are not the important part — what matters is that a fixed rule, not the model''s judgment, decides which tier a case falls into, since thresholds should be enforced in code, not just prompts","The exact dollar thresholds of $50 and $500 are universal best practices that every refund agent should use","The LLM should decide which tier a case falls into, since it can reason about eligibility more flexibly than fixed rules","Deterministic rules are unnecessary once tool permissions and audit logs are in place"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l13,
    'The refund agent interview answer includes the line "I would enforce thresholds in code, not just prompts." What does this lesson say makes this line particularly strong in an interview?',
    '["It signals that the candidate understands prompts are not a reliable enforcement mechanism for high-stakes decisions like refund thresholds","It signals that prompts are always sufficient for enforcing any business rule, however high-stakes","It is a minor detail that does not meaningfully differentiate a strong answer from a weak one","It suggests that code-level enforcement should replace all AI involvement in the refund workflow entirely"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l14,
    'In the AI analytics assistant case study, why does this lesson say "avoid claiming causality without evidence" belongs in the solution description itself, not just in a guardrails list?',
    '["It is a core part of what makes the product trustworthy in the first place, not an add-on safety feature bolted on afterward","Causality claims are not a real risk for analytics assistants and do not need to be addressed anywhere","Guardrails are the only appropriate place to address causality claims, never the solution description","Analytics assistants should always make causal claims to be maximally useful to business users"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l15,
    'The analytics assistant architecture includes a SQL validator step between query generation and database execution. What principle does this lesson say this step demonstrates?',
    '["The model is not the source of truth for numbers — the database is, and the model''s job is to reach it correctly, so its generated queries should never touch real data unvalidated","SQL validation is an optional nice-to-have that does not affect whether the model can invent numbers","The model should be trusted to execute queries directly against production data without any intermediate validation","Validation is only useful for catching syntax errors, not for preventing the model from inventing numbers"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l16,
    'This lesson names "unsupported-causality claim rate" as a metric specific to analytics AI. What does this lesson say about how this metric compares to generic AI metric lists?',
    '["It is worth remembering as a named metric because it is specific to analytics AI and rarely appears in generic AI metric lists","It is one of the most commonly cited metrics across every type of AI product, not just analytics assistants","This metric is redundant with wrong-number rate and should not be tracked separately","This metric only applies to consumer-facing AI products, not internal analytics tools"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l17,
    'What does this lesson say makes the AI learning coach case study distinct from the other four case studies in this module?',
    '["It describes the exact kind of product this course itself is an example of — a lesson-and-quiz platform with adaptive elements","It is the only case study in the module that involves any form of retrieval or grounding","It is the only case study where human review plays any role in the architecture","It is identical in architecture and risk profile to the support copilot case study"]',
    0
  );

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (33 total, one per lesson) — Part 2: Q18-Q33
  -- ─────────────────────────────────────────────────────────────────

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l18,
    'The AI learning coach architecture grounds the coach in approved course content using RAG rather than letting the model invent curriculum freely. What does this lesson say is the effect of this design choice?',
    '["It is the single design choice that keeps a learning coach trustworthy, since the model explains and quizzes from approved content instead of generating curriculum on its own","It has no meaningful effect on trustworthiness, since any LLM can be trusted to invent accurate curriculum unaided","RAG is only useful for factual Q&A products, not for products involving explanation and feedback","Grounding in course content removes the need for any human or teacher review of assessments"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l19,
    'The AI learning coach case study uses three metric categories (learning, engagement, quality) instead of the four used in earlier case studies (business, quality, customer, safety). What does this lesson say explains the difference?',
    '["A learning coach has no real-world action risk the way a refund agent or support copilot does, so a distinct safety/action-risk metric category is not needed in the same way","The learning coach case study simply forgot to include a fourth metric category and this is an oversight","Engagement metrics are unique to the learning coach and never apply to any other type of AI product","Quality metrics do not matter for a learning coach since learning outcomes are the only relevant measure"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l20,
    'A candidate is asked "RAG vs. fine-tuning — when would you use each?" What is the strong answer''s simple memory rule from this lesson?',
    '["RAG gives knowledge at answer time, while fine-tuning changes behavior — use RAG for current, private, or company-specific knowledge, and fine-tuning for consistent output on a repeated task","RAG and fine-tuning are interchangeable and either can be used for any AI use case with equivalent results","Fine-tuning should always be used first, and RAG only added later if fine-tuning proves insufficient","RAG is only for customer-facing products, and fine-tuning is only for internal tools"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l21,
    'A candidate is asked "how would you evaluate an LLM feature?" What three levels does the strong answer in this lesson use?',
    '["Output quality (factuality, completeness, relevance, tone, format), system behavior (retrieval, tool use, refusals, escalation), and product impact (time saved, adoption, satisfaction, business metrics)","Only output quality matters; system behavior and product impact are not part of a strong evaluation answer","Cost, latency, and model size, since these are the only dimensions that matter for evaluating an LLM feature","Only product impact matters, since output quality and system behavior are implementation details outside PM scope"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l22,
    'A candidate is asked "how would you design an AI agent safely?" What staged rollout does the strong answer describe?',
    '["Internal test, then shadow mode, then draft-only, then limited low-risk automation, then broader rollout, with read-only tools automated earlier than write actions that need approvals and audit logs","Full automation from day one, since staged rollouts slow down time to value for AI agents","Draft-only mode permanently, since agents should never be allowed to take real actions","Shadow mode only, with no further stages needed once shadow mode results look acceptable"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l23,
    'A candidate is asked "how would you measure ROI of an AI feature?" What does the strong answer in this lesson say to measure cost by, and why?',
    '["Cost per successful task, not just token cost, because token cost alone ignores engineering, human review, monitoring, and maintenance costs that are part of the real cost of the feature","Token cost alone, since token cost is the only cost driver worth tracking for ROI purposes","Number of user sessions, since ROI should be measured purely by engagement rather than cost or value","Model accuracy percentage, since accuracy is a direct substitute for a full ROI calculation"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l24,
    'A candidate is asked "when should AI be human-in-the-loop?" What conditions does the strong answer in this lesson list as reasons to require human review?',
    '["When mistakes are costly, output is customer-facing, money or access is affected, legal/compliance risk exists, or model confidence is low — with gradual automation possible later for consistently accurate low-risk cases","Human-in-the-loop should be used for every single AI feature regardless of risk level, with no exceptions","Human-in-the-loop is only relevant for agents that call tools, never for features that only draft text","Once a feature launches, human review should be removed permanently regardless of ongoing accuracy"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l25,
    'This lesson lists the biggest risks in AI products (hallucination, privacy leakage, prompt injection, unsafe tool use, bias, over-reliance, weak evaluation, poor source quality) alongside matching mitigations. What structure does this lesson say makes a risk answer sound rigorous?',
    '["Pairing each named risk directly with a named mitigation — for example, RAG and citations for grounding, permission-aware retrieval for privacy, tool restrictions for agents — rather than just listing risks in isolation","Listing as many risks as possible without connecting them to specific mitigations, since breadth alone signals rigor","Focusing only on hallucination, since it is the single risk that matters most across all AI products","Avoiding any mention of mitigations, since interviewers prefer risk-only answers over risk-and-mitigation answers"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l26,
    'This lesson''s practice questions on AI product design tell candidates not to "skip straight to architecture." What does the lesson say to do instead?',
    '["Say the user problem out loud first, every single time, until stating the problem before the architecture becomes automatic","Describe the model and vector database choice first, since that establishes technical credibility early","Skip the user problem and go directly to metrics, since metrics are more concrete than problem statements","Architecture should always be described before the user problem, since it demonstrates technical depth"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l27,
    'This lesson says AI execution questions (like "your AI chatbot gives wrong answers, what do you do?") are diagnostic. What does a strong answer always start with?',
    '["\"First, I would identify the failure mode\" — rather than guessing at a fix before diagnosing what actually went wrong","A specific fix, such as switching to a larger model, without first identifying the failure mode","A recommendation to disable the AI feature entirely until the root cause is found through unrelated means","Increasing the AI feature''s budget, since more resources always resolve execution problems"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l28,
    'The AI feature proposal template in this lesson is described as being derived from something covered earlier in this module. What is it derived from?',
    '["The ten-step master framework, rewritten as a fill-in-the-blank script for structuring any freeform \"design an AI feature for X\" answer under time pressure","The five build examples from Module 25, which this template replaces entirely","A generic industry template unrelated to anything covered earlier in this course","The capstone project''s sample answer, which this template is a shortened version of"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l29,
    'The AI safety answer template says the goal of safety controls is not to block AI. What does it say the actual goal is?',
    '["To match autonomy to evidence and risk — applying stronger controls like approval, tool restrictions, and audit logs specifically when AI affects money, access, legal, health, employment, safety, or customer communication","To prevent AI from being used in any customer-facing or money-affecting workflow, regardless of evidence","To apply the same fixed set of controls uniformly to every AI feature regardless of its risk level","To eliminate human review entirely once red-team testing and monitoring are in place"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l30,
    'The capstone practice project asks candidates to design an AI support copilot with fifteen required elements. What does this lesson say to do because fifteen elements are hard to hold in your head while speaking live?',
    '["Write the fifteen elements down before you start speaking, then work through them in order","Skip several of the fifteen elements, since covering all of them in a live answer is not realistic","Memorize the sample answer from the next lesson word for word instead of generating your own answer first","Only mention the AI role and architecture, since the other thirteen elements are optional in practice"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l31,
    'The capstone sample answer walkthrough is noticeably longer than any single interview answer earlier in the module. What does this lesson say explains the length difference?',
    '["A capstone combines multiple templates — feature proposal, RAG design, safety posture, and ROI — into one continuous narrative, unlike a single-question interview answer","The sample answer is intentionally padded with unnecessary detail that should be trimmed in a real interview","Capstone answers should always be shorter than single-question interview answers, and this one is an exception to avoid","Length has no relationship to how many templates or elements an answer combines"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l32,
    'According to the "what you now know" summary, what are the three knowledge buckets this course covered?',
    '["Core ML (regression, classification, trees, neural networks, etc.), AI and GenAI (LLMs, RAG, agents, fine-tuning, safety, architecture), and PM skills (choosing approaches, defining metrics, evaluating hallucination, measuring ROI)","Only core ML topics, since the AI/GenAI and PM skills content was covered in a separate course","Only interview answers and templates, since the technical modules are not part of what should be retained","Only AI strategy and AI architecture, since those are the most recent and most PM-relevant modules"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l33,
    'What is the final ten-link memory chain and the final PM question this lesson closes the entire course with?',
    '["User problem, then workflow, then AI role, then data/context, then architecture, then UX, then metrics, then guardrails, then rollout, then ROI — closing with the question of whether the AI product solves a real workflow problem better than the old way, safely, measurably, and with user trust","Model, then architecture, then UX, then metrics — closing with the question of whether the model is the most advanced one available","Data, then model, then evaluation — closing with the question of whether the model achieves the highest possible benchmark score","UX, then adoption, then revenue — closing with the question of whether the feature can be marketed as AI-powered"]',
    0
  );

end $$;
