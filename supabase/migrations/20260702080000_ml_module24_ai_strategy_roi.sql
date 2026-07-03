-- AI/ML for Builders — Module 24: AI Strategy, Business Metrics, and ROI
-- 39 lessons — closing the Module 16-24 arc: choosing where AI creates measurable business value

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
  v_l37 uuid; v_l38 uuid; v_l39 uuid;
begin

  select id into v_course_id from courses where sort_order = 2;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 24: AI Strategy, Business Metrics, and ROI',
    'Choosing where AI creates measurable business value — prioritization frameworks, ROI math, adoption and scale, governance, and PM checklists for turning AI pilots into real workflow impact.',
    24
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.1 — Why This Module Matters, and the Simplest Mental Model
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Why This Module Matters, and the Simplest Mental Model',
    1,
    $M24L1$WHY THIS MODULE MATTERS

Many teams say "we need an AI strategy," but they often mean "we need to add AI somewhere." That is not strategy.

AI strategy means deciding which business problems AI should solve, which workflows should change, which use cases are worth building, which use cases should be ignored, what metrics prove success, what risks need controls, what capabilities the company must build, and how to scale from pilots to real impact.

**AI strategy is choosing where AI creates measurable business value, not just where AI looks impressive.**


THE SIMPLEST MENTAL MODEL

Think of AI as a powerful new employee, not magic. A good manager does not say "go do something useful." They say "this is the workflow, this is the problem, this is the goal, these are the rules, this is how we measure success."

Bad AI strategy: "let's build an AI chatbot." Good AI strategy: "our support agents spend 40% of their time searching policies and drafting replies. We will build an AI copilot that retrieves approved policy, drafts responses, and reduces average resolution time by 25% without increasing wrong-answer rate."

[!] AI strategy starts with workflow pain, not model capability.

>> Everything in this module is the discipline of turning "let's use AI" into a statement with a workflow, a metric, and a number attached.$M24L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.2 — AI Strategy Is Not One Feature, and the Wrong Way to Think About AI Strategy
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Strategy Is Not One Feature, and the Wrong Way to Think About AI Strategy',
    2,
    $M24L2$AI STRATEGY IS NOT ONE FEATURE

AI strategy can include internal productivity tools, customer-facing AI features, AI copilots, AI agents, AI search, AI automation, AI-powered analytics, AI recommendations, AI-generated content, AI-assisted operations, AI platform capabilities, and data and governance systems.

A company's AI strategy may have many layers. But at the PM level, the key question is: **which user or business workflow are we improving?**


THE WRONG WAY TO THINK ABOUT AI STRATEGY

Bad questions: where can we add AI? Can we add a chatbot? Can we use GenAI here? Can we say this product is AI-powered? Can we automate everything? Can we replace this team? These questions are too technology-first.

Better questions: what workflow is slow, expensive, or painful? What decision is hard because information is scattered? What work is repetitive but still needs judgment? Where do users need help creating, summarizing, searching, or acting? What measurable outcome would improve? What risk would AI introduce? What human control is needed?

[!] Do not start with AI. Start with the work.

>> Every "bad question" in this lesson is a version of "how do we use this technology." Every "better question" is a version of "what problem do we have." That reframing is the whole point of this module.$M24L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.3 — The Right AI Strategy Question, and AI Value Buckets
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The Right AI Strategy Question, and AI Value Buckets',
    3,
    $M24L3$THE RIGHT AI STRATEGY QUESTION

The best question is: **what task becomes faster, better, cheaper, safer, or newly possible because of AI?**

Faster: a support agent replies faster. Better: a sales rep gets better account research. Cheaper: an operations team processes documents with less manual effort. Safer: a compliance team catches risky contracts earlier. Newly possible: users can ask questions across thousands of documents in natural language.

If the AI use case does not improve at least one of these, it may not be worth building.


AI VALUE BUCKETS

AI usually creates value in five main ways: productivity (people complete work faster — drafting, summarizing, searching, coding, reporting, document processing), quality (output becomes more accurate, consistent, or complete — better support replies, compliance checks, documentation, QA review), revenue growth (AI improves conversion, sales, retention, or personalization), cost reduction (AI reduces manual effort, rework, support volume, or operational cost), and risk reduction (AI detects problems earlier or reduces errors — fraud detection, security triage, compliance monitoring, contract risk review).

[!] AI value usually comes from productivity, quality, revenue, cost, or risk.

>> The five buckets in this lesson are the categories every ROI calculation later in this module will trace back to — pick the bucket first, then the metric follows naturally.$M24L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.4 — AI Use-Case Primitives
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Use-Case Primitives',
    4,
    $M24L4$A helpful way to identify AI opportunities is to look for repeated AI task patterns. OpenAI's enterprise guide groups many AI use cases into common "primitives," including content creation, research, coding, data analysis, ideation/strategy, and automation. For PMs, these primitives are useful because they help you spot AI opportunities across departments.

Content creation means draft, rewrite, localize, summarize, generate — marketing copy, support replies, release notes, product docs, training material.

Research means find, synthesize, compare, explain — market research, competitor analysis, customer feedback synthesis, policy search.

Coding means generate, debug, test, explain code — prototype apps, write test cases, generate SQL, review code.

Data analysis means analyze, explain, query, visualize — weekly business review, metric explanation, natural-language analytics, trend detection.

Ideation and strategy means brainstorm, critique, prioritize, plan — product ideas, experiment design, roadmap tradeoffs, launch planning.

Automation means use tools to complete workflows — ticket routing, CRM updates, document processing, agentic workflows.

[!] AI use cases often repeat across teams, even when the business context is different.

>> When someone pitches a brand-new AI idea, checking which of these six primitives it maps to is usually the fastest way to find prior art and avoid reinventing the same wheel a different department already built.$M24L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.5 — AI Strategy Should Prioritize Workflows Not Isolated Tasks, and the AI Opportunity Map
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Strategy Should Prioritize Workflows Not Isolated Tasks, and the AI Opportunity Map',
    5,
    $M24L5$AI STRATEGY SHOULD PRIORITIZE WORKFLOWS, NOT ISOLATED TASKS

A task is one step. A workflow is a chain of steps. Example task: "summarize this customer ticket." Example workflow: read ticket, identify issue, search policy, check order, decide next action, draft reply, get approval, send reply, update ticket.

A task-level AI feature may save 1 minute. A workflow-level AI solution may save 10 minutes and improve quality. OpenAI's guide notes that teams often start with individual tasks but power users eventually identify use cases that span multi-step workflows.

[!] Task AI creates small wins. Workflow AI creates strategic value.


THE AI OPPORTUNITY MAP

To find AI opportunities, map work across the company. For each team, ask what AI could help with.

Support: ticket summaries, policy Q&A, reply drafting, routing. Sales: account briefs, lead scoring, outreach drafts, CRM updates. Marketing: campaign drafts, audience research, localization. Product: feedback synthesis, PRD drafting, experiment design. Engineering: coding assistant, test generation, code review. Operations: document intake, exception handling, report automation. Finance: invoice extraction, variance explanation, forecast support. Legal: contract summarization, clause extraction, risk flags. HR: policy Q&A, onboarding support, employee helpdesk. Analytics: SQL generation, dashboard explanation, insight summaries.

Then prioritize. Do not build everything.

>> An opportunity map without prioritization is just a wish list — the next lesson covers how to actually choose among all these possibilities.$M24L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.6 — Good AI Use Cases, and Bad AI Use Cases
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Good AI Use Cases, and Bad AI Use Cases',
    6,
    $M24L6$GOOD AI USE CASES

Good AI use cases usually have clear user pain, a repetitive workflow, a language-heavy or knowledge-heavy task, high manual effort, enough data/context, a clear quality bar, a clear business metric, manageable risk, a human review path, a measurable baseline, and an adoption owner.

Examples: a support copilot for policy-grounded replies, AI search over internal documentation, contract clause extraction with human review, a sales account brief generator, AI-assisted analytics summaries, AI document intake for operations.

[!] Good AI use cases are painful, repeated, measurable, and controllable.


BAD AI USE CASES

Bad AI use cases usually have a vague problem, no clear user, no measurable metric, high risk with weak guardrails, poor data quality, no source of truth, an unclear workflow, low adoption likelihood, no owner, no evaluation method, and "AI" as the main value proposition.

Examples: a generic chatbot with no defined job, an AI assistant that answers from outdated docs, an agent that can take risky actions with no approvals, an AI dashboard narrator that invents causes, an AI feature that saves 10 seconds but costs too much, an AI writing tool for a workflow where writing is not the bottleneck.

**If you cannot explain the workflow and success metric, do not build the AI feature yet.**

>> Notice these two lists are nearly mirror images of each other — most "bad" use cases are simply "good" use case criteria that were never checked.$M24L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.7 — The AI Prioritization Framework, and Impact vs. Effort Matrix
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The AI Prioritization Framework, and Impact vs. Effort Matrix',
    7,
    $M24L7$THE AI PRIORITIZATION FRAMEWORK

Use a simple scoring model. Score each AI use case from 1 to 5 on business impact (how much value could it create?), user pain (how painful is the current workflow?), frequency (how often does this workflow happen?), feasibility (can we build it with available data, tools, and models?), risk (how bad are mistakes?), adoption likelihood (will users actually use it?), and strategic importance (does it build long-term capability?).

OpenAI's guide recommends prioritizing opportunities using an impact/effort framework and focusing on high-impact, low-effort opportunities to build momentum.

[!] Start with high-impact, low-risk, high-adoption use cases.


IMPACT VS. EFFORT MATRIX

A simple 2x2 matrix helps. High impact, low effort is the best starting point — examples: meeting summarizer, support reply drafting, internal policy Q&A, feedback synthesis. High impact, high effort are strategic bets — examples: an AI agent for support resolution, an AI analytics assistant with database access, an AI-powered personalization platform. Low impact, low effort are self-service or nice-to-have — examples: a small writing assistant, an internal FAQ bot for a narrow topic. Low impact, high effort should be avoided for now — examples: a complex AI feature with unclear user value, full agent automation for a rare workflow.

>> Quick wins build trust. Strategic bets build advantage. Avoid shiny low-impact projects.$M24L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.8 — The AI ROI Formula, and Hard ROI vs. Soft ROI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The AI ROI Formula, and Hard ROI vs. Soft ROI',
    8,
    $M24L8$THE AI ROI FORMULA

Simple formula: **AI ROI = business value created − total cost − risk cost.**

Business value may come from time saved, cost reduced, revenue increased, errors reduced, risk avoided, quality improved, or customer experience improved.

Total cost includes model usage, engineering, data work, evaluation, human review, monitoring, governance, vendor cost, maintenance, and training users.

Risk cost includes wrong answers, privacy incidents, compliance failures, brand damage, bad decisions, operational errors, and user trust loss.

[!] AI ROI is not only token cost. It is full workflow value minus full system cost and risk.


HARD ROI VS. SOFT ROI

Hard ROI is directly measurable financial value — reduced support cost, lower manual processing time, higher conversion, increased revenue, reduced fraud loss, lower engineering time, fewer escalations.

Soft ROI is important but harder to measure — better employee experience, faster decision-making, higher quality, better knowledge access, improved customer trust, more innovation, better consistency.

Soft ROI matters, but PMs should still define measurable proxies. Instead of "better employee productivity," say "reduce time to find policy answers from 8 minutes to 2 minutes."

>> Hard ROI is what goes in the spreadsheet. Soft ROI is what goes in the story leadership tells — a strong AI business case usually needs both, with soft ROI converted into a proxy metric wherever possible.$M24L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.9 — Baseline First, and AI Productivity Metrics
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Baseline First, and AI Productivity Metrics',
    9,
    $M24L9$BASELINE FIRST

Before measuring ROI, define the current baseline — current average handle time, current ticket resolution time, current cost per ticket, current manual review time, current conversion rate, current error rate, current support volume, current report creation time, current customer satisfaction, current employee satisfaction.

Without a baseline, you cannot prove improvement.

PM question: **"What is the current workflow performance before AI?"**


AI PRODUCTIVITY METRICS

Use productivity metrics when AI saves time or increases output — time saved per task, tasks completed per hour, average handle time, report creation time, document processing time, coding cycle time, draft creation time, search time, number of manual steps removed.

Example: before AI, a support agent spends 9 minutes per ticket; after AI, 6 minutes per ticket — 3 minutes saved per ticket. At a monthly ticket volume of 50,000, that becomes meaningful.

[!] Productivity value = time saved × task volume × cost of time.

>> A baseline is what makes every metric in the rest of this module actually mean something — "3 minutes saved" is meaningless without knowing the starting point was 9 minutes, not 4.$M24L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.10 — AI Quality Metrics, and AI Revenue Metrics
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Quality Metrics, and AI Revenue Metrics',
    10,
    $M24L10$AI QUALITY METRICS

Use quality metrics when AI improves correctness or consistency — factual accuracy, policy compliance, first-contact resolution, error rate, human correction rate, rework rate, QA pass rate, review approval rate, consistency score, completeness score, source citation correctness.

Example: an AI support copilot may not reduce time dramatically, but it may improve policy consistency — that is still valuable.

PM question: **"Does AI make the work better, not just faster?"**


AI REVENUE METRICS

Use revenue metrics when AI improves growth — conversion rate, add-to-cart rate, average order value, revenue per session, retention, expansion revenue, lead conversion, sales cycle time, upsell rate, renewal rate, customer lifetime value.

Example: AI personalization improves onboarding and increases paid conversion. Measure activation, trial-to-paid conversion, retention, and revenue per user.

[!] For revenue AI, connect AI output to actual behavior change, not just clicks.

>> Quality metrics answer "is the work better." Revenue metrics answer "did that better work actually translate into money" — the second is a much higher bar to clear.$M24L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.11 — AI Cost-Reduction Metrics, and AI Risk-Reduction Metrics
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Cost-Reduction Metrics, and AI Risk-Reduction Metrics',
    11,
    $M24L11$AI COST-REDUCTION METRICS

Use cost metrics when AI reduces manual work or operational load — cost per ticket, cost per claim, cost per document processed, manual review hours, support deflection, escalation reduction, rework reduction, fewer duplicate tasks, lower outsourcing cost, lower training time.

Example: AI document extraction reduces manual invoice processing time. Measure field accuracy, human review rate, processing time, cost per invoice, and payment error rate.

PM question: **"Does AI reduce real operational cost, or only shift work to review?"**


AI RISK-REDUCTION METRICS

Use risk metrics when AI reduces bad outcomes — fraud loss reduction, compliance issue detection, security incident response time, contract risk flags, wrong-payment rate, policy violation rate, privacy incident rate, audit finding reduction, error severity reduction.

NIST describes trustworthy AI characteristics as including validity and reliability, safety, security and resilience, accountability and transparency, explainability and interpretability, privacy enhancement, and fairness with harmful bias managed.

[!] Risk-reduction AI should be measured by fewer bad outcomes, not just more alerts.

>> Cost-reduction metrics ask whether work got cheaper. Risk-reduction metrics ask whether the company got safer — both are forms of value, but they need very different proof.$M24L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.12 — AI Adoption Metrics, and AI Satisfaction Metrics
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Adoption Metrics, and AI Satisfaction Metrics',
    12,
    $M24L12$AI ADOPTION METRICS

Even a good AI feature has no value if people do not use it. Adoption metrics: active users, repeat usage, feature adoption rate, tasks completed with AI, AI-assisted workflow share, prompt suggestion usage, draft acceptance rate, agent approval rate, user retention, user satisfaction, training completion.

PM question: **"Are users actually changing their workflow because of AI?"**

McKinsey's 2025 survey notes that many organizations use AI, but most are still in experimentation or pilot stages, with about one-third reporting that they have begun to scale AI programs.


AI SATISFACTION METRICS

Satisfaction matters because AI can be technically correct but annoying. Metrics: CSAT, helpfulness rating, thumbs up/down, user complaints, trust rating, perceived time saved, user confidence, qualitative feedback, support agent satisfaction, employee NPS.

Example: an AI draft may be accurate, but if agents feel it sounds robotic, adoption will suffer.

[!] Measure whether users want AI in the workflow, not just whether AI works technically.

>> A feature can be technically flawless and still fail — adoption and satisfaction metrics are what catch that failure before a business-value metric ever would.$M24L12$
  ) returning id into v_l12;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.13 — AI Safety and Guardrail Metrics, and AI Cost Metrics
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Safety and Guardrail Metrics, and AI Cost Metrics',
    13,
    $M24L13$AI SAFETY AND GUARDRAIL METRICS

Every AI strategy needs safety metrics: hallucination rate, wrong-answer rate, unsupported claim rate, citation error rate, unsafe output rate, privacy leak rate, prompt injection success rate, wrong tool-use rate, human override rate, escalation miss rate, rollback rate, incident rate.

**AI success metrics show value. Guardrail metrics protect trust.**


AI COST METRICS

Track full AI cost: model cost per task, token cost, tool-call cost, retrieval cost, infrastructure cost, vendor cost, human review cost, evaluation cost, monitoring cost, maintenance cost, training cost, incident handling cost.

[!] The cheapest model is not always the cheapest system. A weak model may require more review, retries, escalations, and user correction.

>> Safety metrics and cost metrics are the two categories most likely to get skipped when a project is exciting — both are exactly what this module's ROI formula from earlier subtracts from business value.$M24L13$
  ) returning id into v_l13;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.14 — Cost Per Successful Task, and AI Unit Economics
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Cost Per Successful Task, and AI Unit Economics',
    14,
    $M24L14$COST PER SUCCESSFUL TASK

A very useful AI metric is cost per successful task: **total AI system cost divided by number of successfully completed tasks.**

Example: an AI agent handles 10,000 tasks, total monthly cost is $20,000, and 8,000 tasks succeed. Cost per successful task is $2.50. Now compare this to the human or previous workflow cost.

[!] Measure cost per useful outcome, not cost per model call.


AI UNIT ECONOMICS

AI unit economics asks: does this feature make financial sense per task or per user?

Example, AI support reply draft: model cost $0.03 per ticket, human review cost $1.00 per ticket, time saved $2.50 per ticket, net value $1.47 per ticket — good.

Example, AI agent for rare complex cases: model/tool cost $8 per case, human still reviews fully, time saved $2 per case, net value negative — not good.

PM question: **"Does AI create more value than it costs at the unit level?"**

>> Cost per successful task is the specific metric. Unit economics is the broader discipline of always asking that metric per task or per user, not just in aggregate.$M24L14$
  ) returning id into v_l14;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.15 — AI ROI Calculation Example: Support Copilot
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI ROI Calculation Example: Support Copilot',
    15,
    $M24L15$Use case: AI drafts support replies using policy RAG.

Baseline: 100,000 tickets/month, 8 minutes average handling time, $0.60 labor cost per minute, current cost per ticket $4.80.

AI outcome: saves 2 minutes per ticket, labor savings $1.20 per ticket, AI cost $0.10 per ticket, review/QA cost $0.15 per ticket, net savings $0.95 per ticket.

Monthly value: 100,000 × $0.95 = $95,000/month.

But also check guardrails: wrong-answer rate, CSAT, escalation rate, agent acceptance, policy compliance.

[!] A support AI is valuable only if it saves time without reducing answer quality.

>> Notice the net savings figure ($0.95) already had AI cost and review/QA cost subtracted from labor savings — this is the ROI formula from earlier in this module applied line by line to a real example.$M24L15$
  ) returning id into v_l15;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.16 — AI ROI Calculation Example: Document Extraction
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI ROI Calculation Example: Document Extraction',
    16,
    $M24L16$Use case: AI extracts invoice fields.

Baseline: 50,000 invoices/month, 4 minutes manual processing each, $0.50 labor cost per minute, baseline cost $100,000/month.

AI outcome: 70% of invoices processed automatically, 30% need human review, AI system cost $15,000/month, human review cost $30,000/month, total new cost $45,000/month.

Savings: $55,000/month.

But check: extraction accuracy, payment error rate, duplicate invoice rate, compliance issues, vendor complaints.

[!] Automation ROI must include exception handling.

>> The 30% that still needs human review is not a footnote — it is a real, ongoing cost that this calculation deliberately includes rather than hiding behind an impressive-sounding "70% automated" headline.$M24L16$
  ) returning id into v_l16;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.17 — AI ROI Calculation Example: Sales Copilot, and Analytics Assistant
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI ROI Calculation Example: Sales Copilot, and Analytics Assistant',
    17,
    $M24L17$AI ROI CALCULATION EXAMPLE: SALES COPILOT

Use case: AI creates account briefs and outreach drafts.

Baseline: a sales rep spends 45 minutes preparing per account, 1,000 account briefs/month, cost per hour $80, baseline prep cost $60,000/month.

AI outcome: prep time reduced to 20 minutes, time saved 25 minutes each, labor value saved about $33,333/month, AI cost $5,000/month, net productivity value about $28,333/month.

But for sales, bigger value may come from higher response rate, more meetings booked, higher win rate, and faster sales cycle.

PM question: **"Are we measuring only time saved, or also revenue impact?"**


AI ROI CALCULATION EXAMPLE: ANALYTICS ASSISTANT

Use case: AI helps generate weekly business insights.

Baseline: an analyst spends 6 hours per weekly report, 20 reports/week, 120 analyst hours/week.

AI outcome: reduces report drafting time by 40%, saves 48 hours/week, but the analyst still reviews all numbers — AI improves speed, not final ownership.

Metrics: report creation time, metric accuracy, analyst approval rate, executive usefulness, wrong-number rate, decision speed.

[!] Analytics AI that hallucinates numbers can destroy trust quickly.

>> The sales example shows time-saved value likely understating true impact (revenue matters more). The analytics example shows the opposite risk: a single bad number can destroy far more trust than the saved hours are worth.$M24L17$
  ) returning id into v_l17;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.18 — AI Strategy and Experimentation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Strategy and Experimentation',
    18,
    $M24L18$AI business impact should be tested when possible. Use A/B tests, holdout groups, shadow mode, before/after with caution, phased rollout, human review comparison, and workflow time studies.

Example, support copilot A/B test: control is agents using the current workflow, treatment is agents using the AI copilot. Measure resolution time, CSAT, agent acceptance, wrong-answer rate, escalation rate, and cost per ticket.

[!] Do not assume AI value. Prove it in the workflow.

>> Every ROI example in the previous four lessons was a projected calculation. This lesson is the reminder that projections need to be validated with real experiments before anyone treats them as proven value.$M24L18$
  ) returning id into v_l18;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.19 — AI Pilots vs. AI Scale, and Why AI Pilots Fail to Scale
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Pilots vs. AI Scale, and Why AI Pilots Fail to Scale',
    19,
    $M24L19$AI PILOTS VS. AI SCALE

Many companies get stuck in pilots. A pilot is a small test, narrow group, manual support, exciting demo, limited integration. Scale means the system works reliably, is integrated into the workflow, is monitored, is governed, is adopted by users, has a clear owner, and has measurable business impact.

McKinsey's 2025 survey states that the transition from pilots to scaled impact remains a work in progress for many organizations.

[!] A successful demo is not the same as a scaled product.


WHY AI PILOTS FAIL TO SCALE

Common reasons: no clear business owner (nobody owns adoption or value), weak workflow integration (users must copy-paste between tools), poor data quality (sources are outdated or messy), no evaluation (the team cannot prove quality), no guardrails (risk blocks launch), hidden costs (human review, monitoring, and maintenance are ignored), low adoption (users do not change behavior), no operating model (nobody owns prompts, models, data, tools, or incidents).

>> AI scale is mostly product, data, operations, and change management — not just model access.$M24L19$
  ) returning id into v_l19;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.20 — Workflow Redesign, and Human Role Redesign
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Workflow Redesign, and Human Role Redesign',
    20,
    $M24L20$WORKFLOW REDESIGN

AI creates more value when teams redesign workflows, not just add AI on top. McKinsey's 2025 survey says high performers are much more likely to fundamentally redesign workflows, and workflow redesign is one of the strongest contributors to meaningful business impact among tested factors.

Bad: old workflow plus an AI button. Better: a redesigned workflow where AI handles search, draft, routing, and review.

Example, old support flow: agent reads ticket, searches policy, checks order, writes reply, updates ticket. Redesigned AI support flow: AI summarizes ticket, retrieves policy, checks order, drafts reply, agent reviews, one-click update.

[!] AI value often comes from changing the workflow, not adding a feature.


HUMAN ROLE REDESIGN

AI strategy should define how human work changes. Ask: what does AI do? What does the human still own? What does the human review? What gets escalated? What skills are needed? What training is needed? What accountability remains human? What new roles appear?

Example: a support agent's role may shift from writing every reply to reviewing AI drafts, handling exceptions, and improving knowledge base quality.

>> AI does not remove workflow ownership. It changes where human judgment is needed.$M24L20$
  ) returning id into v_l20;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.21 — AI Capability Maturity
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Capability Maturity',
    21,
    $M24L21$Think of AI maturity in stages.

Stage 1, personal productivity: individuals use AI for drafts, summaries, research.

Stage 2, team workflows: teams use shared AI workflows.

Stage 3, productized copilots: AI is embedded in internal tools or customer products.

Stage 4, governed agents: AI uses tools and takes controlled actions.

Stage 5, AI-native operating model: workflows are redesigned around AI, data, humans, and governance.

[!] Companies usually move from personal AI usage to workflow AI to agentic systems.

>> This maturity ladder mirrors the model selection ladder and the agent autonomy levels from earlier modules — the same "earn it through evidence, one level at a time" principle applied at the company level instead of the feature level.$M24L21$
  ) returning id into v_l21;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.22 — Internal AI vs. Customer-Facing AI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Internal AI vs. Customer-Facing AI',
    22,
    $M24L22$There are two broad AI strategy paths.

Internal AI is used by employees — support copilot, sales assistant, engineering copilot, internal knowledge search, document processing, analytics assistant. Benefits: easier to control, users can review, lower customer-facing risk, good place to start.

Customer-facing AI is used directly by customers — AI chatbot, AI search, AI onboarding assistant, AI recommendations, AI-generated user content. Benefits: can improve customer experience, can create product differentiation, can drive revenue. Risks: higher trust risk, more safety requirements, more brand risk, more edge cases.

[!] Start internal when risk is high. Go customer-facing when quality and controls are proven.

>> This is the company-level version of the risk tiers and progressive autonomy ideas from earlier modules — internal-first is simply the lowest-risk rung to start climbing from.$M24L22$
  ) returning id into v_l22;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.23 — AI Feature vs. AI Platform, and Reusable AI Capabilities
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Feature vs. AI Platform, and Reusable AI Capabilities',
    23,
    $M24L23$AI FEATURE VS. AI PLATFORM

An AI feature solves one use case — example, AI summarizes support tickets. An AI platform enables many use cases — example, shared RAG, model routing, prompt management, evaluation, tool calling, guardrails, logging.

Feature mindset: "how do we ship this AI feature?" Platform mindset: "how do we make many AI features safe and easy to build?"

PM question: **"Are we building one feature, or building reusable AI capability?"**


REUSABLE AI CAPABILITIES

Reusable capabilities include prompt templates, a RAG pipeline, document ingestion, vector search, a tool-calling framework, an agent framework, an evaluation harness, model routing, safety filters, a permission system, audit logging, a human approval workflow, a monitoring dashboard, and a feedback system.

These reduce cost and speed up future AI work.

[!] Do not rebuild the same AI plumbing for every use case.

>> Every one of these reusable capabilities corresponds to a lesson somewhere in Modules 16-23 — this lesson is where those individual technical building blocks become a company-level investment decision.$M24L23$
  ) returning id into v_l23;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.24 — AI Operating Model, and AI Governance
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Operating Model, and AI Governance',
    24,
    $M24L24$AI OPERATING MODEL

AI strategy needs an operating model. Define ownership across product (use case, UX, metrics, adoption, roadmap), engineering (architecture, integration, performance, reliability), data/ML (models, evaluation, tuning, retrieval, monitoring), design (AI UX, trust, control, feedback, error states), legal/compliance (risk review, policy, regulated use), security/privacy (data access, permissions, logging, threat modeling), and business teams (workflow ownership, adoption, feedback, ROI).

[!] AI products need cross-functional ownership from day one.


AI GOVERNANCE

Governance means the rules and ownership for using AI safely. Governance includes use-case approval, risk classification, data access rules, model approval, evaluation requirements, human review rules, monitoring, incident response, vendor review, compliance documentation, and audit logs.

NIST's trustworthy AI characteristics include reliability, safety, security, accountability, transparency, explainability, privacy, and fairness considerations; these should be balanced based on context of use.

>> Governance should enable safe scale, not block all innovation.$M24L24$
  ) returning id into v_l24;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.25 — AI Risk Tiers, and AI Strategy and Data Readiness
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Risk Tiers, and AI Strategy and Data Readiness',
    25,
    $M24L25$AI RISK TIERS

Classify AI use cases by risk. Low risk, like AI drafting internal brainstorming notes, needs light review and basic safety. Medium risk, like AI drafting support replies for human approval, needs RAG, citations, human review, and monitoring. High risk, where AI affects money, access, legal, health, employment, or safety, needs strict permissions, human approval, audit logs, compliance review, safety testing, rollback, and monitoring.

[!] Risk tier decides guardrail level.


AI STRATEGY AND DATA READINESS

AI quality depends heavily on data. Ask: where is the data? Who owns it? Is it clean? Is it current? Is it complete? Is it permissioned? Is it structured or unstructured? Are documents duplicated? Are policies outdated? Are labels reliable? Can the AI access data safely? Can users verify sources?

[!] If the knowledge base is messy, the AI product will be messy.

>> Risk tiers decide how much control a use case needs. Data readiness decides whether the use case can even work reliably in the first place — a well-governed feature built on messy data is still a bad feature.$M24L25$
  ) returning id into v_l25;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.26 — Build vs. Buy Strategy, and AI Vendor Evaluation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Build vs. Buy Strategy, and AI Vendor Evaluation',
    26,
    $M24L26$BUILD VS. BUY STRATEGY

For each AI use case, decide whether to buy a vendor product, use a general AI platform, build internally using APIs, fine-tune/customize a model, build traditional ML, or use deterministic automation.

Buy when the use case is common, a vendor solves it well, speed matters, differentiation is low, and integrations exist. Build when the workflow is unique, data is proprietary, differentiation is high, deep integration is needed, and governance/control matters. Use a platform when you need many AI use cases, want shared infrastructure, and teams need safe self-service.

PM question: **"Is our advantage in the model, workflow, data, UX, distribution, or trust?"**


AI VENDOR EVALUATION

When evaluating AI vendors, ask: what exact use case do they solve? What data do they need, and where is it stored? Is customer data used for training? What models are used, and can we customize prompts/workflows? Can we export logs? How are permissions handled? What guardrails exist, and what eval results can they show? What integrations exist, and what is latency? What is the cost model? What happens if output is wrong? What support and SLA exist? Can we turn features off, audit actions, and meet compliance requirements?

[!] Do not buy AI from demos alone. Buy based on workflow fit, risk controls, and measurable value.

>> Build vs. buy is the strategic decision. Vendor evaluation is the due diligence you run once you have leaned toward buy — skipping it is how teams end up locked into a vendor that fails half of this checklist.$M24L26$
  ) returning id into v_l26;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.27 — AI Moat and Competitive Advantage, and AI Feature Differentiation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Moat and Competitive Advantage, and AI Feature Differentiation',
    27,
    $M24L27$AI MOAT AND COMPETITIVE ADVANTAGE

AI advantage can come from different places. Model advantage means you have a better model — hard to sustain unless you are a model company. Data advantage means you have proprietary data others do not — very valuable if clean, permissioned, and useful. Workflow advantage means you integrate AI deeply into important workflows — often very defensible. Distribution advantage means you already have users and can embed AI where they work — very powerful. Trust advantage means users trust your brand, governance, and reliability — important in high-risk domains.

[!] For most product teams, the moat is not the model. It is data, workflow, UX, distribution, and trust.


AI FEATURE DIFFERENTIATION

Ask: can competitors copy this with the same model? Do we have unique data? Is our workflow integration deep? Does it improve with usage? Does user feedback improve quality? Does it create switching cost? Does it strengthen the core product? Does it reduce user pain meaningfully? Does it build trust?

Bad differentiation: "we use AI." Good differentiation: "our AI understands your workflow, your data, your permissions, your history, and your business process better than generic tools."

>> Moat is the strategic-level version of this question; differentiation is the same question applied feature by feature, on the roadmap.$M24L27$
  ) returning id into v_l27;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.28 — AI Adoption Strategy, and Power Users and Champions
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Adoption Strategy, and Power Users and Champions',
    28,
    $M24L28$AI ADOPTION STRATEGY

AI adoption does not happen automatically. Adoption requires a clear use case, easy access, training, good UX, trust, manager support, workflow integration, a feedback loop, champions, measurement, and change management.

OpenAI's enterprise guide recommends encouraging adoption through workshops, hackathons, and peer-led learning, and notes that teams should break workflows into individual tasks and map where AI can help.

[!] AI adoption is change management, not only product launch.


POWER USERS AND CHAMPIONS

AI often spreads through power users, who try new workflows, find high-value use cases, teach peers, give feedback, identify failures, and help define best practices.

Companies can support them with office hours, prompt libraries, internal demos, use-case competitions, shared templates, an AI champions network, and training sessions.

PM question: **"Who are the early adopters who can help prove and spread the workflow?"**

>> Adoption strategy is the overall plan. Power users and champions are the specific mechanism most companies actually rely on to make that plan work in practice.$M24L28$
  ) returning id into v_l28;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.29 — AI Training and Enablement, and AI Roadmap Structure
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Training and Enablement, and AI Roadmap Structure',
    29,
    $M24L29$AI TRAINING AND ENABLEMENT

Users need to learn what AI can do, what AI cannot do, how to prompt, how to verify sources, how to review output, when to escalate, how to protect data, how to give feedback, what use cases are approved, and what use cases are not allowed.

[!] AI literacy is part of AI strategy. A powerful tool without training can create low adoption or unsafe use.


AI ROADMAP STRUCTURE

An AI roadmap should include multiple horizons. Horizon 1, quick wins: low-risk, high-value use cases like summaries, drafting, internal search, feedback analysis. Horizon 2, workflow copilots: AI integrated into important workflows like support copilot, sales copilot, analytics assistant, document processing copilot. Horizon 3, agentic automation: AI takes controlled actions like a refund workflow agent, IT helpdesk agent, vendor onboarding agent, report generation agent. Horizon 4, AI-native products: new product experiences not possible before, like a personalized AI coach, natural-language analytics product, autonomous workflow platform, AI-first learning system.

>> Roadmap should balance quick wins and strategic bets.$M24L29$
  ) returning id into v_l29;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.30 — AI Roadmap Prioritization Questions, and AI OKRs
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Roadmap Prioritization Questions, and AI OKRs',
    30,
    $M24L30$AI ROADMAP PRIORITIZATION QUESTIONS

For each roadmap item, ask: what workflow changes? What user pain does it solve? What value bucket does it hit? What baseline do we have? What metric proves success? What data does it need? What model/tool/RAG is needed? What risk tier is it? What human review is needed? What cost per task is acceptable? What adoption effort is needed? What reusable capability does it build?

[!] Every AI roadmap item should have a business case and a risk case.


AI OKRS

AI OKRs should connect to outcomes, not just shipping AI. Bad OKR: "launch 5 AI features." Better OKR: "reduce average support resolution time by 20% using AI-assisted workflows while maintaining CSAT and wrong-answer rate below threshold."

Example objective: improve support efficiency with trusted AI assistance. Key results: reduce average handle time by 20%, achieve 70% agent acceptance of AI drafts, maintain CSAT at or above baseline, keep wrong-answer rate below 1%, reduce policy search time by 50%.

>> AI OKRs should measure workflow improvement, not AI feature count.$M24L30$
  ) returning id into v_l30;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.31 — Balanced AI Scorecard
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Balanced AI Scorecard',
    31,
    $M24L31$Use a balanced scorecard across six categories.

Business value: revenue, cost savings, time saved.

User value: satisfaction, task completion, adoption.

Quality: accuracy, groundedness, acceptance.

Safety: hallucination, privacy, unsafe action.

Operations: latency, cost, uptime, escalation.

Learning: feedback, eval improvement, coverage.

[!] AI success is multi-dimensional. A feature that improves productivity but increases risk may not be acceptable.

>> This scorecard is a compressed version of nearly every metric category covered across this entire course — it is meant to be the one-page summary you bring to a leadership review, not a new set of metrics to invent from scratch.$M24L31$
  ) returning id into v_l31;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.32 — Customer-Facing AI Business Metrics, and Internal AI Business Metrics
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Customer-Facing AI Business Metrics, and Internal AI Business Metrics',
    32,
    $M24L32$CUSTOMER-FACING AI BUSINESS METRICS

For customer-facing AI, track activation, conversion, retention, engagement, task completion, self-service success, support deflection, customer satisfaction, trust rating, complaint rate, escalation rate, revenue per user, and churn. Also track safety: wrong answer rate, hallucination reports, unsafe output, privacy issues, prompt injection attempts, human handoff rate.

[!] Customer-facing AI must improve experience without damaging trust.


INTERNAL AI BUSINESS METRICS

For internal AI, track time saved, employee adoption, repeat usage, output acceptance, manual work reduction, faster cycle time, better quality, fewer errors, lower cost, and employee satisfaction. Also track review burden, wrong output rate, data leakage risk, compliance issues, and over-reliance.

[!] Internal AI is valuable when it changes how work gets done, not when it only creates demos.

>> The two metric sets overlap on quality and safety but diverge sharply on business impact — customer-facing AI is measured by growth and trust, internal AI by workflow efficiency, because the stakeholder and the risk profile are different.$M24L32$
  ) returning id into v_l32;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.33 — AI Strategy by Product Type
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Strategy by Product Type',
    33,
    $M24L33$A SaaS product can use AI for onboarding, support, analytics, workflow automation, admin assistance, and document generation.

A marketplace can use AI for recommendations, search, trust and safety, seller support, fraud detection, and listing optimization.

A consumer app can use AI for personalization, content creation, discovery, assistant experiences, summaries, and recommendations.

An enterprise workflow product can use AI for copilots, agents, knowledge search, document processing, approval workflows, and compliance support.

PM question: **"Where does AI strengthen the product's core job-to-be-done?"**

>> The same underlying AI primitives from earlier in this module (content creation, research, automation, and so on) show up differently in each product type — the primitive doesn't change, but which one matters most does.$M24L33$
  ) returning id into v_l33;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.34 — AI Pricing and Packaging, and AI Margin Considerations
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Pricing and Packaging, and AI Margin Considerations',
    34,
    $M24L34$AI PRICING AND PACKAGING

AI features may affect pricing. Included AI (basic AI features included in the product) is good for adoption. A premium AI tier (advanced AI features in a higher plan) is good when value is clear. Usage-based pricing (charge based on AI usage) is good when cost scales with usage. A seat-based AI add-on (charge per user with AI access) is good for enterprise copilots. Outcome-based pricing (charge based on task completion or value) is harder but powerful.

PM questions: what does AI cost to serve? What value does the user get? Is usage predictable? Is AI core or premium? Do we need limits? How do we prevent cost spikes?


AI MARGIN CONSIDERATIONS

AI can reduce or hurt gross margin. Costs include model inference, retrieval, tool calls, storage, monitoring, human review, vendor fees, support burden, and infrastructure. Revenue may come from higher price, higher conversion, higher retention, lower churn, lower operating cost, and better expansion.

[!] AI features need margin thinking, especially at high scale. A feature users love may still be financially weak if cost per use is too high.

>> Pricing decides how AI cost gets recovered from users. Margin considerations decide whether that recovery is actually enough — a feature can have the "right" pricing model and still lose money if the underlying unit economics were never checked.$M24L34$
  ) returning id into v_l34;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.35 — AI and Product-Market Fit, and AI and Competitive Pressure
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI and Product-Market Fit, and AI and Competitive Pressure',
    35,
    $M24L35$AI AND PRODUCT-MARKET FIT

AI does not replace product-market fit. If the core product does not solve a real problem, adding AI will not fix it.

AI can strengthen PMF when it reduces time to value, makes hard tasks easier, unlocks new user behavior, improves personalization, reduces friction, or creates a new capability. AI can distract from PMF when it adds complexity, solves a non-problem, creates trust issues, makes the product more expensive, or hides weak core value.

[!] AI should amplify product value, not cover up weak product value.


AI AND COMPETITIVE PRESSURE

Sometimes teams build AI because competitors are doing it. That can be valid, but it is not enough. Ask: are competitors solving a real user problem? Are users expecting AI in this workflow? Is AI becoming table stakes? Can we differentiate? Can we build safely? What is the cost of not building? What is the cost of building badly?

[!] Competitive pressure can justify urgency, not weak strategy.

>> Both lessons warn against the same trap from different angles: using AI to paper over a problem — a weak core product in one case, a lack of real strategy in the other.$M24L35$
  ) returning id into v_l35;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.36 — AI Strategic Bets, and AI Strategy Failure Modes
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Strategic Bets, and AI Strategy Failure Modes',
    36,
    $M24L36$AI STRATEGIC BETS

Some AI projects are not immediate ROI wins but build long-term capability. Examples: a shared RAG platform, evaluation infrastructure, an AI governance system, an agent tool framework, data cleanup, internal AI literacy, model routing, permission-aware retrieval, prompt/version management.

These may not look like shiny features, but they enable many future features.

PM question: **"Does this project build reusable capability or only one-off output?"**


AI STRATEGY FAILURE MODES

AI for AI's sake, with no clear user problem. Demo-driven strategy — an impressive prototype with a weak production plan. No baseline, so ROI cannot be proven. No evaluation, so quality cannot be proven. No adoption plan, so users do not change behavior. A weak data foundation, so AI uses bad or outdated sources. Over-automation, where AI acts before trust is earned. Ignoring costs, where model, review, and maintenance costs are underestimated. Ignoring risk, where privacy, compliance, safety, and trust are treated too late. Too many pilots, with many experiments and few scaled outcomes.

>> Strategic bets are the deliberate version of "invest without immediate ROI." Strategy failure modes are what happens when that same pattern occurs by accident instead of by design.$M24L36$
  ) returning id into v_l36;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.37 — AI Strategy Review Template
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'AI Strategy Review Template',
    37,
    $M24L37$For any AI idea, create a one-page strategy brief covering: the use case (what are we building?), the user (who uses it?), the workflow (what current workflow changes?), the pain point (what problem exists today?), the AI role (does AI summarize, retrieve, draft, classify, recommend, or act?), the data/source (what information does AI need?), the output (what does AI produce?), the human role (what does the human review, approve, or own?), the success metric (what metric proves value?), the guardrail metric (what metric protects trust?), the cost (what is expected cost per task?), the risk (what can go wrong?), the launch plan (pilot, shadow mode, limited rollout, or full launch?), and the owner (who owns quality and adoption?).

[!] This fourteen-item brief is deliberately short — it should fit on one page and force a clear answer to each question before engineering time is committed.

>> Every idea in this course's AI/GenAI arc — from a simple RAG feature to a full agent workflow — should be able to fill out this template convincingly before it becomes a roadmap item.$M24L37$
  ) returning id into v_l37;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.38 — PM Checklist for AI Strategy, and PM Checklist for AI ROI
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist for AI Strategy, and PM Checklist for AI ROI',
    38,
    $M24L38$PM CHECKLIST FOR AI STRATEGY

Before committing to an AI use case, ask: what user or business problem are we solving, and why is AI needed? What workflow changes, and is this task frequent enough? Is the pain meaningful enough, and what is the current baseline? What value bucket does this hit, and what metric proves success? What guardrail metric protects trust? What data does the AI need, and is it clean and permissioned? Is this internal or customer-facing, and what risk tier is this? What human review is needed, and what cost per task is acceptable? What adoption plan is needed? What is the smallest useful version, and what is the scaling path? What reusable capability does this build? Who owns it after launch?


PM CHECKLIST FOR AI ROI

Ask: what is the baseline cost/time/error today, and how many times does this workflow happen? How much time can AI save per task, and what is the labor value of that time? Can AI improve conversion or revenue? Can AI reduce errors, rework, risk, or incidents? What is the model cost, engineering cost, human review cost, monitoring cost, and maintenance cost? What is the expected adoption rate? What is cost per successful task, and what is the payback period? What risk cost should be included? What metric proves ROI after launch? What would make us stop or pivot?

[!] These two checklists are the complete distillation of this module — every question maps back to a lesson already covered.

>> Walk through the strategy checklist before greenlighting a use case, and the ROI checklist before declaring it a success — they are sequential gates, not the same gate asked twice.$M24L38$
  ) returning id into v_l38;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 24.39 — How to Explain AI Strategy to Leadership, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'How to Explain AI Strategy to Leadership, and the Memory Shortcut',
    39,
    $M24L39$HOW TO EXPLAIN AI STRATEGY TO LEADERSHIP

Simple explanation: "AI strategy should start with high-value workflows, not with the technology. We should identify repeated tasks where AI can save time, improve quality, reduce cost, grow revenue, or reduce risk. Then we should prioritize use cases based on impact, effort, feasibility, adoption likelihood, and risk."

Support example: "for support, the highest-value AI opportunity is not a generic chatbot. It is a policy-grounded copilot inside the support console that summarizes the ticket, retrieves relevant policy, drafts a response, and lets the agent approve before sending. Success will be measured by lower handle time, higher agent acceptance, stable or improved CSAT, and low wrong-answer rate."

Agent example: "for AI agents, we should not start with full autonomy. We should start with shadow mode and draft-only workflows, then gradually increase autonomy for low-risk, high-volume cases where we have strong evaluation, approvals, audit logs, and rollback."


THE MEMORY SHORTCUT

AI strategy is choosing where AI creates measurable workflow value. AI ROI is business value minus total cost and risk.

Remember: workflow pain, then AI role, then metric, then risk, then cost, then adoption, then scale.

Good AI strategy asks what workflow is being improved, what user pain is real, what business value is measurable, what data AI needs, what risk AI creates, what human control is needed, what the smallest useful version is, what proves ROI, and what enables scale.

Measure AI with time saved, cost reduced, revenue increased, quality improved, risk reduced, adoption, satisfaction, safety, and cost per successful task.

Watch out for AI for AI's sake, impressive demos with weak workflow fit, no baseline, no ROI model, no adoption plan, no evaluation, no guardrails, no owner, too many pilots, and ignoring cost and risk.

[!] This module closes the entire AI/GenAI arc that began in Module 16 — every technical capability covered since then (LLMs, prompting, RAG, agents, fine-tuning, evaluation, safety, UX) only creates value when it is aimed at a real workflow, measured honestly, and scaled deliberately.

>> The most important PM question: is this AI use case valuable enough, safe enough, measurable enough, and adopted enough to change the real workflow?$M24L39$
  ) returning id into v_l39;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (39 total, one per lesson) — Part 1: Q1-Q20
  -- ─────────────────────────────────────────────────────────────────

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'A team says "we need an AI strategy" and their plan is "add an AI chatbot to the product." What does this lesson say is wrong with this plan?',
    '["This is not actually a strategy — AI strategy means deciding which business problems AI should solve and which workflows should change, starting from workflow pain (like \"support agents spend 40% of their time searching policies\") rather than starting from a technology choice like \"add a chatbot\"","\"Add an AI chatbot\" is a complete and sufficient AI strategy for any product","AI strategy and AI features are the same concept with no meaningful distinction","Workflow pain is not relevant to AI strategy planning"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'A team evaluates a new AI idea by asking \"can we say this product is AI-powered?\" rather than asking what workflow problem it solves. What does this lesson say about this approach?',
    '["This is exactly the wrong way to think about AI strategy — these are technology-first questions, and better questions start with the work itself, like what workflow is slow, expensive, or painful, and what measurable outcome would improve","\"Can we say this product is AI-powered\" is one of the best questions to start AI strategy planning with","Technology-first questions and workflow-first questions produce identical AI strategies","This approach is acceptable as long as the resulting feature technically uses AI"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'A team pitches an AI feature that does not clearly make anything faster, better, cheaper, safer, or newly possible, but argues it should still be built because it is technically impressive. What does this lesson say about this use case?',
    '["It may not be worth building — the right AI strategy question is what task becomes faster, better, cheaper, safer, or newly possible because of AI, and if the use case does not improve at least one of these, it likely falls outside all five value buckets (productivity, quality, revenue, cost, risk)","Technical impressiveness alone is a sufficient reason to build any AI feature","All AI features automatically fall into at least one of the five value buckets by definition","Value buckets only apply to customer-facing AI, not to impressive technical demonstrations"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'A product team in the legal department pitches a brand-new AI idea for contract summarization, unaware that the sales team already built something similar for proposal summarization. What does this lesson suggest could have caught this overlap earlier?',
    '["Checking the AI use-case primitives — both of these ideas fall under the \"content creation\" primitive (summarize), and recognizing that AI use cases often repeat across teams, even in different business contexts, would have surfaced the existing prior art before duplicating the effort","Use-case primitives only apply to engineering teams, not to legal or sales use cases","This kind of duplication cannot be prevented by any framework described in this lesson","Content creation and research are the same primitive, so this overlap was unavoidable regardless of planning"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A team builds an AI feature that only summarizes a single support ticket, saving about 1 minute, while ignoring the surrounding steps of searching policy, checking the order, and updating the ticket. What does this lesson say this team is missing?',
    '["The team built task-level AI instead of workflow-level AI — a task-level feature may save 1 minute, but a workflow-level solution spanning multiple steps (search policy, check order, draft reply, update ticket) may save far more time and improve quality, which is why AI strategy should prioritize workflows over isolated tasks","Task-level AI features always create more strategic value than workflow-level solutions","There is no meaningful distinction between a task and a workflow for AI strategy purposes","Summarizing a single ticket is already the complete workflow and nothing else needs to be considered"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A team proposes building a generic chatbot with no defined job, no clear metric, and no identified user, arguing that users will figure out how to use it. What does this lesson say about this proposal?',
    '["This matches several signs of a bad AI use case — a vague problem, no clear user, no measurable metric, and unclear workflow — and this lesson explicitly says if you cannot explain the workflow and success metric, do not build the AI feature yet","This proposal matches the criteria for a good AI use case, since chatbots are inherently valuable regardless of specificity","Users always successfully figure out how to use vague, undefined AI tools without any guidance","A defined user and success metric are optional details that can be added after launch"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A team is choosing between two AI ideas: one is high-impact but requires significant engineering effort, and the other is low-impact but very easy to build. Based on this lesson, what should guide their decision about which to build first?',
    '["Use the impact/effort matrix and prioritization scoring — start with high-impact, low-effort opportunities to build momentum, treat high-impact/high-effort ideas as strategic bets, and avoid low-impact/high-effort projects, while being cautious not to spend too much time on low-impact/low-effort \"nice-to-have\" work","Always choose the highest-effort option regardless of impact, since more effort always signals more value","Effort level has no bearing on prioritization decisions, only impact matters","Low-impact, low-effort projects should always be prioritized first since they are the fastest to ship"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A team calculates AI ROI using only the token/model cost of running the feature, without including engineering time, human review cost, or the risk cost of potential wrong answers. What does this lesson say is missing from this calculation?',
    '["The full ROI formula — AI ROI equals business value created minus total cost minus risk cost, and total cost should include engineering, data work, evaluation, human review, monitoring, and maintenance, while risk cost should include things like wrong answers, privacy incidents, and trust loss, none of which this narrow token-cost calculation captures","Token/model cost alone is a complete and sufficient basis for calculating AI ROI","Risk cost and engineering cost should never be included in an ROI calculation since they are unrelated to AI value","This calculation is already complete since business value was not part of the original scope"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A team wants to prove that a new AI feature reduced support resolution time, but never measured how long resolution took before the feature launched. What does this lesson say is the problem with this plan?',
    '["Without a baseline, the team cannot prove improvement — this lesson explicitly states that you need to define the current baseline (like current average handle time) before measuring ROI, since there is no way to know if resolution time actually improved without knowing the starting point","Baselines are optional and can be estimated retroactively with the same reliability as measuring them beforehand","Proving improvement does not require a baseline, only a measurement after launch","This plan is sufficient since resolution time can always be inferred without a pre-launch baseline"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A team celebrates that their AI feature has not changed resolution time at all, but did not check whether policy compliance or consistency improved. What does this lesson say they might be missing?',
    '["Quality metrics — this lesson notes that an AI support copilot may not reduce time dramatically but may still improve policy consistency, which is valuable in its own right, so the team should check quality metrics like factual accuracy and policy compliance in addition to speed metrics","Quality only matters if it is bundled together with a speed improvement","There is no such thing as an AI feature that provides value without reducing task time","Policy compliance and consistency are not real value drivers according to this lesson"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'An AI document extraction tool successfully processes 70% of invoices automatically, but the team only reports this automation percentage without measuring the cost of the human review needed for the remaining 30%. What does this lesson say is missing?',
    '["Cost-reduction metrics should account for the full picture, including the human review cost for exception handling — this lesson specifically warns that automation ROI must include exception handling, since the 30% still requiring review is a real, ongoing cost that should not be hidden behind an impressive automation percentage","An impressive automation percentage alone is sufficient proof of cost reduction, regardless of remaining review costs","Human review costs for the unprocessed 30% should never be included in an AI cost-reduction calculation","This gap only matters for risk-reduction metrics, not for cost-reduction metrics"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l12,
    'An AI feature is technically accurate and performs well in testing, but employees rarely use it and describe it as annoying or robotic-sounding. What category of metric from this lesson would catch this problem?',
    '["Adoption and satisfaction metrics — this lesson explicitly warns that even a good AI feature has no value if people do not use it, and that AI can be technically correct but annoying, so metrics like feature adoption rate, repeat usage, CSAT, and helpfulness rating are needed to catch this specific kind of failure","Technical accuracy metrics alone are sufficient to determine whether an AI feature is successful","Adoption and satisfaction are the same concept as accuracy and do not need to be measured separately","This problem cannot be detected by any metric category described in this lesson"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l13,
    'A team tracks how many alerts their AI fraud-detection feature generates each week and treats a higher number of alerts as proof the feature is succeeding, without checking whether fraud losses actually decreased. What does this lesson say is wrong with this approach?',
    '["Risk-reduction AI should be measured by fewer bad outcomes, not just more alerts — a higher alert count does not necessarily mean fraud loss is decreasing, and could even indicate more false positives, so the team should track an outcome metric like fraud loss reduction rather than alert volume alone","More alerts always directly correspond to better fraud prevention outcomes","Alert volume is the only meaningful metric for evaluating a fraud-detection AI feature","Guardrail and safety metrics are unrelated to risk-reduction AI use cases like fraud detection"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l14,
    'A team compares two AI agents by looking only at total monthly infrastructure cost, without checking how many tasks each agent actually completed successfully. What does this lesson recommend instead?',
    '["Cost per successful task — total AI system cost divided by number of successfully completed tasks is a more meaningful comparison than raw infrastructure cost, since it captures cost per useful outcome rather than cost per model call or raw spend","Total monthly infrastructure cost alone is the most meaningful metric for comparing AI agents","Cost per successful task and total infrastructure cost always produce identical rankings between systems","Successful task completion is irrelevant to cost comparisons between AI systems"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l15,
    'A team calculates that their support copilot saves $0.95 per ticket after subtracting AI cost and review/QA cost from labor savings, and reports $95,000 in monthly value across 100,000 tickets, but has not checked wrong-answer rate or CSAT. What does this lesson say is still missing?',
    '["Guardrail checks — this lesson explicitly notes that a support AI is valuable only if it saves time without reducing answer quality, so even with a strong net savings calculation, the team still needs to verify wrong-answer rate, CSAT, escalation rate, agent acceptance, and policy compliance before declaring the feature a success","Nothing is missing, since the $95,000 monthly value calculation alone is sufficient to declare success","Guardrail metrics like wrong-answer rate are irrelevant once a positive ROI calculation has been completed","CSAT and escalation rate are only relevant for customer-facing AI, not for internal support copilots"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l16,
    'A team reports that their AI invoice extraction tool automated 70% of invoices, saving $55,000 per month, but has not checked extraction accuracy, payment error rate, or duplicate invoice rate. What does this lesson say about declaring this a success?',
    '["This is premature — this lesson explicitly lists extraction accuracy, payment error rate, duplicate invoice rate, compliance issues, and vendor complaints as things that must be checked, since automation ROI must include exception handling and the quality of what was actually automated, not just the cost savings figure","A positive cost savings figure alone is sufficient to declare this automation project a complete success","Extraction accuracy and payment error rate are irrelevant once a cost-reduction figure has been calculated","Duplicate invoice rate and compliance issues only matter for customer-facing AI, not for internal document processing"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l17,
    'A team measures only the time saved by their AI sales copilot (account brief prep time), while ignoring whether it affected meetings booked or win rate. What does this lesson say might be undercounting the copilot''s true value?',
    '["For sales use cases, bigger value may come from higher response rate, more meetings booked, higher win rate, and faster sales cycle — this lesson explicitly notes that measuring only time saved may miss the larger revenue impact that a sales copilot could be driving","Time saved is always the complete and sufficient measure of value for any sales AI tool","Meetings booked and win rate are metrics that only apply to marketing AI, not sales copilots","Revenue impact cannot be measured for AI features that primarily save time"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l18,
    'A team assumes their new AI copilot is valuable because engineering built it and it seemed to work well in a quick internal check, without running any structured comparison against the current workflow. What does this lesson recommend instead?',
    '["Test the business impact through experimentation — using A/B tests, holdout groups, shadow mode, or phased rollout to compare a treatment group using the AI copilot against a control group using the current workflow, measuring metrics like resolution time, CSAT, and cost per ticket, rather than assuming value without proof","Assuming AI value without testing is an acceptable practice as long as the team is confident in the technology","A/B testing and shadow mode are only relevant for consumer-facing products, not internal workflow tools","Structured experimentation is unnecessary once a feature has passed basic internal review"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l19,
    'An impressive AI demo wins internal praise, but six months later it still has not been integrated into daily workflows, has no clear owner, and has no monitoring in place. What does this lesson say this situation illustrates?',
    '["This illustrates a pilot that failed to scale — common reasons include no clear business owner, weak workflow integration, no evaluation, no guardrails, hidden costs, low adoption, and no operating model, and this lesson explicitly states that a successful demo is not the same as a scaled product","An impressive demo is functionally equivalent to a scaled, production-ready AI product","Pilots that generate initial excitement always naturally progress to full production scale without additional effort","Lack of an owner or monitoring plan has no bearing on whether a pilot successfully scales"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l20,
    'A team simply adds an AI \"summarize\" button on top of their existing support workflow without changing any other steps, and sees only modest results. What does this lesson recommend instead?',
    '["Redesign the workflow around AI rather than just adding a feature on top of the old process — this lesson notes that high performers are much more likely to fundamentally redesign workflows, and gives the example of a redesigned support flow where AI summarizes, retrieves policy, checks order, and drafts a reply, with the agent doing a one-click review, rather than just bolting AI onto one step","Adding an AI button on top of an unchanged workflow is the recommended and most effective approach","Workflow redesign is unnecessary as long as at least one step of the process now involves AI","This lesson recommends against workflow redesign in favor of minimal, incremental feature additions"]',
    0
  );

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS — Part 2: Q21-Q39
  -- ─────────────────────────────────────────────────────────────────

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l21,
    'After introducing an AI copilot, a team keeps support agents writing every reply from scratch and never redefines what agents should now review, approve, or escalate instead. What does this lesson say is missing?',
    '["Human role redesign — this lesson explicitly says AI strategy should define how human work changes, asking what the human still owns, reviews, or escalates, and gives the example of a support agent role shifting from writing every reply to reviewing AI drafts and handling exceptions; skipping this means the workflow has not actually changed even though AI exists","Human role redesign is unnecessary as long as the AI tool itself functions correctly","Agents should continue writing every reply from scratch even after an AI copilot is introduced, per this lesson","This gap only matters for agent-based AI, not for copilots"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l22,
    'A company wants to jump directly to \"governed agents\" that take controlled actions across the business, even though most employees have never used AI for basic drafting or summarization tasks yet. What does this lesson say about this plan?',
    '["This skips earlier stages of AI capability maturity — companies usually move from personal AI usage (Stage 1) to team workflows (Stage 2) to productized copilots (Stage 3) before governed agents (Stage 4), and jumping straight to agents without that foundation mirrors skipping rungs on the model selection ladder or agent autonomy levels from earlier modules","Jumping directly to governed agents is the recommended and most efficient path for any company, regardless of current AI usage maturity","AI capability maturity stages are a purely theoretical framework with no practical bearing on rollout planning","Personal productivity usage and team workflows are not meaningful prerequisites for building agentic systems"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l23,
    'A team wants to launch a customer-facing AI chatbot as their very first AI initiative, before building any internal AI tools or establishing evaluation and safety practices. What does this lesson recommend?',
    '["Start internal when risk is high, and go customer-facing when quality and controls are proven — internal AI is easier to control since employees can review output, creating lower customer-facing risk, and is generally a better place to start before taking on the higher trust risk, safety requirements, and brand risk of customer-facing AI","Customer-facing AI should always be the first AI initiative regardless of an organization''s AI maturity or risk tolerance","Internal and customer-facing AI carry identical risk profiles, so starting order does not matter","Evaluation and safety practices are only relevant for customer-facing AI, not for internal tools"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l24,
    'Every time a new team wants to build an AI feature, they rebuild their own RAG pipeline, evaluation process, and prompt management system from scratch instead of reusing shared infrastructure. What does this lesson say this company is missing?',
    '["A platform mindset and reusable AI capabilities — this lesson distinguishes feature mindset (\"how do we ship this AI feature?\") from platform mindset (\"how do we make many AI features safe and easy to build?\"), and explicitly says not to rebuild the same AI plumbing (like RAG pipelines, evaluation harnesses, and prompt management) for every use case","Rebuilding RAG pipelines and evaluation processes from scratch for each new feature is the recommended approach for maintaining team independence","Platform thinking only matters for companies with more than one AI feature already in production","Reusable AI capabilities provide no meaningful cost or speed benefit over rebuilding for each use case"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l25,
    'An AI initiative is being built with clear engineering ownership, but no one from legal, security, or the business team has been involved in defining risk classification, data access rules, or adoption ownership. What does this lesson say is missing?',
    '["An AI operating model with cross-functional ownership and governance — this lesson explicitly says AI products need cross-functional ownership from day one across product, engineering, data/ML, design, legal/compliance, security/privacy, and business teams, and governance should define use-case approval, risk classification, and data access rules, none of which are covered by engineering ownership alone","Engineering ownership alone is sufficient for any AI initiative, regardless of risk level or business impact","Legal, security, and business team involvement is only necessary for customer-facing AI initiatives","Governance and operating model concerns can always be safely addressed after launch rather than from day one"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l26,
    'A team decides to build a custom AI solution in-house for a common, well-solved problem where several vendors already offer strong products, arguing that building always provides more control. What does this lesson say about this decision?',
    '["Buying may be the better choice here — this lesson says to buy when the use case is common, a vendor solves it well, speed matters, differentiation is low, and integrations exist, and building should generally be reserved for cases where the workflow is unique, data is proprietary, or deep integration and governance control specifically matter","Building in-house is always the superior choice over buying from a vendor, regardless of how common the use case is","Vendor evaluation is unnecessary once a team has decided to build a solution in-house","Differentiation and workflow uniqueness are irrelevant factors in the build versus buy decision"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l27,
    'A company believes its main AI competitive advantage comes from having access to the same general-purpose LLM every competitor also has access to. What does this lesson say about this belief?',
    '["This is likely a weak moat — model advantage is hard to sustain unless you are a model company yourself, and for most product teams, the real moat comes from proprietary data, deep workflow integration, distribution advantage, or trust, not from using the same generally available model everyone else can access","Having access to a capable general-purpose model is always a strong and durable competitive advantage","Data, workflow, and trust advantages are less important than model access for most product teams","Competitive advantage from AI can only ever come from the underlying model itself"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l28,
    'A company builds a genuinely useful AI feature but does nothing beyond announcing it in a company-wide email, and adoption stays low six months later. What does this lesson recommend the company should have done?',
    '["Treat AI adoption as change management — this lesson explicitly says AI adoption does not happen automatically and requires training, good UX, manager support, workflow integration, a feedback loop, and champions, recommending things like office hours, prompt libraries, internal demos, and an AI champions network to help spread and prove the workflow, not just an announcement","A single company-wide announcement is a sufficient and complete adoption strategy for any AI feature","Adoption always happens automatically once a feature is technically useful, regardless of change management effort","Power users and champions are not a meaningful lever for driving AI adoption"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l29,
    'A company rolls out a powerful AI tool to all employees with no guidance on what use cases are approved, how to verify sources, or when to escalate, and several employees misuse it in unsafe ways. What does this lesson say could have prevented this?',
    '["AI training and enablement — this lesson explicitly says AI literacy is part of AI strategy, and that a powerful tool without training can create low adoption or unsafe use; users need to learn what AI can and cannot do, how to verify sources, when to escalate, and what use cases are approved or not allowed","Training and enablement are optional extras that do not meaningfully affect safe or effective AI usage","Powerful AI tools are inherently safe to deploy without any user training or guidance","This outcome could not have been prevented by any strategy described in this lesson"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l30,
    'A team plans their entire AI roadmap around building an ambitious, fully autonomous agent platform, with no near-term low-risk wins planned first. What does this lesson recommend instead?',
    '["Balance quick wins and strategic bets across roadmap horizons — this lesson describes four horizons, starting with low-risk, high-value quick wins (like summaries and drafting), then workflow copilots, then agentic automation, then AI-native products, and explicitly says the roadmap should balance quick wins and strategic bets rather than jumping straight to the most ambitious horizon","Planning exclusively around the most ambitious, long-term AI capability is the recommended roadmap approach","Quick wins like summarization and drafting have no place on a serious AI roadmap","Roadmap horizons are a purely theoretical concept with no bearing on actual planning decisions"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l31,
    'A team sets an OKR of \"launch 5 AI features this quarter\" with no connection to any business outcome or workflow metric. What does this lesson say is wrong with this OKR?',
    '["This is a bad OKR because it measures AI feature count rather than workflow improvement — this lesson explicitly contrasts \"launch 5 AI features\" (bad) with an outcome-based OKR like \"reduce average support resolution time by 20% using AI-assisted workflows while maintaining CSAT and wrong-answer rate below threshold\" (better), since AI OKRs should measure workflow improvement, not AI feature count","\"Launch 5 AI features\" is a strong OKR since it is easy to measure and track","AI OKRs should never include specific numeric key results like handle time or acceptance rate","Feature count and workflow outcome are equally valid ways to frame an AI OKR"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l32,
    'A leadership review of an AI initiative only covers time saved and cost savings, with no discussion of safety incidents, user satisfaction, or operational latency. What does this lesson recommend adding to this review?',
    '["A balanced scorecard across all six categories — business value, user value, quality, safety, operations, and learning — since AI success is multi-dimensional, and a feature that improves productivity (business value) but increases risk (safety) may not be acceptable even if the cost-savings numbers look good on their own","Time saved and cost savings are the only two categories that matter for a leadership review of an AI initiative","Safety and operations metrics are only relevant for engineering reviews, not for leadership business reviews","A balanced scorecard is redundant with a simple cost-savings report and adds no additional insight"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l33,
    'A team building a customer-facing AI recommendation feature measures only internal engineering metrics like model accuracy, without tracking activation, conversion, retention, or trust rating. What does this lesson say is missing?',
    '["Customer-facing AI business metrics — this lesson specifically lists activation, conversion, retention, engagement, self-service success, trust rating, and complaint rate as metrics for customer-facing AI, in addition to safety metrics like wrong answer rate and privacy issues, since customer-facing AI must improve experience without damaging trust, which internal accuracy metrics alone cannot capture","Internal engineering metrics like model accuracy are sufficient on their own to evaluate customer-facing AI success","Customer-facing AI and internal AI should be measured with the identical set of metrics","Trust rating and complaint rate are metrics reserved only for internal AI tools, not customer-facing ones"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l34,
    'A marketplace company copies the exact same AI strategy playbook used by a SaaS company, focusing entirely on onboarding and admin assistance, ignoring opportunities like fraud detection or seller support. What does this lesson say about this approach?',
    '["This ignores how AI strategy should differ by product type — this lesson describes different AI opportunities for different product types (SaaS focuses on onboarding, support, and analytics, while a marketplace can use AI for recommendations, search, trust and safety, seller support, and fraud detection), so the marketplace company is missing opportunities specific to its own product type","AI strategy should always be identical regardless of product type, since the same primitives apply everywhere","Fraud detection and seller support are not valid AI opportunities for a marketplace business","SaaS-specific AI opportunities like onboarding and admin assistance always transfer directly and completely to marketplace businesses"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l35,
    'A team prices their new AI feature the same way regardless of usage volume, then discovers that heavy users are costing far more in model inference than the flat price recovers. What does this lesson say the team should have considered?',
    '["AI margin considerations alongside pricing and packaging — this lesson explicitly warns that AI features need margin thinking, especially at high scale, since a feature users love may still be financially weak if cost per use is too high, and notes that usage-based pricing is a good option specifically when cost scales with usage","Pricing decisions do not need to account for underlying AI cost structure or margin implications","A flat price is always the correct pricing model for AI features regardless of usage variability","Margin considerations only matter for enterprise seat-based pricing, not for other pricing models"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l36,
    'A team adds an impressive AI feature to a product that does not otherwise solve a real user problem, hoping the AI feature alone will drive adoption and retention. What does this lesson say about this strategy?',
    '["AI does not replace product-market fit — this lesson explicitly says if the core product does not solve a real problem, adding AI will not fix it, and warns that AI can distract from PMF when it hides weak core value; AI should amplify product value, not cover up weak product value","Adding an impressive AI feature is a reliable way to compensate for a product that lacks product-market fit","AI features always independently drive adoption and retention regardless of the underlying product''s value","Product-market fit and AI strategy are unrelated concepts with no bearing on each other"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l37,
    'A team is asked to summarize their AI proposal for leadership and produces a 20-page document covering every possible detail, with no single clear statement of the use case, success metric, or owner. What does this lesson recommend instead?',
    '["A one-page AI strategy review template — this lesson recommends a concise brief covering use case, user, workflow, pain point, AI role, data/source, output, human role, success metric, guardrail metric, cost, risk, launch plan, and owner, deliberately kept short so it forces clear answers rather than burying them in a lengthy document","A comprehensive 20-page document is the recommended format for communicating an AI proposal to leadership","Strategy review templates should avoid including cost, risk, or owner information to keep them simple","There is no recommended structure for summarizing an AI proposal according to this lesson"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l38,
    'A team wants to know whether they are ready to commit engineering resources to a new AI use case, and separately wants to know, after launch, whether the investment actually paid off. Based on this lesson, what should they use for each of these two moments?',
    '["The PM checklist for AI strategy before committing resources (covering the problem, workflow, value bucket, risk tier, and owner), and the PM checklist for AI ROI after launch (covering baseline, time/cost/revenue impact, cost per successful task, payback period, and what would make them stop or pivot) — these are sequential gates for two different decision points, not the same checklist asked twice","A single checklist should be used identically both before commitment and after launch, since the questions do not differ","The AI ROI checklist should be used before committing resources, and the AI strategy checklist should be used after launch, reversing the order in this lesson","Neither checklist is necessary once a use case has passed an initial impact/effort scoring exercise"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l39,
    'A leadership stakeholder asks why the team is not building the most advanced, fully autonomous AI agent capability available, given all the technical concepts covered throughout this course. Based on this lesson''s closing guidance, what is the appropriate response?',
    '["Explain that AI strategy should start with high-value workflows, not with the most advanced technology available — the team should prioritize use cases based on impact, effort, feasibility, adoption likelihood, and risk, starting with lower-autonomy approaches like shadow mode and draft-only workflows before earning greater autonomy through evidence, strong evaluation, and guardrails, since the most important question is whether a use case is valuable, safe, measurable, and adopted enough to change the real workflow, not how technically advanced it is","The most technically advanced AI capability should always be pursued first, regardless of workflow fit, risk, or adoption readiness","Autonomy level and technical sophistication are the primary factors that should drive AI strategy decisions","Shadow mode and draft-only workflows are unnecessary once a team has strong technical capability available"]',
    0
  );

end $$;
