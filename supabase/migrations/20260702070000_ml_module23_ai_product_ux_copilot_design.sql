-- AI/ML for Builders — Module 23: AI Product UX and Copilot Design
-- 35 lessons — closing the Module 16-23 arc: everything AI can do only matters if the product is usable, trustworthy, and controllable

do $$
declare
  v_course_id uuid;
  v_module_id uuid;
  v_l1  uuid; v_l2  uuid; v_l3  uuid; v_l4  uuid; v_l5  uuid; v_l6  uuid;
  v_l7  uuid; v_l8  uuid; v_l9  uuid; v_l10 uuid; v_l11 uuid; v_l12 uuid;
  v_l13 uuid; v_l14 uuid; v_l15 uuid; v_l16 uuid; v_l17 uuid; v_l18 uuid;
  v_l19 uuid; v_l20 uuid; v_l21 uuid; v_l22 uuid; v_l23 uuid; v_l24 uuid;
  v_l25 uuid; v_l26 uuid; v_l27 uuid; v_l28 uuid; v_l29 uuid; v_l30 uuid;
  v_l31 uuid; v_l32 uuid; v_l33 uuid; v_l34 uuid; v_l35 uuid;
begin

  select id into v_course_id from courses where sort_order = 2;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 23: AI Product UX and Copilot Design',
    'Designing how humans and AI work together — interaction patterns, trust calibration, control points, and copilot/agent UX for AI that fits naturally into real workflows.',
    23
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.1 — Why This Module Matters, and the Simplest Mental Model
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Why This Module Matters, and the Simplest Mental Model',
    1,
    $M23L1$WHY THIS MODULE MATTERS

AI product success is not only about model quality. A good model can still fail if the user experience is bad. Example: the AI gives a correct answer, but the user does not trust it, cannot verify the source, does not know what to ask, cannot edit the output, does not know what the AI can do, accidentally lets it take a risky action, does not understand when it is uncertain, or cannot undo the action.

**AI product design is not just "add a chatbot." It is designing how humans and AI work together safely and usefully.**


THE SIMPLEST MENTAL MODEL

Think of AI as a smart assistant inside a workflow. A good assistant should understand the user's goal, know what it can and cannot do, use the right information, show its work when needed, ask before risky action, let the user edit, let the user undo, escalate when needed, and improve the workflow rather than interrupt it.

Bad AI UX makes the user feel "what is this doing? Can I trust this? Why did it say that? How do I fix it? What happens if I click approve?"

Good AI UX makes the user feel "this saved me time. I understand the source. I am still in control. I know what to do next."

>> Every lesson in this module is really answering one of those five bad-feeling questions with a concrete design pattern.$M23L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.2 — AI UX vs. Normal UX, and the Core AI UX Question
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI UX vs. Normal UX, and the Core AI UX Question',
    2,
    $M23L2$AI UX VS. NORMAL UX

Normal UX is usually deterministic — if a user clicks a button, the same thing happens. AI UX is probabilistic — the same input may produce slightly different outputs. That changes product design.

AI products need extra care around uncertainty, trust, explainability, feedback, human control, error recovery, source visibility, safety, permissions, and monitoring.

**Traditional UX designs clear actions. AI UX designs collaboration with an imperfect assistant.**


THE CORE AI UX QUESTION

Before designing any AI feature, ask: **where should AI fit in the user's existing workflow?**

Do not start with "should we add chat?" Start with: what is the user trying to accomplish? Where are they stuck? What takes too much time? What requires too much reading? What requires repetitive writing? What requires searching across sources? What requires decision support? What should stay human-controlled?

AI should reduce friction in a workflow. It should not become an extra task.

>> The core AI UX question is the single filter every other lesson in this module runs through — if a design choice does not answer "where does this fit in the workflow," it is decoration.$M23L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.3 — Not Every AI Feature Needs Chat, and AI UX Patterns
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Not Every AI Feature Needs Chat, and AI UX Patterns',
    3,
    $M23L3$NOT EVERY AI FEATURE NEEDS CHAT

A common mistake is assuming AI means chatbot. Chat is useful when user intent is broad, the user wants to ask questions, the task is exploratory, natural language is easier than menus, or there are many possible requests.

But chat is not always best. Sometimes better AI UX is a button, an inline suggestion, autocomplete, a draft panel, side-by-side review, a smart filter, a recommendation card, an alert, a checklist, form autofill, a "summarize" action, an "explain this" button, or a "suggest next step" panel.

**Use chat when conversation is the best interface. Do not use chat just because the feature is AI.**


AI UX PATTERNS

Common patterns: a chat assistant (good for exploration, Q&A, help, internal knowledge search); a copilot panel (good for drafting, reviewing, summarizing, recommending); inline completion (good for writing, coding, search queries, forms); a one-click action (good for summarize, rewrite, extract fields, generate report, find similar items); and an agent workflow (good for scheduling, support workflows, CRM updates, document processing).

PM question: **"Which UX pattern best matches the job-to-be-done?"**

>> This lesson's five patterns are the toolbox; the rest of this module is largely about knowing which tool fits which job.$M23L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.4 — Assistant, Copilot, Autopilot, and the Copilot Design Principle
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Assistant, Copilot, Autopilot, and the Copilot Design Principle',
    4,
    $M23L4$ASSISTANT, COPILOT, AUTOPILOT

There are different levels of AI involvement. An assistant answers or explains — example, "explain this policy." A copilot helps a human complete work — example, "draft a reply for me to review." An autopilot acts with little or no human review — example, "automatically resolve eligible refund requests."

**Assistant informs. Copilot assists. Autopilot acts.**

Move from assistant to autopilot only when the task is low-risk, well-tested, and properly monitored.


COPILOT DESIGN PRINCIPLE

A copilot should make the human better, not remove the human too early.

A good copilot saves time, reduces the blank-page problem, suggests next steps, shows evidence, lets the user edit, lets the user reject, learns from feedback, and keeps the human accountable.

A bad copilot creates confident wrong output, hides sources, makes editing hard, takes action too early, makes users over-trust it, interrupts the workflow, or requires more checking than doing manually.

[!] A copilot should reduce cognitive load, not create review burden.

>> Assistant, copilot, and autopilot are levels of autonomy; the copilot design principle is specifically about getting the middle level right, since that is where most real AI products actually live.$M23L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.5 — Start With the User Journey, and Design Around User Intent
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Start With the User Journey, and Design Around User Intent',
    5,
    $M23L5$START WITH THE USER JOURNEY

For AI UX, map the user journey. Example, a support agent workflow: read customer message, understand issue, search policy, check order, decide next step, write response, send response, update ticket.

AI can help at multiple points — summarize issue, retrieve policy, check order, suggest next step, draft reply, flag risk, update ticket. But not every step should be automated.

PM question: **"Where does the user need speed, accuracy, judgment, or control?"**


DESIGN AROUND USER INTENT

AI should understand what the user is trying to do. A user may say "help me with this customer" — that is vague. Possible intents: summarize the issue, draft a response, find policy, check eligibility, escalate the ticket, identify sentiment, recommend next step.

Good UX can help by offering intent shortcuts — summarize, draft reply, find policy, check eligibility, escalate, create action items. Nielsen Norman Group notes that helpful site-specific AI chatbots clearly state capabilities, offer relevant prompt suggestions, and signal they understand what users are looking at.

[!] Do not make users guess how to use the AI. Show what it can do.

>> Mapping the journey tells you where AI could help. Designing around intent is how you make each of those moments actually usable instead of a blank box.$M23L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.6 — Capability Disclosure, and First-Use Experience
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Capability Disclosure, and First-Use Experience',
    6,
    $M23L6$CAPABILITY DISCLOSURE

Users need to know what the AI can and cannot do. Bad: "ask me anything" — this creates unrealistic expectations. Better: "I can summarize this ticket, find relevant policy, draft a reply, or suggest next steps."

Capability disclosure should explain what AI can do, what it cannot do, what sources it uses, whether it can take action, whether human review is needed, and what data it can access.

PM question: **"Does the user understand the AI's scope?"**


FIRST-USE EXPERIENCE

The first-use experience matters. Users should quickly learn what this AI does, when to use it, what input it needs, what output to expect, whether output is editable, whether it uses sources, whether it can act, and how to give feedback.

Microsoft's Human-AI Interaction Guidelines cover how AI systems should behave during initial interaction, regular interaction, when wrong, and over time.

[!] The first experience should teach the user how to trust and control the AI.

>> Capability disclosure is what you tell the user. First-use experience is whether they actually absorb it in practice — the same information delivered badly on first use gets ignored.$M23L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.7 — Empty State Design, and Prompt Suggestions
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Empty State Design, and Prompt Suggestions',
    7,
    $M23L7$EMPTY STATE DESIGN

The empty state is what users see before they interact. Bad empty state: a blank chat box. Better empty state: "I can help you with: summarize this document, extract action items, draft a reply, find relevant policy, explain this metric."

Good empty state reduces anxiety and gives examples.

PM question: **"What should the user try first?"**


PROMPT SUGGESTIONS

Prompt suggestions help users get useful output quickly. Examples: "summarize this in 5 bullets," "draft a professional reply," "find risks in this PRD," "extract action items," "explain this chart," "compare these options," "create an experiment plan."

Good prompt suggestions are context-aware, specific, useful, short, and based on user workflow. Bad prompt suggestions are generic — "ask me anything," "write something," "analyze this."

[!] Prompt suggestions are UX, not decoration.

>> An empty state without prompt suggestions is a wasted opportunity — the first thing a user sees is the best place to teach them what "good" looks like.$M23L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.8 — Context Awareness, and User Control
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Context Awareness, and User Control',
    8,
    $M23L8$CONTEXT AWARENESS

AI feels useful when it understands the current context. Example: a user viewing a support ticket should see AI suggestions like summarize ticket, find policy, draft reply, detect sentiment, suggest escalation — not "write a poem" or "generate marketing copy."

Context-aware AI uses the current page, selected text, user role, workflow state, the current document, relevant data, and permissions.

PM question: **"What context should the AI automatically know, and what should the user provide?"**


USER CONTROL

AI should not make users feel powerless. Control options: edit output, regenerate, shorten, change tone, accept, reject, undo, view source, ask a follow-up, escalate to a human, stop the task, change settings, remove memory, disable the AI feature.

[!] The more powerful the AI, the more control the user needs.

>> Context awareness reduces how much the user has to explain. User control makes sure that even with less explaining, the user never loses the ability to steer or stop the AI.$M23L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.9 — Draft-First Design, and Approval Flows
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Draft-First Design, and Approval Flows',
    9,
    $M23L9$DRAFT-FIRST DESIGN

For many workflows, AI should draft before acting. Examples: draft email, human sends; draft support reply, agent approves; draft report, analyst reviews; draft CRM note, sales rep edits; draft meeting summary, user confirms.

Draft-first design is safer because humans can review. Use it when user-facing communication is involved, the task has business risk, output could be wrong, tone matters, policy matters, or user trust matters.

**Draft is safer than auto-send.**


APPROVAL FLOWS

Approval flows are needed when AI action has risk. Example: "I found the order and policy. This case appears eligible for a return label. Approve creating the label?"

Good approval UX should show what action will happen, why AI recommends it, source evidence, risk level, what data will change, who will be notified, and whether the action can be undone.

PM question: **"Does the user understand what they are approving?"**

>> Draft-first is the default safety pattern for content. Approval flows are the equivalent pattern for actions — same underlying idea, applied to a different kind of output.$M23L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.10 — Undo and Recovery, and Transparency
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Undo and Recovery, and Transparency',
    10,
    $M23L10$UNDO AND RECOVERY

AI can make mistakes. Users need recovery options: undo a CRM update, reopen a ticket, revert a document, cancel a scheduled email, void a draft, restore a previous version, remove AI-generated text, escalate after a bad answer.

Some actions cannot be fully undone — a sent email, an issued refund, deleted data, an external notification, a public post.

[!] If an AI action cannot be undone, require stronger confirmation before action.


TRANSPARENCY

Transparency means users can understand what AI did. For low-risk tasks, simple transparency may be enough — example, "draft generated from selected text." For higher-risk tasks, show more — example, "used Refund Policy section 4 and Order #123 delivery date to recommend escalation."

Transparency can include sources used, tools called, data accessed, confidence reason, missing information, action taken, and next step.

**Transparency should match risk.**

>> Undo and recovery are what protect the user after a mistake happens. Transparency is what helps them notice the mistake happened at all.$M23L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.11 — Source Visibility, and Confidence UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Source Visibility, and Confidence UX',
    11,
    $M23L11$SOURCE VISIBILITY

For grounded AI, sources should be visible — a policy section, a document quote, a customer record field, an analytics table, a contract clause, a knowledge base article.

Good source UX shows the source title, shows the relevant excerpt, links to the full source, makes citation easy to verify, and clearly separates source from AI interpretation. Bad source UX shows a vague citation, links to an irrelevant document, hides evidence, or invents source names.

PM question: **"Can the user verify the answer quickly?"**


CONFIDENCE UX

Showing confidence can help, but it can also mislead. Bad: "confidence: 92%" — the user may over-trust it without knowing why. Better: "confidence: medium — policy confirms return window, but product category exception is unclear."

Good confidence UX explains what evidence supports the answer, what information is missing, whether sources agree, whether human review is needed, and what action is safe.

[!] Confidence should be explained, not just scored.

>> Source visibility gives the user something to check. Confidence UX tells them how hard they need to check it — the two work together to calibrate exactly how much scrutiny a given answer deserves.$M23L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.12 — Uncertainty Design, and Error Messages
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Uncertainty Design, and Error Messages',
    12,
    $M23L12$UNCERTAINTY DESIGN

AI should handle uncertainty honestly. Good uncertainty messages: "I do not have enough information from the provided sources." "The policy does not mention this case." "These sources conflict." "This may require human review." "I need the order date to check eligibility."

Bad uncertainty behavior: guessing, over-apologizing, giving a fake answer, hiding missing information, sounding confident when unsure.

**Good AI UX makes uncertainty visible and actionable.**


ERROR MESSAGES

AI errors should be helpful. Bad: "something went wrong." Better: "I could not access the order lookup tool. You can try again, or continue by manually entering the order date."

Good AI error messages include what failed, whether user action is needed, whether retry is possible, whether data was changed, an alternative path, and an escalation option.

[!] AI failure states need design, not just engineering logs.

>> Uncertainty design handles the case where the AI does not know the answer. Error messages handle the case where the AI could not even try. Both need the same discipline: say what happened and what to do next.$M23L12$
  ) returning id into v_l12;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.13 — Loading and Progress UX, and Streaming Output
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Loading and Progress UX, and Streaming Output',
    13,
    $M23L13$LOADING AND PROGRESS UX

AI tasks may take time. For short tasks, a spinner may be fine. For longer tasks, show progress — "searching policy…", "checking order…", "drafting response…", "waiting for approval…" This helps users trust the system.

For agents, progress visibility is critical because the AI may take multiple steps.

PM question: **"Does the user know what the AI is doing while they wait?"**


STREAMING OUTPUT

Streaming means showing the answer as it is generated. Useful for long text, drafting, summaries, and chat answers. Benefits: feels faster, the user sees progress, the user can stop early, and it reduces waiting anxiety.

But streaming may be bad when output needs validation first, safety checks happen after generation, partial output could be misleading, or structured output must be complete.

[!] Stream low-risk text. Validate high-risk output before showing.

>> Progress UX and streaming solve the same underlying problem — users hate silent waiting — but streaming only works when partial output is safe to show as-is.$M23L13$
  ) returning id into v_l13;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.14 — Editability, and Review Burden
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Editability, and Review Burden',
    14,
    $M23L14$EDITABILITY

AI output should often be editable — a customer reply, email, PRD, summary, meeting notes, report, CRM note.

Good edit UX lets the user revise directly, lets AI shorten/expand/change tone, makes changes visible, lets the user check the original source, and lets the user accept or reject suggestions.

**For copilots, editing is part of the workflow, not an afterthought.**


REVIEW BURDEN

AI can create hidden work. Example: AI drafts long support replies, and the agent now spends more time checking the draft than writing from scratch. Bad AI increases review burden.

Measure time saved, edit distance, acceptance rate, rejection reason, human confidence, error rate, and review time.

[!] A copilot is useful only if review time is lower than manual work time.

>> Editability is the mechanism. Review burden is the metric that tells you whether that mechanism is actually saving time or just relocating the work.$M23L14$
  ) returning id into v_l14;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.15 — Feedback Loops From Users, and Implicit Feedback
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Feedback Loops From Users, and Implicit Feedback',
    15,
    $M23L15$FEEDBACK LOOPS FROM USERS

Users should be able to give feedback — thumbs up/down, "this was wrong," "source was irrelevant," "too long," "wrong tone," "missing information," "unsafe," "report issue," edit tracking, accept/reject behavior.

Feedback should feed into evaluation, prompt improvement, retrieval improvement, fine-tuning data, product analytics, and safety monitoring.

PM question: **"What feedback tells us whether the AI was actually useful?"**


IMPLICIT FEEDBACK

Not all feedback is explicit. Implicit signals: the user accepted the draft, edited heavily, regenerated, copied the answer, ignored the AI, clicked the source, escalated, undid the action, abandoned the workflow, or asked a follow-up.

These signals help measure usefulness, but be careful — copying an answer does not always mean it was correct.

[!] Implicit feedback is useful, but interpret it carefully.

>> Explicit feedback is what users tell you directly. Implicit feedback is what their behavior tells you whether they meant to or not — both matter, and neither alone is the full picture.$M23L15$
  ) returning id into v_l15;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.16 — Trust Calibration, and Explainability
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Trust Calibration, and Explainability',
    16,
    $M23L16$TRUST CALIBRATION

The goal is not maximum trust. The goal is appropriate trust. Over-trust means the user accepts wrong AI output. Under-trust means the user ignores useful AI output.

Good UX helps users know when to trust, verify, edit, or escalate. Trust calibration tools: sources, confidence explanation, human review, clear limitations, editability, feedback, risk labels, audit trail, consistent behavior.

**Good AI UX creates calibrated trust.**


EXPLAINABILITY

Explainability means helping users understand why AI gave an output. Examples: "recommended because customer mentioned damaged item and policy section 4 applies." "Escalated because order value exceeds approval threshold." "Classified as Billing because customer says they were charged twice." "Confidence is low because no delivery date was found."

Explainability is especially useful when AI influences decisions.

[!] Explain the reason when the user needs to decide, approve, or trust.

>> Trust calibration is the overall goal. Explainability is one of its most important tools — a well-explained answer is much easier to trust the right amount.$M23L16$
  ) returning id into v_l16;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.17 — Designing for Mistakes, and Human Handoff
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Designing for Mistakes, and Human Handoff',
    17,
    $M23L17$DESIGNING FOR MISTAKES

AI will make mistakes. Design should assume that. Mistake-friendly design includes easy correction, undo, report issue, human escalation, source verification, draft mode, confirmation before action, error labels, safe defaults, logs, and rollback.

PM question: **"When AI is wrong, can the user recover quickly?"**


HUMAN HANDOFF

Human handoff should be smooth. Bad handoff: "AI could not help. Contact support." Good handoff: "I am escalating because the policy does not cover this exception. I checked the order date, item condition, and refund policy. Here is a summary for the human reviewer."

Good handoff includes the user request, AI summary, sources checked, tools used, missing information, the reason for escalation, and a recommended next step.

[!] A good handoff should save the human time.

>> Designing for mistakes covers recovery when the AI itself is wrong. Human handoff covers the case where the AI correctly recognizes it has reached its own limit — both are forms of graceful failure.$M23L17$
  ) returning id into v_l17;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.18 — AI Memory UX, and Personalization UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Memory UX, and Personalization UX',
    18,
    $M23L18$AI MEMORY UX

If AI remembers things, users should understand and control it. Memory UX should answer: what does AI remember? Why does it remember this? Can the user edit it? Can the user delete it? Can the user turn memory off? Is sensitive data remembered? Who can access memory? Does memory affect future answers?

[!] Memory can feel helpful or creepy. Design for consent and control.


PERSONALIZATION UX

AI can personalize experiences — preferred tone, user role, recent activity, saved preferences, frequent tasks, language, workflow shortcuts. But personalization must be transparent and useful.

Bad personalization: AI makes assumptions the user did not approve. Good personalization: "using your saved preference for concise summaries."

PM question: **"Is personalization helping the user, or making the experience feel invasive?"**

>> Memory is the mechanism that makes personalization possible across sessions. Both need the same underlying safeguard: the user should always know what is remembered and be able to say no.$M23L18$
  ) returning id into v_l18;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.19 — Data Boundary UX, and Permission UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Data Boundary UX, and Permission UX',
    19,
    $M23L19$DATA BOUNDARY UX

Users should understand what data AI can access. Examples: "this answer uses only this document." "This assistant can access your open ticket and public help center articles." "This copilot cannot access customer payment details." "This agent will use your calendar only after permission."

[!] Users should know what the AI sees.


PERMISSION UX

For tool-using AI, users may need to grant permissions. Example: "to schedule this meeting, I need access to your calendar availability."

Good permission UX explains what access is requested, why it is needed, what action AI will take, whether it is one-time or ongoing, how to revoke access, and what data is not accessed.

PM question: **"Can the user make an informed permission decision?"**

>> Data boundary UX describes what the AI already can see. Permission UX is the moment-by-moment process of asking for more — together they keep data access visible instead of implicit.$M23L19$
  ) returning id into v_l19;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.20 — Agent UX, and Showing Agent Progress
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Agent UX, and Showing Agent Progress',
    20,
    $M23L20$AGENT UX

Agent UX needs stronger design because agents act. Good agent UX shows the goal, the plan, the steps, the tools used, progress, approval points, the final action, a summary, undo/rollback if possible, and an escalation path.

Example plan: "1. Look up order. 2. Check refund policy. 3. Determine eligibility. 4. Draft response. 5. Ask for your approval before sending."

**Agents need visible plans and approval gates.**


SHOWING AGENT PROGRESS

For multi-step agents, show progress — "reading customer request," "looking up order," "checking policy," "drafting response," "waiting for approval." This reduces anxiety and helps users catch errors early.

Example: if the agent says "checking order #456" and the user expected #123, they can stop it.

PM question: **"Can the user intervene before the agent makes a mistake?"**

>> Agent UX is the overall design requirement. Showing progress is the specific mechanism that makes intervention possible mid-task, not just before or after.$M23L20$
  ) returning id into v_l20;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.21 — Confirmation Design, and Progressive Autonomy
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Confirmation Design, and Progressive Autonomy',
    21,
    $M23L21$CONFIRMATION DESIGN

Confirmation should be specific. Bad: "are you sure?" Better: "approve sending this email to Priya Shah about Order #123? This will notify the customer and update the ticket status to Waiting for Customer."

Good confirmation includes the action, the target, the consequence, whether it is reversible, the source/reason, and the risk level.

**Confirm the consequence, not just the click.**


PROGRESSIVE AUTONOMY

Do not start with full automation. Maturity path: suggest, then draft, then review-required action, then auto-action for low-risk cases, then conditional autonomy, then full autonomy for narrow, proven workflows.

Example, support refund AI: phase 1 summarize ticket, phase 2 draft reply, phase 3 recommend eligibility, phase 4 create return label after approval, phase 5 auto-create return label for low-value clear cases.

[!] Earn autonomy through evidence.

>> A specific confirmation dialog is what keeps a single action safe. Progressive autonomy is what keeps the whole feature safe over time, as it climbs from suggestion toward automation.$M23L21$
  ) returning id into v_l21;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.22 — AI Inside Existing Tools, and Designing AI Search UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Inside Existing Tools, and Designing AI Search UX',
    22,
    $M23L22$AI INSIDE EXISTING TOOLS

AI is most useful when it lives where work happens — in the support console, in the CRM, in the analytics dashboard, in the document editor, in the email composer, in the code editor, in the project management tool, in the search experience.

Bad UX: the user must copy-paste between tools. Good UX: AI has the right context and returns output where the user needs it.

**The best AI UX often disappears into the workflow.**


DESIGNING AI SEARCH UX

AI search is different from normal search. Normal search returns links. AI search may return a direct answer, a summary, sources, suggested follow-ups, related documents, and confidence/limitations.

Good AI search UX should include the answer, sources, a "view source" link, follow-up suggestions, "not enough info" behavior, feedback, and the ability to refine the query.

PM question: **"Does AI search help users verify, not just answer?"**

>> "AI inside existing tools" is the general placement principle; AI search UX is one of the specific interfaces that principle gets applied to.$M23L22$
  ) returning id into v_l22;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.23 — Designing AI Writing UX, and Designing AI Summarization UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Designing AI Writing UX, and Designing AI Summarization UX',
    23,
    $M23L23$DESIGNING AI WRITING UX

AI writing UX should support the writer. Good features: draft, rewrite, shorten, expand, change tone, make executive-ready, make simpler, convert to bullets, suggest a subject line, preserve meaning, compare versions.

Important rule: for business writing, AI should not add unsupported facts.

**Writing AI should improve expression, not invent substance.**


DESIGNING AI SUMMARIZATION UX

Summaries must be trustworthy. Good summarization UX includes a clear summary type, length control, source references, action items, owners/deadlines, missing-information labels, the ability to expand, and a link back to the original.

Example summary types: executive summary, action-item summary, customer issue summary, decision summary, risk summary.

PM question: **"What kind of summary does this user actually need?"**

>> Writing UX and summarization UX are two sides of the same coin — one expands input into more polished output, the other compresses it into less, and both share the same rule against inventing content that was not there.$M23L23$
  ) returning id into v_l23;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.24 — Designing AI Analytics UX, and Designing AI Support UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Designing AI Analytics UX, and Designing AI Support UX',
    24,
    $M23L24$DESIGNING AI ANALYTICS UX

Analytics AI is risky because wrong numbers can mislead decisions. Good analytics AI UX shows the query used, the data source, the metric definition, separates facts from hypotheses, allows analyst review, shows a chart/table, avoids unsupported causality, flags missing data, and links to the dashboard.

Bad: "revenue dropped because of pricing." Better: "revenue dropped 8% week over week. The data shown here does not prove cause. Possible drivers to investigate: traffic decline, conversion drop, pricing change, or product mix."

[!] Analytics AI must not hallucinate numbers or causes.


DESIGNING AI SUPPORT UX

Support AI must protect customer trust. Good support AI UX retrieves approved policy, shows source, drafts reply, flags risky cases, requires approval before send, shows customer context, avoids unsupported promises, escalates legal/safety/angry cases, and logs the final answer.

Metrics: agent acceptance, resolution time, CSAT, wrong-answer rate, escalation quality.

PM question: **"Should AI answer the customer directly, or assist the agent first?"**

>> Both domains share the same underlying risk: a confident, wrong output that a user acts on before checking it — the UX design in each case exists specifically to slow that down.$M23L24$
  ) returning id into v_l24;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.25 — Designing AI Document UX, and Designing AI Recommendation UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Designing AI Document UX, and Designing AI Recommendation UX',
    25,
    $M23L25$DESIGNING AI DOCUMENT UX

Document AI should handle long and complex information. Good UX highlights source passages, extracts fields into a structured table, shows confidence by field, lets the user correct fields, links each extracted value to source, flags missing or ambiguous fields, preserves the original document, and escalates high-risk fields.

Example: invoice extraction should show where the total amount came from.

**For document AI, every important extracted answer should trace back to the document.**


DESIGNING AI RECOMMENDATION UX

AI recommendations should be understandable and controllable. Good recommendation UX explains "why this," allows feedback, allows hide/not-interested, provides diversity, avoids repetition, respects preferences, makes sponsored/business-driven items clear, and avoids creepy personalization.

Example explanations: "because you viewed hiking shoes." "Popular with users who bought this." "New in a category you follow." "Similar to your saved items."

PM question: **"Does the user feel helped or manipulated?"**

>> Document UX earns trust through traceability back to a source document. Recommendation UX earns trust through traceability back to a stated reason — the same "show your work" principle applied to two very different outputs.$M23L25$
  ) returning id into v_l25;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.26 — Accessibility and Inclusive AI UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Accessibility and Inclusive AI UX',
    26,
    $M23L26$AI UX should work for different users. Consider language, reading level, screen readers, keyboard navigation, voice input/output, color contrast, cognitive load, different accents, different technical skill levels, mobile vs. desktop, and low-bandwidth environments.

Microsoft's responsible AI principles include inclusiveness alongside fairness, reliability/safety, privacy/security, transparency, and accountability.

[!] AI should reduce barriers, not create new ones.

>> Accessibility is not a separate checklist tacked onto AI UX — every pattern covered earlier in this module (capability disclosure, confirmation design, error messages) needs to actually work for a screen reader user, a non-native speaker, and a low-bandwidth connection, not just for the design team's own setup.$M23L26$
  ) returning id into v_l26;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.27 — AI UX Metrics
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI UX Metrics',
    27,
    $M23L27$Measure AI UX with product and quality metrics.

Adoption: feature usage, repeat usage, activation, prompt suggestion clicks.

Efficiency: time saved, tasks completed faster, fewer clicks, reduced search time, reduced manual effort.

Quality: acceptance rate, edit distance, factual accuracy, source correctness, human review pass rate.

Trust and satisfaction: CSAT, helpfulness rating, thumbs up/down, user complaints, reported wrong answers.

Safety: escalation rate, wrong-action rate, unsafe output rate, privacy incidents, human override rate.

[!] Measure both usefulness and safety.

>> Five metric categories, and none of them alone tells the full story — a feature can look great on adoption while quietly failing on safety, or look safe while nobody actually uses it.$M23L27$
  ) returning id into v_l27;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.28 — Edit Distance, and Acceptance Rate
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Edit Distance, and Acceptance Rate',
    28,
    $M23L28$EDIT DISTANCE

Edit distance measures how much the user changes AI output. Example: AI drafts an email, the user edits 80% of it — that may mean the draft was poor. If the user edits only 10%, it may be useful.

But interpret carefully. Low edit distance does not always mean correct — the user may accept wrong output. So combine edit distance with human rating, accuracy checks, source correctness, business outcome, and user satisfaction.

**Edit distance measures usefulness, not truth.**


ACCEPTANCE RATE

Acceptance rate measures how often users accept AI output — an agent accepts a support draft, a user inserts an AI summary, a sales rep uses an account brief, an analyst accepts generated SQL, a PM uses generated release notes.

High acceptance can show value, but again, acceptance does not guarantee correctness.

PM question: **"Are users accepting because the output is good, or because they over-trust AI?"**

>> Both metrics have the exact same blind spot: they measure whether users liked the output, not whether the output was actually right — this is why implicit feedback always needs pairing with an accuracy check.$M23L28$
  ) returning id into v_l28;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.29 — Time Saved, and Common AI UX Failure Modes
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Time Saved, and Common AI UX Failure Modes',
    29,
    $M23L29$TIME SAVED

Time saved is a strong AI UX metric. Example: before AI, an agent spends 8 minutes writing a response; after AI, the agent reviews a draft in 3 minutes — 5 minutes saved per ticket.

But measure end-to-end. Do not count only generation time — include reading, reviewing, editing, verifying sources, correcting errors, approving, and escalating.

[!] AI saves time only if total workflow time decreases.


COMMON AI UX FAILURE MODES

A chatbot slapped onto the product with no workflow integration. Vague capability, where the user does not know what AI can do. No source visibility, so the user cannot verify output. No edit control, so the user cannot fix output easily. Auto-action too early, taking risky action without approval. Poor failure states, leaving the user unsure what went wrong. Overconfident answers that hide uncertainty. Too much review burden, where AI creates more work than it saves. Creepy personalization, making the user feel watched or manipulated. No feedback loop, so the product team cannot learn from failures.

>> Time saved is the metric this whole module is ultimately trying to protect; every failure mode in this lesson's list is a specific way a feature can quietly erase it.$M23L29$
  ) returning id into v_l29;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.30 — AI UX Design Process
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI UX Design Process',
    30,
    $M23L30$A good AI UX process: map the workflow, identify user pain, decide the AI's role, choose the interaction pattern, define data/context, define the output, define control points, define the risk level, design feedback and correction, prototype, test with real users, evaluate quality and usefulness, add guardrails, roll out gradually, and monitor after launch.

Google's People + AI Guidebook is built as a practical guide for creating useful, responsible AI applications and includes UX/ML guidance, patterns, and workshops.

[!] This fifteen-step process is essentially every lesson in this module, in the order you would actually apply them to a real feature.

>> Treat this lesson as the table of contents for the whole module — each step maps to a cluster of lessons already covered.$M23L30$
  ) returning id into v_l30;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.31 — User Research for AI Products, and AI Prototype Testing
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'User Research for AI Products, and AI Prototype Testing',
    31,
    $M23L31$USER RESEARCH FOR AI PRODUCTS

AI products need user research. Ask users: what part of the workflow is slow? What decisions are hard? What information is hard to find? What would you trust AI to do? What would you never want AI to do? What output format is useful? What sources do you trust? When should AI ask for approval? What mistakes are acceptable? What mistakes are serious?

[!] Do not ask only "would you use AI?" Ask "where do you need help?"


AI PROTOTYPE TESTING

When testing AI prototypes, observe: do users know what to ask? Do users understand output? Do users verify sources? Do users over-trust it? Do users edit output? Do users know how to recover? Do users notice errors? Does AI fit the workflow? Is latency acceptable? Is the output worth the review time?

PM question: **"Does the AI make the user more effective in the actual workflow?"**

>> Research tells you where to build. Prototype testing tells you whether what you built actually works for the specific workflow research identified.$M23L31$
  ) returning id into v_l31;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.32 — PM Checklist for AI UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist for AI UX',
    32,
    $M23L32$Before designing AI UX, ask: what workflow are we improving, and what user pain are we solving? Is AI the right solution? Should this be chat, button, inline, panel, or agent? What does the user already know, and what context should AI know? What should the user provide, and what output format is most useful? Should output be editable? Should AI show sources, confidence, or uncertainty? What actions require confirmation or human approval? Can users undo AI actions? How does AI fail gracefully, and how does it hand off to humans? How do users give feedback? How do we measure usefulness and safety? How do we prevent over-trust?

[!] This checklist is the general-purpose version; the next two lessons specialize it for copilots and agents specifically.

>> Walk through this checklist for any new AI feature before a single mockup gets drawn — most of the failure modes covered earlier in this module trace back to a question on this list that was never asked.$M23L32$
  ) returning id into v_l32;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.33 — PM Checklist for Copilot Design
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist for Copilot Design',
    33,
    $M23L33$Ask: who is the human user, and what work does the copilot help with? Does it draft, suggest, retrieve, classify, or act? What should the human review, and what should they approve? What should the copilot never do? What sources should it use, and what tools can it access? What does the user see before accepting, and can they edit or reject easily? Can they ask for revision? Are sources visible, and are risky cases escalated? Is the final action logged, and is there a rollback? Does it reduce total workflow time and improve quality? Does it increase user confidence while preserving human accountability?

[!] This checklist is the copilot design principle from earlier in this module, expanded into twenty concrete questions.

>> A copilot that scores well on this checklist is, by construction, reducing cognitive load rather than creating review burden — the two ideas are the same test applied at different levels of detail.$M23L33$
  ) returning id into v_l33;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.34 — PM Checklist for AI Agent UX
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist for AI Agent UX',
    34,
    $M23L34$Ask: what goal does the agent pursue, and what plan does it show? What tools can it use, and what data can it access? What steps are visible to the user? What requires confirmation, and what requires human approval? What can be undone, and what cannot? How does the user stop the agent? How does it handle failure and escalate? What summary does it provide at the end, and what actions are logged? How does the user report a mistake? How do we prevent duplicate actions and prompt injection? How do we monitor unsafe actions? What is the kill switch? What level of autonomy is safe?

[!] Notice how much of this checklist pulls directly from the agents module and the evaluation/safety module — agent UX is where product design and safety engineering meet most directly.

>> An agent that cannot answer most of these questions clearly is not ready for real users, regardless of how good its underlying task performance is.$M23L34$
  ) returning id into v_l34;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 23.35 — How to Explain AI UX to Leadership, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'How to Explain AI UX to Leadership, and the Memory Shortcut',
    35,
    $M23L35$HOW TO EXPLAIN AI UX TO LEADERSHIP

Simple explanation: "AI product success is not just model quality. We need to design how users interact with the AI, verify its output, stay in control, and recover from mistakes. The right UX pattern may be a button, inline suggestion, copilot panel, or agent workflow — not always a chatbot."

Support example: "for the support copilot, AI should first summarize the ticket, retrieve policy, and draft a response for agent approval. The UX should show the policy source, let the agent edit, and require approval before sending. We will measure agent acceptance, edit distance, resolution time, CSAT, and wrong-answer rate."

Agent example: "for an AI agent, the UX must show what action the agent plans to take, what data it used, and where human approval is required. The user should be able to stop, edit, approve, or escalate before any high-risk action happens."


THE MEMORY SHORTCUT

AI UX is designing how humans and AI work together. Copilot design is helping humans do work faster and better while keeping them in control. Agent UX is making AI actions visible, controllable, reversible, and safe.

Remember: workflow, then AI role, then interaction pattern, then evidence, then control, then feedback, then metrics.

Use chat when user intent is broad, conversation helps, exploration matters, or natural language is better than menus. Use buttons/panels/inline AI when the task is specific, the workflow is clear, the user needs fast action, or output should appear inside the existing tool. Use a copilot when human judgment matters, drafting/review helps, risk needs approval, or AI should assist but not fully automate. Use an agent when the task is multi-step, tools are needed, the workflow is repeated, and permissions and guardrails are strong.

Watch out for a chatbot slapped onto the product, no capability disclosure, no source visibility, overconfident output, no edit/undo, auto-action too early, poor failure states, too much review burden, weak feedback loops, and creepy personalization.

[!] This module closes the loop on the entire AI/GenAI arc from Modules 16-22 — everything about what LLMs, RAG, agents, fine-tuning, and safety can do only matters if the resulting product is actually usable, trustworthy, and controllable by a real person.

>> The most important PM question: does the AI fit naturally into the workflow while keeping the user informed, in control, and able to recover from mistakes?$M23L35$
  ) returning id into v_l35;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (35 total, one per lesson) — Part 1: Q1-Q17
  -- ─────────────────────────────────────────────────────────────────

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'A team ships an AI feature that gives correct answers, but users cannot verify the source, do not know what the AI can do, and cannot undo its actions. What does this lesson say is the underlying problem?',
    '["Model quality alone is not enough for AI product success — AI product design is not just \"add a chatbot,\" it is designing how humans and AI work together safely and usefully, and this feature is missing the trust, control, and recovery elements that make that collaboration work","Correct answers are sufficient for AI product success, and none of these UX gaps matter as long as the output is accurate","This is purely an engineering bug, not a product design issue","Users will naturally figure out how to trust and control an AI feature over time without any UX design needed"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'A team designs their AI feature the same way they would design a normal button click, assuming the exact same input will always produce the exact same output. What does this lesson say is wrong with this assumption?',
    '["AI UX is probabilistic, not deterministic — the same input may produce slightly different outputs, unlike a normal UX button click, so AI products need extra design care around uncertainty, trust, explainability, and error recovery that deterministic UX does not require","AI systems always produce identical output for identical input, just like a button click","Deterministic and probabilistic systems require exactly the same design approach","This distinction only matters for agents, not for simpler AI features"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'A team starts their AI project by asking \"should we add a chatbot?\" before considering what the user is actually trying to accomplish. What does this lesson recommend instead?',
    '["Start with the core AI UX question: \"where should AI fit in the user''s existing workflow?\" — asking what the user is trying to accomplish, where they are stuck, and what takes too much time, rather than starting from a specific interface choice like chat","Starting with \"should we add chat\" is the correct first question for any AI product","Chatbots are always the right interface regardless of the underlying workflow","The order in which these questions are asked has no effect on the resulting product design"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'A team builds a chat interface for every new AI feature, including a simple \"summarize this document\" capability that users trigger the same way every time. What does this lesson recommend considering instead?',
    '["A one-click action or button, since chat is best when user intent is broad and exploratory, while a specific, repeatable task like summarizing a document is often better served by a simpler pattern like a button or inline action rather than a chat interface","Chat is always the correct interface for any AI feature, regardless of how specific or repeatable the task is","One-click actions and buttons cannot be used for AI-powered features","This distinction is purely aesthetic and does not affect usability"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A team builds a system that automatically resolves and closes customer refund requests with no human review, immediately upon launch, for a brand-new use case. Based on the assistant/copilot/autopilot distinction, what does this lesson say about this approach?',
    '["This jumps straight to autopilot (acting with little or no human review) without first building trust through assistant and copilot stages — this lesson recommends moving to autopilot only when the task is low-risk, well-tested, and properly monitored, none of which applies to a brand-new, unproven use case","Autopilot is the correct starting point for any new AI feature, regardless of how proven or low-risk it is","Assistant, copilot, and autopilot are interchangeable terms with no meaningful difference in risk or design","Human review is unnecessary once an AI system has passed basic functional testing"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A team maps out the eight-step support agent workflow but decides to automate every single step immediately, without considering which specific steps need human speed, accuracy, judgment, or control. What does this lesson say about this approach?',
    '["Not every step in a mapped workflow should be automated — this lesson explicitly asks \"where does the user need speed, accuracy, judgment, or control?\" as a way to decide which specific points in the journey are good candidates for AI help versus which should remain human-controlled","Mapping the user journey means every single step should always be automated with AI","User journey mapping is only useful for identifying automation opportunities, not for identifying where humans should retain control","This approach is correct since automating every step always produces the best outcome"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'An AI feature launches with the generic prompt box description \"ask me anything,\" giving users no indication of what tasks it actually handles well. What does this lesson recommend instead?',
    '["Capability disclosure — clearly stating what the AI can and cannot do, like \"I can summarize this ticket, find relevant policy, draft a reply, or suggest next steps,\" since \"ask me anything\" creates unrealistic expectations and leaves users guessing about the AI''s actual scope","\"Ask me anything\" is the ideal framing for any AI feature since it maximizes perceived flexibility","Capability disclosure is unnecessary as long as the underlying model is capable enough","Users should be expected to discover an AI feature''s capabilities entirely through trial and error"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A new AI chat feature launches with a completely blank chat box and no example prompts, and users struggle to figure out what to type first. What does this lesson recommend?',
    '["Design a better empty state with example prompt suggestions, like \"summarize this document,\" \"extract action items,\" or \"draft a reply\" — a blank chat box is called out as a bad empty state, since good empty states reduce anxiety and show users what to try first","A blank chat box is the ideal empty state design since it gives users maximum creative freedom","Empty state design has no meaningful effect on how users engage with an AI feature","Prompt suggestions should only be generic, like \"ask me anything,\" rather than specific to the user''s context"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A user viewing a support ticket is shown AI suggestions like \"write a poem\" and \"generate marketing copy\" instead of options relevant to the ticket they are looking at. What does this lesson say is missing?',
    '["Context awareness — the AI is not using the current page, workflow state, or relevant data to tailor its suggestions to what the user is actually doing, and should instead surface options like \"summarize ticket,\" \"find policy,\" or \"draft reply\" that match the support ticket context","This is expected behavior, since AI suggestions should always be generic and unrelated to the current context","Context awareness only matters for agents, not for suggestion-based AI features","Users should be expected to ignore irrelevant suggestions without any need for the product to adapt them"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'An AI feature automatically sends customer-facing refund emails immediately after generating them, with no draft or review step, even though the underlying content could be wrong. What does this lesson recommend instead?',
    '["Draft-first design — since user-facing communication is involved and the task carries business risk, the AI should draft the email and let a human review and send it, rather than auto-sending immediately, since draft is safer than auto-send","Auto-sending immediately is the recommended approach for any AI-generated customer communication","Draft-first design is only relevant for internal communications, not customer-facing ones","Review steps should be skipped whenever the AI-generated content appears well-written"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'An AI agent issues a refund and deletes a customer record with no way for the user to reverse either action, and the product has no undo mechanism for either. What does this lesson say should have been designed differently?',
    '["Since some actions like issuing a refund or deleting data cannot be fully undone, this lesson recommends requiring stronger confirmation before such irreversible actions happen in the first place, rather than relying on an after-the-fact undo that may not exist for these action types","Undo mechanisms should always be built for every possible AI action, including issued refunds and deleted data, with no exceptions","Since these actions cannot be undone, no additional confirmation or safeguard is needed beforehand either","This is an acceptable design as long as the AI is highly accurate, regardless of what safeguards exist beforehand"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l12,
    'An AI answer includes a citation labeled simply \"Company Policy\" with no excerpt, no link, and no way for the user to quickly check whether the citation actually supports the claim. What does this lesson say is missing?',
    '["Good source visibility — sources should show the source title, the relevant excerpt, a link to the full source, and make citation easy to verify, none of which this vague \"Company Policy\" label provides, making it hard for the user to verify the answer quickly","This citation is sufficient, since any citation label is better than no citation at all regardless of detail","Source visibility only matters for RAG-based products, not for general AI features that cite sources","Users should be expected to search for the source themselves without any excerpt or link provided"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l13,
    'An AI agent takes 45 seconds to complete a multi-step task, showing only a generic spinner the entire time with no indication of what it is doing. What does this lesson recommend instead?',
    '["Show progress messages like \"searching policy…\", \"checking order…\", \"drafting response…\" — for longer tasks, especially multi-step agent tasks, progress visibility is critical to help users trust the system and understand what is happening while they wait","A generic spinner is always sufficient regardless of how long or how many steps the AI task involves","Progress visibility is only relevant for chat-based AI features, not for agent workflows","Users do not need any indication of what the AI is doing during a wait, regardless of task length"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l14,
    'An AI copilot drafts long, detailed support replies, but agents report spending more time double-checking and rewriting these drafts than they would spend writing a reply from scratch. What does this lesson call this problem?',
    '["This is review burden — a copilot is useful only if review time is lower than manual work time, and if reviewing the AI draft actually takes longer than writing from scratch, the copilot is creating more work than it saves, even though the drafts are technically editable","This is expected and acceptable behavior for any AI copilot, since editing is always part of the workflow regardless of how long it takes","Editability and review burden are the same concept, so having an editable draft automatically means review burden is low","This problem cannot occur as long as the AI output is factually accurate"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l15,
    'A team notices that most users copy an AI-generated answer without ever clicking on the provided source link, and assumes this means the answers are always correct. What does this lesson say about interpreting this signal?',
    '["This is implicit feedback, and it should be interpreted carefully — copying an answer does not always mean it was correct, so this signal alone should not be treated as proof of accuracy without combining it with other evaluation methods like human rating or accuracy checks","Copying an AI answer is explicit feedback that definitively proves the answer was correct","Implicit feedback signals like this should always be taken at face value with no need for careful interpretation","Users clicking or not clicking a source link has no relationship to feedback about the AI''s usefulness"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l16,
    'Users of an AI feature either blindly accept every AI suggestion without checking it, or ignore the AI entirely and never use its suggestions at all. What does this lesson say the product should be aiming for instead of either extreme?',
    '["Calibrated trust, not maximum or zero trust — the goal is appropriate trust, where good UX (like showing sources, confidence explanations, and clear limitations) helps users know when to trust, verify, edit, or escalate, avoiding both over-trust and under-trust","Maximum trust is always the correct goal, and the product should be designed to get users to accept AI output as often as possible","Zero trust is the safest approach, and products should be designed to make users independently verify everything regardless of context","Trust calibration is not a real design consideration and this pattern of behavior cannot be influenced by product design"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l17,
    'An AI system escalates a ticket to a human with only the message \"AI could not help. Contact support,\" providing no summary of what was checked or why escalation happened. What does this lesson say is wrong with this handoff?',
    '["This is a bad handoff — a good handoff should include the user request, an AI summary, sources checked, tools used, missing information, the reason for escalation, and a recommended next step, so the human reviewer does not have to start their investigation from scratch","This handoff message is sufficient, since the human reviewer is expected to start their own independent investigation regardless of what the AI found","Human handoff design has no effect on how much time the human reviewer spends resolving the issue","Providing a reason for escalation is only necessary for agent-based systems, not for simpler AI assistants"]',
    0
  );

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS — Part 2: Q18-Q35
  -- ─────────────────────────────────────────────────────────────────

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l18,
    'An AI assistant silently remembers a user''s past conversations and preferences across sessions, with no way for the user to see, edit, or delete what is being remembered. What does this lesson say is missing?',
    '["AI memory UX — users should be able to understand and control what the AI remembers, including whether they can edit it, delete it, turn memory off, and know whether sensitive data is included, since memory can feel helpful or creepy depending on whether it is designed for consent and control","Memory should always operate silently in the background with no user-facing controls, since this creates the smoothest experience","Users do not need to know what an AI system remembers about them as long as the remembered information improves output quality","Memory UX only matters for enterprise AI products, not for consumer-facing assistants"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l19,
    'An AI scheduling agent asks to access a user''s calendar with no explanation of why it needs this access, whether it is one-time or ongoing, or how to revoke it later. What does this lesson say is missing?',
    '["Good permission UX — which should explain what access is requested, why it is needed, what action the AI will take, whether access is one-time or ongoing, and how to revoke it, none of which this vague permission request provides, leaving the user unable to make an informed decision","This permission request is sufficient, since users do not need to understand why access is being requested as long as the AI eventually completes the task","Permission UX is unnecessary for internal, low-risk features like calendar access","Revocation options are not a meaningful part of permission UX design"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l20,
    'A multi-step refund agent completes its entire task silently and only shows the user a final result, with no visibility into its plan or the individual steps it took along the way. What does this lesson say is missing, and why does it matter?',
    '["Agent UX with visible plans and progress — good agent UX shows the goal, plan, steps, and progress so the user can catch a mistake early, such as noticing the agent checking the wrong order number before it takes an irreversible action, rather than only seeing the outcome after the fact","Nothing is missing, since showing only the final result is the ideal UX for any agent, regardless of task complexity","Progress visibility is only useful for entertainment value and does not affect the user''s ability to catch errors","Agents should never show their plan or steps, since this would overwhelm and confuse the user"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l21,
    'An AI system shows only a generic \"Are you sure?\" dialog before sending a customer email, with no details about who the email goes to, what it says, or what happens next. What does this lesson recommend instead?',
    '["Specific confirmation design that includes the action, target, consequence, whether it is reversible, and risk level — for example, \"Approve sending this email to Priya Shah about Order #123? This will notify the customer and update the ticket status,\" since good confirmation should confirm the consequence, not just the click","A generic \"Are you sure?\" dialog is sufficient for any AI action regardless of its consequences","Confirmation dialogs should be avoided entirely since they slow down the workflow","Specific confirmation details are only necessary for agent-based systems, not for simpler AI features"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l22,
    'A team builds a useful AI feature but requires users to leave their support console, open a separate AI tool, copy relevant information over, and then copy the AI output back into the console. What does this lesson say about this design?',
    '["This violates the principle that AI is most useful when it lives where work happens — good UX means AI has the right context and returns output where the user needs it, and requiring users to copy-paste between tools is called out as bad UX; the best AI UX often disappears into the existing workflow","Requiring users to switch between separate tools is the recommended approach for any AI feature, since it keeps concerns cleanly separated","This design has no meaningful effect on user experience or adoption as long as the AI output itself is high quality","AI features should always exist as separate, standalone tools rather than being embedded inside existing workflows"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l23,
    'An AI writing assistant, when asked to make a customer email more concise, adds a new fact about a discount that was not present in the original draft or any source material. What does this lesson say is wrong with this behavior?',
    '["Writing AI should improve expression, not invent substance — for business writing, AI should not add unsupported facts, and adding a discount detail that was not in the original draft or any source is exactly the kind of substance-inventing behavior this lesson warns against","Adding helpful new information like a discount is a positive and expected behavior for AI writing assistants","This behavior is only a problem if the added fact happens to be factually incorrect, not if it is simply unsupported by the original content","Writing AI is expected to add supporting details regardless of whether they were present in the source material"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l24,
    'An AI analytics assistant tells an executive \"revenue dropped because of the pricing change,\" presenting this as a definitive fact rather than one possible explanation among several. What does this lesson say about this behavior?',
    '["This is exactly the kind of unsupported causality this lesson warns against — good analytics AI UX should separate facts from hypotheses and avoid unsupported causality, presenting something like \"revenue dropped 8%; the data does not prove cause; possible drivers to investigate include pricing, traffic, and conversion\" instead of stating a cause as settled fact","Stating a definitive cause like this is acceptable as long as the revenue drop percentage itself is accurate","Analytics AI is expected to identify a single definitive cause for any metric change to be useful to executives","This behavior is only a problem if the executive acts on the information without further investigation"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l25,
    'An AI invoice extraction tool reports a total amount value but gives the user no way to see which part of the original document that number came from. What does this lesson say is missing?',
    '["Traceability back to the source document — for document AI, every important extracted answer should trace back to the document, and this lesson specifically uses invoice extraction as the example: the total amount should show where in the document it came from so the user can verify it","This is acceptable behavior since document extraction tools are expected to be fully trusted without any traceability","Traceability to source is only necessary for RAG-based chat features, not for document extraction tools","Users should independently re-read the entire original document rather than expecting the AI to show where extracted values came from"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l26,
    'A team designs their AI feature''s error messages, confirmation dialogs, and capability disclosure only in English, with no consideration for screen reader compatibility or low-bandwidth environments. What does this lesson say about this approach?',
    '["This is a gap in accessibility and inclusive AI UX — AI UX patterns like capability disclosure, confirmation design, and error messages need to actually work for screen reader users, non-native speakers, and low-bandwidth connections, not just for the design team''s own setup, since AI should reduce barriers, not create new ones","Accessibility only needs to be considered for traditional UX features, not for AI-specific UX patterns like confirmation dialogs or error messages","This approach is acceptable as long as the majority of users are unaffected by these gaps","Inclusive design principles do not apply to AI products in the same way they apply to traditional software"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l27,
    'A team reports that their AI feature has high adoption and positive CSAT scores, and concludes the feature is fully successful without checking escalation rate, wrong-action rate, or privacy incidents. What does this lesson say is missing from this evaluation?',
    '["Safety metrics — this lesson explicitly lists five metric categories (adoption, efficiency, quality, trust/satisfaction, and safety), and a feature can look great on adoption and satisfaction while quietly failing on safety, so measuring both usefulness and safety is necessary for a complete picture","Adoption and CSAT alone are sufficient to declare an AI feature fully successful","Safety metrics are only relevant for agent-based features, not for features with high user satisfaction","Efficiency and quality metrics are redundant with adoption and trust metrics, so tracking all five categories is unnecessary"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l28,
    'A team observes that users edit only 5% of an AI-drafted support reply on average and concludes the AI must be highly accurate. What does this lesson say about this conclusion?',
    '["Low edit distance measures usefulness, not truth — users may accept wrong output without editing it, so low edit distance alone does not guarantee correctness, and it should be combined with human rating, accuracy checks, and source correctness rather than treated as proof of accuracy on its own","Low edit distance is definitive proof that AI output is accurate and requires no further verification","Edit distance and accuracy are the same metric and always move together in the same direction","This conclusion is valid as long as the acceptance rate is also high"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l29,
    'A team measures \"time saved\" for their AI drafting feature by only counting how fast the AI generates a draft, without including the time agents spend reading, editing, and verifying sources afterward. What does this lesson say is wrong with this measurement?',
    '["Time saved should be measured end-to-end, including reading, reviewing, editing, verifying sources, correcting errors, approving, and escalating, not just generation time — AI only saves time if total workflow time decreases, and generation speed alone does not capture that","Measuring only generation time is the correct and complete way to calculate time saved for any AI feature","Review, editing, and verification time should never be included in time-saved calculations since they are considered separate from the AI feature itself","This measurement approach is valid as long as the AI generates output quickly"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l30,
    'A team is starting a new AI feature and jumps directly to prototyping and building, skipping workflow mapping, user pain identification, and risk-level definition. Based on the AI UX design process in this lesson, what is missing?',
    '["Several of the earlier steps in the fifteen-step process — mapping the workflow, identifying user pain, deciding the AI''s role, defining control points and risk level should happen before prototyping, since this process is meant to be followed roughly in order, and skipping straight to building risks missing foundational product decisions","Prototyping and building are the only steps that actually matter, and the earlier planning steps are optional","The order of these fifteen steps has no bearing on the quality of the resulting AI feature","Workflow mapping and risk-level definition are only relevant for agent-based features, not for simpler AI products"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l31,
    'A team conducts user research by only asking \"would you use an AI feature here?\" without asking what parts of the workflow are actually slow or difficult. What does this lesson recommend instead?',
    '["Ask \"where do you need help?\" instead of only \"would you use AI?\" — this lesson explicitly warns against asking only the generic adoption-interest question, and recommends asking about slow workflow parts, hard decisions, trusted sources, and acceptable versus serious mistakes to actually identify where AI would help","\"Would you use AI here?\" is the single most important and sufficient question for AI product user research","User research is unnecessary for AI products since prototype testing alone is sufficient","Asking about acceptable versus serious mistakes is not a relevant question for AI product user research"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l32,
    'A team is about to launch a new AI feature and has decided on chat as the interface without evaluating whether the output should be editable, whether sources should be shown, or what actions require human approval. Based on the checklist in this lesson, is this feature ready?',
    '["No — the PM checklist for AI UX includes many additional questions beyond interface choice, such as whether output should be editable, whether sources and confidence should be shown, what requires confirmation or approval, and how usefulness and safety will be measured, none of which have been addressed here","Yes, since choosing the interface pattern (chat) is the only decision required before launching an AI feature","Editability and source visibility are optional considerations that do not need to be addressed before launch","This checklist only applies to copilot and agent features, not to simpler chat-based AI features"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l33,
    'A team building a copilot has not defined what the copilot should never do, whether sources are visible to the user, or whether the final action is logged. Based on the copilot design checklist in this lesson, what should the team address before launch?',
    '["All three gaps — the checklist explicitly includes what the copilot should never do, whether sources are visible, and whether the final action is logged, all of which help ensure the copilot reduces cognitive load rather than creating review burden, and preserves human accountability","None of these gaps matter as long as the copilot successfully drafts useful content","Only logging the final action matters; source visibility and defining forbidden actions are optional for copilots","This checklist only applies to fully autonomous agents, not to copilots that require human review"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l34,
    'A team building an AI agent has not defined a kill switch, has not decided which actions require human approval, and has not tested for prompt injection. Based on the AI agent UX checklist in this lesson, is this agent ready to launch?',
    '["No — the checklist explicitly asks about the kill switch, what requires human approval, and how prompt injection is prevented, all of which are unaddressed here; this checklist pulls directly from agent design and safety concepts, since agent UX is where product design and safety engineering meet most directly","Yes, since these three items are optional extras that do not affect whether an agent is ready for real users","Kill switches and approval requirements are only relevant for read-only agents, not for action-taking agents","Prompt injection testing is a purely technical concern unrelated to agent UX design"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l35,
    'A leadership stakeholder asks why the team is spending time designing confirmation flows, source visibility, and undo mechanisms instead of just shipping the AI feature as soon as the model performs well in testing. Based on this lesson''s guidance for explaining AI UX to leadership, what is the appropriate response?',
    '["Explain that AI product success is not just model quality — the team needs to design how users interact with the AI, verify its output, stay in control, and recover from mistakes, since a good model can still fail in production if users cannot trust it, understand it, or undo its mistakes","Model performance in testing is the only factor that determines whether an AI feature is ready to ship","Confirmation flows, source visibility, and undo mechanisms are nice-to-have polish items that can always be safely skipped or added much later","UX design work is only necessary for chat-based AI features, not for simpler AI-powered capabilities"]',
    0
  );

end $$;
