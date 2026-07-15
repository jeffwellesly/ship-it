-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 24: AI Strategy, Business Metrics, and ROI
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update modules set description = $M$Choosing where AI creates measurable business value, prioritization frameworks, ROI math, adoption and scale, governance, and PM checklists for turning AI pilots into real workflow impact.$M$ where id = '2acfb5ab-4e42-43c3-8aed-feab5e71eeea';

update lessons set content = $D3f9ded38_9a46_414f_8026_a2681bb87175$Use case: AI extracts invoice fields.

Baseline: 50,000 invoices/month, 4 minutes manual processing each, $0.50 labor cost per minute, baseline cost $100,000/month.

AI outcome: 70% of invoices processed automatically, 30% need human review, AI system cost $15,000/month, human review cost $30,000/month, total new cost $45,000/month.

Savings: $55,000/month.

But check: extraction accuracy, payment error rate, duplicate invoice rate, compliance issues, vendor complaints.

[!] Automation ROI must include exception handling.

>> The 30% that still needs human review is not a footnote, it is a real, ongoing cost that this calculation deliberately includes rather than hiding behind an impressive-sounding "70% automated" headline.$D3f9ded38_9a46_414f_8026_a2681bb87175$ where id = '3f9ded38-9a46-414f-8026-a2681bb87175';

update lessons set content = $D83432a71_3613_4ef8_bc91_1b4a1e366c76$THE RIGHT AI STRATEGY QUESTION

The best question is: **what task becomes faster, better, cheaper, safer, or newly possible because of AI?**

Faster: a support agent replies faster. Better: a sales rep gets better account research. Cheaper: an operations team processes documents with less manual effort. Safer: a compliance team catches risky contracts earlier. Newly possible: users can ask questions across thousands of documents in natural language.

If the AI use case does not improve at least one of these, it may not be worth building.


AI VALUE BUCKETS

AI usually creates value in five main ways: productivity (people complete work faster, drafting, summarizing, searching, coding, reporting, document processing), quality (output becomes more accurate, consistent, or complete, better support replies, compliance checks, documentation, QA review), revenue growth (AI improves conversion, sales, retention, or personalization), cost reduction (AI reduces manual effort, rework, support volume, or operational cost), and risk reduction (AI detects problems earlier or reduces errors, fraud detection, security triage, compliance monitoring, contract risk review).

[!] AI value usually comes from productivity, quality, revenue, cost, or risk.

>> The five buckets in this lesson are the categories every ROI calculation later in this module will trace back to, pick the bucket first, then the metric follows naturally.$D83432a71_3613_4ef8_bc91_1b4a1e366c76$ where id = '83432a71-3613-4ef8-bc91-1b4a1e366c76';

update lessons set content = $Dc8f080bc_89e2_42d9_93d7_1e4663474564$A helpful way to identify AI opportunities is to look for repeated AI task patterns. OpenAI's enterprise guide groups many AI use cases into common "primitives," including content creation, research, coding, data analysis, ideation/strategy, and automation. For PMs, these primitives are useful because they help you spot AI opportunities across departments.

Content creation means draft, rewrite, localize, summarize, generate, marketing copy, support replies, release notes, product docs, training material.

Research means find, synthesize, compare, explain, market research, competitor analysis, customer feedback synthesis, policy search.

Coding means generate, debug, test, explain code, prototype apps, write test cases, generate SQL, review code.

Data analysis means analyze, explain, query, visualize, weekly business review, metric explanation, natural-language analytics, trend detection.

Ideation and strategy means brainstorm, critique, prioritize, plan, product ideas, experiment design, roadmap tradeoffs, launch planning.

Automation means use tools to complete workflows, ticket routing, CRM updates, document processing, agentic workflows.

[!] AI use cases often repeat across teams, even when the business context is different.

>> When someone pitches a brand-new AI idea, checking which of these six primitives it maps to is usually the fastest way to find prior art and avoid reinventing the same wheel a different department already built.$Dc8f080bc_89e2_42d9_93d7_1e4663474564$ where id = 'c8f080bc-89e2-42d9-93d7-1e4663474564';

update lessons set content = $Ddd93199b_a9f4_4130_befa_eca61988003e$AI STRATEGY SHOULD PRIORITIZE WORKFLOWS, NOT ISOLATED TASKS

A task is one step. A workflow is a chain of steps. Example task: "summarize this customer ticket." Example workflow: read ticket, identify issue, search policy, check order, decide next action, draft reply, get approval, send reply, update ticket.

A task-level AI feature may save 1 minute. A workflow-level AI solution may save 10 minutes and improve quality. OpenAI's guide notes that teams often start with individual tasks but power users eventually identify use cases that span multi-step workflows.

[!] Task AI creates small wins. Workflow AI creates strategic value.


THE AI OPPORTUNITY MAP

To find AI opportunities, map work across the company. For each team, ask what AI could help with.

Support: ticket summaries, policy Q&A, reply drafting, routing. Sales: account briefs, lead scoring, outreach drafts, CRM updates. Marketing: campaign drafts, audience research, localization. Product: feedback synthesis, PRD drafting, experiment design. Engineering: coding assistant, test generation, code review. Operations: document intake, exception handling, report automation. Finance: invoice extraction, variance explanation, forecast support. Legal: contract summarization, clause extraction, risk flags. HR: policy Q&A, onboarding support, employee helpdesk. Analytics: SQL generation, dashboard explanation, insight summaries.

Then prioritize. Do not build everything.

>> An opportunity map without prioritization is just a wish list, the next lesson covers how to actually choose among all these possibilities.$Ddd93199b_a9f4_4130_befa_eca61988003e$ where id = 'dd93199b-a9f4-4130-befa-eca61988003e';

update lessons set content = $D63aaa08d_3512_4a04_a505_345c63df861c$GOOD AI USE CASES

Good AI use cases usually have clear user pain, a repetitive workflow, a language-heavy or knowledge-heavy task, high manual effort, enough data/context, a clear quality bar, a clear business metric, manageable risk, a human review path, a measurable baseline, and an adoption owner.

Examples: a support copilot for policy-grounded replies, AI search over internal documentation, contract clause extraction with human review, a sales account brief generator, AI-assisted analytics summaries, AI document intake for operations.

[!] Good AI use cases are painful, repeated, measurable, and controllable.


BAD AI USE CASES

Bad AI use cases usually have a vague problem, no clear user, no measurable metric, high risk with weak guardrails, poor data quality, no source of truth, an unclear workflow, low adoption likelihood, no owner, no evaluation method, and "AI" as the main value proposition.

Examples: a generic chatbot with no defined job, an AI assistant that answers from outdated docs, an agent that can take risky actions with no approvals, an AI dashboard narrator that invents causes, an AI feature that saves 10 seconds but costs too much, an AI writing tool for a workflow where writing is not the bottleneck.

**If you cannot explain the workflow and success metric, do not build the AI feature yet.**

>> Notice these two lists are nearly mirror images of each other, most "bad" use cases are simply "good" use case criteria that were never checked.$D63aaa08d_3512_4a04_a505_345c63df861c$ where id = '63aaa08d-3512-4a04-a505-345c63df861c';

update lessons set content = $D2db9521a_4fc5_49cf_8ffd_7569b0455b49$THE AI PRIORITIZATION FRAMEWORK

Use a simple scoring model. Score each AI use case from 1 to 5 on business impact (how much value could it create?), user pain (how painful is the current workflow?), frequency (how often does this workflow happen?), feasibility (can we build it with available data, tools, and models?), risk (how bad are mistakes?), adoption likelihood (will users actually use it?), and strategic importance (does it build long-term capability?).

OpenAI's guide recommends prioritizing opportunities using an impact/effort framework and focusing on high-impact, low-effort opportunities to build momentum.

[!] Start with high-impact, low-risk, high-adoption use cases.


IMPACT VS. EFFORT MATRIX

A simple 2x2 matrix helps. High impact, low effort is the best starting point, examples: meeting summarizer, support reply drafting, internal policy Q&A, feedback synthesis. High impact, high effort are strategic bets, examples: an AI agent for support resolution, an AI analytics assistant with database access, an AI-powered personalization platform. Low impact, low effort are self-service or nice-to-have, examples: a small writing assistant, an internal FAQ bot for a narrow topic. Low impact, high effort should be avoided for now, examples: a complex AI feature with unclear user value, full agent automation for a rare workflow.

>> Quick wins build trust. Strategic bets build advantage. Avoid shiny low-impact projects.$D2db9521a_4fc5_49cf_8ffd_7569b0455b49$ where id = '2db9521a-4fc5-49cf-8ffd-7569b0455b49';

update lessons set content = $D7c40b4f6_7363_4b7b_957b_f84ee30cca63$THE AI ROI FORMULA

Simple formula: **AI ROI = business value created − total cost − risk cost.**

Business value may come from time saved, cost reduced, revenue increased, errors reduced, risk avoided, quality improved, or customer experience improved.

Total cost includes model usage, engineering, data work, evaluation, human review, monitoring, governance, vendor cost, maintenance, and training users.

Risk cost includes wrong answers, privacy incidents, compliance failures, brand damage, bad decisions, operational errors, and user trust loss.

[!] AI ROI is not only token cost. It is full workflow value minus full system cost and risk.


HARD ROI VS. SOFT ROI

Hard ROI is directly measurable financial value, reduced support cost, lower manual processing time, higher conversion, increased revenue, reduced fraud loss, lower engineering time, fewer escalations.

Soft ROI is important but harder to measure, better employee experience, faster decision-making, higher quality, better knowledge access, improved customer trust, more innovation, better consistency.

Soft ROI matters, but PMs should still define measurable proxies. Instead of "better employee productivity," say "reduce time to find policy answers from 8 minutes to 2 minutes."

>> Hard ROI is what goes in the spreadsheet. Soft ROI is what goes in the story leadership tells, a strong AI business case usually needs both, with soft ROI converted into a proxy metric wherever possible.$D7c40b4f6_7363_4b7b_957b_f84ee30cca63$ where id = '7c40b4f6-7363-4b7b-957b-f84ee30cca63';

update lessons set content = $D1b7e8765_eff4_41c3_b6b7_a7149a181915$BASELINE FIRST

Before measuring ROI, define the current baseline, current average handle time, current ticket resolution time, current cost per ticket, current manual review time, current conversion rate, current error rate, current support volume, current report creation time, current customer satisfaction, current employee satisfaction.

Without a baseline, you cannot prove improvement.

PM question: **"What is the current workflow performance before AI?"**


AI PRODUCTIVITY METRICS

Use productivity metrics when AI saves time or increases output, time saved per task, tasks completed per hour, average handle time, report creation time, document processing time, coding cycle time, draft creation time, search time, number of manual steps removed.

Example: before AI, a support agent spends 9 minutes per ticket; after AI, 6 minutes per ticket, 3 minutes saved per ticket. At a monthly ticket volume of 50,000, that becomes meaningful.

[!] Productivity value = time saved × task volume × cost of time.

>> A baseline is what makes every metric in the rest of this module actually mean something, "3 minutes saved" is meaningless without knowing the starting point was 9 minutes, not 4.$D1b7e8765_eff4_41c3_b6b7_a7149a181915$ where id = '1b7e8765-eff4-41c3-b6b7-a7149a181915';

update lessons set content = $Df2d7dd73_c3eb_4bf8_ade4_0496d7b7c53e$AI QUALITY METRICS

Use quality metrics when AI improves correctness or consistency, factual accuracy, policy compliance, first-contact resolution, error rate, human correction rate, rework rate, QA pass rate, review approval rate, consistency score, completeness score, source citation correctness.

Example: an AI support copilot may not reduce time dramatically, but it may improve policy consistency, that is still valuable.

PM question: **"Does AI make the work better, not just faster?"**


AI REVENUE METRICS

Use revenue metrics when AI improves growth, conversion rate, add-to-cart rate, average order value, revenue per session, retention, expansion revenue, lead conversion, sales cycle time, upsell rate, renewal rate, customer lifetime value.

Example: AI personalization improves onboarding and increases paid conversion. Measure activation, trial-to-paid conversion, retention, and revenue per user.

[!] For revenue AI, connect AI output to actual behavior change, not just clicks.

>> Quality metrics answer "is the work better." Revenue metrics answer "did that better work actually translate into money", the second is a much higher bar to clear.$Df2d7dd73_c3eb_4bf8_ade4_0496d7b7c53e$ where id = 'f2d7dd73-c3eb-4bf8-ade4-0496d7b7c53e';

update lessons set content = $D315a59cc_7fb6_4aca_a378_f76b761d0940$AI COST-REDUCTION METRICS

Use cost metrics when AI reduces manual work or operational load, cost per ticket, cost per claim, cost per document processed, manual review hours, support deflection, escalation reduction, rework reduction, fewer duplicate tasks, lower outsourcing cost, lower training time.

Example: AI document extraction reduces manual invoice processing time. Measure field accuracy, human review rate, processing time, cost per invoice, and payment error rate.

PM question: **"Does AI reduce real operational cost, or only shift work to review?"**


AI RISK-REDUCTION METRICS

Use risk metrics when AI reduces bad outcomes, fraud loss reduction, compliance issue detection, security incident response time, contract risk flags, wrong-payment rate, policy violation rate, privacy incident rate, audit finding reduction, error severity reduction.

NIST describes trustworthy AI characteristics as including validity and reliability, safety, security and resilience, accountability and transparency, explainability and interpretability, privacy enhancement, and fairness with harmful bias managed.

[!] Risk-reduction AI should be measured by fewer bad outcomes, not just more alerts.

>> Cost-reduction metrics ask whether work got cheaper. Risk-reduction metrics ask whether the company got safer, both are forms of value, but they need very different proof.$D315a59cc_7fb6_4aca_a378_f76b761d0940$ where id = '315a59cc-7fb6-4aca-a378-f76b761d0940';

update lessons set content = $D8b819035_7480_4d5e_b2b2_8191dfd7236f$AI ADOPTION METRICS

Even a good AI feature has no value if people do not use it. Adoption metrics: active users, repeat usage, feature adoption rate, tasks completed with AI, AI-assisted workflow share, prompt suggestion usage, draft acceptance rate, agent approval rate, user retention, user satisfaction, training completion.

PM question: **"Are users actually changing their workflow because of AI?"**

McKinsey's 2025 survey notes that many organizations use AI, but most are still in experimentation or pilot stages, with about one-third reporting that they have begun to scale AI programs.


AI SATISFACTION METRICS

Satisfaction matters because AI can be technically correct but annoying. Metrics: CSAT, helpfulness rating, thumbs up/down, user complaints, trust rating, perceived time saved, user confidence, qualitative feedback, support agent satisfaction, employee NPS.

Example: an AI draft may be accurate, but if agents feel it sounds robotic, adoption will suffer.

[!] Measure whether users want AI in the workflow, not just whether AI works technically.

>> A feature can be technically flawless and still fail, adoption and satisfaction metrics are what catch that failure before a business-value metric ever would.$D8b819035_7480_4d5e_b2b2_8191dfd7236f$ where id = '8b819035-7480-4d5e-b2b2-8191dfd7236f';

update lessons set content = $D1e6cfa80_8802_4d18_8462_d6f800d8a9f9$AI SAFETY AND GUARDRAIL METRICS

Every AI strategy needs safety metrics: hallucination rate, wrong-answer rate, unsupported claim rate, citation error rate, unsafe output rate, privacy leak rate, prompt injection success rate, wrong tool-use rate, human override rate, escalation miss rate, rollback rate, incident rate.

**AI success metrics show value. Guardrail metrics protect trust.**


AI COST METRICS

Track full AI cost: model cost per task, token cost, tool-call cost, retrieval cost, infrastructure cost, vendor cost, human review cost, evaluation cost, monitoring cost, maintenance cost, training cost, incident handling cost.

[!] The cheapest model is not always the cheapest system. A weak model may require more review, retries, escalations, and user correction.

>> Safety metrics and cost metrics are the two categories most likely to get skipped when a project is exciting, both are exactly what this module's ROI formula from earlier subtracts from business value.$D1e6cfa80_8802_4d18_8462_d6f800d8a9f9$ where id = '1e6cfa80-8802-4d18-8462-d6f800d8a9f9';

update lessons set content = $D480cf9b5_b750_4930_8dbf_43be5dec6257$COST PER SUCCESSFUL TASK

A very useful AI metric is cost per successful task: **total AI system cost divided by number of successfully completed tasks.**

Example: an AI agent handles 10,000 tasks, total monthly cost is $20,000, and 8,000 tasks succeed. Cost per successful task is $2.50. Now compare this to the human or previous workflow cost.

[!] Measure cost per useful outcome, not cost per model call.


AI UNIT ECONOMICS

AI unit economics asks: does this feature make financial sense per task or per user?

Example, AI support reply draft: model cost $0.03 per ticket, human review cost $1.00 per ticket, time saved $2.50 per ticket, net value $1.47 per ticket, good.

Example, AI agent for rare complex cases: model/tool cost $8 per case, human still reviews fully, time saved $2 per case, net value negative, not good.

PM question: **"Does AI create more value than it costs at the unit level?"**

>> Cost per successful task is the specific metric. Unit economics is the broader discipline of always asking that metric per task or per user, not just in aggregate.$D480cf9b5_b750_4930_8dbf_43be5dec6257$ where id = '480cf9b5-b750-4930-8dbf-43be5dec6257';

update lessons set content = $Dfc92be5b_0d85_428d_8f7d_fc5bc6d28e68$Use case: AI drafts support replies using policy RAG.

Baseline: 100,000 tickets/month, 8 minutes average handling time, $0.60 labor cost per minute, current cost per ticket $4.80.

AI outcome: saves 2 minutes per ticket, labor savings $1.20 per ticket, AI cost $0.10 per ticket, review/QA cost $0.15 per ticket, net savings $0.95 per ticket.

Monthly value: 100,000 × $0.95 = $95,000/month.

But also check guardrails: wrong-answer rate, CSAT, escalation rate, agent acceptance, policy compliance.

[!] A support AI is valuable only if it saves time without reducing answer quality.

>> Notice the net savings figure ($0.95) already had AI cost and review/QA cost subtracted from labor savings, this is the ROI formula from earlier in this module applied line by line to a real example.$Dfc92be5b_0d85_428d_8f7d_fc5bc6d28e68$ where id = 'fc92be5b-0d85-428d-8f7d-fc5bc6d28e68';

update lessons set content = $Dbb66459c_acc7_4adf_926b_642a7528aabc$AI ROI CALCULATION EXAMPLE: SALES COPILOT

Use case: AI creates account briefs and outreach drafts.

Baseline: a sales rep spends 45 minutes preparing per account, 1,000 account briefs/month, cost per hour $80, baseline prep cost $60,000/month.

AI outcome: prep time reduced to 20 minutes, time saved 25 minutes each, labor value saved about $33,333/month, AI cost $5,000/month, net productivity value about $28,333/month.

But for sales, bigger value may come from higher response rate, more meetings booked, higher win rate, and faster sales cycle.

PM question: **"Are we measuring only time saved, or also revenue impact?"**


AI ROI CALCULATION EXAMPLE: ANALYTICS ASSISTANT

Use case: AI helps generate weekly business insights.

Baseline: an analyst spends 6 hours per weekly report, 20 reports/week, 120 analyst hours/week.

AI outcome: reduces report drafting time by 40%, saves 48 hours/week, but the analyst still reviews all numbers, AI improves speed, not final ownership.

Metrics: report creation time, metric accuracy, analyst approval rate, executive usefulness, wrong-number rate, decision speed.

[!] Analytics AI that hallucinates numbers can destroy trust quickly.

>> The sales example shows time-saved value likely understating true impact (revenue matters more). The analytics example shows the opposite risk: a single bad number can destroy far more trust than the saved hours are worth.$Dbb66459c_acc7_4adf_926b_642a7528aabc$ where id = 'bb66459c-acc7-4adf-926b-642a7528aabc';

update lessons set content = $D30c76eba_929c_47f3_8e19_a31574d62657$AI PILOTS VS. AI SCALE

Many companies get stuck in pilots. A pilot is a small test, narrow group, manual support, exciting demo, limited integration. Scale means the system works reliably, is integrated into the workflow, is monitored, is governed, is adopted by users, has a clear owner, and has measurable business impact.

McKinsey's 2025 survey states that the transition from pilots to scaled impact remains a work in progress for many organizations.

[!] A successful demo is not the same as a scaled product.


WHY AI PILOTS FAIL TO SCALE

Common reasons: no clear business owner (nobody owns adoption or value), weak workflow integration (users must copy-paste between tools), poor data quality (sources are outdated or messy), no evaluation (the team cannot prove quality), no guardrails (risk blocks launch), hidden costs (human review, monitoring, and maintenance are ignored), low adoption (users do not change behavior), no operating model (nobody owns prompts, models, data, tools, or incidents).

>> AI scale is mostly product, data, operations, and change management, not just model access.$D30c76eba_929c_47f3_8e19_a31574d62657$ where id = '30c76eba-929c-47f3-8e19-a31574d62657';

update lessons set content = $Df22ee043_9df6_4b20_8568_7ee58c872a23$Think of AI maturity in stages.

Stage 1, personal productivity: individuals use AI for drafts, summaries, research.

Stage 2, team workflows: teams use shared AI workflows.

Stage 3, productized copilots: AI is embedded in internal tools or customer products.

Stage 4, governed agents: AI uses tools and takes controlled actions.

Stage 5, AI-native operating model: workflows are redesigned around AI, data, humans, and governance.

[!] Companies usually move from personal AI usage to workflow AI to agentic systems.

>> This maturity ladder mirrors the model selection ladder and the agent autonomy levels from earlier modules, the same "earn it through evidence, one level at a time" principle applied at the company level instead of the feature level.$Df22ee043_9df6_4b20_8568_7ee58c872a23$ where id = 'f22ee043-9df6-4b20-8568-7ee58c872a23';

update lessons set content = $D110e3fb2_a5bc_4f39_94ce_4e0e90fe149a$There are two broad AI strategy paths.

Internal AI is used by employees, support copilot, sales assistant, engineering copilot, internal knowledge search, document processing, analytics assistant. Benefits: easier to control, users can review, lower customer-facing risk, good place to start.

Customer-facing AI is used directly by customers, AI chatbot, AI search, AI onboarding assistant, AI recommendations, AI-generated user content. Benefits: can improve customer experience, can create product differentiation, can drive revenue. Risks: higher trust risk, more safety requirements, more brand risk, more edge cases.

[!] Start internal when risk is high. Go customer-facing when quality and controls are proven.

>> This is the company-level version of the risk tiers and progressive autonomy ideas from earlier modules, internal-first is simply the lowest-risk rung to start climbing from.$D110e3fb2_a5bc_4f39_94ce_4e0e90fe149a$ where id = '110e3fb2-a5bc-4f39-94ce-4e0e90fe149a';

update lessons set content = $D28cdce35_03b3_4d96_8512_c80de9c2d6e3$AI FEATURE VS. AI PLATFORM

An AI feature solves one use case, example, AI summarizes support tickets. An AI platform enables many use cases, example, shared RAG, model routing, prompt management, evaluation, tool calling, guardrails, logging.

Feature mindset: "how do we ship this AI feature?" Platform mindset: "how do we make many AI features safe and easy to build?"

PM question: **"Are we building one feature, or building reusable AI capability?"**


REUSABLE AI CAPABILITIES

Reusable capabilities include prompt templates, a RAG pipeline, document ingestion, vector search, a tool-calling framework, an agent framework, an evaluation harness, model routing, safety filters, a permission system, audit logging, a human approval workflow, a monitoring dashboard, and a feedback system.

These reduce cost and speed up future AI work.

[!] Do not rebuild the same AI plumbing for every use case.

>> Every one of these reusable capabilities corresponds to a lesson somewhere in Modules 16-23, this lesson is where those individual technical building blocks become a company-level investment decision.$D28cdce35_03b3_4d96_8512_c80de9c2d6e3$ where id = '28cdce35-03b3-4d96-8512-c80de9c2d6e3';

update lessons set content = $D74b9abd0_a5eb_4c75_9d5a_4ac2ab0820f4$AI RISK TIERS

Classify AI use cases by risk. Low risk, like AI drafting internal brainstorming notes, needs light review and basic safety. Medium risk, like AI drafting support replies for human approval, needs RAG, citations, human review, and monitoring. High risk, where AI affects money, access, legal, health, employment, or safety, needs strict permissions, human approval, audit logs, compliance review, safety testing, rollback, and monitoring.

[!] Risk tier decides guardrail level.


AI STRATEGY AND DATA READINESS

AI quality depends heavily on data. Ask: where is the data? Who owns it? Is it clean? Is it current? Is it complete? Is it permissioned? Is it structured or unstructured? Are documents duplicated? Are policies outdated? Are labels reliable? Can the AI access data safely? Can users verify sources?

[!] If the knowledge base is messy, the AI product will be messy.

>> Risk tiers decide how much control a use case needs. Data readiness decides whether the use case can even work reliably in the first place, a well-governed feature built on messy data is still a bad feature.$D74b9abd0_a5eb_4c75_9d5a_4ac2ab0820f4$ where id = '74b9abd0-a5eb-4c75-9d5a-4ac2ab0820f4';

update lessons set content = $D41785f84_1400_4141_8382_e738c8a9ac6a$BUILD VS. BUY STRATEGY

For each AI use case, decide whether to buy a vendor product, use a general AI platform, build internally using APIs, fine-tune/customize a model, build traditional ML, or use deterministic automation.

Buy when the use case is common, a vendor solves it well, speed matters, differentiation is low, and integrations exist. Build when the workflow is unique, data is proprietary, differentiation is high, deep integration is needed, and governance/control matters. Use a platform when you need many AI use cases, want shared infrastructure, and teams need safe self-service.

PM question: **"Is our advantage in the model, workflow, data, UX, distribution, or trust?"**


AI VENDOR EVALUATION

When evaluating AI vendors, ask: what exact use case do they solve? What data do they need, and where is it stored? Is customer data used for training? What models are used, and can we customize prompts/workflows? Can we export logs? How are permissions handled? What guardrails exist, and what eval results can they show? What integrations exist, and what is latency? What is the cost model? What happens if output is wrong? What support and SLA exist? Can we turn features off, audit actions, and meet compliance requirements?

[!] Do not buy AI from demos alone. Buy based on workflow fit, risk controls, and measurable value.

>> Build vs. buy is the strategic decision. Vendor evaluation is the due diligence you run once you have leaned toward buy, skipping it is how teams end up locked into a vendor that fails half of this checklist.$D41785f84_1400_4141_8382_e738c8a9ac6a$ where id = '41785f84-1400-4141-8382-e738c8a9ac6a';

update lessons set content = $Dd950a4d8_9f11_45b7_9b48_e1a9a77f1da1$AI MOAT AND COMPETITIVE ADVANTAGE

AI advantage can come from different places. Model advantage means you have a better model, hard to sustain unless you are a model company. Data advantage means you have proprietary data others do not, very valuable if clean, permissioned, and useful. Workflow advantage means you integrate AI deeply into important workflows, often very defensible. Distribution advantage means you already have users and can embed AI where they work, very powerful. Trust advantage means users trust your brand, governance, and reliability, important in high-risk domains.

[!] For most product teams, the moat is not the model. It is data, workflow, UX, distribution, and trust.


AI FEATURE DIFFERENTIATION

Ask: can competitors copy this with the same model? Do we have unique data? Is our workflow integration deep? Does it improve with usage? Does user feedback improve quality? Does it create switching cost? Does it strengthen the core product? Does it reduce user pain meaningfully? Does it build trust?

Bad differentiation: "we use AI." Good differentiation: "our AI understands your workflow, your data, your permissions, your history, and your business process better than generic tools."

>> Moat is the strategic-level version of this question; differentiation is the same question applied feature by feature, on the roadmap.$Dd950a4d8_9f11_45b7_9b48_e1a9a77f1da1$ where id = 'd950a4d8-9f11-45b7-9b48-e1a9a77f1da1';

update lessons set content = $D783086dd_0876_41b9_b9d9_cc62cfdbc5ee$Use a balanced scorecard across six categories.

Business value: revenue, cost savings, time saved.

User value: satisfaction, task completion, adoption.

Quality: accuracy, groundedness, acceptance.

Safety: hallucination, privacy, unsafe action.

Operations: latency, cost, uptime, escalation.

Learning: feedback, eval improvement, coverage.

[!] AI success is multi-dimensional. A feature that improves productivity but increases risk may not be acceptable.

>> This scorecard is a compressed version of nearly every metric category covered across this entire course, it is meant to be the one-page summary you bring to a leadership review, not a new set of metrics to invent from scratch.$D783086dd_0876_41b9_b9d9_cc62cfdbc5ee$ where id = '783086dd-0876-41b9-b9d9-cc62cfdbc5ee';

update lessons set content = $D8a3e0ccd_72a0_48ff_a3e9_d6737d3e3ff3$CUSTOMER-FACING AI BUSINESS METRICS

For customer-facing AI, track activation, conversion, retention, engagement, task completion, self-service success, support deflection, customer satisfaction, trust rating, complaint rate, escalation rate, revenue per user, and churn. Also track safety: wrong answer rate, hallucination reports, unsafe output, privacy issues, prompt injection attempts, human handoff rate.

[!] Customer-facing AI must improve experience without damaging trust.


INTERNAL AI BUSINESS METRICS

For internal AI, track time saved, employee adoption, repeat usage, output acceptance, manual work reduction, faster cycle time, better quality, fewer errors, lower cost, and employee satisfaction. Also track review burden, wrong output rate, data leakage risk, compliance issues, and over-reliance.

[!] Internal AI is valuable when it changes how work gets done, not when it only creates demos.

>> The two metric sets overlap on quality and safety but diverge sharply on business impact, customer-facing AI is measured by growth and trust, internal AI by workflow efficiency, because the stakeholder and the risk profile are different.$D8a3e0ccd_72a0_48ff_a3e9_d6737d3e3ff3$ where id = '8a3e0ccd-72a0-48ff-a3e9-d6737d3e3ff3';

update lessons set content = $Df92e348c_3cee_4870_81f1_ae10126aca22$A SaaS product can use AI for onboarding, support, analytics, workflow automation, admin assistance, and document generation.

A marketplace can use AI for recommendations, search, trust and safety, seller support, fraud detection, and listing optimization.

A consumer app can use AI for personalization, content creation, discovery, assistant experiences, summaries, and recommendations.

An enterprise workflow product can use AI for copilots, agents, knowledge search, document processing, approval workflows, and compliance support.

PM question: **"Where does AI strengthen the product's core job-to-be-done?"**

>> The same underlying AI primitives from earlier in this module (content creation, research, automation, and so on) show up differently in each product type, the primitive doesn't change, but which one matters most does.$Df92e348c_3cee_4870_81f1_ae10126aca22$ where id = 'f92e348c-3cee-4870-81f1-ae10126aca22';

update lessons set content = $D0e4b5511_f1f8_4877_aa63_fb836b2c436c$AI PRICING AND PACKAGING

AI features may affect pricing. Included AI (basic AI features included in the product) is good for adoption. A premium AI tier (advanced AI features in a higher plan) is good when value is clear. Usage-based pricing (charge based on AI usage) is good when cost scales with usage. A seat-based AI add-on (charge per user with AI access) is good for enterprise copilots. Outcome-based pricing (charge based on task completion or value) is harder but powerful.

PM questions: what does AI cost to serve? What value does the user get? Is usage predictable? Is AI core or premium? Do we need limits? How do we prevent cost spikes?


AI MARGIN CONSIDERATIONS

AI can reduce or hurt gross margin. Costs include model inference, retrieval, tool calls, storage, monitoring, human review, vendor fees, support burden, and infrastructure. Revenue may come from higher price, higher conversion, higher retention, lower churn, lower operating cost, and better expansion.

[!] AI features need margin thinking, especially at high scale. A feature users love may still be financially weak if cost per use is too high.

>> Pricing decides how AI cost gets recovered from users. Margin considerations decide whether that recovery is actually enough, a feature can have the "right" pricing model and still lose money if the underlying unit economics were never checked.$D0e4b5511_f1f8_4877_aa63_fb836b2c436c$ where id = '0e4b5511-f1f8-4877-aa63-fb836b2c436c';

update lessons set content = $Dc4814232_d30c_4c2d_a4e8_ddc01eb2d36f$AI AND PRODUCT-MARKET FIT

AI does not replace product-market fit. If the core product does not solve a real problem, adding AI will not fix it.

AI can strengthen PMF when it reduces time to value, makes hard tasks easier, unlocks new user behavior, improves personalization, reduces friction, or creates a new capability. AI can distract from PMF when it adds complexity, solves a non-problem, creates trust issues, makes the product more expensive, or hides weak core value.

[!] AI should amplify product value, not cover up weak product value.


AI AND COMPETITIVE PRESSURE

Sometimes teams build AI because competitors are doing it. That can be valid, but it is not enough. Ask: are competitors solving a real user problem? Are users expecting AI in this workflow? Is AI becoming table stakes? Can we differentiate? Can we build safely? What is the cost of not building? What is the cost of building badly?

[!] Competitive pressure can justify urgency, not weak strategy.

>> Both lessons warn against the same trap from different angles: using AI to paper over a problem, a weak core product in one case, a lack of real strategy in the other.$Dc4814232_d30c_4c2d_a4e8_ddc01eb2d36f$ where id = 'c4814232-d30c-4c2d-a4e8-ddc01eb2d36f';

update lessons set content = $D98d456ab_61c5_4f45_9675_fae9b28eec5f$AI STRATEGIC BETS

Some AI projects are not immediate ROI wins but build long-term capability. Examples: a shared RAG platform, evaluation infrastructure, an AI governance system, an agent tool framework, data cleanup, internal AI literacy, model routing, permission-aware retrieval, prompt/version management.

These may not look like shiny features, but they enable many future features.

PM question: **"Does this project build reusable capability or only one-off output?"**


AI STRATEGY FAILURE MODES

AI for AI's sake, with no clear user problem. Demo-driven strategy, an impressive prototype with a weak production plan. No baseline, so ROI cannot be proven. No evaluation, so quality cannot be proven. No adoption plan, so users do not change behavior. A weak data foundation, so AI uses bad or outdated sources. Over-automation, where AI acts before trust is earned. Ignoring costs, where model, review, and maintenance costs are underestimated. Ignoring risk, where privacy, compliance, safety, and trust are treated too late. Too many pilots, with many experiments and few scaled outcomes.

>> Strategic bets are the deliberate version of "invest without immediate ROI." Strategy failure modes are what happens when that same pattern occurs by accident instead of by design.$D98d456ab_61c5_4f45_9675_fae9b28eec5f$ where id = '98d456ab-61c5-4f45-9675-fae9b28eec5f';

update lessons set content = $De82bae6e_dcc3_4f79_8a84_5d74dbab2111$For any AI idea, create a one-page strategy brief covering: the use case (what are we building?), the user (who uses it?), the workflow (what current workflow changes?), the pain point (what problem exists today?), the AI role (does AI summarize, retrieve, draft, classify, recommend, or act?), the data/source (what information does AI need?), the output (what does AI produce?), the human role (what does the human review, approve, or own?), the success metric (what metric proves value?), the guardrail metric (what metric protects trust?), the cost (what is expected cost per task?), the risk (what can go wrong?), the launch plan (pilot, shadow mode, limited rollout, or full launch?), and the owner (who owns quality and adoption?).

[!] This fourteen-item brief is deliberately short, it should fit on one page and force a clear answer to each question before engineering time is committed.

>> Every idea in this course's AI/GenAI arc, from a simple RAG feature to a full agent workflow, should be able to fill out this template convincingly before it becomes a roadmap item.$De82bae6e_dcc3_4f79_8a84_5d74dbab2111$ where id = 'e82bae6e-dcc3-4f79-8a84-5d74dbab2111';

update lessons set content = $D84ab8934_c2cf_45be_9cbc_edd801be905e$PM CHECKLIST FOR AI STRATEGY

Before committing to an AI use case, ask: what user or business problem are we solving, and why is AI needed? What workflow changes, and is this task frequent enough? Is the pain meaningful enough, and what is the current baseline? What value bucket does this hit, and what metric proves success? What guardrail metric protects trust? What data does the AI need, and is it clean and permissioned? Is this internal or customer-facing, and what risk tier is this? What human review is needed, and what cost per task is acceptable? What adoption plan is needed? What is the smallest useful version, and what is the scaling path? What reusable capability does this build? Who owns it after launch?


PM CHECKLIST FOR AI ROI

Ask: what is the baseline cost/time/error today, and how many times does this workflow happen? How much time can AI save per task, and what is the labor value of that time? Can AI improve conversion or revenue? Can AI reduce errors, rework, risk, or incidents? What is the model cost, engineering cost, human review cost, monitoring cost, and maintenance cost? What is the expected adoption rate? What is cost per successful task, and what is the payback period? What risk cost should be included? What metric proves ROI after launch? What would make us stop or pivot?

[!] These two checklists are the complete distillation of this module, every question maps back to a lesson already covered.

>> Walk through the strategy checklist before greenlighting a use case, and the ROI checklist before declaring it a success, they are sequential gates, not the same gate asked twice.$D84ab8934_c2cf_45be_9cbc_edd801be905e$ where id = '84ab8934-c2cf-45be-9cbc-edd801be905e';

update lessons set content = $D33fa4db3_e9a6_4ee0_bb85_52b3d57ee2d1$HOW TO EXPLAIN AI STRATEGY TO LEADERSHIP

Simple explanation: "AI strategy should start with high-value workflows, not with the technology. We should identify repeated tasks where AI can save time, improve quality, reduce cost, grow revenue, or reduce risk. Then we should prioritize use cases based on impact, effort, feasibility, adoption likelihood, and risk."

Support example: "for support, the highest-value AI opportunity is not a generic chatbot. It is a policy-grounded copilot inside the support console that summarizes the ticket, retrieves relevant policy, drafts a response, and lets the agent approve before sending. Success will be measured by lower handle time, higher agent acceptance, stable or improved CSAT, and low wrong-answer rate."

Agent example: "for AI agents, we should not start with full autonomy. We should start with shadow mode and draft-only workflows, then gradually increase autonomy for low-risk, high-volume cases where we have strong evaluation, approvals, audit logs, and rollback."


THE MEMORY SHORTCUT

AI strategy is choosing where AI creates measurable workflow value. AI ROI is business value minus total cost and risk.

Remember: workflow pain, then AI role, then metric, then risk, then cost, then adoption, then scale.

Good AI strategy asks what workflow is being improved, what user pain is real, what business value is measurable, what data AI needs, what risk AI creates, what human control is needed, what the smallest useful version is, what proves ROI, and what enables scale.

Measure AI with time saved, cost reduced, revenue increased, quality improved, risk reduced, adoption, satisfaction, safety, and cost per successful task.

Watch out for AI for AI's sake, impressive demos with weak workflow fit, no baseline, no ROI model, no adoption plan, no evaluation, no guardrails, no owner, too many pilots, and ignoring cost and risk.

[!] This module closes the entire AI/GenAI arc that began in Module 16, every technical capability covered since then (LLMs, prompting, RAG, agents, fine-tuning, evaluation, safety, UX) only creates value when it is aimed at a real workflow, measured honestly, and scaled deliberately.

>> The most important PM question: is this AI use case valuable enough, safe enough, measurable enough, and adopted enough to change the real workflow?$D33fa4db3_e9a6_4ee0_bb85_52b3d57ee2d1$ where id = '33fa4db3-e9a6-4ee0-bb85-52b3d57ee2d1';

update questions set choices = $D22e1dd6a_168b_459c_acd3_d8a3982a5457Q$["This is not actually a strategy, AI strategy means deciding which business problems AI should solve and which workflows should change, starting from workflow pain (like \"support agents spend 40% of their time searching policies\") rather than starting from a technology choice like \"add a chatbot\"","\"Add an AI chatbot\" is a complete and sufficient AI strategy for any product","AI strategy and AI features are the same concept with no meaningful distinction","Workflow pain is not relevant to AI strategy planning"]$D22e1dd6a_168b_459c_acd3_d8a3982a5457Q$::jsonb where id = '22e1dd6a-168b-459c-acd3-d8a3982a5457';

update questions set choices = $D4ada8382_a68c_4d47_b1c7_9a491c72e96dQ$["This is exactly the wrong way to think about AI strategy, these are technology-first questions, and better questions start with the work itself, like what workflow is slow, expensive, or painful, and what measurable outcome would improve","\"Can we say this product is AI-powered\" is one of the best questions to start AI strategy planning with","Technology-first questions and workflow-first questions produce identical AI strategies","This approach is acceptable as long as the resulting feature technically uses AI"]$D4ada8382_a68c_4d47_b1c7_9a491c72e96dQ$::jsonb where id = '4ada8382-a68c-4d47-b1c7-9a491c72e96d';

update questions set choices = $D3c97f335_94dd_4735_b6da_2880d2e60474Q$["It may not be worth building, the right AI strategy question is what task becomes faster, better, cheaper, safer, or newly possible because of AI, and if the use case does not improve at least one of these, it likely falls outside all five value buckets (productivity, quality, revenue, cost, risk)","Technical impressiveness alone is a sufficient reason to build any AI feature","All AI features automatically fall into at least one of the five value buckets by definition","Value buckets only apply to customer-facing AI, not to impressive technical demonstrations"]$D3c97f335_94dd_4735_b6da_2880d2e60474Q$::jsonb where id = '3c97f335-94dd-4735-b6da-2880d2e60474';

update questions set choices = $D76e0120b_a9c1_46ac_83a7_a92787f8cd00Q$["Checking the AI use-case primitives, both of these ideas fall under the \"content creation\" primitive (summarize), and recognizing that AI use cases often repeat across teams, even in different business contexts, would have surfaced the existing prior art before duplicating the effort","Use-case primitives only apply to engineering teams, not to legal or sales use cases","This kind of duplication cannot be prevented by any framework described in this lesson","Content creation and research are the same primitive, so this overlap was unavoidable regardless of planning"]$D76e0120b_a9c1_46ac_83a7_a92787f8cd00Q$::jsonb where id = '76e0120b-a9c1-46ac-83a7-a92787f8cd00';

update questions set choices = $Decf41f58_12f5_49e9_896a_0fcead2e698aQ$["The team built task-level AI instead of workflow-level AI, a task-level feature may save 1 minute, but a workflow-level solution spanning multiple steps (search policy, check order, draft reply, update ticket) may save far more time and improve quality, which is why AI strategy should prioritize workflows over isolated tasks","Task-level AI features always create more strategic value than workflow-level solutions","There is no meaningful distinction between a task and a workflow for AI strategy purposes","Summarizing a single ticket is already the complete workflow and nothing else needs to be considered"]$Decf41f58_12f5_49e9_896a_0fcead2e698aQ$::jsonb where id = 'ecf41f58-12f5-49e9-896a-0fcead2e698a';

update questions set choices = $De39038db_14ca_4918_a15d_57bc57d769b5Q$["This matches several signs of a bad AI use case, a vague problem, no clear user, no measurable metric, and unclear workflow, and this lesson explicitly says if you cannot explain the workflow and success metric, do not build the AI feature yet","This proposal matches the criteria for a good AI use case, since chatbots are inherently valuable regardless of specificity","Users always successfully figure out how to use vague, undefined AI tools without any guidance","A defined user and success metric are optional details that can be added after launch"]$De39038db_14ca_4918_a15d_57bc57d769b5Q$::jsonb where id = 'e39038db-14ca-4918-a15d-57bc57d769b5';

update questions set choices = $D4ff55821_47c6_4b8c_9d39_15a768e62a62Q$["Use the impact/effort matrix and prioritization scoring, start with high-impact, low-effort opportunities to build momentum, treat high-impact/high-effort ideas as strategic bets, and avoid low-impact/high-effort projects, while being cautious not to spend too much time on low-impact/low-effort \"nice-to-have\" work","Always choose the highest-effort option regardless of impact, since more effort always signals more value","Effort level has no bearing on prioritization decisions, only impact matters","Low-impact, low-effort projects should always be prioritized first since they are the fastest to ship"]$D4ff55821_47c6_4b8c_9d39_15a768e62a62Q$::jsonb where id = '4ff55821-47c6-4b8c-9d39-15a768e62a62';

update questions set choices = $Deb24c96b_6bd2_40ce_8f6b_99f67f33315dQ$["The full ROI formula, AI ROI equals business value created minus total cost minus risk cost, and total cost should include engineering, data work, evaluation, human review, monitoring, and maintenance, while risk cost should include things like wrong answers, privacy incidents, and trust loss, none of which this narrow token-cost calculation captures","Token/model cost alone is a complete and sufficient basis for calculating AI ROI","Risk cost and engineering cost should never be included in an ROI calculation since they are unrelated to AI value","This calculation is already complete since business value was not part of the original scope"]$Deb24c96b_6bd2_40ce_8f6b_99f67f33315dQ$::jsonb where id = 'eb24c96b-6bd2-40ce-8f6b-99f67f33315d';

update questions set choices = $D4f1d5325_9d0e_4aa4_a91f_45126049b419Q$["Without a baseline, the team cannot prove improvement, this lesson explicitly states that you need to define the current baseline (like current average handle time) before measuring ROI, since there is no way to know if resolution time actually improved without knowing the starting point","Baselines are optional and can be estimated retroactively with the same reliability as measuring them beforehand","Proving improvement does not require a baseline, only a measurement after launch","This plan is sufficient since resolution time can always be inferred without a pre-launch baseline"]$D4f1d5325_9d0e_4aa4_a91f_45126049b419Q$::jsonb where id = '4f1d5325-9d0e-4aa4-a91f-45126049b419';

update questions set choices = $D84907a8c_20c3_4929_80c4_ae0ba2135811Q$["Quality metrics, this lesson notes that an AI support copilot may not reduce time dramatically but may still improve policy consistency, which is valuable in its own right, so the team should check quality metrics like factual accuracy and policy compliance in addition to speed metrics","Quality only matters if it is bundled together with a speed improvement","There is no such thing as an AI feature that provides value without reducing task time","Policy compliance and consistency are not real value drivers according to this lesson"]$D84907a8c_20c3_4929_80c4_ae0ba2135811Q$::jsonb where id = '84907a8c-20c3-4929-80c4-ae0ba2135811';

update questions set choices = $D0ee18ca2_7c3d_4636_839c_d890043f5e9dQ$["Cost-reduction metrics should account for the full picture, including the human review cost for exception handling, this lesson specifically warns that automation ROI must include exception handling, since the 30% still requiring review is a real, ongoing cost that should not be hidden behind an impressive automation percentage","An impressive automation percentage alone is sufficient proof of cost reduction, regardless of remaining review costs","Human review costs for the unprocessed 30% should never be included in an AI cost-reduction calculation","This gap only matters for risk-reduction metrics, not for cost-reduction metrics"]$D0ee18ca2_7c3d_4636_839c_d890043f5e9dQ$::jsonb where id = '0ee18ca2-7c3d-4636-839c-d890043f5e9d';

update questions set choices = $D91b491f6_1869_4400_8a20_41880af8c06fQ$["Adoption and satisfaction metrics, this lesson explicitly warns that even a good AI feature has no value if people do not use it, and that AI can be technically correct but annoying, so metrics like feature adoption rate, repeat usage, CSAT, and helpfulness rating are needed to catch this specific kind of failure","Technical accuracy metrics alone are sufficient to determine whether an AI feature is successful","Adoption and satisfaction are the same concept as accuracy and do not need to be measured separately","This problem cannot be detected by any metric category described in this lesson"]$D91b491f6_1869_4400_8a20_41880af8c06fQ$::jsonb where id = '91b491f6-1869-4400-8a20-41880af8c06f';

update questions set choices = $Dbdaba387_69c3_494f_9177_d18f2e899422Q$["Risk-reduction AI should be measured by fewer bad outcomes, not just more alerts, a higher alert count does not necessarily mean fraud loss is decreasing, and could even indicate more false positives, so the team should track an outcome metric like fraud loss reduction rather than alert volume alone","More alerts always directly correspond to better fraud prevention outcomes","Alert volume is the only meaningful metric for evaluating a fraud-detection AI feature","Guardrail and safety metrics are unrelated to risk-reduction AI use cases like fraud detection"]$Dbdaba387_69c3_494f_9177_d18f2e899422Q$::jsonb where id = 'bdaba387-69c3-494f-9177-d18f2e899422';

update questions set choices = $D5f473e88_261f_4f95_a8a0_7c348b49ac69Q$["Cost per successful task, total AI system cost divided by number of successfully completed tasks is a more meaningful comparison than raw infrastructure cost, since it captures cost per useful outcome rather than cost per model call or raw spend","Total monthly infrastructure cost alone is the most meaningful metric for comparing AI agents","Cost per successful task and total infrastructure cost always produce identical rankings between systems","Successful task completion is irrelevant to cost comparisons between AI systems"]$D5f473e88_261f_4f95_a8a0_7c348b49ac69Q$::jsonb where id = '5f473e88-261f-4f95-a8a0-7c348b49ac69';

update questions set choices = $D00d75e77_1860_4e75_8521_639582d00bd4Q$["Guardrail checks, this lesson explicitly notes that a support AI is valuable only if it saves time without reducing answer quality, so even with a strong net savings calculation, the team still needs to verify wrong-answer rate, CSAT, escalation rate, agent acceptance, and policy compliance before declaring the feature a success","Nothing is missing, since the $95,000 monthly value calculation alone is sufficient to declare success","Guardrail metrics like wrong-answer rate are irrelevant once a positive ROI calculation has been completed","CSAT and escalation rate are only relevant for customer-facing AI, not for internal support copilots"]$D00d75e77_1860_4e75_8521_639582d00bd4Q$::jsonb where id = '00d75e77-1860-4e75-8521-639582d00bd4';

update questions set choices = $D6c7fe40f_6322_4db4_9694_138e52f09e47Q$["This is premature, this lesson explicitly lists extraction accuracy, payment error rate, duplicate invoice rate, compliance issues, and vendor complaints as things that must be checked, since automation ROI must include exception handling and the quality of what was actually automated, not just the cost savings figure","A positive cost savings figure alone is sufficient to declare this automation project a complete success","Extraction accuracy and payment error rate are irrelevant once a cost-reduction figure has been calculated","Duplicate invoice rate and compliance issues only matter for customer-facing AI, not for internal document processing"]$D6c7fe40f_6322_4db4_9694_138e52f09e47Q$::jsonb where id = '6c7fe40f-6322-4db4-9694-138e52f09e47';

update questions set choices = $D6544c0e1_55da_4df9_a85a_e4e1f5a66bd0Q$["For sales use cases, bigger value may come from higher response rate, more meetings booked, higher win rate, and faster sales cycle, this lesson explicitly notes that measuring only time saved may miss the larger revenue impact that a sales copilot could be driving","Time saved is always the complete and sufficient measure of value for any sales AI tool","Meetings booked and win rate are metrics that only apply to marketing AI, not sales copilots","Revenue impact cannot be measured for AI features that primarily save time"]$D6544c0e1_55da_4df9_a85a_e4e1f5a66bd0Q$::jsonb where id = '6544c0e1-55da-4df9-a85a-e4e1f5a66bd0';

update questions set choices = $D63bb3727_e8d9_4a63_b941_38551ffbb421Q$["Test the business impact through experimentation, using A/B tests, holdout groups, shadow mode, or phased rollout to compare a treatment group using the AI copilot against a control group using the current workflow, measuring metrics like resolution time, CSAT, and cost per ticket, rather than assuming value without proof","Assuming AI value without testing is an acceptable practice as long as the team is confident in the technology","A/B testing and shadow mode are only relevant for consumer-facing products, not internal workflow tools","Structured experimentation is unnecessary once a feature has passed basic internal review"]$D63bb3727_e8d9_4a63_b941_38551ffbb421Q$::jsonb where id = '63bb3727-e8d9-4a63-b941-38551ffbb421';

update questions set choices = $D5a76f74c_850d_431a_8c8e_550cab974a52Q$["This illustrates a pilot that failed to scale, common reasons include no clear business owner, weak workflow integration, no evaluation, no guardrails, hidden costs, low adoption, and no operating model, and this lesson explicitly states that a successful demo is not the same as a scaled product","An impressive demo is functionally equivalent to a scaled, production-ready AI product","Pilots that generate initial excitement always naturally progress to full production scale without additional effort","Lack of an owner or monitoring plan has no bearing on whether a pilot successfully scales"]$D5a76f74c_850d_431a_8c8e_550cab974a52Q$::jsonb where id = '5a76f74c-850d-431a-8c8e-550cab974a52';

update questions set choices = $D415153cd_7316_4653_9abd_ed87128d8772Q$["Redesign the workflow around AI rather than just adding a feature on top of the old process, this lesson notes that high performers are much more likely to fundamentally redesign workflows, and gives the example of a redesigned support flow where AI summarizes, retrieves policy, checks order, and drafts a reply, with the agent doing a one-click review, rather than just bolting AI onto one step","Adding an AI button on top of an unchanged workflow is the recommended and most effective approach","Workflow redesign is unnecessary as long as at least one step of the process now involves AI","This lesson recommends against workflow redesign in favor of minimal, incremental feature additions"]$D415153cd_7316_4653_9abd_ed87128d8772Q$::jsonb where id = '415153cd-7316-4653-9abd-ed87128d8772';

update questions set choices = $D112acbbf_55c2_46ef_ab29_8e5cc59c7e87Q$["Human role redesign, this lesson explicitly says AI strategy should define how human work changes, asking what the human still owns, reviews, or escalates, and gives the example of a support agent role shifting from writing every reply to reviewing AI drafts and handling exceptions; skipping this means the workflow has not actually changed even though AI exists","Human role redesign is unnecessary as long as the AI tool itself functions correctly","Agents should continue writing every reply from scratch even after an AI copilot is introduced, per this lesson","This gap only matters for agent-based AI, not for copilots"]$D112acbbf_55c2_46ef_ab29_8e5cc59c7e87Q$::jsonb where id = '112acbbf-55c2-46ef-ab29-8e5cc59c7e87';

update questions set choices = $D96aafcbe_b54d_47c9_b44b_3dc7fc06b970Q$["This skips earlier stages of AI capability maturity, companies usually move from personal AI usage (Stage 1) to team workflows (Stage 2) to productized copilots (Stage 3) before governed agents (Stage 4), and jumping straight to agents without that foundation mirrors skipping rungs on the model selection ladder or agent autonomy levels from earlier modules","Jumping directly to governed agents is the recommended and most efficient path for any company, regardless of current AI usage maturity","AI capability maturity stages are a purely theoretical framework with no practical bearing on rollout planning","Personal productivity usage and team workflows are not meaningful prerequisites for building agentic systems"]$D96aafcbe_b54d_47c9_b44b_3dc7fc06b970Q$::jsonb where id = '96aafcbe-b54d-47c9-b44b-3dc7fc06b970';

update questions set choices = $Df0a7772a_a296_4ead_a03e_454839e2fcecQ$["Start internal when risk is high, and go customer-facing when quality and controls are proven, internal AI is easier to control since employees can review output, creating lower customer-facing risk, and is generally a better place to start before taking on the higher trust risk, safety requirements, and brand risk of customer-facing AI","Customer-facing AI should always be the first AI initiative regardless of an organization's AI maturity or risk tolerance","Internal and customer-facing AI carry identical risk profiles, so starting order does not matter","Evaluation and safety practices are only relevant for customer-facing AI, not for internal tools"]$Df0a7772a_a296_4ead_a03e_454839e2fcecQ$::jsonb where id = 'f0a7772a-a296-4ead-a03e-454839e2fcec';

update questions set choices = $Dca1f3e07_faa4_4390_8225_ac7f963b8d65Q$["A platform mindset and reusable AI capabilities, this lesson distinguishes feature mindset (\"how do we ship this AI feature?\") from platform mindset (\"how do we make many AI features safe and easy to build?\"), and explicitly says not to rebuild the same AI plumbing (like RAG pipelines, evaluation harnesses, and prompt management) for every use case","Rebuilding RAG pipelines and evaluation processes from scratch for each new feature is the recommended approach for maintaining team independence","Platform thinking only matters for companies with more than one AI feature already in production","Reusable AI capabilities provide no meaningful cost or speed benefit over rebuilding for each use case"]$Dca1f3e07_faa4_4390_8225_ac7f963b8d65Q$::jsonb where id = 'ca1f3e07-faa4-4390-8225-ac7f963b8d65';

update questions set choices = $Ded1a1f97_1280_4689_b2d3_48e6ec88be12Q$["An AI operating model with cross-functional ownership and governance, this lesson explicitly says AI products need cross-functional ownership from day one across product, engineering, data/ML, design, legal/compliance, security/privacy, and business teams, and governance should define use-case approval, risk classification, and data access rules, none of which are covered by engineering ownership alone","Engineering ownership alone is sufficient for any AI initiative, regardless of risk level or business impact","Legal, security, and business team involvement is only necessary for customer-facing AI initiatives","Governance and operating model concerns can always be safely addressed after launch rather than from day one"]$Ded1a1f97_1280_4689_b2d3_48e6ec88be12Q$::jsonb where id = 'ed1a1f97-1280-4689-b2d3-48e6ec88be12';

update questions set choices = $D73984a9f_fcf0_4de2_afce_e7d3ceb078a2Q$["Buying may be the better choice here, this lesson says to buy when the use case is common, a vendor solves it well, speed matters, differentiation is low, and integrations exist, and building should generally be reserved for cases where the workflow is unique, data is proprietary, or deep integration and governance control specifically matter","Building in-house is always the superior choice over buying from a vendor, regardless of how common the use case is","Vendor evaluation is unnecessary once a team has decided to build a solution in-house","Differentiation and workflow uniqueness are irrelevant factors in the build versus buy decision"]$D73984a9f_fcf0_4de2_afce_e7d3ceb078a2Q$::jsonb where id = '73984a9f-fcf0-4de2-afce-e7d3ceb078a2';

update questions set choices = $Dedf31c2d_687c_41fd_be0f_37f10c3aa132Q$["This is likely a weak moat, model advantage is hard to sustain unless you are a model company yourself, and for most product teams, the real moat comes from proprietary data, deep workflow integration, distribution advantage, or trust, not from using the same generally available model everyone else can access","Having access to a capable general-purpose model is always a strong and durable competitive advantage","Data, workflow, and trust advantages are less important than model access for most product teams","Competitive advantage from AI can only ever come from the underlying model itself"]$Dedf31c2d_687c_41fd_be0f_37f10c3aa132Q$::jsonb where id = 'edf31c2d-687c-41fd-be0f-37f10c3aa132';

update questions set choices = $Deb69c917_353f_4729_9ef6_b515328e7689Q$["Treat AI adoption as change management, this lesson explicitly says AI adoption does not happen automatically and requires training, good UX, manager support, workflow integration, a feedback loop, and champions, recommending things like office hours, prompt libraries, internal demos, and an AI champions network to help spread and prove the workflow, not just an announcement","A single company-wide announcement is a sufficient and complete adoption strategy for any AI feature","Adoption always happens automatically once a feature is technically useful, regardless of change management effort","Power users and champions are not a meaningful lever for driving AI adoption"]$Deb69c917_353f_4729_9ef6_b515328e7689Q$::jsonb where id = 'eb69c917-353f-4729-9ef6-b515328e7689';

update questions set choices = $Ddb7a3714_c33d_461a_b849_3c3d30b01b57Q$["AI training and enablement, this lesson explicitly says AI literacy is part of AI strategy, and that a powerful tool without training can create low adoption or unsafe use; users need to learn what AI can and cannot do, how to verify sources, when to escalate, and what use cases are approved or not allowed","Training and enablement are optional extras that do not meaningfully affect safe or effective AI usage","Powerful AI tools are inherently safe to deploy without any user training or guidance","This outcome could not have been prevented by any strategy described in this lesson"]$Ddb7a3714_c33d_461a_b849_3c3d30b01b57Q$::jsonb where id = 'db7a3714-c33d-461a-b849-3c3d30b01b57';

update questions set choices = $D61859977_36c0_4eae_b6d8_a8333abddd8fQ$["Balance quick wins and strategic bets across roadmap horizons, this lesson describes four horizons, starting with low-risk, high-value quick wins (like summaries and drafting), then workflow copilots, then agentic automation, then AI-native products, and explicitly says the roadmap should balance quick wins and strategic bets rather than jumping straight to the most ambitious horizon","Planning exclusively around the most ambitious, long-term AI capability is the recommended roadmap approach","Quick wins like summarization and drafting have no place on a serious AI roadmap","Roadmap horizons are a purely theoretical concept with no bearing on actual planning decisions"]$D61859977_36c0_4eae_b6d8_a8333abddd8fQ$::jsonb where id = '61859977-36c0-4eae-b6d8-a8333abddd8f';

update questions set choices = $Db81e91de_76fd_4082_90a9_df235588267cQ$["This is a bad OKR because it measures AI feature count rather than workflow improvement, this lesson explicitly contrasts \"launch 5 AI features\" (bad) with an outcome-based OKR like \"reduce average support resolution time by 20% using AI-assisted workflows while maintaining CSAT and wrong-answer rate below threshold\" (better), since AI OKRs should measure workflow improvement, not AI feature count","\"Launch 5 AI features\" is a strong OKR since it is easy to measure and track","AI OKRs should never include specific numeric key results like handle time or acceptance rate","Feature count and workflow outcome are equally valid ways to frame an AI OKR"]$Db81e91de_76fd_4082_90a9_df235588267cQ$::jsonb where id = 'b81e91de-76fd-4082-90a9-df235588267c';

update questions set choices = $D14d9b536_f769_42af_9a97_b25e0cf2ae2dQ$["A balanced scorecard across all six categories, business value, user value, quality, safety, operations, and learning, since AI success is multi-dimensional, and a feature that improves productivity (business value) but increases risk (safety) may not be acceptable even if the cost-savings numbers look good on their own","Time saved and cost savings are the only two categories that matter for a leadership review of an AI initiative","Safety and operations metrics are only relevant for engineering reviews, not for leadership business reviews","A balanced scorecard is redundant with a simple cost-savings report and adds no additional insight"]$D14d9b536_f769_42af_9a97_b25e0cf2ae2dQ$::jsonb where id = '14d9b536-f769-42af-9a97-b25e0cf2ae2d';

update questions set choices = $De0fd41a6_5908_4d57_b335_dd5e598946e1Q$["Customer-facing AI business metrics, this lesson specifically lists activation, conversion, retention, engagement, self-service success, trust rating, and complaint rate as metrics for customer-facing AI, in addition to safety metrics like wrong answer rate and privacy issues, since customer-facing AI must improve experience without damaging trust, which internal accuracy metrics alone cannot capture","Internal engineering metrics like model accuracy are sufficient on their own to evaluate customer-facing AI success","Customer-facing AI and internal AI should be measured with the identical set of metrics","Trust rating and complaint rate are metrics reserved only for internal AI tools, not customer-facing ones"]$De0fd41a6_5908_4d57_b335_dd5e598946e1Q$::jsonb where id = 'e0fd41a6-5908-4d57-b335-dd5e598946e1';

update questions set choices = $D78321c4c_efd1_44ab_bb05_c2441c19a6f0Q$["This ignores how AI strategy should differ by product type, this lesson describes different AI opportunities for different product types (SaaS focuses on onboarding, support, and analytics, while a marketplace can use AI for recommendations, search, trust and safety, seller support, and fraud detection), so the marketplace company is missing opportunities specific to its own product type","AI strategy should always be identical regardless of product type, since the same primitives apply everywhere","Fraud detection and seller support are not valid AI opportunities for a marketplace business","SaaS-specific AI opportunities like onboarding and admin assistance always transfer directly and completely to marketplace businesses"]$D78321c4c_efd1_44ab_bb05_c2441c19a6f0Q$::jsonb where id = '78321c4c-efd1-44ab-bb05-c2441c19a6f0';

update questions set choices = $D1e40f1ef_4b25_4f98_99bf_76ad1291729bQ$["AI margin considerations alongside pricing and packaging, this lesson explicitly warns that AI features need margin thinking, especially at high scale, since a feature users love may still be financially weak if cost per use is too high, and notes that usage-based pricing is a good option specifically when cost scales with usage","Pricing decisions do not need to account for underlying AI cost structure or margin implications","A flat price is always the correct pricing model for AI features regardless of usage variability","Margin considerations only matter for enterprise seat-based pricing, not for other pricing models"]$D1e40f1ef_4b25_4f98_99bf_76ad1291729bQ$::jsonb where id = '1e40f1ef-4b25-4f98-99bf-76ad1291729b';

update questions set choices = $Dac09fcfa_9f38_4828_b50c_d1e2153a17ebQ$["AI does not replace product-market fit, this lesson explicitly says if the core product does not solve a real problem, adding AI will not fix it, and warns that AI can distract from PMF when it hides weak core value; AI should amplify product value, not cover up weak product value","Adding an impressive AI feature is a reliable way to compensate for a product that lacks product-market fit","AI features always independently drive adoption and retention regardless of the underlying product's value","Product-market fit and AI strategy are unrelated concepts with no bearing on each other"]$Dac09fcfa_9f38_4828_b50c_d1e2153a17ebQ$::jsonb where id = 'ac09fcfa-9f38-4828-b50c-d1e2153a17eb';

update questions set choices = $D1129bc6f_48f6_481a_9d18_2acbc646a582Q$["A one-page AI strategy review template, this lesson recommends a concise brief covering use case, user, workflow, pain point, AI role, data/source, output, human role, success metric, guardrail metric, cost, risk, launch plan, and owner, deliberately kept short so it forces clear answers rather than burying them in a lengthy document","A comprehensive 20-page document is the recommended format for communicating an AI proposal to leadership","Strategy review templates should avoid including cost, risk, or owner information to keep them simple","There is no recommended structure for summarizing an AI proposal according to this lesson"]$D1129bc6f_48f6_481a_9d18_2acbc646a582Q$::jsonb where id = '1129bc6f-48f6-481a-9d18-2acbc646a582';

update questions set choices = $D5b6e5ee9_bc27_426e_a884_4751112e1b57Q$["The PM checklist for AI strategy before committing resources (covering the problem, workflow, value bucket, risk tier, and owner), and the PM checklist for AI ROI after launch (covering baseline, time/cost/revenue impact, cost per successful task, payback period, and what would make them stop or pivot), these are sequential gates for two different decision points, not the same checklist asked twice","A single checklist should be used identically both before commitment and after launch, since the questions do not differ","The AI ROI checklist should be used before committing resources, and the AI strategy checklist should be used after launch, reversing the order in this lesson","Neither checklist is necessary once a use case has passed an initial impact/effort scoring exercise"]$D5b6e5ee9_bc27_426e_a884_4751112e1b57Q$::jsonb where id = '5b6e5ee9-bc27-426e-a884-4751112e1b57';

update questions set choices = $D3bc22dd4_2464_466f_8ec2_a139c42b19e2Q$["Explain that AI strategy should start with high-value workflows, not with the most advanced technology available, the team should prioritize use cases based on impact, effort, feasibility, adoption likelihood, and risk, starting with lower-autonomy approaches like shadow mode and draft-only workflows before earning greater autonomy through evidence, strong evaluation, and guardrails, since the most important question is whether a use case is valuable, safe, measurable, and adopted enough to change the real workflow, not how technically advanced it is","The most technically advanced AI capability should always be pursued first, regardless of workflow fit, risk, or adoption readiness","Autonomy level and technical sophistication are the primary factors that should drive AI strategy decisions","Shadow mode and draft-only workflows are unnecessary once a team has strong technical capability available"]$D3bc22dd4_2464_466f_8ec2_a139c42b19e2Q$::jsonb where id = '3bc22dd4-2464-466f-8ec2-a139c42b19e2';
