-- AI/ML for Builders — Module 21: Fine-tuning, Model Selection, and Custom AI Models
-- 36 lessons — closing the Module 16-21 "which method" arc with the discipline of knowing when customization is worth it

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
begin

  select id into v_course_id from courses where sort_order = 2;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 21: Fine-tuning, Model Selection, and Custom AI Models',
    'When customization is actually worth it — model selection dimensions, fine-tuning vs. RAG vs. tools vs. traditional ML, data quality, evaluation, safety, and launch discipline for custom models.',
    21
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.1 — Why This Module Matters, and the Simplest Mental Model
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Why This Module Matters, and the Simplest Mental Model',
    1,
    $M21L1$WHY THIS MODULE MATTERS

When building AI products, teams often ask "should we fine-tune the model?" But that is not always the right first question.

Better question: **what exactly is failing, and what is the cheapest, safest way to fix it?**

Maybe the model is failing because the prompt is vague, the model lacks company knowledge, retrieval is weak, the wrong model is being used, the task needs tools, the workflow is poorly designed, the output format is unclear, evaluation is missing, the data is poor, or the task is too risky for automation.

Fine-tuning is useful in some cases, but it is not magic.

[!] Do not fine-tune a model until you know what problem fine-tuning is supposed to solve.


THE SIMPLEST MENTAL MODEL

Think of AI customization like training an employee. If the employee gives weak output, you do not immediately send them for months of training. First you ask: did I give clear instructions? Did I give the right documents? Did I explain the expected format? Did I show examples? Did they have access to the right tools? Did they understand the goal? Is the task too broad? Is this the right person for the job?

Only after that do you consider deeper training. Same with AI. First try: a better prompt, better context, better examples, better retrieval or RAG, better tool access, better model selection, better evaluation — fine-tuning comes later, not first.

>> Fine-tuning is the last rung on the ladder, not the first thing to reach for when output quality is disappointing.$M21L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.2 — What Is Model Selection, and Bigger Model Is Not Always Better
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is Model Selection, and Bigger Model Is Not Always Better',
    2,
    $M21L2$WHAT IS MODEL SELECTION?

Model selection means choosing the right model for the task. You may choose based on quality, cost, speed, context window, reasoning ability, coding ability, vision ability, structured output ability, tool-use ability, safety behavior, fine-tuning availability, deployment environment, and privacy requirements.

**Model selection means choosing the right engine for the job.** You do not use a truck for every trip. You do not use a sports car for every road. You do not use the biggest LLM for every AI task.


BIGGER MODEL IS NOT ALWAYS BETTER

A bigger model may be better for complex tasks. But it may also be more expensive, slower, harder to scale, unnecessary for simple tasks, overkill for structured classification, and less suitable for high-volume workflows.

Example: for a simple ticket classifier, a smaller model may work well. For complex legal reasoning across many documents, a larger model may be needed.

[!] Use the smallest, cheapest, fastest model that meets the quality bar safely — not the biggest one available.

>> "Which model is best" is the wrong question. "Which model is best for this specific task, at this cost and latency" is the right one.$M21L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.3 — Model Selection Dimensions
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Model Selection Dimensions',
    3,
    $M21L3$When choosing a model, compare these dimensions.

Quality — does it produce correct outputs? Cost — what is the cost per task? Latency — is it fast enough for the UX? Context window — can it handle the needed input? Tool use — can it reliably call tools? Structured output — can it return valid JSON, tables, or fields? Safety — does it avoid harmful behavior? Grounding — can it answer from sources? Multimodal ability — does it need text, image, audio, or video? Fine-tuning support — can it be customized if needed? Availability — is it supported in our environment? Compliance — does it meet data and privacy rules?

[!] OpenAI's production best-practices guide frames production readiness around secure access, robust architecture, traffic handling, and deployment planning — exactly the kinds of concerns PMs should consider after the prototype stage, not only model quality on a demo.

>> Most model comparisons stop at quality. A real model selection decision runs through all twelve dimensions above before committing.$M21L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.4 — Model Families PMs Should Understand
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Model Families PMs Should Understand',
    4,
    $M21L4$PMs do not need to know every model name, but they should understand model categories.

A general LLM is good for writing, summarization, Q&A, general reasoning, and chat.

A reasoning model is good for complex analysis, multi-step problems, planning, code reasoning, and hard trade-off decisions.

A small or fast model is good for classification, extraction, routing, simple summarization, and high-volume tasks.

An embedding model is good for semantic search, RAG retrieval, similarity, clustering, and recommendations.

A vision-language model is good for image understanding, OCR-like reasoning, screenshot analysis, document images, and visual Q&A.

A speech or audio model is good for transcription, voice assistants, call analysis, and audio classification.

A custom or fine-tuned model is good for a repeated specialized task, a specific format, domain-specific behavior, and cost or latency optimization at scale.

[!] Different AI tasks need different model types — reaching for a general LLM by default, when an embedding model or a small classifier would do the job better and cheaper, is a common and expensive habit.

>> Knowing the seven categories above is usually enough for a PM to spot when "just use the LLM" is the wrong plan.$M21L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.5 — The Model Selection Ladder
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The Model Selection Ladder',
    5,
    $M21L5$Before customizing a model, climb this ladder: use a good base model, improve the prompt, add examples, add structured output, add RAG or context, add tools or APIs, route tasks to different models, use a smaller or larger model, fine-tune, and only then train a custom model.

**Start simple. Customize only when the simple path cannot meet quality, cost, or latency goals.**

[!] Every rung on this ladder is cheaper, faster, and lower-risk than the one below it. Skipping straight to fine-tuning or custom training means skipping past several genuinely simpler fixes that might have solved the problem outright.

>> This ladder is the whole module compressed into ten steps — everything after this lesson is detail on when and how to climb the later rungs.$M21L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.6 — What Is Fine-Tuning, and What Fine-Tuning Is Good For
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is Fine-Tuning, and What Fine-Tuning Is Good For',
    6,
    $M21L6$WHAT IS FINE-TUNING?

Fine-tuning means further training a pretrained model on examples for a specific task or behavior. Anthropic defines fine-tuning as further training a pretrained language model using additional data so it starts representing and mimicking patterns in the fine-tuning dataset.

Example: you provide many examples like a customer complaint as input, and the correct category, urgency, summary, and recommended action as expected output. The model learns to produce similar outputs.

**Fine-tuning teaches the model a repeated behavior using examples.**


WHAT FINE-TUNING IS GOOD FOR

Fine-tuning is useful when you need the model to behave consistently for a specific task — classification, sentiment analysis, entity extraction, consistent structured output, specific writing style, specialized summarization, domain-specific query writing, correcting repeated instruction-following failures, and making a smaller model perform like a larger model on a narrow task.

[!] OpenAI's model optimization guide describes supervised fine-tuning as providing correct responses to prompts, listing classification, nuanced translation, specific-format generation, and correcting instruction-following failures as common use cases. Google's tuning docs similarly recommend supervised fine-tuning for classification, sentiment analysis, entity extraction, less-complex summarization, and domain-specific query writing.

>> Fine-tuning's sweet spot is narrow, repeatable, well-defined behavior — not broad intelligence or up-to-date knowledge.$M21L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.7 — What Fine-Tuning Is Not Good For, and RAG vs. Fine-Tuning
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Fine-Tuning Is Not Good For, and RAG vs. Fine-Tuning',
    7,
    $M21L7$WHAT FINE-TUNING IS NOT GOOD FOR

Fine-tuning is usually not the best way to add changing knowledge. Bad reason to fine-tune: "we want the model to know our latest policy." Better solution: use RAG or tools.

Why? Policies change, documents change, prices change, customer data changes, product docs change. If knowledge changes often, fine-tuning becomes hard to maintain.

**Use RAG for knowledge. Use fine-tuning for behavior.**


RAG VS. FINE-TUNING

For answering from company docs, using current policy, citing sources, or using customer-specific data, RAG (or tools/RAG) is the better first choice. For following an exact response style or returning consistent JSON, prompting or fine-tuning (plus structured outputs) is the better first choice. For classifying tickets at scale, reducing long prompt cost, or teaching a new repeated behavior, fine-tuning may help. For improving retrieval quality itself, better embeddings and retrieval design help — not fine-tuning alone.

[!] Anthropic's glossary describes RAG as retrieving external knowledge at runtime and passing it into the model's context, making it useful for up-to-date information, domain knowledge, and source-grounded answers; it also notes that RAG depends heavily on the quality of the knowledge base and retrieved content.

>> If the failure is "the model does not know X," ask whether X changes — if it does, that is a RAG problem wearing a fine-tuning costume.$M21L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.8 — Prompting vs. Fine-Tuning, and Context Engineering vs. Fine-Tuning
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Prompting vs. Fine-Tuning, and Context Engineering vs. Fine-Tuning',
    8,
    $M21L8$PROMPTING VS. FINE-TUNING

Prompting is the first step. Use prompting when you need fast iteration, requirements change often, you are still exploring the task, the model can follow instructions well, you need only a few examples, volume is low or medium, or you do not yet have training data.

Use fine-tuning when prompting is not consistent enough, you have many high-quality examples, the task is repeated often, you need shorter prompts, you need lower latency or cost at scale, you need a smaller model to perform well, or you need consistent style or format.

[!] OpenAI's model optimization guide says fine-tuning can allow more examples than fit in one prompt, shorter prompts, lower token cost and latency, and training a smaller, cheaper, faster model for a specific task.


CONTEXT ENGINEERING VS. FINE-TUNING

Prompting is not the whole picture. Modern AI systems need context engineering — deciding what information enters the model's working context. This may include system instructions, the user message, retrieved documents, tool outputs, conversation history, memory, examples, a user profile, and workflow state.

Anthropic describes context engineering as curating and maintaining the right set of tokens during inference, including system instructions, tools, external data, message history, and other information beyond the prompt itself.

>> Before fine-tuning, check whether the model is seeing the right context — a model missing the right information will fail no matter how much it is retrained.$M21L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.9 — Fine-Tuning vs. Tools, and Fine-Tuning vs. Training From Scratch
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fine-Tuning vs. Tools, and Fine-Tuning vs. Training From Scratch',
    9,
    $M21L9$FINE-TUNING VS. TOOLS

Fine-tuning cannot replace live tools. Example: "what is the status of order #123?" — fine-tuning is not appropriate here; the model needs an order lookup tool. Example: "classify this support ticket into one of our internal categories" — fine-tuning may be appropriate if you have labeled examples.

**Fine-tuning teaches behavior. Tools provide live facts and actions.**


FINE-TUNING VS. TRAINING FROM SCRATCH

Fine-tuning starts with an existing pretrained model. Training from scratch builds a model from the beginning, and usually requires massive data, a large ML team, a huge compute budget, deep infrastructure, long training time, safety work, and evaluation systems.

Most product teams should not train foundation models from scratch. They should use existing models, prompting, RAG, tools, fine-tuning, or smaller specialized models.

[!] Fine-tuning is customization. Training from scratch is building the engine — a distinction most product teams will never need to cross, and should not try to.

>> Two very different "no" answers: fine-tuning cannot substitute for a live tool call, and training from scratch is almost never the right scope for a product team.$M21L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.10 — Types of Fine-Tuning
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Types of Fine-Tuning',
    10,
    $M21L10$SUPERVISED FINE-TUNING

You provide input-output examples — a customer message as input, the correct category and response format as output. Google describes supervised fine-tuning as using hundreds of labeled examples to teach a model to mimic desired behavior or task output.

PREFERENCE TUNING

You provide examples of better vs. worse outputs. Example: prompt "write support reply" — preferred answer is clear, correct, and empathetic; rejected answer is too long with an unsupported refund promise. Google describes preference tuning as using human feedback data to learn subjective preferences that may be hard to define with labels alone.

PARAMETER-EFFICIENT TUNING

Instead of updating the whole model, update a smaller set of parameters. Google describes parameter-efficient tuning as adapting large models by updating a relatively small subset of parameters, making it more resource-efficient than full fine-tuning.

FULL FINE-TUNING

Updates all model parameters. Google notes that full fine-tuning can adapt models to complex tasks but demands higher computational resources and higher overall costs.

[!] You do not need to implement any of these yourself as a PM, but knowing which one a vendor or engineering team is proposing tells you a lot about cost, risk, and how much data you actually need.

>> Four different tools for four different jobs: supervised for "do this," preference for "prefer this over that," parameter-efficient for "cheaply," and full fine-tuning for "thoroughly, at a price."$M21L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.11 — Supervised Fine-Tuning, and Preference Tuning in Simple Words
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Supervised Fine-Tuning, and Preference Tuning in Simple Words',
    11,
    $M21L11$SUPERVISED FINE-TUNING IN SIMPLE WORDS

Supervised fine-tuning is like giving the model many examples of the right answer.

Example training data: input "customer says: I was charged twice," expected output a structured JSON object like category "Billing," urgency "Medium," summary "customer reports duplicate charge," and needs_human_review true.

After seeing many examples, the model learns the expected pattern. Good for classification, extraction, structured output, tone, repeated workflows, and domain-specific phrasing.

PM question: **"Do we have enough high-quality examples of what good output looks like?"**


PREFERENCE TUNING IN SIMPLE WORDS

Preference tuning teaches the model which answer is better.

Example: prompt "draft a response to this angry customer." Response A is empathetic, policy-grounded, and concise. Response B is overly casual and promises a refund without evidence. A human marks A as better, and the model learns the preference.

Good for tone, style, helpfulness, ranking output quality, subjective tasks, brand voice, and assistant behavior.

PM question: **"Can humans reliably judge which output is better?"**

>> Supervised fine-tuning needs a correct answer for each example. Preference tuning only needs a comparison — which is often easier to produce reliably for subjective qualities like tone.$M21L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.12 — Parameter-Efficient Tuning, and When Fine-Tuning Helps Most
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Parameter-Efficient Tuning, and When Fine-Tuning Helps Most',
    12,
    $M21L12$PARAMETER-EFFICIENT TUNING IN SIMPLE WORDS

Parameter-efficient tuning adapts a model without changing the whole thing. Analogy: instead of rebuilding a car, you add a specialized attachment.

Benefits: cheaper, faster, needs less compute, easier to create multiple variants, useful when full fine-tuning is too expensive.

You do not need to know the math, but you should know that customization can happen at different cost and complexity levels.


WHEN FINE-TUNING HELPS MOST

Fine-tuning tends to help when the task is repeated often, the desired output is clear, you have many good examples, prompting is not consistent enough, RAG is not the main issue, the model already has the base ability, you need cost or latency optimization, output format or style must be very consistent, the model fails in predictable ways, and evaluation can prove improvement.

[!] Fine-tune when the behavior is repeatable, measurable, and examples exist — all three conditions, not just one.

>> Parameter-efficient tuning lowers the cost of the "when to fine-tune" decision. It does not change the underlying question of whether fine-tuning is the right fix in the first place.$M21L12$
  ) returning id into v_l12;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.13 — When Fine-Tuning Is Risky, and Fine-Tuning Data Quality
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'When Fine-Tuning Is Risky, and Fine-Tuning Data Quality',
    13,
    $M21L13$WHEN FINE-TUNING IS RISKY

Fine-tuning can be risky when training data is low quality, labels are inconsistent, examples contain bias, the task is not clearly defined, the model needs changing knowledge, you cannot evaluate improvement, you do not have enough examples, the base model is already good enough, fine-tuning makes other capabilities worse, or the system lacks monitoring.

Anthropic warns that fine-tuning requires careful consideration of training data and potential effects on performance and bias.

**A model trained on messy examples will learn messy behavior.**


FINE-TUNING DATA QUALITY

Good fine-tuning data should be accurate, consistent, representative, diverse, clean, well-labeled, policy-compliant, free of sensitive data unless properly controlled, aligned with real production cases, and reviewed by domain experts.

Bad data examples: contradictory labels, outdated policy answers, low-quality human replies, biased examples, hallucinated outputs, inconsistent formatting, missing edge cases.

[!] PM question: "Would we be proud for the model to copy this data?" If the honest answer is no, do not fine-tune on it.

>> Every risk in this lesson traces back to one root cause: fine-tuning makes the model copy whatever is in the training data, flaws included.$M21L13$
  ) returning id into v_l13;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.14 — Fine-Tuning Example: Support Ticket Classification, and Structured Extraction
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fine-Tuning Example: Support Ticket Classification, and Structured Extraction',
    14,
    $M21L14$FINE-TUNING EXAMPLE: SUPPORT TICKET CLASSIFICATION

Business problem: support tickets need routing. Input is a customer message; output is category, urgency, sentiment, and recommended queue.

Current problem: prompting works 85% of the time but fails on edge categories.

Fine-tuning may help because labels are defined, historical tickets exist, correct outputs are available, the task repeats at high volume, and the output format is structured.

Metrics: classification accuracy, precision/recall by category, confusion matrix, human correction rate, routing time, resolution time, support cost.

PM question: **"Which categories are confused, and do we have enough examples for those categories?"**


FINE-TUNING EXAMPLE: STRUCTURED EXTRACTION

Business problem: extract fields from invoices — vendor name, invoice date, total amount, currency — as structured JSON.

Fine-tuning may help if documents are similar, output format is stable, historical labeled examples exist, the model often misses specific fields, and validation rules are clear.

But tools or rules may still be needed for calculation, currency validation, duplicate detection, vendor database matching, and payment approval.

[!] Use fine-tuning for extraction behavior. Use rules and tools for validation and action.

>> Both examples share a shape: fine-tuning fixes the pattern-recognition part of the task, while validation and tools still handle the parts that need to be exactly right.$M21L14$
  ) returning id into v_l14;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.15 — Fine-Tuning Example: Brand Voice, and Smaller Model Optimization
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fine-Tuning Example: Brand Voice, and Smaller Model Optimization',
    15,
    $M21L15$FINE-TUNING EXAMPLE: BRAND VOICE

Business problem: the marketing team wants AI copy in a consistent brand voice. Prompting works, but outputs vary too much.

Fine-tuning may help if there are many approved examples, brand voice is consistent, the use case is high volume, quality can be judged reliably, and the brand/legal team can review training data.

Metrics: brand compliance score, human edit distance, approval rate, time saved, reuse rate, customer engagement, legal or policy issue rate.

[!] Fine-tuning on brand voice does not guarantee factual correctness — use grounding when facts matter, not just consistent tone.


FINE-TUNING EXAMPLE: SMALLER MODEL OPTIMIZATION

Business problem: a large model performs well but is too expensive. Use case: classify millions of short messages.

Approach: fine-tune a smaller model on high-quality examples, aiming to get similar task quality at lower cost and lower latency.

OpenAI's model optimization guide describes fine-tuning as one way to train a smaller, cheaper, faster model to perform well on a particular task where a larger model may not be cost-effective.

PM metrics: quality vs. the larger model, cost per 1,000 tasks, latency, throughput, error rate, human review rate.

>> Fine-tuning is often an optimization strategy, not only a quality strategy — sometimes the goal is not "better," it's "just as good, for a fraction of the cost."$M21L15$
  ) returning id into v_l15;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.16 — Fine-Tuning Example: Domain-Specific Query Generation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fine-Tuning Example: Domain-Specific Query Generation',
    16,
    $M21L16$Business problem: analysts ask questions in English, and AI generates SQL.

Problem: the generic model often uses wrong table names or business logic.

Fine-tuning may help if you have many examples of question-to-correct-SQL pairs, the database schema is stable, metric definitions are clear, generated SQL is validated, and analysts review outputs.

But RAG and tools may also be needed for the current schema, table metadata, permission checks, query execution, and result validation.

[!] Fine-tuning can teach query style. Tools and RAG provide live schema and validation — neither one replaces the other here.

>> This example is a clean illustration of the whole module's thesis: fine-tuning handles the repeatable pattern (how we phrase SQL), while RAG and tools handle everything that changes (the schema itself).$M21L16$
  ) returning id into v_l16;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.17 — When RAG Is Better Than Fine-Tuning, and When Prompting Is Better Than Fine-Tuning
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'When RAG Is Better Than Fine-Tuning, and When Prompting Is Better Than Fine-Tuning',
    17,
    $M21L17$WHEN RAG IS BETTER THAN FINE-TUNING

Use RAG when the answer depends on documents, sources change often, citations are required, users need source verification, knowledge is private or user-specific, multiple policies may conflict, access permissions apply, or freshness matters.

Example: "what is the latest return policy for damaged items in Canada?" Do not fine-tune — use RAG over current policy docs with region metadata.

**Do not bake changing knowledge into model weights. Retrieve it at runtime.**


WHEN PROMPTING IS BETTER THAN FINE-TUNING

Use prompting when you are prototyping, the task changes often, the model already performs well, you have few examples, volume is low, you need fast iteration, requirements are uncertain, or you want human-readable control.

Example: a PM wants to summarize interviews in a specific format. Start with prompting. Fine-tune only if the task becomes high-volume, stable, and quality gaps are predictable.

[!] Both of these are really the same lesson from two directions: reach for fine-tuning only after ruling out the cheaper options that fit the situation better.

>> RAG wins when knowledge is the problem. Prompting wins when the task is still evolving. Fine-tuning waits until neither of those is true anymore.$M21L17$
  ) returning id into v_l17;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.18 — When Tools Are Better Than Fine-Tuning, and When a Custom Traditional ML Model Is Better
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'When Tools Are Better Than Fine-Tuning, and When a Custom Traditional ML Model Is Better',
    18,
    $M21L18$WHEN TOOLS ARE BETTER THAN FINE-TUNING

Use tools when the model needs exact or live information — order status, account balance, current price, inventory, calendar availability, database values, payment state, user permissions, latest analytics.

Fine-tuning cannot make a model know live information.

**If the answer depends on a system of record, use a tool.**


WHEN A CUSTOM TRADITIONAL ML MODEL IS BETTER

Not every AI problem needs an LLM. Use traditional ML when input is structured data, output is a number, class, probability, or ranking, you need high efficiency, the task is prediction-heavy rather than language-heavy, interpretability matters, training data is well-structured, or latency and cost need to be low.

Examples: churn prediction, fraud risk, demand forecast, lead scoring, credit risk support, recommendation ranking, delivery time prediction.

[!] Use LLMs for language. Use traditional ML for structured prediction — this is the same distinction covered all the way back in Module 16, and it still applies here.

>> Tools solve "the model doesn't know this fact." Traditional ML solves "this isn't really a language problem in the first place."$M21L18$
  ) returning id into v_l18;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.19 — When Deterministic Software Is Better, and Model Routing
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'When Deterministic Software Is Better, and Model Routing',
    19,
    $M21L19$WHEN DETERMINISTIC SOFTWARE IS BETTER

Sometimes no AI is needed. Use deterministic software when rules are clear, output must be exact, compliance requires fixed logic, the task is calculation, the workflow is simple, errors are unacceptable, or the same input should always produce the same output.

Examples: tax calculation, billing formula, eligibility based on exact rule, currency conversion, password validation, form completeness check.

**Do not use AI where simple rules are safer.**


MODEL ROUTING

Model routing means sending different tasks to different models or workflows. Example: simple classification to a small model, complex reasoning to a larger model, policy Q&A to RAG, a live order question to a tool call, a high-risk case to human review, image input to a vision model, search similarity to an embedding model.

One model does not need to do everything. Model routing improves cost, latency, quality, safety, and scalability.

[!] Route the task to the right model, tool, or human — the same principle whether the "wrong" choice is an oversized model or an AI system tackling a problem deterministic code already solves.

>> This lesson closes the loop on the whole "what should we use" question — sometimes the answer is no AI at all, and routing is how a single product applies the right answer to each part of a task.$M21L19$
  ) returning id into v_l19;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.20 — Build vs. Buy vs. Use API
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Build vs. Buy vs. Use API',
    20,
    $M21L20$PMs often need to decide whether to use a commercial AI API, use an open-source model, fine-tune a model, build a custom model, or buy a vertical AI product.

Use an API when speed matters, general model quality is good, the internal ML team is small, you want fast prototyping, or differentiation is in workflow, not model.

Use an open-source or self-hosted model when data control matters, cost at scale favors self-hosting, customization is needed, regulatory or deployment constraints exist, or the team can manage infrastructure.

Fine-tune when the task is stable and repeated, you have examples, the base model needs behavior adaptation, or cost/latency optimization matters.

Build a custom model when the task is highly specialized, you have proprietary data, existing models are not good enough, differentiation depends on the model, or you have strong ML capability.

Buy a vertical product when the workflow is common, a vendor already solves it well, speed matters more than differentiation, or integrations and compliance are already available.

[!] PM question: "Where is our real differentiation — model, data, workflow, UX, distribution, or trust?" The answer usually points directly at which of these five paths makes sense.

>> Five options, one underlying question: does building or customizing this actually create an advantage, or would the same effort be better spent on the workflow around it?$M21L20$
  ) returning id into v_l20;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.21 — Open-Source vs. Closed Model
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Open-Source vs. Closed Model',
    21,
    $M21L21$CLOSED/COMMERCIAL MODEL

Pros: strong quality, easy API access, faster to start, less infrastructure, often better tooling, managed updates.

Cons: vendor dependency, usage cost, less control, data/privacy review needed, limited customization depending on the provider.


OPEN-SOURCE/SELF-HOSTED MODEL

Pros: more control, potential cost advantage at scale, custom deployment, data locality, custom fine-tuning.

Cons: infrastructure burden, ML ops complexity, security patching, model quality may vary, need for a specialized team.

[!] Closed models reduce build complexity. Open or self-hosted models increase control but also increase ownership — every advantage on one side has a matching cost on the other.

>> This decision rarely has a universally correct answer — it hinges on whether your team's scarce resource is engineering time or model control.$M21L21$
  ) returning id into v_l21;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.22 — Model Evaluation Before Selection, and Golden Dataset for Model Selection
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Model Evaluation Before Selection, and Golden Dataset for Model Selection',
    22,
    $M21L22$MODEL EVALUATION BEFORE SELECTION

Do not choose models only from demos or leaderboard scores. OpenAI's evaluation guidance says generative AI is variable, so evals are needed to test performance despite nondeterminism; it also warns against vibe-based evals and recommends task-specific evals that reflect real production distributions.

For PMs, model evaluation should include real user examples, edge cases, hard cases, safety cases, long input cases, no-answer cases, sensitive cases, cost and latency, human review, and business workflow impact.

**The best model is the one that works best on your task, not the one with the best generic demo.**


GOLDEN DATASET FOR MODEL SELECTION

A golden dataset is a trusted set of examples used to compare models. For model selection, include typical cases, hard cases, edge cases, sensitive cases, missing-information cases, no-answer cases, policy conflict cases, long-context cases, tool-use cases, and desired outputs.

Example for support AI: 500 real historical tickets, correct policy source, ideal agent answer, escalation label, risk level, expected structured fields.

Use it to compare model A vs. model B, prompt vs. RAG, base model vs. fine-tuned model, small model vs. large model, and tool workflow versions.

[!] No golden dataset, no serious model selection — everything else in this lesson depends on having one.

>> Vibe-based model selection ("this one felt smarter in the demo") is exactly the trap a golden dataset exists to prevent.$M21L22$
  ) returning id into v_l22;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.23 — Fine-Tuning Evaluation, and Holdout Test Set
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fine-Tuning Evaluation, and Holdout Test Set',
    23,
    $M21L23$FINE-TUNING EVALUATION

Before fine-tuning, measure baseline performance. Then fine-tune. Then compare. Metrics depend on the task.

For classification: accuracy, precision, recall, F1, confusion matrix, segment performance.

For extraction: field accuracy, missing-field rate, false extraction rate, JSON validity.

For summarization: factual accuracy, completeness, conciseness, human preference, unsupported claims.

For support replies: policy accuracy, tone, agent acceptance, wrong-answer rate, escalation correctness.

For cost/latency: cost per task, time to first token, end-to-end latency, tokens per request.

PM question: **"Did fine-tuning improve the actual task metric, not just make outputs look nicer?"**


HOLDOUT TEST SET

Fine-tuning data should be split into a training set, a validation set, and a test set. The test set should not be used during training.

Why? You need to know whether the fine-tuned model generalizes to new cases.

[!] PM question: "Was the fine-tuned model tested on examples it never saw?" If the answer is no, the reported improvement cannot be trusted.

>> Task-specific metrics tell you what to measure. A holdout test set tells you whether the number you measured actually means anything.$M21L23$
  ) returning id into v_l23;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.24 — Overfitting in Fine-Tuning, and Regression Testing
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Overfitting in Fine-Tuning, and Regression Testing',
    24,
    $M21L24$OVERFITTING IN FINE-TUNING

Overfitting means the model memorizes training examples instead of learning general behavior.

Signs: great training performance, weak test performance, the model repeats phrases too often, the model fails on new wording, the model handles common cases but not edge cases, output becomes rigid.

**Fine-tuning should teach patterns, not memorize examples.**


REGRESSION TESTING

After fine-tuning, make sure the model did not get worse on important behavior.

Example: a fine-tuned support model becomes better at tone but worse at policy accuracy. That is not acceptable.

Regression tests should check safety behavior, refusal behavior, policy compliance, format compliance, accuracy, bias/fairness, edge cases, no-answer cases, and tool-use behavior if relevant.

[!] PM question: "What did the fine-tuned model become worse at?" Every fine-tuning run should have an answer to this, not just a list of what improved.

>> Overfitting is a training-time failure that shows up as weak test performance. Regression testing is how you catch it — along with any other capability that quietly got worse.$M21L24$
  ) returning id into v_l24;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.25 — Catastrophic Forgetting, and Fine-Tuning and Safety
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Catastrophic Forgetting, and Fine-Tuning and Safety',
    25,
    $M21L25$CATASTROPHIC FORGETTING

Catastrophic forgetting means a model loses some prior capability after further training. For LLM fine-tuning, this can show up as worse general instruction following, more rigid responses, weaker reasoning, poorer safety behavior, and bad handling of out-of-scope prompts.

Do not assume fine-tuning only improves the model. It can also change behavior in unwanted ways.


FINE-TUNING AND SAFETY

Fine-tuning can affect safety. Risks: the model learns unsafe tone, over-complies with risky requests, reveals sensitive patterns, learns biased outputs, stops refusing when it should, overstates confidence, or copies bad training examples.

Safety eval should include refusal cases, sensitive data cases, bias cases, prompt injection cases, high-risk user requests, out-of-scope questions, and escalation cases.

[!] Fine-tuned models still need safety testing — passing the task metric does not mean the model is still safe on everything it was safe on before.

>> Catastrophic forgetting is the general version of this problem (any capability can degrade); safety is the specific version that matters most to test for explicitly.$M21L25$
  ) returning id into v_l25;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.26 — Fine-Tuning and Privacy, and Fine-Tuning and Compliance
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fine-Tuning and Privacy, and Fine-Tuning and Compliance',
    26,
    $M21L26$FINE-TUNING AND PRIVACY

Fine-tuning data may contain sensitive information — customer names, account IDs, medical details, financial records, legal documents, employee data, internal strategy, source code.

Before fine-tuning, ask: is this data allowed for training? Has sensitive data been removed or masked? Is consent required? Who can access training data? Where is data stored? Is data retained? Can outputs leak memorized details? Does vendor policy allow this use?

**Training data is product risk. Treat it carefully.**


FINE-TUNING AND COMPLIANCE

Some domains need stricter review — healthcare, finance, insurance, legal, employment, education, identity verification, credit, and safety-critical systems.

For high-risk domains, fine-tuning may need legal review, compliance review, security review, data governance, human review, audit logs, model documentation, bias testing, and an approval workflow.

[!] PM question: "Does this model influence a high-impact decision?" If yes, controls must be stronger.

>> Privacy asks what is in the training data. Compliance asks what happens because of the model's decisions. A high-risk domain needs both questions answered carefully.$M21L26$
  ) returning id into v_l26;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.27 — Data Labeling for Fine-Tuning, and How Many Examples Are Needed
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Data Labeling for Fine-Tuning, and How Many Examples Are Needed',
    27,
    $M21L27$DATA LABELING FOR FINE-TUNING

Fine-tuning usually needs labeled examples. The labeling process should define a label taxonomy, output format, annotation guidelines, edge-case rules, reviewer training, quality checks, inter-annotator agreement, an escalation process, version control, and a sampling strategy.

Example: for support classification, annotators must agree on what counts as Billing vs. Refund vs. Product Defect. If humans disagree, the model will also be confused.

**If humans cannot label consistently, the model cannot learn consistently.**


HOW MANY EXAMPLES ARE NEEDED?

The number depends on task complexity, model, and quality bar. A simple classification task may need fewer examples. A complex domain-specific writing task may need many more.

Google's supervised fine-tuning docs describe using hundreds of labeled examples for teaching a model to mimic a desired behavior or task.

[!] Data quality usually matters more than raw data quantity — a thousand inconsistent examples teach the model inconsistency, not the desired behavior.

>> Labeling discipline determines the ceiling on fine-tuning quality; example count mostly determines how close you can get to that ceiling.$M21L27$
  ) returning id into v_l27;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.28 — Fine-Tuning Project Plan, and Shadow Mode for Fine-Tuned Models
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fine-Tuning Project Plan, and Shadow Mode for Fine-Tuned Models',
    28,
    $M21L28$FINE-TUNING PROJECT PLAN

A fine-tuning project should follow a clear plan: define the task, define success metrics, build a baseline prompt/model, collect examples, clean and label data, split train/validation/test, fine-tune, evaluate against baseline, run safety and regression tests, pilot in shadow mode or copilot mode, monitor production, and update data and model if needed.

**Fine-tuning is a product experiment, not a one-time technical trick.**


SHADOW MODE FOR FINE-TUNED MODELS

Before full launch, run in shadow mode. Example: a fine-tuned ticket classifier predicts categories while humans still route tickets. Compare the model's category to the human's category, where the model disagrees, which errors are costly, which categories need more data, and whether routing would improve.

[!] PM question: "Can we test the fine-tuned model without impacting users first?" Shadow mode reduces risk by answering this before any real decision depends on the model.

>> The project plan is the full arc. Shadow mode is the specific checkpoint inside that arc where the model finally meets real data without yet being trusted with real decisions.$M21L28$
  ) returning id into v_l28;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.29 — Launch Strategy for Fine-Tuned Models, and Monitoring Fine-Tuned Models
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Launch Strategy for Fine-Tuned Models, and Monitoring Fine-Tuned Models',
    29,
    $M21L29$LAUNCH STRATEGY FOR FINE-TUNED MODELS

Do not launch all at once. Use a phased rollout: internal testing, offline eval, shadow mode, human-in-the-loop, low-risk traffic, partial rollout, full rollout, and continuous monitoring.

Monitor quality, cost, latency, human override, error rate, segment performance, safety incidents, and drift.

**Fine-tuned models need deployment discipline like any ML model.**


MONITORING FINE-TUNED MODELS

After launch, monitor input distribution, output distribution, accuracy, human correction rate, format failures, cost, latency, escalations, user complaints, safety incidents, drift, segment performance, and prompt/model version.

Fine-tuned model quality can degrade when user behavior changes, policies change, new categories appear, the product changes, data distribution shifts, or edge cases increase.

[!] PM question: "How will we know when the fine-tuned model is no longer good enough?" Without an answer, quiet degradation can run for months before anyone notices.

>> Launch strategy controls how fast risk is introduced. Monitoring controls how fast a problem is noticed once it exists. A fine-tuned model needs both, permanently — not just at launch.$M21L29$
  ) returning id into v_l29;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.30 — Model Versioning, and Cost-Benefit of Fine-Tuning
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Model Versioning, and Cost-Benefit of Fine-Tuning',
    30,
    $M21L30$MODEL VERSIONING

Track every model version. For each version, store the base model, fine-tuning dataset version, training date, evaluation results, safety results, known limitations, deployment date, owner, and rollback plan.

**If you cannot trace the model version, you cannot debug the model.**


COST-BENEFIT OF FINE-TUNING

Benefits: better task quality, more consistent output, shorter prompts, lower latency, lower token usage, a smaller model may work, better format compliance, less repeated prompting.

Costs: data labeling, training cost, evaluation effort, maintenance, versioning, safety testing, risk of overfitting, risk of bias, retraining when the task changes.

PM question: **"Does the quality, cost, or latency improvement justify the added complexity?"**

[!] Every benefit on this list has a matching, ongoing cost — fine-tuning is rarely a one-time investment, it is an ongoing maintenance commitment.

>> Versioning is what makes the cost-benefit calculation honest over time — without it, you cannot tell whether today's model is even the one your original evaluation was measuring.$M21L30$
  ) returning id into v_l30;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.31 — Fine-Tuning ROI Example
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fine-Tuning ROI Example',
    31,
    $M21L31$Use case: support ticket classification.

Current workflow: humans manually classify 100,000 tickets per month.

Base prompt: 85% accuracy, moderate cost, acceptable latency.

Fine-tuned small model: 94% accuracy, lower cost, lower latency, fewer human corrections.

Business value: faster routing, lower manual effort, better SLA, lower support cost, better CSAT.

Fine-tuning makes sense if training cost is recovered, errors are reduced, quality is stable, and human review catches risky mistakes.

[!] Fine-tuning is worth it when repeated volume turns small improvements into meaningful value — a 9-point accuracy gain matters far more at 100,000 tickets a month than at 100.

>> This is the concrete version of the cost-benefit lesson before it: the same nine-percentage-point improvement is either a rounding error or a major win, depending entirely on volume.$M21L31$
  ) returning id into v_l31;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.32 — Model Selection Example: Support Copilot, and Internal Analytics Assistant
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Model Selection Example: Support Copilot, and Internal Analytics Assistant',
    32,
    $M21L32$MODEL SELECTION EXAMPLE: SUPPORT COPILOT

Task: draft support replies.

Prompt-only is good for a prototype. RAG plus prompt is better for policy-grounded answers. A fine-tuned model is useful if tone or format is inconsistent at scale. A tool-using agent is needed if the system must check order status or create actions. Human-in-the-loop is needed for high-risk responses.

Best design may combine all of these: RAG for policy, a tool for order status, a prompt for answer structure, fine-tuning for tone or format if volume justifies it, and human approval before sending.

**Most real AI products combine multiple methods.**


MODEL SELECTION EXAMPLE: INTERNAL ANALYTICS ASSISTANT

Task: answer business metric questions.

An LLM alone is risky — it may hallucinate numbers. RAG is useful for metric definitions and documentation. A tool or database query is needed for the actual numbers. Fine-tuning may help generate SQL in the company's style. Human review is needed for executive reports.

Best design: tool access for data, RAG for metric definitions, validation for SQL, a prompt for narrative, and human review before leadership distribution.

[!] Use the model for language, but use tools for truth — this single sentence explains both examples in this lesson.

>> Neither example picks one method and calls it done — production-grade AI products are usually a combination, not a single technique.$M21L32$
  ) returning id into v_l32;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.33 — Model Selection Example: Invoice Extraction, and Product Recommendations
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Model Selection Example: Invoice Extraction, and Product Recommendations',
    33,
    $M21L33$MODEL SELECTION EXAMPLE: INVOICE EXTRACTION

Task: extract invoice fields.

A prompt-only vision or document model is good for a prototype. Fine-tuning is useful if invoices follow domain-specific patterns. Validation rules are needed for totals, currency, dates, and vendor IDs. Human review is needed for high-value invoices or low-confidence fields.

Best design: an OCR or document model, structured extraction, validation rules, human review for exceptions, and fine-tuning if field errors persist at scale.

**Fine-tuning improves extraction behavior, but validation prevents costly mistakes.**


MODEL SELECTION EXAMPLE: PRODUCT RECOMMENDATIONS

Task: rank products.

An LLM is usually not the core model here. Better tools: a recommendation model, embeddings, a ranking model, collaborative filtering, a learning-to-rank model, and experimentation.

An LLM may still help with explaining recommendations, generating product descriptions, understanding natural-language intent, and search query rewriting.

[!] Do not force LLMs into every ML problem — ranking is a classic case where traditional ML and recommendation systems (covered back in earlier modules) usually outperform an LLM doing the same job.

>> Invoice extraction shows fine-tuning working alongside validation. Product recommendations shows an LLM playing a supporting role to a different core model entirely.$M21L33$
  ) returning id into v_l33;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.34 — Decision Tree: What Should We Use?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Decision Tree: What Should We Use?',
    34,
    $M21L34$Ask this in order:

Does the task need exact live data? Use tools, a database, or an API.

Does the task need company documents or current knowledge? Use RAG.

Does the task need better instructions or format? Use prompting or structured output.

Does the task need consistent behavior at scale? Consider fine-tuning.

Does the task use structured data prediction? Use traditional ML.

Does the task involve many ranked options? Use a recommendation or ranking model.

Does the task need actions across systems? Use an agent with tools and approvals.

Is the task simple and rule-based? Use deterministic software.

**Choose the simplest reliable solution that meets the quality bar.**

[!] This decision tree is the entire module condensed into eight questions, in the order you should actually ask them — most teams skip straight to "should we fine-tune" and never reach the earlier, cheaper questions at all.

>> If you remember nothing else from this module, remember to ask these eight questions in order before reaching for fine-tuning.$M21L34$
  ) returning id into v_l34;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.35 — PM Checklist Before Fine-Tuning, and PM Checklist for Model Selection
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist Before Fine-Tuning, and PM Checklist for Model Selection',
    35,
    $M21L35$PM CHECKLIST BEFORE FINE-TUNING

Before approving fine-tuning, ask: what exact behavior are we trying to improve? Have we tried prompt improvement, and examples or few-shot prompting? Is missing knowledge the actual issue, and would RAG solve it better? Does the task require live data or tools? Do we have enough high-quality examples, and are labels consistent? Is the output format stable, and is the task repeated often enough? What baseline are we comparing against, and what metric must improve? What safety behavior must not get worse? What is the expected cost or latency benefit? How will we test on unseen examples, and how will we monitor after launch? Who owns retraining, and what is the rollback plan?


PM CHECKLIST FOR MODEL SELECTION

Before choosing a model, ask: what is the task, the input, and the output — language, image, audio, structured data, or ranking? Does it need reasoning, long context, or current/private knowledge? Does it need tools or structured output? What quality bar must it meet, and what latency and cost are acceptable? What safety risks exist, and what data can it access? What model options are available, and what is the baseline? What golden dataset will compare options, and what human evaluation is needed? What online metric proves value, and what is the fallback if it fails?

[!] Notice how much these two checklists overlap with the decision tree and the model selection ladder from earlier in this module — they are the same discipline applied at two different decision points: before fine-tuning specifically, and before choosing any model at all.

>> Two checklists, same spirit: write down the actual questions before committing engineering time, rather than discovering the gaps after launch.$M21L35$
  ) returning id into v_l35;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 21.36 — How to Explain Fine-Tuning to Leadership, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'How to Explain Fine-Tuning to Leadership, and the Memory Shortcut',
    36,
    $M21L36$HOW TO EXPLAIN FINE-TUNING TO LEADERSHIP

Simple explanation: "fine-tuning means taking a pretrained model and training it further on examples of our desired input and output. It is useful when we need consistent behavior for a repeated task, such as classification, extraction, formatting, or brand style. It is not usually the best way to add changing knowledge. For knowledge-heavy tasks, RAG is usually better because it retrieves current sources at answer time."

Example: "we should not fine-tune first. We should first measure the base model with prompting and RAG. If the model still fails in a repeated, measurable way and we have high-quality examples, then fine-tuning may improve consistency and reduce cost or latency."

Another example: "for support ticket routing, fine-tuning may be valuable because we have labeled historical tickets and a stable taxonomy. For policy Q&A, RAG is better because policies change and agents need citations."


THE MEMORY SHORTCUT

Model selection is choosing the right model or method for the job. Fine-tuning is teaching a pretrained model a repeated behavior using examples. RAG is giving the model knowledge at answer time. Tools are connecting the model to live facts and actions. Traditional ML is better for structured prediction and ranking. Deterministic software is better when rules are exact.

Remember: prompt first, then add context/RAG/tools, then evaluate, then fine-tune only if needed.

Use fine-tuning when the task is stable, the behavior is repeatable, you have high-quality examples, prompting is not enough, RAG is not the main issue, output consistency matters, volume justifies the cost, and you can evaluate improvement.

Do not use fine-tuning when knowledge changes often, you need live data, you lack examples, the task is vague, labels are inconsistent, a simple prompt works, a rule-based system works, or safety cannot be tested.

Measure fine-tuning with task accuracy, format compliance, human acceptance, cost per task, latency, safety regression, bias/fairness, and business impact.

[!] This module completes the "which method" arc that runs through Modules 16-21 — LLMs and prompting first, then RAG, then agents, and now the discipline of knowing when customization is actually worth it.

>> The most important PM question: are we choosing the simplest, safest, most cost-effective AI method that solves the actual failure mode?$M21L36$
  ) returning id into v_l36;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (36 total, one per lesson) — Part 1: Q1-Q18
  -- ─────────────────────────────────────────────────────────────────

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'A team''s AI feature gives poor output, and the team immediately proposes fine-tuning as the fix without investigating further. What does this lesson say about this approach?',
    '["Fine-tuning should not be the first response — the better first question is what exactly is failing and what is the cheapest, safest way to fix it, since the cause could be a vague prompt, missing knowledge, weak retrieval, the wrong model, or several other issues fine-tuning would not fix","Fine-tuning is always the correct first response to poor AI output, regardless of the root cause","This approach is fine as long as the team has a large enough budget for fine-tuning","Poor output can only ever be fixed through fine-tuning, with no other possible causes or solutions"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'A team always defaults to the largest, most expensive available model for every task, including simple ticket classification. What does this lesson say about this default?',
    '["Bigger models are not always better — they can be more expensive, slower, and unnecessary for simple tasks like ticket classification, where a smaller model may work well; the goal is to use the smallest, cheapest, fastest model that meets the quality bar safely","This default is correct, since the largest model always produces the best results for every task type","Model size has no effect on cost or latency, so this default carries no real tradeoff","Simple classification tasks always require the largest available model to work correctly"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'A team selects a model based only on its quality score in a public benchmark, without considering cost, latency, or whether it can reliably return structured output for their specific use case. What does this lesson say is missing from this evaluation?',
    '["Model selection should compare across multiple dimensions — including cost, latency, context window, tool use, structured output ability, safety, and compliance — not just quality alone, since a model that scores well on a generic benchmark may still fail on dimensions the specific product actually depends on","Quality score alone is a sufficient and complete basis for model selection in every case","Cost and latency are engineering concerns that should never factor into a PM''s model selection decision","Structured output ability and tool use are irrelevant to model selection regardless of the product''s needs"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'A team wants to build a semantic search feature and defaults to using a general-purpose chat LLM directly for the search matching, instead of considering other model types. What does this lesson suggest they consider instead?',
    '["An embedding model — this lesson specifically identifies embedding models as good for semantic search, RAG retrieval, similarity, and clustering, which is a better fit for search matching than a general chat-oriented LLM","A speech/audio model, since audio models are the most versatile category for any search-related task","There is no meaningful difference between model families, so the default choice is equally appropriate","A reasoning model is always the correct choice for search tasks regardless of the underlying need"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A team encounters a quality problem and jumps directly to fine-tuning without first improving the prompt, adding examples, or trying RAG. Based on the model selection ladder in this lesson, what did they skip?',
    '["Several cheaper, lower-risk rungs on the ladder — improving the prompt, adding examples, adding structured output, and adding RAG or tools all come before fine-tuning, and skipping straight to fine-tuning means skipping past several genuinely simpler potential fixes","This is the correct approach, since fine-tuning should always be attempted before any other method","The ladder recommends fine-tuning as the very first step for any quality problem","There is no meaningful order to these methods, so skipping steps has no consequence"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A team wants to fine-tune a model specifically so it "knows our latest return policy," expecting this knowledge to stay accurate as the policy changes over time. What does this lesson say is the problem with this plan?',
    '["Fine-tuning is good for teaching repeated behavior (like classification or consistent formatting), not for knowledge that changes — since policies change over time, baking the current policy into the model''s weights via fine-tuning will become outdated and hard to maintain","Fine-tuning is an ideal way to keep the model updated on facts that change frequently, like company policy","This is a good use case for fine-tuning as long as the model is retrained every single day","Fine-tuning and knowledge freshness are unrelated concepts that do not interact in any way"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A team wants the model to always answer using the most current version of a frequently-changing document, and is considering fine-tuning on that document. What does this lesson recommend instead?',
    '["Use RAG instead of fine-tuning — since the document changes often, fine-tuning becomes hard to maintain, while RAG retrieves external knowledge at runtime, keeping answers current without needing constant retraining","Fine-tuning is the recommended approach for any document, regardless of how frequently it changes","RAG and fine-tuning always produce identical results, so either approach works equally well here","Neither RAG nor fine-tuning can help with frequently-changing documents, and no AI-based solution exists"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A PM is still exploring exactly what format and style an AI summarization feature should use, with requirements shifting week to week. Should this PM fine-tune a model right now, based on this lesson?',
    '["No — prompting is the better choice while requirements are still uncertain and changing often, since prompting allows fast iteration; fine-tuning is better suited to a task that is stable and has settled requirements","Yes, fine-tuning should always happen as early as possible in a project regardless of how unstable requirements are","Yes, since frequently changing requirements are exactly the situation fine-tuning is designed to handle","This decision has nothing to do with how stable the requirements are"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A user asks an AI system "what is the status of my order #123?" and the team proposes fine-tuning the model so it can answer this type of question directly. What does this lesson say about this plan?',
    '["Fine-tuning is not appropriate here — the model needs a tool like an order lookup to get the actual live order status, since fine-tuning cannot make a model know real-time, live information like a specific order''s current status","Fine-tuning is the correct solution, since fine-tuning can teach the model to know live, real-time order status","This question requires training a completely new model from scratch rather than fine-tuning or tools","This is exactly the kind of task fine-tuning excels at compared to using a tool"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A team is deciding between supervised fine-tuning and preference tuning for a task where the "correct" output is highly subjective (persuasive marketing tone), and clear right/wrong labels are hard to define. Which type of fine-tuning does this lesson suggest fits better?',
    '["Preference tuning — it uses comparisons between better and worse outputs (which humans can judge even for subjective qualities like tone) rather than requiring one single \"correct\" labeled answer, which supervised fine-tuning needs","Supervised fine-tuning is always the better choice regardless of how subjective the desired output is","Parameter-efficient tuning is specifically designed only for subjective tasks like tone and style","Full fine-tuning is required whenever the task involves any subjective judgment"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'A team collects many examples where the correct category, urgency, and summary are clearly labeled for each customer message, and wants the model to learn this exact input-to-output mapping. Which fine-tuning approach from this lesson fits best?',
    '["Supervised fine-tuning — it works by providing input-output examples (like a customer message mapped to the correct category, urgency, and summary), which is exactly the labeled-example structure described in this lesson","Preference tuning is the better fit, since it is designed specifically for cases with clear correct labels","This task cannot be addressed by any type of fine-tuning described in this lesson","Parameter-efficient tuning and supervised fine-tuning are mutually exclusive and cannot both apply to labeled data"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l12,
    'A team has limited compute budget and wants to customize a large model''s behavior without the cost of updating every parameter. What technique from this lesson fits this constraint?',
    '["Parameter-efficient tuning — it adapts large models by updating only a relatively small subset of parameters, making it more resource-efficient than full fine-tuning, which fits a limited compute budget better","Full fine-tuning is the only option available for customizing model behavior under a limited budget","Preference tuning always requires more compute than any other fine-tuning method, regardless of budget","Compute budget has no bearing on which fine-tuning technique is appropriate to use"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l13,
    'A team fine-tunes a model on customer support data where different annotators labeled similar tickets with different, inconsistent categories. What does this lesson say the fine-tuned model is likely to learn?',
    '["Messy, inconsistent behavior — since a model trained on messy examples will learn messy behavior, inconsistent labels will teach the model to be inconsistent in the same way the training data was inconsistent","The model will automatically resolve the inconsistencies and learn only the correct pattern regardless of label quality","Label consistency has no effect on what the fine-tuned model learns","The model will simply ignore all inconsistently labeled examples during training without any negative effect"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l14,
    'A team building a support ticket classifier finds that prompting alone works 85% of the time but consistently fails on a specific set of edge categories, and they have thousands of correctly labeled historical tickets for those categories. Based on this lesson, is fine-tuning likely to help here?',
    '["Yes — this matches the support ticket classification example closely: labels are defined, historical tickets exist, correct outputs are available, the task repeats at high volume, and the output format is structured, all of which are the conditions where fine-tuning tends to help","No, fine-tuning is never appropriate for classification tasks regardless of available labeled data","This scenario requires structured extraction instead of fine-tuning, and fine-tuning would not apply here","Fine-tuning would only help if the task involved unstructured invoice documents rather than support tickets"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l15,
    'A marketing team wants consistent brand voice across AI-generated copy but has almost no approved example copy to work from, and quality is hard for reviewers to judge consistently. What does this lesson say about fine-tuning in this situation?',
    '["Fine-tuning for brand voice depends on having many approved examples and quality that can be judged reliably — without enough approved examples or reliable quality judgment, this is not yet a good fit for fine-tuning, even though brand voice is generally a reasonable fine-tuning use case","Fine-tuning should proceed immediately regardless of example availability or ability to judge quality","Brand voice fine-tuning never requires any approved examples to be effective","This scenario is identical to the smaller-model-optimization example and should be approached the same way"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l16,
    'A team wants an AI system to generate SQL queries for analysts, and the database schema changes frequently as the product evolves. Based on this lesson, what combination of approaches makes the most sense?',
    '["Fine-tuning can teach the general query style and phrasing patterns, but RAG and tools are still needed to provide the current schema, table metadata, permission checks, and query validation, since the schema itself changes frequently and fine-tuning alone cannot keep up with those changes","Fine-tuning alone is sufficient and no RAG or tools are needed regardless of how often the schema changes","RAG alone is sufficient and fine-tuning provides no additional value for this use case","This task should avoid AI entirely and rely only on deterministic software with no model involvement"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l17,
    'A user asks "what is the latest return policy for damaged items in Canada?" and a team proposes fine-tuning the model to memorize this policy. What does this lesson recommend instead, and why?',
    '["Use RAG over current policy documents with region metadata instead of fine-tuning — the answer depends on documents that change often and need region-specific accuracy, and baking changing knowledge into model weights via fine-tuning is exactly what this lesson warns against","Fine-tuning is the ideal solution for any region-specific policy question, regardless of how often it changes","This question cannot be answered by RAG since RAG only works for policies that never change","Prompting alone, without RAG or fine-tuning, is the recommended solution for this scenario"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l18,
    'A user asks an AI system "what is my current account balance?" and the team proposes fine-tuning the model to answer this more reliably. What does this lesson say about this plan?',
    '["Fine-tuning cannot make a model know live information like a real-time account balance — since the answer depends on a system of record, a tool is needed instead, regardless of how much fine-tuning is applied","Fine-tuning is an effective way to teach a model live, constantly-changing account balances","This is a structured prediction problem that requires training a new traditional ML model instead of using a tool","Account balance questions cannot be answered by any method described in this lesson"]',
    0
  );

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS — Part 2: Q19-Q36
  -- ─────────────────────────────────────────────────────────────────

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l19,
    'A finance team wants an AI system to calculate exact tax owed using a fixed, well-defined formula, and considers fine-tuning a model to perform this calculation reliably. What does this lesson recommend instead?',
    '["Use deterministic software instead — since the rules are clear, output must be exact, and this is fundamentally a calculation task, deterministic software is safer and more reliable here than fine-tuning a model, which can still make probabilistic errors on exact calculations","Fine-tuning is the best approach for any calculation task, including fixed-formula tax calculations","Model routing should send this task to the largest available reasoning model instead of deterministic code","This task cannot be solved by any method, AI-based or otherwise, according to this lesson"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l20,
    'A company wants to decide between using a commercial AI API and fine-tuning a model in-house for a new AI feature, but has a very small internal ML team and needs to prototype quickly. Based on this lesson, which option best fits their situation?',
    '["Use a commercial AI API — this fits when speed matters, general model quality is good, the internal ML team is small, and the team wants fast prototyping, all of which apply to this company''s situation","Fine-tuning in-house is always the better choice for small ML teams regardless of speed needs","Building a custom model from scratch is the recommended path for any team without existing infrastructure","There is no meaningful difference between these options for a small team"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l21,
    'A team chooses a closed/commercial model for speed and ease of use, but later realizes they need full control over data locality and custom deployment for regulatory reasons. What does this lesson say about this tradeoff?',
    '["Closed models reduce build complexity but come with less control and vendor dependency, while open-source or self-hosted models increase control (including data locality and custom deployment) but also increase ownership burden like infrastructure and ML ops complexity — this is exactly the tradeoff the team is now experiencing","Closed models always provide the same level of data locality and deployment control as open-source models","This tradeoff does not exist, since closed and open-source models are functionally identical in terms of control and complexity","Regulatory requirements around data locality can only ever be solved by fine-tuning, not by choice of model hosting"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l22,
    'A team selects a model for their support AI product based solely on how impressive it seemed in a live demo, without testing it against real historical support tickets. What does this lesson say about this approach?',
    '["This is a vibe-based evaluation, which this lesson specifically warns against — model evaluation should use task-specific evals that reflect real production distributions, including real user examples, edge cases, and hard cases, rather than relying on demo impressions","Demo performance is a fully reliable substitute for task-specific evaluation on real production data","Vibe-based evaluation is the recommended approach specifically for support AI products","Evaluation is unnecessary once a model has performed well in any demo setting"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l23,
    'A team fine-tunes a model and reports "the outputs look much better now," but has not measured any specific accuracy, format compliance, or business metric before and after the change. What does this lesson say is missing?',
    '["A measured comparison against a baseline using the actual task metric — the lesson specifically asks whether fine-tuning improved the actual task metric, not just made outputs look nicer, which requires measuring baseline and post-fine-tuning performance on defined metrics like accuracy or format compliance","Nothing is missing, since outputs looking better is a sufficient basis for concluding fine-tuning was successful","This gap only matters for extraction tasks, not for other types of fine-tuning like classification","Subjective impressions of quality are always more reliable than measured metrics for evaluating fine-tuning success"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l24,
    'A fine-tuned model performs very well on the exact examples it was trained on but performs poorly when tested on new, unseen support tickets with slightly different wording. What does this lesson say is happening?',
    '["This is overfitting — the model memorized training examples instead of learning general behavior, shown by great training performance combined with weak test performance and failure on new wording, which is exactly the pattern described in this lesson","This is expected and desirable behavior for any well-fine-tuned model","This indicates the model needs more training on the exact same examples it already saw","This pattern only occurs in preference tuning, not in supervised fine-tuning"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l25,
    'A fine-tuned support model shows improved tone scores after fine-tuning, but the team has not checked whether policy accuracy, refusal behavior, or safety cases got worse. What does this lesson recommend?',
    '["Run regression tests covering safety behavior, refusal behavior, policy compliance, format compliance, accuracy, bias/fairness, edge cases, and no-answer cases — since a fine-tuned model that improves on one dimension (tone) but regresses on another (policy accuracy) is not acceptable, and this can only be caught by explicitly testing for it","Improved tone scores alone are sufficient evidence that the fine-tuned model is ready to launch","Regression testing is only necessary for models that show a decline in the primary task metric, not for models that improve","Policy accuracy and safety behavior cannot be affected by fine-tuning that targets tone, so no additional testing is needed"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l26,
    'A team wants to fine-tune a customer support model using real historical support tickets that include unredacted customer names, account IDs, and payment details. What does this lesson say the team should check before proceeding?',
    '["Whether this data is allowed for training, whether sensitive data has been removed or masked, who can access the training data, whether outputs could leak memorized details, and whether vendor policy allows this use — training data is product risk and must be treated carefully, especially with unredacted sensitive information like this","Nothing needs to be checked, since historical support tickets are always safe to use for training as-is","Privacy review is only required for healthcare or financial fine-tuning projects, not for general customer support","Redacting sensitive data would make the fine-tuning less effective, so it should be left unredacted"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l27,
    'Two annotators labeling the same support tickets frequently disagree on whether a ticket belongs in "Billing" or "Refund," and the team proceeds with fine-tuning anyway without resolving this disagreement. What does this lesson predict will happen?',
    '["The model will likely learn the same inconsistency the annotators had — if humans cannot label consistently, the model cannot learn consistently, so proceeding without resolving the labeling disagreement will likely produce a similarly confused model","The fine-tuned model will automatically resolve the ambiguity and produce perfectly consistent categorization","Annotator disagreement has no impact on fine-tuning outcomes as long as there are enough total examples","This kind of disagreement only matters for preference tuning, not for supervised fine-tuning tasks like classification"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l28,
    'A team fine-tunes a model, evaluates it once, and deploys it to 100% of production traffic immediately, with no shadow mode or phased rollout. What does this lesson say about this launch approach?',
    '["This skips important steps in both the fine-tuning project plan and shadow mode testing — the recommended approach is to pilot in shadow mode or copilot mode and use a phased rollout before full deployment, so the team can catch problems (like disagreements with human judgment on real cases) before they affect all users","This is the recommended launch approach for any fine-tuned model with a good evaluation score","Shadow mode is only relevant for agent-based systems, not for fine-tuned classification models","A single evaluation pass is always sufficient to justify full production deployment with no phased rollout"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l29,
    'A team launches a fine-tuned model gradually, but stops actively watching input distribution, output distribution, or drift after the initial launch period, assuming the model will remain reliable indefinitely. What does this lesson say about this assumption?',
    '["This assumption is risky — fine-tuned model quality can degrade over time as user behavior changes, policies change, new categories appear, or data distribution shifts, so ongoing monitoring is needed to know when the model is no longer good enough, not just monitoring during the initial launch","This assumption is correct, since a well-fine-tuned model requires no further monitoring once launched successfully","Monitoring is only necessary if the initial evaluation showed poor results, not for models that launched successfully","Drift and distribution shift are concepts that only apply to traditional ML models, not to fine-tuned LLMs"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l30,
    'A team has multiple fine-tuned model versions in production but cannot determine which training dataset or evaluation results correspond to the version currently live, making it hard to debug a reported quality issue. What does this lesson say is missing?',
    '["Model versioning — tracking the base model, fine-tuning dataset version, training date, evaluation results, safety results, deployment date, owner, and rollback plan for each version, since without this, the team cannot trace or debug which version is actually running and why it might be behaving a certain way","Nothing is missing, since debugging a fine-tuned model does not require knowing which version or dataset was used","This problem can only be solved by retraining from scratch, not by improved versioning practices","Model versioning is only relevant for traditional ML models, not for fine-tuned LLMs"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l31,
    'A company fine-tunes a small model for ticket classification, improving accuracy from 85% to 94%, but processes only 50 tickets per month rather than 100,000. Based on this lesson''s ROI example, how should the PM think about whether this was worth it?',
    '["The value of even a large accuracy improvement scales with volume — this lesson''s ROI example shows fine-tuning making strong business sense at 100,000 tickets per month, but at only 50 tickets per month, the same percentage-point improvement translates to far less absolute value, so the PM should weigh the fine-tuning cost against this much smaller realized benefit","The ROI is identical regardless of volume, since accuracy improvement alone determines whether fine-tuning was worthwhile","Fine-tuning is only worthwhile if the accuracy improvement exceeds 20 percentage points, regardless of volume","Volume has no bearing on fine-tuning ROI calculations according to this lesson"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l32,
    'A team building a support copilot uses only a single fine-tuned model for the entire feature — drafting replies, checking order status, retrieving policy, and validating tone — instead of combining multiple methods. What does this lesson''s examples suggest about this design?',
    '["Most real AI products combine multiple methods — the support copilot example in this lesson recommends RAG for policy, a tool for order status, a prompt for structure, fine-tuning for tone/format if justified by volume, and human approval, rather than relying on a single fine-tuned model to handle everything including things like live order status that fine-tuning cannot provide","A single fine-tuned model handling all of these responsibilities is the recommended and most efficient design according to this lesson","Order status lookups can be reliably handled by a sufficiently well fine-tuned model without any tool integration","Combining multiple methods is only relevant for internal analytics assistants, not for support copilots"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l33,
    'A team wants to rank products for a recommendation feature and defaults to fine-tuning a general-purpose LLM to perform the ranking, rather than considering other model types. What does this lesson''s product recommendations example suggest instead?',
    '["Consider dedicated recommendation and ranking approaches instead — this lesson notes that an LLM is usually not the core model for ranking products, and better tools include recommendation models, embeddings, ranking models, collaborative filtering, and learning-to-rank models, with the LLM playing a supporting role like explaining recommendations rather than doing the ranking itself","Fine-tuning a general-purpose LLM is the recommended and most effective approach for all product ranking tasks","Traditional recommendation and ranking models are obsolete and should always be replaced by fine-tuned LLMs","This decision has no meaningful tradeoffs, since any model type performs identically for ranking tasks"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l34,
    'A team is deciding how to build a new AI feature and is unsure whether it needs live data, current documents, better prompting, fine-tuning, traditional ML, or deterministic rules. What does this lesson recommend they do?',
    '["Work through the decision tree in order — check whether the task needs exact live data (use tools), company documents (use RAG), better instructions (use prompting), consistent behavior at scale (consider fine-tuning), structured prediction (use traditional ML), ranking (use a ranking model), cross-system actions (use an agent), or simple fixed rules (use deterministic software) — and choose the simplest reliable solution that meets the quality bar","Skip directly to fine-tuning, since it is the most broadly capable option and can substitute for any of the other approaches","Always choose traditional ML first regardless of whether the task involves structured data or ranking","This decision cannot be made systematically and should be based on which method the team is most excited about"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l35,
    'A team wants to approve a fine-tuning project but has not documented what baseline they are comparing against, what metric must improve, or what safety behavior must not get worse. Based on the checklist in this lesson, should this project proceed as-is?',
    '["No — the PM checklist before fine-tuning specifically requires defining the baseline, the metric that must improve, and the safety behavior that must not get worse before approving fine-tuning, and skipping these questions leaves the project without a way to know if it actually succeeded","Yes, since these details can be figured out after the fine-tuning is already complete","Yes, as long as the team has enough training examples, regardless of whether a baseline or safety criteria are defined","Baseline and safety criteria are only required for model selection decisions, not for fine-tuning approval"]',
    0
  );

  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l36,
    'A leadership stakeholder asks why the team is starting a new AI feature with prompting and RAG instead of fine-tuning, when fine-tuning "sounds more advanced and thorough." Based on this lesson''s guidance for explaining fine-tuning to leadership, what is the appropriate response?',
    '["Explain that fine-tuning is not usually the best way to add changing knowledge, and the team should first measure the base model with prompting and RAG; only if the model still fails in a repeated, measurable way, and high-quality examples exist, does fine-tuning make sense to improve consistency or reduce cost/latency — sounding \"more advanced\" does not make it the right first step","Fine-tuning should always be used first for any new AI feature since it is inherently more thorough and advanced than prompting or RAG","Prompting and RAG are outdated techniques that should be replaced entirely by fine-tuning in modern AI products","The choice between these approaches has no relationship to whether the task involves changing knowledge or stable, repeated behavior"]',
    0
  );

end $$;
