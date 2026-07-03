-- AI/ML for Builders — Module 25: AI System Architecture for PMs
-- 40 lessons — the full system around the model: layers, patterns, build examples, and architecture decisions

do $$
declare
  v_course_id uuid;
  v_module_id uuid;
  v_l1  uuid; v_l2  uuid; v_l3  uuid; v_l4  uuid; v_l5  uuid; v_l6  uuid;
  v_l7  uuid; v_l8  uuid; v_l9  uuid; v_l10 uuid; v_l11 uuid; v_l12 uuid;
  v_l13 uuid; v_l14 uuid; v_l15 uuid; v_l16 uuid; v_l17 uuid; v_l18 uuid;
  v_l19 uuid; v_l20 uuid; v_l21 uuid; v_l22 uuid; v_l23 uuid; v_l24 uuid;
  v_l25 uuid; v_l26 uuid; v_l27 uuid; v_l28 uuid; v_l29 uuid; v_l30 uuid;
  v_l31 uuid; v_l32 uuid; v_l33 uuid; v_l34 uuid; v_l35 uuid; v_l36 uuid;
  v_l37 uuid; v_l38 uuid; v_l39 uuid; v_l40 uuid;
begin

  select id into v_course_id from courses where sort_order = 2;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 25: AI System Architecture for PMs',
    'The full system around the model — architecture layers, retrieval and tool design, guardrails, monitoring, deployment patterns, and the decisions PMs actually need to weigh in on.',
    25
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.1 — Why This Module Matters, and the Simplest Mental Model
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Why This Module Matters: The Full System Around the Model',
    1,
    $M25L1$WHY THIS MODULE MATTERS

A lot of people think an AI product is just "user asks question, LLM answers." That is only the demo version.

A real production AI product usually needs a user interface, prompt instructions, model selection, RAG/retrieval, embeddings, a vector database, tools and APIs, memory, permissions, guardrails, human approval, logging, monitoring, evaluation, cost controls, and a rollback plan.

**An AI product is not just a model. It is a full system around the model.**

PMs do not need to build every layer themselves, but they must understand what each layer does.


THE SIMPLEST MENTAL MODEL

Think of an AI product like a restaurant. The user sees the dining area, but behind the scenes there is a kitchen, a chef, ingredients, recipes, storage, cleanliness rules, waiters, a billing system, safety checks, a manager, and a supplier process.

Same with AI. The user may see only a chatbot or button, but behind the scenes there is a prompt, a model, data, retrieval, tools, guardrails, permissions, evaluation, monitoring, logging, and human review.

[!] AI UX is the front stage. AI architecture is the backstage system that makes it reliable.

>> This module is the backstage tour — everything the user never sees, but everything that determines whether the front stage actually works.$M25L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.2 — AI Product Architecture in One Line, and the Main AI Architecture Layers
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Product Architecture in One Line, and the Main AI Architecture Layers',
    2,
    $M25L2$AI PRODUCT ARCHITECTURE IN ONE LINE

A typical AI product works like this: **user request, then app logic, then context/retrieval/tools, then model, then validation, then response/action, then logging/monitoring.**

Example: a user asks "can this customer get a refund?" The system may understand the request, check user permission, look up the order, retrieve the refund policy, build the prompt, call the model, validate the answer, require approval before action, draft the response, and log everything. That is architecture.


THE MAIN AI ARCHITECTURE LAYERS

A production AI system usually has these layers: user experience, application/backend, orchestration, prompt/instruction, model, RAG/retrieval, tool/API, memory/state, permission/security, guardrail/evaluation, monitoring/observability, and human workflow.

[!] AI architecture = UX + app + model + data + tools + safety + monitoring.

>> Twelve layers sounds like a lot, but each one maps to a lesson later in this module — think of this list as the table of contents for everything that follows.$M25L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.3 — Layer 1: User Experience Layer, and Layer 2: Application/Backend Layer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Layer 1: User Experience Layer, and Layer 2: Application/Backend Layer',
    3,
    $M25L3$LAYER 1: USER EXPERIENCE LAYER

This is what the user sees — a chat interface, copilot panel, AI button, inline suggestion, search box, draft composer, agent progress view, approval screen, source citation view.

Good AI UX should answer: what can the AI do? What input does it need? What output will it give? Can the user verify, edit, approve, reject, undo, or escalate?

[!] The UX should make AI useful, understandable, and controllable.


LAYER 2: APPLICATION/BACKEND LAYER

The backend connects the AI to the product. It handles user authentication, request routing, data fetching, session management, business logic, API calls, tool execution, response formatting, logging, rate limits, and error handling.

Example: when a user asks about an order, the backend may check who the user is, confirm they can access the order, call the order database, send the result to the AI, and return a safe answer.

>> The UX layer is the only layer this whole module the user actually sees. Every other layer, starting with the backend, exists to make that one visible layer trustworthy.$M25L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.4 — Layer 3: Orchestration Layer, and Why Orchestration Matters
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Layer 3: Orchestration Layer, and Why Orchestration Matters',
    4,
    $M25L4$LAYER 3: ORCHESTRATION LAYER

Orchestration controls the AI workflow. It decides which model to use, which prompt to use, whether retrieval is needed, which tools to call, in what order steps happen, whether human approval is needed, whether to retry or escalate, and what memory/state to keep.

Google's generative AI glossary describes orchestration as the layer that manages memory, state, decision-making, planning, tool usage, and data flow in an agent.

[!] Orchestration is the traffic controller of the AI system.


WHY ORCHESTRATION MATTERS

Without orchestration, the AI system may be too simple. Example: a user asks "can this customer get a refund?" A weak system sends the question directly to the LLM. A stronger system orchestrates: identify this as a refund workflow, retrieve policy, look up the order, check the refund threshold, ask the model to draft a recommendation, validate the policy citation, and require human approval if high value.

>> For serious AI products, the question is not only "what model?" It is "what workflow around the model?"$M25L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.5 — Layer 4: Prompt/Instruction Layer, and Layer 5: Model Layer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Layer 4: Prompt/Instruction Layer, and Layer 5: Model Layer',
    5,
    $M25L5$LAYER 4: PROMPT/INSTRUCTION LAYER

Prompts tell the model what to do. The prompt layer may include system instructions, developer/product instructions, the user prompt, retrieved context, tool results, output format, safety rules, examples, refusal rules, and tone rules.

Example prompt rule: "answer using only the retrieved policy. If the policy does not answer, say there is not enough information. Do not promise refunds."

[!] Prompts translate product policy into model behavior. But prompts are not enough for high-risk rules — important rules should also be enforced in code, permissions, and guardrails.


LAYER 5: MODEL LAYER

The model layer is the AI engine. It may include a large language model, reasoning model, small classification model, embedding model, vision model, speech model, fine-tuned model, or traditional ML model.

Different tasks need different models: summarization uses an LLM, semantic search uses an embedding model, image understanding uses a vision model, churn prediction uses a traditional ML model, product ranking uses a recommendation model, and simple routing uses a small model/classifier.

>> Do not use one model for everything. Match the model to the task.$M25L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.6 — Model Gateway, and Model Routing
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Model Gateway, and Model Routing',
    6,
    $M25L6$MODEL GATEWAY

Many AI products use a model gateway — a layer that manages access to models. It may handle model routing, fallback models, rate limits, cost tracking, logging, prompt templates, safety checks, vendor abstraction, model versioning, and latency monitoring.

Example: if Model A is too slow, route simple tasks to Model B. If a request is high-risk, route to a stronger model or human review.

[!] A model gateway helps teams control cost, reliability, and model choice.


MODEL ROUTING

Model routing means sending different requests to different models or workflows. Simple classification goes to a small/cheap model; complex reasoning goes to a stronger reasoning model; policy Q&A goes to RAG plus an LLM; live order status goes to a tool/API plus an LLM; an image question goes to a vision model; a high-risk action goes to human review; search similarity goes to an embedding model; recommendation ranking goes to a ranking model.

>> Use the cheapest, fastest, safest model that meets the quality bar.$M25L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.7 — Layer 6: RAG/Retrieval Layer, and RAG Architecture Flow
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Layer 6: RAG/Retrieval Layer, and RAG Architecture Flow',
    7,
    $M25L7$LAYER 6: RAG/RETRIEVAL LAYER

RAG means Retrieval-Augmented Generation — it lets the AI retrieve trusted information before answering. Microsoft's Azure AI Search docs describe RAG as retrieving grounding data and passing it to a language model so the model can generate responses based on your content.

The RAG layer includes document ingestion, text extraction, chunking, embeddings, vector search, keyword search, hybrid search, metadata filtering, re-ranking, source citation, and permission filtering.

[!] RAG connects the AI to trusted knowledge.


RAG ARCHITECTURE FLOW

A RAG flow usually looks like this: the user asks a question, the system creates a query embedding, search retrieves relevant chunks, metadata filters remove the wrong region/version/permission, a re-ranker improves relevance, top sources are added to the prompt, the LLM answers from sources, citations are shown, and the answer is validated.

>> Question, then retrieve evidence, then answer from evidence, then cite evidence — this is the same RAG flow covered in depth back in Module 19, now placed as one layer inside the bigger system.$M25L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.8 — Vector Database Layer, and Hybrid Search Layer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Vector Database Layer, and Hybrid Search Layer',
    8,
    $M25L8$VECTOR DATABASE LAYER

A vector database stores embeddings and helps the system search by meaning. Example: a user asks "my item arrived broken, can I get money back?" Vector search may retrieve "damaged merchandise refund eligibility policy" — even though the words differ, the meaning is similar.

The vector database may store the text chunk, embedding vector, document ID, source title, section heading, permissions, version, region, effective date, and metadata tags.

[!] Vector database = meaning-based search storage.


HYBRID SEARCH LAYER

Many AI systems use hybrid search, combining keyword search and vector search. Keyword search is good for exact terms — error code, product SKU, policy ID, contract clause, customer ID. Vector search is good for meaning — "broken item" is close to "damaged product," "cancel subscription" is close to "terminate plan."

>> Hybrid search is often better because users ask with both exact terms and natural language.$M25L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.9 — Layer 7: Tool/API Layer, and Tool Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Layer 7: Tool/API Layer, and Tool Architecture',
    9,
    $M25L9$LAYER 7: TOOL/API LAYER

Tools let AI interact with systems — search documents, query a database, look up an order, check a calendar, send email, create a ticket, update a CRM, process a refund, run code, generate a report, create a return label.

Tools can be read tools (fetch information) or write tools (change something).

[!] Tools turn AI from a talker into a worker.


TOOL ARCHITECTURE

A tool needs a name, description, input schema, output schema, permissions, error handling, risk level, logging, rate limits, and an owner.

Example: tool lookup_order, inputs order_id and customer_id, outputs delivery date, item status, order value, and return eligibility flags. Risk is low to medium if read-only.

PM question: **"Is every tool clearly defined, permissioned, and logged?"**

>> Every field in a tool definition maps to a question a PM should be able to answer for any tool in their product — if you cannot fill in the schema, the tool is not ready.$M25L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.10 — Read Tools vs. Write Tools, and Tool Permission Layer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Read Tools vs. Write Tools, and Tool Permission Layer',
    10,
    $M25L10$READ TOOLS VS. WRITE TOOLS

Read tools are lower risk — read policy, look up order, search docs, query analytics, check calendar availability. Write tools are higher risk — send email, issue refund, cancel order, update account, delete record, approve claim, modify billing.

[!] Read tools can often be automated earlier. Write tools need stronger controls.


TOOL PERMISSION LAYER

The tool permission layer decides what AI can access or do. Questions: can this user access this data? Can this AI workflow use this tool? Does this action require approval? Is the action reversible? Is the amount below threshold? Is the case low-risk? Is the user authorized?

Example: AI can draft a refund recommendation, but AI cannot issue a refund above $100 without human approval.

>> Agent permissions should be narrower than human admin permissions.$M25L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.11 — Layer 8: Memory/State Layer, and Why State Matters
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Layer 8: Memory/State Layer, and Why State Matters',
    11,
    $M25L11$LAYER 8: MEMORY/STATE LAYER

Memory and state help the AI know what has happened. Conversation memory is what has been said in this chat. User memory is user preferences or stable facts. Workflow state is the current step in a task — example, order checked, policy retrieved, waiting for approval. Agent memory is what the agent has done, what tools it called, and what result it got.

[!] Memory helps continuity. State helps workflow control.


WHY STATE MATTERS

Imagine an agent processing a refund. Without state, it may forget which order it checked, which policy was retrieved, whether approval was already requested, whether a return label was created, or whether the customer was notified. That can create duplicate actions or confusion.

Good state management prevents repeated tool calls, duplicate refunds, lost workflow progress, wrong next steps, and inconsistent output.

>> How does the system know where it is in the workflow? Ask that question for any multi-step AI feature before it ships.$M25L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.12 — Memory Privacy, and Layer 9: Permission/Security Layer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Memory Privacy, and Layer 9: Permission/Security Layer',
    12,
    $M25L12$MEMORY PRIVACY

Memory can be useful but risky. Questions: what is stored, and why? How long is it stored? Can the user edit or delete it? Does memory include sensitive data? Who can access it? Is it used for training? Is consent needed?

[!] Memory should be useful, visible, and controllable — not creepy.


LAYER 9: PERMISSION/SECURITY LAYER

The permission/security layer protects users, data, and systems. It handles authentication, authorization, role-based access, document permissions, tool permissions, data masking, sensitive-data detection, secrets management, audit logs, abuse prevention, and prompt injection defense.

NIST's AI Risk Management Framework is designed to help organizations manage AI risks to individuals, organizations, and society.

>> AI should follow the same security rules as the rest of the product — often stricter.$M25L12$
  ) returning id into v_l12;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.13 — Permission-Aware Retrieval, and Data Masking
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Permission-Aware Retrieval, and Data Masking',
    13,
    $M25L13$PERMISSION-AWARE RETRIEVAL

Permission-aware retrieval means AI retrieves only sources the user can access. Example: a customer-facing bot should not retrieve internal policy notes, a sales rep should not retrieve HR compensation documents, and a regional manager should not retrieve another region's confidential plans.

PM question: **"Does retrieval check permissions before sources enter the prompt?"**

[!] Do not only filter after generation. If restricted content enters the prompt, the risk already exists.


DATA MASKING

Data masking means hiding or replacing sensitive information — replace a full SSN with the last 4 digits, hide a credit card number, remove medical details, redact employee salary, mask a customer email, remove API keys.

Use masking when the model does not need exact sensitive data, logs may be viewed by humans, third-party systems are involved, or training/evaluation data is being created.

>> Do not send the model sensitive data unless the task truly needs it.$M25L13$
  ) returning id into v_l13;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.14 — Layer 10: Guardrail/Evaluation Layer, and Input Guardrails
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Layer 10: Guardrail/Evaluation Layer, and Input Guardrails',
    14,
    $M25L14$LAYER 10: GUARDRAIL/EVALUATION LAYER

Guardrails help keep AI safe and reliable. Evaluation checks whether AI is good enough. Guardrails may happen before input reaches the model, during retrieval, during tool use, after model output, before the user sees the answer, or before an action is taken.

Examples: block an unsafe request, filter restricted sources, validate JSON, check citations, block an unsupported refund promise, require human approval, detect a private data leak, prevent a duplicate action.

[!] Guardrails are product rules made enforceable.


INPUT GUARDRAILS

Input guardrails check the user request before AI responds. Is the request allowed? Is the user trying prompt injection? Is private data included? Is the request out of scope or harmful? Does the user have permission?

Example: a user asks "show me confidential salary data" — the input guardrail should block this.

>> Should this request enter the AI workflow at all? That question belongs at the very front of the pipeline, before retrieval or the model ever sees the request.$M25L14$
  ) returning id into v_l14;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.15 — Output Guardrails, and Action Guardrails
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Output Guardrails, and Action Guardrails',
    15,
    $M25L15$OUTPUT GUARDRAILS

Output guardrails check the AI response before display or action — check hallucination risk, unsupported claims, citation correctness, private data leakage, unsafe content, tone, required format, and policy compliance.

Example: AI says "we guarantee refund approval" — the output guardrail blocks it because policy does not support that promise.

[!] Output guardrails catch mistakes before users see them.


ACTION GUARDRAILS

Action guardrails control real-world actions: require approval before sending email, block a refund above a threshold, prevent a duplicate payment, validate the target customer, confirm before deleting data, log all tool calls, enforce idempotency, allow rollback.

>> The closer AI gets to taking action, the stronger the guardrails must be — input guardrails are the first line of defense, output guardrails the second, and action guardrails the last line before real-world consequences.$M25L15$
  ) returning id into v_l15;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.16 — Evaluation Harness, and Layer 11: Monitoring/Observability Layer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Evaluation Harness, and Layer 11: Monitoring/Observability Layer',
    16,
    $M25L16$EVALUATION HARNESS

An evaluation harness is a system for testing AI quality repeatedly. It may include a golden dataset, test prompts, expected outputs, human review rubrics, automated checks, regression tests, safety tests, prompt injection tests, RAG retrieval tests, agent tool-use tests, and cost/latency checks.

[!] Evaluation harness = repeatable AI quality testing machine.


LAYER 11: MONITORING/OBSERVABILITY LAYER

After launch, AI systems must be monitored. OpenAI's production guidance includes production concerns such as scaling, security, and cost management.

AI monitoring may track latency, cost, token usage, error rate, model version, prompt version, retrieval quality, tool failures, user feedback, hallucination reports, safety incidents, escalations, human overrides, drift, and prompt injection attempts.

>> AI monitoring tells you whether the system is still working after launch — evaluation proves readiness once, monitoring proves it continues to hold up over time.$M25L16$
  ) returning id into v_l16;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.17 — Observability, and Layer 12: Human Workflow Layer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Observability, and Layer 12: Human Workflow Layer',
    17,
    $M25L17$OBSERVABILITY

Observability means the team can inspect what happened. For AI, observability should show the user request, prompt used, retrieved documents, tool calls, tool results, model response, guardrail decisions, final output, human approval, errors, cost, and latency.

PM question: **"If something goes wrong, can we reconstruct why?"** Without observability, AI failures become difficult to debug.


LAYER 12: HUMAN WORKFLOW LAYER

AI architecture must include humans. Humans may review outputs, approve actions, handle escalations, correct errors, label data, improve prompts, update the knowledge base, monitor quality, and investigate incidents.

Example, support copilot: AI drafts, the agent approves, QA reviews samples, the PM monitors wrong-answer rate, and the policy team updates sources.

[!] Human-in-the-loop is part of architecture, not an afterthought.

>> Observability is what makes the human workflow layer actually possible — a human reviewer or incident investigator can only do their job if the system shows them what happened.$M25L17$
  ) returning id into v_l17;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.18 — The Complete AI Request Flow
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The Complete AI Request Flow',
    18,
    $M25L18$A strong AI product request flow may look like this: the user submits a request, the app checks authentication and permissions, the orchestrator identifies intent, the system chooses a workflow, retrieval fetches relevant sources, tools fetch live data if needed, the prompt is assembled, the model generates an answer or plan, output guardrails validate the response, action guardrails check tool actions, human approval is requested if needed, the user sees the answer or approves the action, the system logs sources/tools/model/prompt/cost/result, and monitoring tracks quality and failures.

[!] Authenticate, then retrieve/tool, then prompt/model, then validate, then approve/action, then log/monitor.

>> This fifteen-step flow is every layer from this module so far, assembled into the order they actually execute in — read it as the connective tissue between all the individual layers.$M25L18$
  ) returning id into v_l18;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.19 — Architecture Pattern 1: Prompt-Only AI, and Pattern 2: RAG AI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Architecture Pattern 1: Prompt-Only AI, and Pattern 2: RAG AI',
    19,
    $M25L19$PATTERN 1: PROMPT-ONLY AI

The simplest pattern. Flow: user input, then prompt, then model, then output. Good for rewriting, brainstorming, drafting, summarizing provided text, and low-risk personal productivity. Weakness: no external knowledge, no live data, higher hallucination risk, limited control.

PM use case: "rewrite this message professionally" — no RAG or tools needed.

[!] Prompt-only is fine when the user provides all needed context and risk is low.


PATTERN 2: RAG AI

Flow: user input, then retrieval, then sources, then prompt, then model, then answer with citations. Good for internal knowledge search, product docs Q&A, policy assistant, contract Q&A, and support knowledge assistant.

Microsoft's RAG documentation explains how retrieval can ground LLM responses using your content. Weakness: depends on source quality, retrieval can fail, citations may be wrong, permissions matter, and the knowledge base must be maintained.

>> Use RAG when the AI must answer from trusted documents.$M25L19$
  ) returning id into v_l19;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.20 — Architecture Pattern 3: Tool-Using AI, and Pattern 4: Agentic AI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Architecture Pattern 3: Tool-Using AI, and Pattern 4: Agentic AI',
    20,
    $M25L20$PATTERN 3: TOOL-USING AI

Flow: user input, then orchestrator, then tool call, then tool result, then model, then answer/action. Good for order lookup, analytics queries, calendar scheduling, CRM updates, report generation, and account status checks. Weakness: tool failure risk, permission complexity, security risk, action risk, need for logs and approvals.

[!] Use tools when the AI needs live data or needs to do something.


PATTERN 4: AGENTIC AI

Flow: goal, then plan, then tools/retrieval, then observe, then next step, then approval/action, then complete. Good for multi-step workflows, support resolution, IT helpdesk, sales prep, vendor onboarding, document intake, and workflow automation.

Google Cloud describes AI agents as systems that use AI to pursue goals and complete tasks with reasoning, planning, memory, and autonomy. Weakness: harder to test, higher risk, more tool failures, more monitoring needed, more approval design needed.

>> Use agents when the task is multi-step and tool-based, not just Q&A.$M25L20$
  ) returning id into v_l20;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.21 — Architecture Pattern 5: Human-in-the-Loop AI, and Pattern 6: Batch AI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Architecture Pattern 5: Human-in-the-Loop AI, and Pattern 6: Batch AI',
    21,
    $M25L21$PATTERN 5: HUMAN-IN-THE-LOOP AI

Flow: AI output, then human review, then approve/edit/reject, then final action. Good for customer-facing replies, legal/compliance summaries, high-value refunds, finance workflows, medical/health workflows, and sensitive decisions. Weakness: slower, requires reviewer time, may reduce automation ROI, needs review UX.

[!] Use human-in-the-loop when mistakes are costly but AI can still save preparation time.


PATTERN 6: BATCH AI

Batch AI runs on a schedule — nightly customer summaries, weekly business reports, daily risk scoring, monthly document processing, bulk feedback analysis. Good for lower latency pressure, large volumes, scheduled workflows, cost control, and human review before release. Weakness: not real-time, may use stale data, needs scheduling/monitoring.

>> Use batch AI when real-time response is not needed.$M25L21$
  ) returning id into v_l21;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.22 — Architecture Pattern 7: Real-Time AI, and Pattern 8: Edge/On-Device AI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Architecture Pattern 7: Real-Time AI, and Pattern 8: Edge/On-Device AI',
    22,
    $M25L22$PATTERN 7: REAL-TIME AI

Real-time AI responds during user interaction — chat assistant, live support copilot, search answer, checkout recommendation, meeting copilot, real-time agent. Good for interactive UX, immediate help, personalization, dynamic workflows. Weakness: latency matters, cost can spike, reliability must be high, fallbacks are important.

[!] Real-time AI must be fast enough for the moment where it appears.


PATTERN 8: EDGE/ON-DEVICE AI

Some AI runs locally on the user's device or edge environment. Useful when privacy is important, latency must be low, internet may be unavailable, data should stay local, or cloud call cost is high — on-device summarization, local speech recognition, camera/image AI, offline assistant features. Weakness: smaller models, device limitations, harder updates, lower quality.

>> On-device AI trades some model power for privacy, speed, and local control.$M25L22$
  ) returning id into v_l22;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.23 — Architecture Pattern 9: Multi-Agent AI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Architecture Pattern 9: Multi-Agent AI',
    23,
    $M25L23$Multi-agent systems use multiple specialized agents — example, a research agent, a data agent, a policy agent, a drafting agent, and a reviewer agent.

Google Cloud's agentic architecture guidance says designing agentic AI architecture is iterative and involves choosing suitable components for the application and workload.

Good for complex workflows, specialized subtasks, review loops, and research-heavy work. Weakness: hard to debug, more latency, more cost, coordination failures, more monitoring needed.

[!] Use multi-agent systems only when one well-designed workflow is not enough.

>> This is the ninth and most complex pattern in this lesson set — it is the last resort, not the default, and every weakness listed compounds the more agents you add.$M25L23$
  ) returning id into v_l23;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.24 — Build Example: Support Copilot Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Build Example: Support Copilot Architecture',
    24,
    $M25L24$Use case: a support agent wants help replying to a customer.

Architecture: the user opens the ticket, the AI sees the ticket text and customer context, an intent classifier detects the issue type, RAG retrieves approved policy, an order lookup tool fetches order status, the prompt asks the model to draft a response, an output guardrail checks for unsupported promises, the agent sees the draft, source, and warning flags, the agent edits and approves, and the system logs the final reply and AI usage.

Metrics: agent acceptance, resolution time, CSAT, wrong-answer rate, policy compliance, escalation accuracy.

[!] This is not just a chatbot. It is an integrated support workflow.

>> Notice this single example touches nearly every layer from this module — orchestration, RAG, tools, prompt, output guardrails, human review, and logging — all in ten steps.$M25L24$
  ) returning id into v_l24;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.25 — Build Example: Internal Knowledge Assistant Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Build Example: Internal Knowledge Assistant Architecture',
    25,
    $M25L25$Use case: employees ask questions across company docs.

Architecture: documents are ingested, text is extracted and chunked, embeddings are created, chunks are stored in the vector database, metadata includes owner/version/permissions, the user asks a question, the system checks user permissions, hybrid search retrieves relevant chunks, the LLM answers from sources, citations are shown, and feedback is collected.

Metrics: search success, time to answer, citation correctness, answer helpfulness, source click-through, reduced repeated questions.

[!] Knowledge assistants depend as much on document quality as model quality.

>> Notice how many of these eleven steps happen before a single user ever asks a question — ingestion, chunking, embedding, and metadata tagging are all indexing-phase work that determines whether the later retrieval steps can succeed.$M25L25$
  ) returning id into v_l25;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.26 — Build Example: AI Analytics Assistant Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Build Example: AI Analytics Assistant Architecture',
    26,
    $M25L26$Use case: a business user asks questions about metrics.

Architecture: the user asks a question, the system identifies metric intent, RAG retrieves metric definitions, a SQL generation tool creates a query, a SQL validator checks syntax and permissions, the database executes the query, the model summarizes the result, the output separates facts from hypotheses, analyst review is required for executive reports, and the system logs the query, data source, and answer.

Metrics: query correctness, time to insight, analyst acceptance, wrong-number rate, user satisfaction, decision usefulness.

[!] Analytics AI should never invent numbers. It must use real data tools.

>> The SQL validator step is doing the same job as an output guardrail from earlier in this module — checking the model's work before it reaches a real database or a real business decision.$M25L26$
  ) returning id into v_l26;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.27 — Build Example: Refund Agent Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Build Example: Refund Agent Architecture',
    27,
    $M25L27$Use case: AI helps process low-risk refund requests.

Architecture: the customer request is received, intent is detected as a refund, an order lookup tool checks the order, policy RAG retrieves the refund policy, eligibility logic checks deterministic rules, the model drafts a recommendation and customer message, a guardrail checks the amount threshold, low-risk cases may proceed with approval, high-risk cases escalate, and the audit log records every step.

Metrics: correct eligibility decisions, resolution time, refund error rate, CSAT, escalation quality, unsafe action rate.

[!] For action agents, deterministic rules and approvals matter as much as the model.

>> Notice "eligibility logic checks deterministic rules" sits right alongside the model-drafted recommendation — this is the same "use rules for hard constraints, AI for messy interpretation" principle from earlier modules, applied at the architecture level.$M25L27$
  ) returning id into v_l27;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.28 — Build Example: AI Document Processing Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Build Example: AI Document Processing Architecture',
    28,
    $M25L28$Use case: process invoices or contracts.

Architecture: the user uploads a document, OCR/text extraction runs, the document type is classified, relevant fields are extracted, field confidence is calculated, values are validated against rules/database, a human reviews low-confidence/high-value cases, final structured data is saved, and the audit trail links fields to source text.

Metrics: field accuracy, missing-field rate, human correction rate, processing time, cost per document, compliance errors.

[!] Document AI needs traceability from extracted value back to source.

>> Five build examples across this module now cover support, internal knowledge, analytics, agents, and documents — each uses a different combination of the same twelve architecture layers, tailored to its own risk profile.$M25L28$
  ) returning id into v_l28;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.29 — Data Flow Matters, and Latency Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Data Flow Matters, and Latency Architecture',
    29,
    $M25L29$DATA FLOW MATTERS

PMs should understand what data flows through the AI system. Ask: what user input enters the model? What documents are retrieved? What customer data is included? What tool outputs are included? What gets stored in logs? What gets sent to external vendors? What is used for evaluation? What is retained? What can be deleted?

[!] Data flow is where privacy, security, and compliance risks become real.


LATENCY ARCHITECTURE

Latency means how long the user waits. It depends on model speed, prompt length, output length, retrieval time, tool calls, number of steps, guardrail checks, network calls, and human approval.

Ways to reduce latency: use a smaller model for easy tasks, cache common responses, retrieve fewer but better chunks, stream low-risk outputs, run tool calls in parallel, use batch processing where possible, shorten prompts, limit output length.

PM question: **"How fast does this AI need to be for this UX moment?"**

>> Data flow and latency are both consequences of the same architecture decisions made earlier in this module — every extra retrieval step or tool call adds both risk and time.$M25L29$
  ) returning id into v_l29;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.30 — Cost Architecture, and Reliability Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Cost Architecture, and Reliability Architecture',
    30,
    $M25L30$COST ARCHITECTURE

AI cost includes more than model usage: input tokens, output tokens, model calls, embedding calls, vector database, tool/API calls, cloud infrastructure, human review, evaluation, monitoring, logging, vendor licenses, and engineering maintenance.

[!] Measure cost per successful task, not just cost per model call.


RELIABILITY ARCHITECTURE

AI systems can fail in many ways: model unavailable, rate limit hit, tool API down, retrieval returns a bad source, prompt too long, output invalid, guardrail blocks too much, latency timeout, cost spike, human review queue overloaded.

Reliability controls: fallback model, retry logic, timeout handling, graceful degradation, queueing, cached answers, read-only mode, manual fallback, kill switch.

>> AI products need failure design just like normal software.$M25L30$
  ) returning id into v_l30;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.31 — Fallback Design, and Logging Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fallback Design, and Logging Architecture',
    31,
    $M25L31$FALLBACK DESIGN

Fallback means what happens when AI cannot complete the task. Examples: "I could not access the order system. Please try again or enter details manually." "The policy source is unavailable. Escalating to human review." "I cannot answer from the available documents." "Draft-only mode is available; auto-action is disabled." "Using previous stable model because current model is unavailable."

[!] Fallback should keep the workflow moving safely.


LOGGING ARCHITECTURE

Logs should capture the request ID, user ID or anonymized ID, timestamp, prompt version, model version, retrieved sources, tool calls, tool outputs, final answer, guardrail decisions, human approvals, errors, latency, and cost.

But logs must not expose unnecessary sensitive data.

PM question: **"Can we debug incidents without creating privacy risk in logs?"**

>> Fallback design is the reliability lesson's action plan for when things fail; logging is what makes it possible to figure out why they failed in the first place.$M25L31$
  ) returning id into v_l31;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.32 — Audit Architecture, and Versioning Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Audit Architecture, and Versioning Architecture',
    32,
    $M25L32$AUDIT ARCHITECTURE

Audit matters when AI affects important workflows. Audit logs should answer: who requested the action? What did AI see? What sources did AI use? What tools did AI call? What decision did AI make? Who approved it? What action was taken? Can it be reversed? What model/prompt version was used?

[!] If AI affects money, access, policy, or customer communication, auditability is mandatory.


VERSIONING ARCHITECTURE

AI systems have many versioned parts: model version, prompt version, RAG index version, embedding model version, chunking strategy, tool version, guardrail version, fine-tuned model version, evaluation dataset version, workflow version.

When AI output changes, you need to know what changed.

>> Without versioning, debugging becomes guesswork.$M25L32$
  ) returning id into v_l32;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.33 — Evaluation Architecture, and Deployment Architecture
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Evaluation Architecture, and Deployment Architecture',
    33,
    $M25L33$EVALUATION ARCHITECTURE

Evaluation should be built into the system, not treated as a one-time spreadsheet. Components: golden dataset, automated checks, human review workflow, A/B testing, regression testing, safety testing, RAG retrieval testing, agent tool-use testing, dashboards, alerting.

[!] Evaluation should be an operating system for quality, not a one-time check.


DEPLOYMENT ARCHITECTURE

Deployment is how AI changes go live. AI deployment may include prompt deployment, model deployment, RAG index update, tool permission update, guardrail update, workflow change, or UI change.

Safe deployment practices: internal testing, shadow mode, canary rollout, A/B test, phased rollout, monitoring, rollback.

>> AI changes should roll out gradually because behavior can change unexpectedly.$M25L33$
  ) returning id into v_l33;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.34 — Shadow Mode, and Canary Rollout
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Shadow Mode, and Canary Rollout',
    34,
    $M25L34$SHADOW MODE

Shadow mode means AI runs in the background without affecting users. Example: a refund agent recommends actions, but humans still decide. Compare the AI recommendation, the human action, the agreement rate, error type, potential time saved, and risky mistakes.

[!] Shadow mode lets you learn before giving AI power.


CANARY ROLLOUT

Canary rollout means releasing to a small portion of users first. Example: 1% of support tickets use the AI copilot, then 5%, then 25%, then full rollout.

Use canary when risk exists, a new model is deployed, a new workflow is launched, a new agent action is introduced, or you want early warning.

>> Canary rollout reduces blast radius — shadow mode reduces it to zero for the first phase, and canary reduces it further gradually once real actions begin.$M25L34$
  ) returning id into v_l34;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.35 — Kill Switch, and Architecture and Compliance
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Kill Switch, and Architecture and Compliance',
    35,
    $M25L35$KILL SWITCH

A kill switch turns off the AI feature or risky capability — disable auto-send, disable the refund tool, switch to draft-only mode, disable a retrieval source, roll back the model, route all cases to human review.

PM question: **"If this AI starts causing harm, how fast can we stop it?"**


ARCHITECTURE AND COMPLIANCE

Some AI products need legal/compliance review, especially when AI affects money, employment, healthcare, credit, insurance, legal decisions, identity, education access, safety, customer rights, or personal data.

NIST's AI RMF is intended to improve the ability to incorporate trustworthiness considerations into the design, development, use, and evaluation of AI products, services, and systems.

[!] High-impact AI needs stronger architecture, documentation, and governance.

>> A kill switch is the last-resort control for any single feature. Compliance review is the upfront check for whether a feature needed all of these controls (kill switch included) before it ever launched.$M25L35$
  ) returning id into v_l35;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.36 — Architecture Decision: Cloud vs. Self-Hosted, and Single Model vs. Multi-Model
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Architecture Decision: Cloud vs. Self-Hosted, and Single Model vs. Multi-Model',
    36,
    $M25L36$CLOUD VS. SELF-HOSTED

A cloud/API model is fast to start, offers strong models, needs less infrastructure, has managed scaling, and is easier to experiment with — but comes with vendor dependency, data review needs, usage cost, and less low-level control.

A self-hosted model offers more control, data locality, potential cost advantage at scale, and custom deployment — but comes with infrastructure complexity, model ops burden, security patching, scaling effort, and a need for ML expertise.

PM question: **"Do we need speed, control, privacy, cost efficiency, or customization most?"**


SINGLE MODEL VS. MULTI-MODEL

A single model is simpler — good for a prototype, a narrow use case, or low complexity. Multi-model is more flexible — good for different task types, cost optimization, specialized workflows, routing by complexity, and backup/fallback.

[!] Start simple, but design for routing if use cases grow.$M25L36$
  ) returning id into v_l36;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.37 — Architecture Decision: Generic Assistant vs. Workflow AI, and Chat vs. Embedded AI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Architecture Decision: Generic Assistant vs. Workflow AI, and Chat vs. Embedded AI',
    37,
    $M25L37$GENERIC ASSISTANT VS. WORKFLOW AI

A generic assistant is broad and flexible, but risks being vague and hard to measure. Workflow AI is narrow and integrated — example, "draft policy-grounded support replies inside the ticket console" — and is better because it has a clear user, clear input, clear output, clear metric, easier evaluation, and easier guardrails.

[!] Workflow AI is usually easier to make valuable than a generic assistant.


CHAT VS. EMBEDDED AI

Chat is good for broad exploration, Q&A, and open-ended help. Embedded AI is good for a specific workflow, faster action, lower user effort, better context, and easier measurement — examples: a summarize button, draft reply panel, inline autocomplete, smart checklist, approval workflow.

>> The best AI interface is often not chat. It is AI embedded where work happens.$M25L37$
  ) returning id into v_l37;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.38 — Architecture Decision: Automation vs. Augmentation, and Deterministic Rules vs. AI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Architecture Decision: Automation vs. Augmentation, and Deterministic Rules vs. AI',
    38,
    $M25L38$AUTOMATION VS. AUGMENTATION

Augmentation means AI helps the human — draft, suggest, summarize, recommend, explain. Automation means AI completes the task — auto-route a ticket, auto-fill a form, auto-create a report, auto-process a low-risk refund.

Use augmentation when risk is high, quality is not proven, or human judgment matters. Use automation when the task is low-risk, rules are clear, evaluation is strong, monitoring exists, and mistakes are recoverable.

[!] Start with augmentation. Move to automation after evidence.


DETERMINISTIC RULES VS. AI

Use deterministic rules when logic is clear, output must be exact, regulation requires fixed behavior, rules are easy to maintain, and the same input should always produce the same output. Use AI when input is messy, language understanding is needed, judgment is needed, similarity/search matters, or drafting/summarizing is needed.

Best systems often combine both — example: AI reads the customer request, rules enforce the refund threshold, a human approves the exception.

>> Use AI for messy interpretation. Use rules for hard constraints.$M25L38$
  ) returning id into v_l38;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.39 — PM Architecture Review Questions, and PM Checklist for AI Architecture Readiness
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Architecture Review Questions, and PM Checklist for AI Architecture Readiness',
    39,
    $M25L39$PM ARCHITECTURE REVIEW QUESTIONS

When reviewing AI architecture, ask: what is the user workflow, and what is the AI's role? What data enters the model, and what sources does it retrieve? What tools can it call, and what actions can it take? What permissions apply? What happens if retrieval fails, a tool fails, or the model is wrong? What guardrails exist, and what requires human approval? What is logged? How is quality evaluated, and how are cost and latency monitored? How is privacy protected? How do we roll back, and what is the kill switch? Who owns the system after launch?


PM CHECKLIST FOR AI ARCHITECTURE READINESS

Before launch, check: UX is clear, user permissions are enforced, sources are approved, retrieval is tested, prompt is versioned, model is selected based on task, tools are documented, tool permissions are limited, human approval exists for risky actions, guardrails are tested, a golden dataset exists, a monitoring dashboard exists, logs are safe and useful, a rollback plan exists, a kill switch exists, cost estimate is clear, latency meets the UX requirement, privacy/security review is complete, an incident response owner is named, and success metrics are defined.

[!] These two lists are the practical distillation of this entire module — every question maps back to a layer or lesson already covered.

>> The review questions are for evaluating an architecture in progress; the readiness checklist is the final gate before launch — use the first while designing, the second right before shipping.$M25L39$
  ) returning id into v_l39;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 25.40 — How to Explain AI Architecture to Leadership, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'How to Explain AI Architecture to Leadership, and the Memory Shortcut',
    40,
    $M25L40$HOW TO EXPLAIN AI ARCHITECTURE TO LEADERSHIP

Simple explanation: "an AI product is not just a model. It is a system that includes user experience, prompts, model selection, retrieval, tools, permissions, guardrails, human review, logging, monitoring, and evaluation. The architecture determines whether the AI can be trusted in production."

Support example: "for the support copilot, the model is only one part. The system must retrieve approved policy, check order data through tools, draft a response, show citations, block unsupported promises, require agent approval before sending, and monitor wrong-answer rate and CSAT after launch."

Agent example: "for the refund agent, architecture risk is higher because the AI can take action. We need deterministic refund thresholds, permission-limited tools, human approval for high-value cases, audit logs, rollback, and a kill switch."


THE MEMORY SHORTCUT

AI architecture is the full system that makes AI useful, safe, and reliable.

Remember: UX, then orchestration, then prompt, then model, then retrieval, then tools, then permissions, then guardrails, then human review, then monitoring.

Use prompt-only when risk is low, the user provides all context, and the task is drafting/rewrite/brainstorming. Use RAG when AI needs trusted documents, citations matter, or knowledge changes. Use tools when AI needs live data or needs to take action. Use agents when the workflow is multi-step and tools and planning are needed. Use human-in-the-loop when risk is high or output affects users, money, access, safety, or compliance.

Watch out for treating the model as the full product, no permissions, no source governance, no tool controls, no evaluation, no logging, no rollback, no kill switch, weak monitoring, and over-automation.

[!] This module closes the entire AI/GenAI arc that began in Module 16 — every capability covered since then (LLMs, prompting, RAG, agents, fine-tuning, evaluation, safety, UX, strategy) is a piece of the architecture this module just assembled into one system.

>> The most important PM question: does the architecture give the AI the right context, tools, controls, and monitoring to solve the workflow safely in production?$M25L40$
  ) returning id into v_l40;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (40 total, one per lesson) — Part 1: Q1-Q20
  -- ─────────────────────────────────────────────────────────────────

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'A PM describes their AI product as "the user asks a question and the LLM answers." What does this lesson say is missing from that description?',
    '["That is only the demo version — a real production AI product is a full system around the model, including UX, prompt instructions, retrieval, tools, memory, permissions, guardrails, monitoring, and a rollback plan","Nothing is missing — that description fully captures what a production AI product needs","The description is too complex and should be simplified further","Adding more layers around the model always makes the product worse"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'A team maps their AI product as "user request, then app logic, then context/retrieval/tools, then model, then validation, then response/action, then logging/monitoring." What does this lesson call this kind of layered structure?',
    '["AI product architecture — a production AI system typically has around twelve layers spanning UX, application, orchestration, prompts, models, retrieval, tools, memory, permissions, guardrails, monitoring, and human workflow","This is unnecessary complexity and a single model call would be equivalent","This structure only applies to consumer chatbots, not enterprise AI products","Architecture layers are optional documentation and do not affect how the system behaves"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'A backend team asks why they need to build authentication, routing, and business logic around the AI model instead of just calling the model directly from the frontend. What does this lesson say the application/backend layer is for?',
    '["It connects the AI to the product — handling authentication, request routing, data fetching, session management, business logic, tool execution, and error handling, so the one visible UX layer becomes trustworthy","The backend layer is unnecessary if the UX layer is well designed","Authentication and business logic belong in the model layer, not the backend","Direct frontend-to-model calls are the recommended architecture for production AI products"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'For a refund question, a weak system sends the question straight to the LLM, while a stronger system identifies it as a refund workflow, retrieves policy, checks the order, and requires approval for high-value cases. What layer is responsible for this kind of workflow control?',
    '["The orchestration layer — it decides which model and prompt to use, whether retrieval or tools are needed, what order steps happen in, and whether human approval is required, acting as the traffic controller of the AI system","The user experience layer, since orchestration is a visual design concern","No layer is responsible — orchestration happens automatically inside any LLM","The model layer, since orchestration is a property of the model itself"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A team writes a prompt rule that says "do not promise refunds" but does not enforce this rule anywhere else in the system. What does this lesson say about relying on prompts alone for high-risk rules?',
    '["Prompts translate policy into model behavior, but important rules should also be enforced in code, permissions, and guardrails — not left to the prompt alone","Prompt instructions are always sufficient on their own for enforcing any product policy, however high-risk","The prompt layer should be removed entirely and replaced only with code-level rules","High-risk rules are best left unenforced since users can be trusted to interpret model output correctly"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A team uses one large reasoning model for summarization, semantic search, image understanding, and churn prediction. What does this lesson say about that approach?',
    '["This is a mistake — different tasks need different models, so semantic search should use an embedding model, image understanding a vision model, and churn prediction a traditional ML model, not one model for everything","Using one model for every task type is the recommended best practice for simplicity","A model gateway is unnecessary once a team commits to a single model for everything","Model routing only matters for cost, not for matching task type to model type"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A support bot needs to answer questions using the company''s actual refund policy documents rather than the model''s general knowledge. Which architecture layer does this lesson say is designed for this?',
    '["The RAG/retrieval layer — it retrieves grounding data such as approved policy documents and passes it to the model so responses are generated based on trusted content, with source citation","The memory/state layer, since retrieval is a form of long-term memory","The tool/API layer, since retrieving documents counts as calling an external API","No specific layer is needed — the base model already knows all company-specific policies"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A customer asks "my item arrived broken, can I get money back?" and the system retrieves a policy titled "damaged merchandise refund eligibility" even though none of the customer''s exact words appear in the title. What made this possible?',
    '["Vector search in the vector database layer, which searches by meaning using embeddings rather than requiring exact keyword matches","Keyword search alone, which only matches identical words between the query and the document","The tool/API layer, which looked up the order directly instead of searching documents","The guardrail layer, which rewrote the customer''s question before retrieval happened"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A team wants their AI to actually look up a live order status and process a return label, not just talk about policy. What does this lesson say is needed to make AI do things instead of only discuss them?',
    '["Tools — the tool/API layer lets AI interact with real systems such as order databases, calendars, CRMs, and ticketing systems, turning AI from a talker into a worker","Nothing extra is needed, since any RAG-enabled system can already take real-world actions","A larger language model, since bigger models can inherently query live databases without tools","The memory/state layer, since remembering past orders is equivalent to looking one up live"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A team gives their AI agent the same permissions as a human admin, including the ability to issue any refund amount without review. What does this lesson say about that design choice?',
    '["This is risky — agent permissions should be narrower than human admin permissions, and higher-risk write tools like issuing refunds should require approval below a threshold rather than unlimited access","This is ideal, since AI agents should always match the permission level of the most senior human admin","Read tools and write tools carry identical risk levels, so no distinction in permissions is needed","Tool permissions are handled automatically by the model and do not need explicit design"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'An agent processing a multi-step refund keeps calling the same order-lookup tool repeatedly and loses track of whether approval was already requested. What is missing from this system according to this lesson?',
    '["Memory/state — without tracking workflow state (like which step has been completed), the system cannot avoid duplicate tool calls, duplicate refunds, or lost workflow progress","A stronger model, since state tracking is purely a function of model quality rather than a distinct architecture layer","Nothing is missing — repeating tool calls is expected and harmless behavior for any agent","A better prompt, since state should always be fully re-derived from the prompt on every step"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l12,
    'A team wants to add long-term memory to their AI assistant so it remembers user preferences across sessions. What questions does this lesson say the team should answer before doing so?',
    '["What is stored and why, how long it is stored, whether the user can edit or delete it, whether it includes sensitive data, who can access it, and whether it is used for training or requires consent","None — memory features can be added freely without any privacy or retention considerations","Only whether the memory feature will increase user engagement metrics","Only whether the underlying model architecture technically supports a longer context window"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l13,
    'A customer-facing support bot''s retrieval system pulls in an internal-only policy note containing confidential pricing strategy, which then appears in the model''s prompt context. What does this lesson say went wrong?',
    '["Retrieval was not permission-aware — sources should be filtered by what the requesting user can access before they ever enter the prompt, not filtered only after generation","Nothing went wrong, since filtering restricted content after the model generates its response is equally safe","This is expected behavior, since RAG systems should retrieve from all available documents regardless of audience","The output guardrail layer should have caught this instead, since permission checks belong only at output time"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l14,
    'A user submits a request that says "show me confidential salary data" directly to a company AI assistant. According to this lesson, at what point should this be stopped?',
    '["At the input guardrail, before the request even enters the AI workflow or reaches retrieval and the model","Only at the output guardrail, after the model has already generated a response using salary data","Only at the action guardrail, after the assistant has already attempted to send the data somewhere","It should not be stopped, since guardrails only apply to model outputs, not user inputs"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l15,
    'An AI support assistant drafts a reply that says "we guarantee your refund will be approved," which is not actually supported by company policy. What kind of guardrail does this lesson say should catch this before the user sees it?',
    '["An output guardrail — it checks the AI response for unsupported claims and policy compliance before the message is shown to the user","An input guardrail, since the problem originated from the user''s original question","An action guardrail, since no real-world action like a payment was taken yet","No guardrail is needed here, since customer-facing tone issues are not a safety concern"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l16,
    'A team wants a repeatable way to test AI quality before every release rather than manually spot-checking outputs each time. What does this lesson recommend?',
    '["An evaluation harness — a system with a golden dataset, test prompts, expected outputs, automated checks, and regression/safety tests that can be run repeatedly","Manual spot-checking is already sufficient and a repeatable harness adds no value","Evaluation should only happen once, before the very first launch, and never again afterward","Monitoring in production is a full substitute for pre-launch evaluation"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l17,
    'Months after launch, a team wants to know whether their AI feature is still performing well and hasn''t silently degraded. What does this lesson say they need, beyond the one-time evaluation done before launch?',
    '["Monitoring/observability — ongoing tracking of latency, cost, error rate, retrieval quality, tool failures, user feedback, and drift to confirm the system is still working after launch","Nothing further is needed, since a passing evaluation before launch guarantees performance indefinitely","A completely new model, since monitoring is not actually necessary for production AI systems","Only user complaints, since formal monitoring dashboards are not useful signals"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l18,
    'A PM is asked to describe the full journey of a single AI request from submission to logging, in the correct order. According to this lesson''s complete AI request flow, what comes first and what comes last?',
    '["Authentication and permission checks come first, and logging sources/tools/model/cost plus monitoring comes last, with retrieval, prompt assembly, model generation, and guardrail/approval steps in between","The model generates a response first, and authentication is checked only afterward if the user complains","Logging happens first so that a record exists before the request is even processed","Guardrail checks come first and authentication happens only at the very end, after the action is taken"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l19,
    'A PM is asked to rewrite a message professionally, where the user pastes in all the necessary text and there is no need for outside documents or live data. Which architecture pattern fits this task, and why?',
    '["Pattern 1, Prompt-Only AI — the flow is simply user input, then prompt, then model, then output, which is appropriate because the user provides all needed context and risk is low","Pattern 2, RAG AI, because any text rewriting task requires retrieval from a document store","Pattern 4, Agentic AI, because rewriting a message requires multi-step planning and tool use","Pattern 9, Multi-Agent AI, because professional tone requires multiple specialized agents"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l20,
    'A workflow needs the AI to look up a live order status and check calendar availability before answering. Which pattern from this lesson applies, and what is the key weakness to plan for?',
    '["Pattern 3, Tool-Using AI — flow is orchestrator, then tool call, then tool result, then model; the key weakness is tool failure risk, permission complexity, and the need for logs and approvals","Pattern 1, Prompt-Only AI, which requires no special handling for live data or actions","Pattern 6, Batch AI, since any tool call should always run on a nightly schedule instead of live","Pattern 8, Edge/On-Device AI, since tool calls are always best run locally on the user''s device"]',
    0
  );

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (40 total, one per lesson) — Part 2: Q21-Q40
  -- ─────────────────────────────────────────────────────────────────

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l21,
    'A finance team wants AI to draft high-value refund recommendations, but insists a human must review and approve every one before money moves. Which pattern does this describe, and when does this lesson say to use it?',
    '["Pattern 5, Human-in-the-Loop AI — use it when mistakes are costly but AI can still save preparation time, such as finance workflows and high-value refunds","Pattern 6, Batch AI, since human review always implies the workflow must run on a nightly schedule","Pattern 7, Real-Time AI, since human approval is a form of low-latency response","Pattern 9, Multi-Agent AI, since any human reviewer is functionally equivalent to an additional AI agent"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l22,
    'A privacy-sensitive photo app wants to run image AI locally on the phone even when there is no internet connection, accepting a smaller model in exchange. Which pattern is this, and what is the tradeoff?',
    '["Pattern 8, Edge/On-Device AI — it trades some model power for privacy, speed, and local control, useful when data should stay local or the internet may be unavailable","Pattern 7, Real-Time AI, which requires a constant cloud connection and cannot run offline","Pattern 2, RAG AI, since on-device processing always requires a vector database in the cloud","Pattern 4, Agentic AI, since on-device models are inherently more autonomous than cloud models"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l23,
    'A team is designing a complex workflow with a research agent, a data agent, a policy agent, a drafting agent, and a reviewer agent working together. What does this lesson say about when to reach for this pattern?',
    '["Multi-agent systems should be used only when one well-designed workflow is not enough, since they are the most complex pattern with more latency, cost, coordination failures, and harder debugging","Multi-agent systems are the recommended default starting point for any new AI feature, however simple","Multi-agent systems eliminate the need for monitoring since each agent supervises the others","Multi-agent systems always reduce cost and latency compared to a single well-orchestrated workflow"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l24,
    'In the support copilot build example, after the model drafts a response, what happens before the customer ever sees it?',
    '["An output guardrail checks for unsupported promises, then the agent reviews the draft along with sources and warning flags, edits it, and approves it before the final reply and AI usage are logged","The draft is sent to the customer immediately, since output guardrails only apply to internal-facing tools","The draft skips human review entirely since RAG-grounded answers are considered pre-approved","The system deletes the draft and starts over with a different model whenever a warning flag appears"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l25,
    'In the internal knowledge assistant build example, what has to happen to company documents before an employee can ever ask a question that retrieves them?',
    '["Documents must be ingested, text extracted and chunked, embeddings created, and results stored in the vector database with metadata like owner, version, and permissions — all before any question is asked","Nothing needs to happen beforehand, since the model can search raw unprocessed documents live for every query","Employees must manually tag every document with the exact question it answers before ingestion","Only permission metadata matters; chunking and embeddings are optional steps that can be skipped"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l26,
    'In the AI analytics assistant build example, after a SQL generation tool creates a query from the user''s question, what happens next, and why does this lesson emphasize it?',
    '["A SQL validator checks syntax and permissions before the database executes the query, because analytics AI should never invent numbers and must use real, validated data tools rather than the model guessing values","The query is executed immediately without validation, since SQL generated by a language model is inherently safe to run","The model directly returns a numeric answer without ever running a real database query","Analyst review happens before the SQL is generated rather than after the report is drafted"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l27,
    'In the refund agent build example, eligibility is checked using deterministic rules even though the model also drafts a recommendation and customer message. What does this lesson say this combination demonstrates?',
    '["For action agents, deterministic rules and approvals matter as much as the model — use rules for hard constraints like eligibility thresholds and AI for messier tasks like drafting messages","Deterministic rules are unnecessary once an LLM is involved, since the model can handle eligibility logic directly","The model should decide eligibility while deterministic rules should draft the customer message","Using both deterministic rules and an LLM in the same workflow is redundant and should be simplified"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l28,
    'In the AI document processing build example, why does this lesson emphasize linking each extracted field back to the source text in the audit trail?',
    '["Document AI needs traceability from extracted value back to source, especially for low-confidence or high-value fields that a human must review and validate against the original document","Traceability is only useful for marketing purposes and does not affect accuracy or compliance","Once OCR extracts a field, there is no further need to reference the original document text","Human review is unnecessary once field confidence scores are calculated, regardless of the score"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l29,
    'A PM wants to understand privacy and security risk in their AI product. What does this lesson say is the right starting question?',
    '["What data flows through the system — what user input enters the model, what documents are retrieved, what customer data is included, what gets logged, and what gets sent to external vendors","Only how large the underlying model is, since bigger models are inherently riskier regardless of data flow","Only how fast the AI responds, since latency and privacy risk are the same concern","Data flow does not matter once guardrails are in place, since guardrails eliminate all privacy risk"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l30,
    'A team wants to reduce how long users wait for an AI response in a live chat feature. Which of these does this lesson list as a way to reduce latency?',
    '["Use a smaller model for easy tasks, cache common responses, retrieve fewer but better chunks, run tool calls in parallel, and shorten prompts and output length","Always use the largest and most powerful model available regardless of task difficulty","Increase the number of retrieved chunks and add more sequential tool calls before responding","Remove all guardrail checks, since guardrails are the primary driver of latency in every system"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l31,
    'A team measures AI cost only by model API token usage and reports that number to leadership. What does this lesson say is wrong with that measurement?',
    '["AI cost includes far more than token usage — embeddings, vector database, tool/API calls, infrastructure, human review, evaluation, monitoring, and logging all contribute, so cost should be measured per successful task, not just per model call","Token usage is the only cost that matters and everything else is negligible by comparison","Cost measurement is not a PM concern and should be left entirely to finance","Human review costs should never be included in AI cost calculations since they are a fixed cost"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l32,
    'An AI order-lookup tool goes down, and the assistant has no defined behavior for this case, so it fails silently and confuses the user. What does this lesson say should have existed instead?',
    '["A fallback design — such as telling the user the order system is unavailable and offering manual entry or escalation to human review — so the workflow keeps moving safely","Nothing; silent failure is the expected and acceptable behavior when a tool becomes unavailable","The system should have simply retried the same failing tool call indefinitely until it succeeded","Fallback behavior is only relevant for model failures, not for tool or API failures"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l33,
    'An incident occurs and the team cannot determine which prompt version, model version, or retrieved sources were used for a specific bad answer. What does this lesson say was missing?',
    '["Logging architecture and versioning — logs should capture prompt version, model version, retrieved sources, tool calls, and guardrail decisions, and every part of the system should be versioned so changes can be traced","Nothing was missing; without versioning, AI behavior changes are simply unexplainable by design","Only the final output needs to be logged; intermediate steps like retrieval and tool calls are not useful","Versioning only applies to the model itself, not to prompts, RAG indexes, or guardrails"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l34,
    'Before giving a refund agent the power to actually issue refunds, a team runs it in the background so it produces recommendations that humans still act on, comparing agreement rate and error type. What technique is this?',
    '["Shadow mode — the AI runs without affecting users, letting the team learn from comparing recommendations to human decisions before giving the AI real power","Canary rollout, which instead releases the new capability to a small percentage of live users immediately","A kill switch, which is used to turn off a feature rather than to safely observe it before launch","Human-in-the-loop review, which requires the AI to already be taking live actions with human approval"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l35,
    'A newly launched AI agent starts behaving unexpectedly and causing harm to a small number of users. What does this lesson say the team needs in order to respond quickly?',
    '["A kill switch — the ability to disable the risky capability, such as switching to draft-only mode, disabling a tool, rolling back the model, or routing all cases to human review","Nothing is needed immediately; the team should wait for the next scheduled deployment to fix the issue","A completely new model trained from scratch, since kill switches are not a real architecture pattern","An increase in the model''s permissions so it can fix its own mistakes autonomously"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l36,
    'A team is deciding between an API-based cloud model and a self-hosted model for a new AI feature. According to this lesson, what should drive this decision?',
    '["Whether the team needs speed, control, privacy, cost efficiency, or customization most — cloud models are faster to start but create vendor dependency, while self-hosted models offer more control but require more infrastructure and ML expertise","Self-hosted models should always be chosen because they are cheaper in every scenario regardless of scale","Cloud/API models should always be chosen because self-hosted models are never viable for production","This decision has no meaningful tradeoffs and either option is functionally identical"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l37,
    'A team builds a broad, general-purpose chat assistant instead of embedding AI directly into the ticket console workflow where support agents already work. What does this lesson suggest about that choice?',
    '["Workflow AI is usually easier to make valuable than a generic assistant, since it has a clear user, input, output, and metric — and embedded AI is often better than chat because it offers better context and easier measurement","Generic chat assistants are always superior to embedded, workflow-specific AI features","There is no meaningful difference between a generic assistant and workflow-specific AI in terms of measurability","Embedding AI into an existing workflow always increases user effort compared to a standalone chat tool"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l38,
    'A team is unsure whether to enforce a refund policy threshold using a fixed rule or let the model decide case by case using natural language judgment. What does this lesson recommend?',
    '["Use deterministic rules for hard constraints like a fixed refund threshold, since output must be exact and consistent, and use AI for messier tasks like interpreting the customer''s language or drafting a response","Always use AI judgment instead of deterministic rules, since rules are considered obsolete once AI is available","Always use deterministic rules for everything, including messy natural language interpretation tasks","Combining deterministic rules and AI judgment in the same workflow should be avoided as an architecture anti-pattern"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l39,
    'A PM is preparing for an architecture review before launching a new AI feature. According to this lesson''s readiness checklist, which of the following should be confirmed before launch?',
    '["That tool permissions are limited, human approval exists for risky actions, guardrails are tested, a golden dataset and monitoring dashboard exist, a rollback plan and kill switch exist, and success metrics are defined","Only that the model produces grammatically correct output in a handful of manual test prompts","Only that the UI design has been approved by the design team, with no other readiness criteria","Readiness checklists are unnecessary once the model has been selected and prompt-tuned"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l40,
    'A PM needs to explain to leadership why a refund agent needs more architecture than a simple internal knowledge assistant. Using this lesson''s framing, what is the core reason?',
    '["Architecture risk is higher when AI can take real action — the refund agent needs deterministic thresholds, permission-limited tools, human approval for high-value cases, audit logs, rollback, and a kill switch, unlike a read-only knowledge assistant","There is no meaningful architecture difference between an agent that takes actions and an assistant that only answers questions","The refund agent needs a bigger model, and model size alone accounts for all the additional risk","Knowledge assistants require more architecture than action-taking agents since they handle more documents"]',
    0
  );

end $$;
