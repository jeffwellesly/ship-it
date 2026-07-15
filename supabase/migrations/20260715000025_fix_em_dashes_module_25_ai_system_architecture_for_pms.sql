-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 25: AI System Architecture for PMs
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update modules set description = $M$The full system around the model, architecture layers, retrieval and tool design, guardrails, monitoring, deployment patterns, and the decisions PMs actually need to weigh in on.$M$ where id = '3f698808-c51b-4e7a-8ee8-88a34960b136';

update lessons set content = $D8c0f9c10_376b_41eb_b91e_18986c5e1ee5$Use case: AI helps process low-risk refund requests.

Architecture: the customer request is received, intent is detected as a refund, an order lookup tool checks the order, policy RAG retrieves the refund policy, eligibility logic checks deterministic rules, the model drafts a recommendation and customer message, a guardrail checks the amount threshold, low-risk cases may proceed with approval, high-risk cases escalate, and the audit log records every step.

Metrics: correct eligibility decisions, resolution time, refund error rate, CSAT, escalation quality, unsafe action rate.

[!] For action agents, deterministic rules and approvals matter as much as the model.

>> Notice "eligibility logic checks deterministic rules" sits right alongside the model-drafted recommendation, this is the same "use rules for hard constraints, AI for messy interpretation" principle from earlier modules, applied at the architecture level.$D8c0f9c10_376b_41eb_b91e_18986c5e1ee5$ where id = '8c0f9c10-376b-41eb-b91e-18986c5e1ee5';

update lessons set content = $D959b9a31_4986_49dd_b433_cb10e5518bd8$Use case: process invoices or contracts.

Architecture: the user uploads a document, OCR/text extraction runs, the document type is classified, relevant fields are extracted, field confidence is calculated, values are validated against rules/database, a human reviews low-confidence/high-value cases, final structured data is saved, and the audit trail links fields to source text.

Metrics: field accuracy, missing-field rate, human correction rate, processing time, cost per document, compliance errors.

[!] Document AI needs traceability from extracted value back to source.

>> Five build examples across this module now cover support, internal knowledge, analytics, agents, and documents, each uses a different combination of the same twelve architecture layers, tailored to its own risk profile.$D959b9a31_4986_49dd_b433_cb10e5518bd8$ where id = '959b9a31-4986-49dd-b433-cb10e5518bd8';

update lessons set content = $D5a870d51_68e0_495f_bc2c_0f616c5b402f$CLOUD VS. SELF-HOSTED

A cloud/API model is fast to start, offers strong models, needs less infrastructure, has managed scaling, and is easier to experiment with, but comes with vendor dependency, data review needs, usage cost, and less low-level control.

A self-hosted model offers more control, data locality, potential cost advantage at scale, and custom deployment, but comes with infrastructure complexity, model ops burden, security patching, scaling effort, and a need for ML expertise.

PM question: **"Do we need speed, control, privacy, cost efficiency, or customization most?"**


SINGLE MODEL VS. MULTI-MODEL

A single model is simpler, good for a prototype, a narrow use case, or low complexity. Multi-model is more flexible, good for different task types, cost optimization, specialized workflows, routing by complexity, and backup/fallback.

[!] Start simple, but design for routing if use cases grow.$D5a870d51_68e0_495f_bc2c_0f616c5b402f$ where id = '5a870d51-68e0-495f-bc2c-0f616c5b402f';

update lessons set content = $D8e26079e_6b27_459d_b974_ea583e304719$GENERIC ASSISTANT VS. WORKFLOW AI

A generic assistant is broad and flexible, but risks being vague and hard to measure. Workflow AI is narrow and integrated, example, "draft policy-grounded support replies inside the ticket console", and is better because it has a clear user, clear input, clear output, clear metric, easier evaluation, and easier guardrails.

[!] Workflow AI is usually easier to make valuable than a generic assistant.


CHAT VS. EMBEDDED AI

Chat is good for broad exploration, Q&A, and open-ended help. Embedded AI is good for a specific workflow, faster action, lower user effort, better context, and easier measurement, examples: a summarize button, draft reply panel, inline autocomplete, smart checklist, approval workflow.

>> The best AI interface is often not chat. It is AI embedded where work happens.$D8e26079e_6b27_459d_b974_ea583e304719$ where id = '8e26079e-6b27-459d-b974-ea583e304719';

update lessons set content = $D7d146071_3df3_4900_9311_b8608287125d$PATTERN 5: HUMAN-IN-THE-LOOP AI

Flow: AI output, then human review, then approve/edit/reject, then final action. Good for customer-facing replies, legal/compliance summaries, high-value refunds, finance workflows, medical/health workflows, and sensitive decisions. Weakness: slower, requires reviewer time, may reduce automation ROI, needs review UX.

[!] Use human-in-the-loop when mistakes are costly but AI can still save preparation time.


PATTERN 6: BATCH AI

Batch AI runs on a schedule, nightly customer summaries, weekly business reports, daily risk scoring, monthly document processing, bulk feedback analysis. Good for lower latency pressure, large volumes, scheduled workflows, cost control, and human review before release. Weakness: not real-time, may use stale data, needs scheduling/monitoring.

>> Use batch AI when real-time response is not needed.$D7d146071_3df3_4900_9311_b8608287125d$ where id = '7d146071-3df3-4900-9311-b8608287125d';

update lessons set content = $Dca8b5ab2_480f_4432_94b0_61a7cf7716ab$PATTERN 7: REAL-TIME AI

Real-time AI responds during user interaction, chat assistant, live support copilot, search answer, checkout recommendation, meeting copilot, real-time agent. Good for interactive UX, immediate help, personalization, dynamic workflows. Weakness: latency matters, cost can spike, reliability must be high, fallbacks are important.

[!] Real-time AI must be fast enough for the moment where it appears.


PATTERN 8: EDGE/ON-DEVICE AI

Some AI runs locally on the user's device or edge environment. Useful when privacy is important, latency must be low, internet may be unavailable, data should stay local, or cloud call cost is high, on-device summarization, local speech recognition, camera/image AI, offline assistant features. Weakness: smaller models, device limitations, harder updates, lower quality.

>> On-device AI trades some model power for privacy, speed, and local control.$Dca8b5ab2_480f_4432_94b0_61a7cf7716ab$ where id = 'ca8b5ab2-480f-4432-94b0-61a7cf7716ab';

update lessons set content = $Da364938d_aadc_4927_a427_7f5ecc33bc2c$Multi-agent systems use multiple specialized agents, example, a research agent, a data agent, a policy agent, a drafting agent, and a reviewer agent.

Google Cloud's agentic architecture guidance says designing agentic AI architecture is iterative and involves choosing suitable components for the application and workload.

Good for complex workflows, specialized subtasks, review loops, and research-heavy work. Weakness: hard to debug, more latency, more cost, coordination failures, more monitoring needed.

[!] Use multi-agent systems only when one well-designed workflow is not enough.

>> This is the ninth and most complex pattern in this lesson set, it is the last resort, not the default, and every weakness listed compounds the more agents you add.$Da364938d_aadc_4927_a427_7f5ecc33bc2c$ where id = 'a364938d-aadc-4927-a427-7f5ecc33bc2c';

update lessons set content = $D62411700_704e_427a_bdd5_d363e82c23bc$Use case: a support agent wants help replying to a customer.

Architecture: the user opens the ticket, the AI sees the ticket text and customer context, an intent classifier detects the issue type, RAG retrieves approved policy, an order lookup tool fetches order status, the prompt asks the model to draft a response, an output guardrail checks for unsupported promises, the agent sees the draft, source, and warning flags, the agent edits and approves, and the system logs the final reply and AI usage.

Metrics: agent acceptance, resolution time, CSAT, wrong-answer rate, policy compliance, escalation accuracy.

[!] This is not just a chatbot. It is an integrated support workflow.

>> Notice this single example touches nearly every layer from this module, orchestration, RAG, tools, prompt, output guardrails, human review, and logging, all in ten steps.$D62411700_704e_427a_bdd5_d363e82c23bc$ where id = '62411700-704e-427a-bdd5-d363e82c23bc';

update lessons set content = $D8237c64a_2e10_4fef_bcfa_a8e13a486e75$Use case: employees ask questions across company docs.

Architecture: documents are ingested, text is extracted and chunked, embeddings are created, chunks are stored in the vector database, metadata includes owner/version/permissions, the user asks a question, the system checks user permissions, hybrid search retrieves relevant chunks, the LLM answers from sources, citations are shown, and feedback is collected.

Metrics: search success, time to answer, citation correctness, answer helpfulness, source click-through, reduced repeated questions.

[!] Knowledge assistants depend as much on document quality as model quality.

>> Notice how many of these eleven steps happen before a single user ever asks a question, ingestion, chunking, embedding, and metadata tagging are all indexing-phase work that determines whether the later retrieval steps can succeed.$D8237c64a_2e10_4fef_bcfa_a8e13a486e75$ where id = '8237c64a-2e10-4fef-bcfa-a8e13a486e75';

update lessons set content = $D641b9b00_06a1_469d_89e9_58a005f14542$Use case: a business user asks questions about metrics.

Architecture: the user asks a question, the system identifies metric intent, RAG retrieves metric definitions, a SQL generation tool creates a query, a SQL validator checks syntax and permissions, the database executes the query, the model summarizes the result, the output separates facts from hypotheses, analyst review is required for executive reports, and the system logs the query, data source, and answer.

Metrics: query correctness, time to insight, analyst acceptance, wrong-number rate, user satisfaction, decision usefulness.

[!] Analytics AI should never invent numbers. It must use real data tools.

>> The SQL validator step is doing the same job as an output guardrail from earlier in this module, checking the model's work before it reaches a real database or a real business decision.$D641b9b00_06a1_469d_89e9_58a005f14542$ where id = '641b9b00-06a1-469d-89e9-58a005f14542';

update lessons set content = $D055d5c86_6ae6_4e98_8471_6887ffd012c3$AI PRODUCT ARCHITECTURE IN ONE LINE

A typical AI product works like this: **user request, then app logic, then context/retrieval/tools, then model, then validation, then response/action, then logging/monitoring.**

Example: a user asks "can this customer get a refund?" The system may understand the request, check user permission, look up the order, retrieve the refund policy, build the prompt, call the model, validate the answer, require approval before action, draft the response, and log everything. That is architecture.


THE MAIN AI ARCHITECTURE LAYERS

A production AI system usually has these layers: user experience, application/backend, orchestration, prompt/instruction, model, RAG/retrieval, tool/API, memory/state, permission/security, guardrail/evaluation, monitoring/observability, and human workflow.

[!] AI architecture = UX + app + model + data + tools + safety + monitoring.

>> Twelve layers sounds like a lot, but each one maps to a lesson later in this module, think of this list as the table of contents for everything that follows.$D055d5c86_6ae6_4e98_8471_6887ffd012c3$ where id = '055d5c86-6ae6-4e98-8471-6887ffd012c3';

update lessons set content = $D7cee428c_d7fc_4b87_90bc_0ef200219434$LAYER 1: USER EXPERIENCE LAYER

This is what the user sees, a chat interface, copilot panel, AI button, inline suggestion, search box, draft composer, agent progress view, approval screen, source citation view.

Good AI UX should answer: what can the AI do? What input does it need? What output will it give? Can the user verify, edit, approve, reject, undo, or escalate?

[!] The UX should make AI useful, understandable, and controllable.


LAYER 2: APPLICATION/BACKEND LAYER

The backend connects the AI to the product. It handles user authentication, request routing, data fetching, session management, business logic, API calls, tool execution, response formatting, logging, rate limits, and error handling.

Example: when a user asks about an order, the backend may check who the user is, confirm they can access the order, call the order database, send the result to the AI, and return a safe answer.

>> The UX layer is the only layer this whole module the user actually sees. Every other layer, starting with the backend, exists to make that one visible layer trustworthy.$D7cee428c_d7fc_4b87_90bc_0ef200219434$ where id = '7cee428c-d7fc-4b87-90bc-0ef200219434';

update lessons set content = $Df99fd2e6_2c1f_4837_8f13_e56d413136e7$LAYER 4: PROMPT/INSTRUCTION LAYER

Prompts tell the model what to do. The prompt layer may include system instructions, developer/product instructions, the user prompt, retrieved context, tool results, output format, safety rules, examples, refusal rules, and tone rules.

Example prompt rule: "answer using only the retrieved policy. If the policy does not answer, say there is not enough information. Do not promise refunds."

[!] Prompts translate product policy into model behavior. But prompts are not enough for high-risk rules, important rules should also be enforced in code, permissions, and guardrails.


LAYER 5: MODEL LAYER

The model layer is the AI engine. It may include a large language model, reasoning model, small classification model, embedding model, vision model, speech model, fine-tuned model, or traditional ML model.

Different tasks need different models: summarization uses an LLM, semantic search uses an embedding model, image understanding uses a vision model, churn prediction uses a traditional ML model, product ranking uses a recommendation model, and simple routing uses a small model/classifier.

>> Do not use one model for everything. Match the model to the task.$Df99fd2e6_2c1f_4837_8f13_e56d413136e7$ where id = 'f99fd2e6-2c1f-4837-8f13-e56d413136e7';

update lessons set content = $D0724f586_b40b_443d_8709_d3725becaf87$MODEL GATEWAY

Many AI products use a model gateway, a layer that manages access to models. It may handle model routing, fallback models, rate limits, cost tracking, logging, prompt templates, safety checks, vendor abstraction, model versioning, and latency monitoring.

Example: if Model A is too slow, route simple tasks to Model B. If a request is high-risk, route to a stronger model or human review.

[!] A model gateway helps teams control cost, reliability, and model choice.


MODEL ROUTING

Model routing means sending different requests to different models or workflows. Simple classification goes to a small/cheap model; complex reasoning goes to a stronger reasoning model; policy Q&A goes to RAG plus an LLM; live order status goes to a tool/API plus an LLM; an image question goes to a vision model; a high-risk action goes to human review; search similarity goes to an embedding model; recommendation ranking goes to a ranking model.

>> Use the cheapest, fastest, safest model that meets the quality bar.$D0724f586_b40b_443d_8709_d3725becaf87$ where id = '0724f586-b40b-443d-8709-d3725becaf87';

update lessons set content = $D12c083be_9c93_49f9_8c53_dadc33b252a3$LAYER 6: RAG/RETRIEVAL LAYER

RAG means Retrieval-Augmented Generation, it lets the AI retrieve trusted information before answering. Microsoft's Azure AI Search docs describe RAG as retrieving grounding data and passing it to a language model so the model can generate responses based on your content.

The RAG layer includes document ingestion, text extraction, chunking, embeddings, vector search, keyword search, hybrid search, metadata filtering, re-ranking, source citation, and permission filtering.

[!] RAG connects the AI to trusted knowledge.


RAG ARCHITECTURE FLOW

A RAG flow usually looks like this: the user asks a question, the system creates a query embedding, search retrieves relevant chunks, metadata filters remove the wrong region/version/permission, a re-ranker improves relevance, top sources are added to the prompt, the LLM answers from sources, citations are shown, and the answer is validated.

>> Question, then retrieve evidence, then answer from evidence, then cite evidence, this is the same RAG flow covered in depth back in Module 19, now placed as one layer inside the bigger system.$D12c083be_9c93_49f9_8c53_dadc33b252a3$ where id = '12c083be-9c93-49f9-8c53-dadc33b252a3';

update lessons set content = $D9d8fdc8a_7d93_412b_b224_0465c5b41a16$VECTOR DATABASE LAYER

A vector database stores embeddings and helps the system search by meaning. Example: a user asks "my item arrived broken, can I get money back?" Vector search may retrieve "damaged merchandise refund eligibility policy", even though the words differ, the meaning is similar.

The vector database may store the text chunk, embedding vector, document ID, source title, section heading, permissions, version, region, effective date, and metadata tags.

[!] Vector database = meaning-based search storage.


HYBRID SEARCH LAYER

Many AI systems use hybrid search, combining keyword search and vector search. Keyword search is good for exact terms, error code, product SKU, policy ID, contract clause, customer ID. Vector search is good for meaning, "broken item" is close to "damaged product," "cancel subscription" is close to "terminate plan."

>> Hybrid search is often better because users ask with both exact terms and natural language.$D9d8fdc8a_7d93_412b_b224_0465c5b41a16$ where id = '9d8fdc8a-7d93-412b-b224-0465c5b41a16';

update lessons set content = $Daa0d095d_ab5e_42bb_9198_de9f06b264f6$LAYER 7: TOOL/API LAYER

Tools let AI interact with systems, search documents, query a database, look up an order, check a calendar, send email, create a ticket, update a CRM, process a refund, run code, generate a report, create a return label.

Tools can be read tools (fetch information) or write tools (change something).

[!] Tools turn AI from a talker into a worker.


TOOL ARCHITECTURE

A tool needs a name, description, input schema, output schema, permissions, error handling, risk level, logging, rate limits, and an owner.

Example: tool lookup_order, inputs order_id and customer_id, outputs delivery date, item status, order value, and return eligibility flags. Risk is low to medium if read-only.

PM question: **"Is every tool clearly defined, permissioned, and logged?"**

>> Every field in a tool definition maps to a question a PM should be able to answer for any tool in their product, if you cannot fill in the schema, the tool is not ready.$Daa0d095d_ab5e_42bb_9198_de9f06b264f6$ where id = 'aa0d095d-ab5e-42bb-9198-de9f06b264f6';

update lessons set content = $D8de72411_226c_4d72_883a_b69aa0799f55$READ TOOLS VS. WRITE TOOLS

Read tools are lower risk, read policy, look up order, search docs, query analytics, check calendar availability. Write tools are higher risk, send email, issue refund, cancel order, update account, delete record, approve claim, modify billing.

[!] Read tools can often be automated earlier. Write tools need stronger controls.


TOOL PERMISSION LAYER

The tool permission layer decides what AI can access or do. Questions: can this user access this data? Can this AI workflow use this tool? Does this action require approval? Is the action reversible? Is the amount below threshold? Is the case low-risk? Is the user authorized?

Example: AI can draft a refund recommendation, but AI cannot issue a refund above $100 without human approval.

>> Agent permissions should be narrower than human admin permissions.$D8de72411_226c_4d72_883a_b69aa0799f55$ where id = '8de72411-226c-4d72-883a-b69aa0799f55';

update lessons set content = $D21576345_d154_4ddb_843b_c920e540564c$LAYER 8: MEMORY/STATE LAYER

Memory and state help the AI know what has happened. Conversation memory is what has been said in this chat. User memory is user preferences or stable facts. Workflow state is the current step in a task, example, order checked, policy retrieved, waiting for approval. Agent memory is what the agent has done, what tools it called, and what result it got.

[!] Memory helps continuity. State helps workflow control.


WHY STATE MATTERS

Imagine an agent processing a refund. Without state, it may forget which order it checked, which policy was retrieved, whether approval was already requested, whether a return label was created, or whether the customer was notified. That can create duplicate actions or confusion.

Good state management prevents repeated tool calls, duplicate refunds, lost workflow progress, wrong next steps, and inconsistent output.

>> How does the system know where it is in the workflow? Ask that question for any multi-step AI feature before it ships.$D21576345_d154_4ddb_843b_c920e540564c$ where id = '21576345-d154-4ddb-843b-c920e540564c';

update lessons set content = $Dab30fc5d_a38e_4923_bb31_acb11e8cef5e$MEMORY PRIVACY

Memory can be useful but risky. Questions: what is stored, and why? How long is it stored? Can the user edit or delete it? Does memory include sensitive data? Who can access it? Is it used for training? Is consent needed?

[!] Memory should be useful, visible, and controllable, not creepy.


LAYER 9: PERMISSION/SECURITY LAYER

The permission/security layer protects users, data, and systems. It handles authentication, authorization, role-based access, document permissions, tool permissions, data masking, sensitive-data detection, secrets management, audit logs, abuse prevention, and prompt injection defense.

NIST's AI Risk Management Framework is designed to help organizations manage AI risks to individuals, organizations, and society.

>> AI should follow the same security rules as the rest of the product, often stricter.$Dab30fc5d_a38e_4923_bb31_acb11e8cef5e$ where id = 'ab30fc5d-a38e-4923-bb31-acb11e8cef5e';

update lessons set content = $D7715b35e_8f90_4779_97fc_6f2911eca533$PERMISSION-AWARE RETRIEVAL

Permission-aware retrieval means AI retrieves only sources the user can access. Example: a customer-facing bot should not retrieve internal policy notes, a sales rep should not retrieve HR compensation documents, and a regional manager should not retrieve another region's confidential plans.

PM question: **"Does retrieval check permissions before sources enter the prompt?"**

[!] Do not only filter after generation. If restricted content enters the prompt, the risk already exists.


DATA MASKING

Data masking means hiding or replacing sensitive information, replace a full SSN with the last 4 digits, hide a credit card number, remove medical details, redact employee salary, mask a customer email, remove API keys.

Use masking when the model does not need exact sensitive data, logs may be viewed by humans, third-party systems are involved, or training/evaluation data is being created.

>> Do not send the model sensitive data unless the task truly needs it.$D7715b35e_8f90_4779_97fc_6f2911eca533$ where id = '7715b35e-8f90-4779-97fc-6f2911eca533';

update lessons set content = $D4ffd262e_f5e3_44a9_86ce_7e0b3b7141ec$LAYER 10: GUARDRAIL/EVALUATION LAYER

Guardrails help keep AI safe and reliable. Evaluation checks whether AI is good enough. Guardrails may happen before input reaches the model, during retrieval, during tool use, after model output, before the user sees the answer, or before an action is taken.

Examples: block an unsafe request, filter restricted sources, validate JSON, check citations, block an unsupported refund promise, require human approval, detect a private data leak, prevent a duplicate action.

[!] Guardrails are product rules made enforceable.


INPUT GUARDRAILS

Input guardrails check the user request before AI responds. Is the request allowed? Is the user trying prompt injection? Is private data included? Is the request out of scope or harmful? Does the user have permission?

Example: a user asks "show me confidential salary data", the input guardrail should block this.

>> Should this request enter the AI workflow at all? That question belongs at the very front of the pipeline, before retrieval or the model ever sees the request.$D4ffd262e_f5e3_44a9_86ce_7e0b3b7141ec$ where id = '4ffd262e-f5e3-44a9-86ce-7e0b3b7141ec';

update lessons set content = $D9cde7bcc_6040_41c5_9979_a9d9f613f8cd$OUTPUT GUARDRAILS

Output guardrails check the AI response before display or action, check hallucination risk, unsupported claims, citation correctness, private data leakage, unsafe content, tone, required format, and policy compliance.

Example: AI says "we guarantee refund approval", the output guardrail blocks it because policy does not support that promise.

[!] Output guardrails catch mistakes before users see them.


ACTION GUARDRAILS

Action guardrails control real-world actions: require approval before sending email, block a refund above a threshold, prevent a duplicate payment, validate the target customer, confirm before deleting data, log all tool calls, enforce idempotency, allow rollback.

>> The closer AI gets to taking action, the stronger the guardrails must be, input guardrails are the first line of defense, output guardrails the second, and action guardrails the last line before real-world consequences.$D9cde7bcc_6040_41c5_9979_a9d9f613f8cd$ where id = '9cde7bcc-6040-41c5-9979-a9d9f613f8cd';

update lessons set content = $D13b44fc8_8c40_419f_abd8_28a79070f408$EVALUATION HARNESS

An evaluation harness is a system for testing AI quality repeatedly. It may include a golden dataset, test prompts, expected outputs, human review rubrics, automated checks, regression tests, safety tests, prompt injection tests, RAG retrieval tests, agent tool-use tests, and cost/latency checks.

[!] Evaluation harness = repeatable AI quality testing machine.


LAYER 11: MONITORING/OBSERVABILITY LAYER

After launch, AI systems must be monitored. OpenAI's production guidance includes production concerns such as scaling, security, and cost management.

AI monitoring may track latency, cost, token usage, error rate, model version, prompt version, retrieval quality, tool failures, user feedback, hallucination reports, safety incidents, escalations, human overrides, drift, and prompt injection attempts.

>> AI monitoring tells you whether the system is still working after launch, evaluation proves readiness once, monitoring proves it continues to hold up over time.$D13b44fc8_8c40_419f_abd8_28a79070f408$ where id = '13b44fc8-8c40-419f-abd8-28a79070f408';

update lessons set content = $D2d332c2a_34f1_40ef_afa4_fe0225fa47a4$OBSERVABILITY

Observability means the team can inspect what happened. For AI, observability should show the user request, prompt used, retrieved documents, tool calls, tool results, model response, guardrail decisions, final output, human approval, errors, cost, and latency.

PM question: **"If something goes wrong, can we reconstruct why?"** Without observability, AI failures become difficult to debug.


LAYER 12: HUMAN WORKFLOW LAYER

AI architecture must include humans. Humans may review outputs, approve actions, handle escalations, correct errors, label data, improve prompts, update the knowledge base, monitor quality, and investigate incidents.

Example, support copilot: AI drafts, the agent approves, QA reviews samples, the PM monitors wrong-answer rate, and the policy team updates sources.

[!] Human-in-the-loop is part of architecture, not an afterthought.

>> Observability is what makes the human workflow layer actually possible, a human reviewer or incident investigator can only do their job if the system shows them what happened.$D2d332c2a_34f1_40ef_afa4_fe0225fa47a4$ where id = '2d332c2a-34f1-40ef-afa4-fe0225fa47a4';

update lessons set content = $Db5b61d5e_f2f0_46c7_8cad_8ab4223e7801$A strong AI product request flow may look like this: the user submits a request, the app checks authentication and permissions, the orchestrator identifies intent, the system chooses a workflow, retrieval fetches relevant sources, tools fetch live data if needed, the prompt is assembled, the model generates an answer or plan, output guardrails validate the response, action guardrails check tool actions, human approval is requested if needed, the user sees the answer or approves the action, the system logs sources/tools/model/prompt/cost/result, and monitoring tracks quality and failures.

[!] Authenticate, then retrieve/tool, then prompt/model, then validate, then approve/action, then log/monitor.

>> This fifteen-step flow is every layer from this module so far, assembled into the order they actually execute in, read it as the connective tissue between all the individual layers.$Db5b61d5e_f2f0_46c7_8cad_8ab4223e7801$ where id = 'b5b61d5e-f2f0-46c7-8cad-8ab4223e7801';

update lessons set content = $De175dd19_81ad_4e55_9989_d6d422e68e30$PATTERN 1: PROMPT-ONLY AI

The simplest pattern. Flow: user input, then prompt, then model, then output. Good for rewriting, brainstorming, drafting, summarizing provided text, and low-risk personal productivity. Weakness: no external knowledge, no live data, higher hallucination risk, limited control.

PM use case: "rewrite this message professionally", no RAG or tools needed.

[!] Prompt-only is fine when the user provides all needed context and risk is low.


PATTERN 2: RAG AI

Flow: user input, then retrieval, then sources, then prompt, then model, then answer with citations. Good for internal knowledge search, product docs Q&A, policy assistant, contract Q&A, and support knowledge assistant.

Microsoft's RAG documentation explains how retrieval can ground LLM responses using your content. Weakness: depends on source quality, retrieval can fail, citations may be wrong, permissions matter, and the knowledge base must be maintained.

>> Use RAG when the AI must answer from trusted documents.$De175dd19_81ad_4e55_9989_d6d422e68e30$ where id = 'e175dd19-81ad-4e55-9989-d6d422e68e30';

update lessons set content = $Dcc591284_cbd3_4efb_b6f7_55e5f08e03f6$DATA FLOW MATTERS

PMs should understand what data flows through the AI system. Ask: what user input enters the model? What documents are retrieved? What customer data is included? What tool outputs are included? What gets stored in logs? What gets sent to external vendors? What is used for evaluation? What is retained? What can be deleted?

[!] Data flow is where privacy, security, and compliance risks become real.


LATENCY ARCHITECTURE

Latency means how long the user waits. It depends on model speed, prompt length, output length, retrieval time, tool calls, number of steps, guardrail checks, network calls, and human approval.

Ways to reduce latency: use a smaller model for easy tasks, cache common responses, retrieve fewer but better chunks, stream low-risk outputs, run tool calls in parallel, use batch processing where possible, shorten prompts, limit output length.

PM question: **"How fast does this AI need to be for this UX moment?"**

>> Data flow and latency are both consequences of the same architecture decisions made earlier in this module, every extra retrieval step or tool call adds both risk and time.$Dcc591284_cbd3_4efb_b6f7_55e5f08e03f6$ where id = 'cc591284-cbd3-4efb-b6f7-55e5f08e03f6';

update lessons set content = $Dd525625e_b3d6_4289_b0cc_6d8e8c78a420$SHADOW MODE

Shadow mode means AI runs in the background without affecting users. Example: a refund agent recommends actions, but humans still decide. Compare the AI recommendation, the human action, the agreement rate, error type, potential time saved, and risky mistakes.

[!] Shadow mode lets you learn before giving AI power.


CANARY ROLLOUT

Canary rollout means releasing to a small portion of users first. Example: 1% of support tickets use the AI copilot, then 5%, then 25%, then full rollout.

Use canary when risk exists, a new model is deployed, a new workflow is launched, a new agent action is introduced, or you want early warning.

>> Canary rollout reduces blast radius, shadow mode reduces it to zero for the first phase, and canary reduces it further gradually once real actions begin.$Dd525625e_b3d6_4289_b0cc_6d8e8c78a420$ where id = 'd525625e-b3d6-4289-b0cc-6d8e8c78a420';

update lessons set content = $D48c39e26_8268_4ddd_bf81_32016d1ef4cd$KILL SWITCH

A kill switch turns off the AI feature or risky capability, disable auto-send, disable the refund tool, switch to draft-only mode, disable a retrieval source, roll back the model, route all cases to human review.

PM question: **"If this AI starts causing harm, how fast can we stop it?"**


ARCHITECTURE AND COMPLIANCE

Some AI products need legal/compliance review, especially when AI affects money, employment, healthcare, credit, insurance, legal decisions, identity, education access, safety, customer rights, or personal data.

NIST's AI RMF is intended to improve the ability to incorporate trustworthiness considerations into the design, development, use, and evaluation of AI products, services, and systems.

[!] High-impact AI needs stronger architecture, documentation, and governance.

>> A kill switch is the last-resort control for any single feature. Compliance review is the upfront check for whether a feature needed all of these controls (kill switch included) before it ever launched.$D48c39e26_8268_4ddd_bf81_32016d1ef4cd$ where id = '48c39e26-8268-4ddd-bf81-32016d1ef4cd';

update lessons set content = $D054c5bc1_ef47_4737_89a4_c83c8847a3a0$AUTOMATION VS. AUGMENTATION

Augmentation means AI helps the human, draft, suggest, summarize, recommend, explain. Automation means AI completes the task, auto-route a ticket, auto-fill a form, auto-create a report, auto-process a low-risk refund.

Use augmentation when risk is high, quality is not proven, or human judgment matters. Use automation when the task is low-risk, rules are clear, evaluation is strong, monitoring exists, and mistakes are recoverable.

[!] Start with augmentation. Move to automation after evidence.


DETERMINISTIC RULES VS. AI

Use deterministic rules when logic is clear, output must be exact, regulation requires fixed behavior, rules are easy to maintain, and the same input should always produce the same output. Use AI when input is messy, language understanding is needed, judgment is needed, similarity/search matters, or drafting/summarizing is needed.

Best systems often combine both, example: AI reads the customer request, rules enforce the refund threshold, a human approves the exception.

>> Use AI for messy interpretation. Use rules for hard constraints.$D054c5bc1_ef47_4737_89a4_c83c8847a3a0$ where id = '054c5bc1-ef47-4737-89a4-c83c8847a3a0';

update lessons set content = $D91084936_e042_4d21_96d6_1e41c46395ef$PM ARCHITECTURE REVIEW QUESTIONS

When reviewing AI architecture, ask: what is the user workflow, and what is the AI's role? What data enters the model, and what sources does it retrieve? What tools can it call, and what actions can it take? What permissions apply? What happens if retrieval fails, a tool fails, or the model is wrong? What guardrails exist, and what requires human approval? What is logged? How is quality evaluated, and how are cost and latency monitored? How is privacy protected? How do we roll back, and what is the kill switch? Who owns the system after launch?


PM CHECKLIST FOR AI ARCHITECTURE READINESS

Before launch, check: UX is clear, user permissions are enforced, sources are approved, retrieval is tested, prompt is versioned, model is selected based on task, tools are documented, tool permissions are limited, human approval exists for risky actions, guardrails are tested, a golden dataset exists, a monitoring dashboard exists, logs are safe and useful, a rollback plan exists, a kill switch exists, cost estimate is clear, latency meets the UX requirement, privacy/security review is complete, an incident response owner is named, and success metrics are defined.

[!] These two lists are the practical distillation of this entire module, every question maps back to a layer or lesson already covered.

>> The review questions are for evaluating an architecture in progress; the readiness checklist is the final gate before launch, use the first while designing, the second right before shipping.$D91084936_e042_4d21_96d6_1e41c46395ef$ where id = '91084936-e042-4d21-96d6-1e41c46395ef';

update lessons set content = $D9637ca1b_bc8b_43b5_bd11_39b0eba7e8af$HOW TO EXPLAIN AI ARCHITECTURE TO LEADERSHIP

Simple explanation: "an AI product is not just a model. It is a system that includes user experience, prompts, model selection, retrieval, tools, permissions, guardrails, human review, logging, monitoring, and evaluation. The architecture determines whether the AI can be trusted in production."

Support example: "for the support copilot, the model is only one part. The system must retrieve approved policy, check order data through tools, draft a response, show citations, block unsupported promises, require agent approval before sending, and monitor wrong-answer rate and CSAT after launch."

Agent example: "for the refund agent, architecture risk is higher because the AI can take action. We need deterministic refund thresholds, permission-limited tools, human approval for high-value cases, audit logs, rollback, and a kill switch."


THE MEMORY SHORTCUT

AI architecture is the full system that makes AI useful, safe, and reliable.

Remember: UX, then orchestration, then prompt, then model, then retrieval, then tools, then permissions, then guardrails, then human review, then monitoring.

Use prompt-only when risk is low, the user provides all context, and the task is drafting/rewrite/brainstorming. Use RAG when AI needs trusted documents, citations matter, or knowledge changes. Use tools when AI needs live data or needs to take action. Use agents when the workflow is multi-step and tools and planning are needed. Use human-in-the-loop when risk is high or output affects users, money, access, safety, or compliance.

Watch out for treating the model as the full product, no permissions, no source governance, no tool controls, no evaluation, no logging, no rollback, no kill switch, weak monitoring, and over-automation.

[!] This module closes the entire AI/GenAI arc that began in Module 16, every capability covered since then (LLMs, prompting, RAG, agents, fine-tuning, evaluation, safety, UX, strategy) is a piece of the architecture this module just assembled into one system.

>> The most important PM question: does the architecture give the AI the right context, tools, controls, and monitoring to solve the workflow safely in production?$D9637ca1b_bc8b_43b5_bd11_39b0eba7e8af$ where id = '9637ca1b-bc8b-43b5-bd11-39b0eba7e8af';

update lessons set content = $D5c85b250_585f_4193_af1a_8a9877353d0a$WHY THIS MODULE MATTERS

A lot of people think an AI product is just "user asks question, LLM answers." That is only the demo version.

A real production AI product usually needs a user interface, prompt instructions, model selection, RAG/retrieval, embeddings, a vector database, tools and APIs, memory, permissions, guardrails, human approval, logging, monitoring, evaluation, cost controls, and a rollback plan.

**An AI product is not just a model. It is a full system around the model.**

PMs do not need to build every layer themselves, but they must understand what each layer does.


THE SIMPLEST MENTAL MODEL

Think of an AI product like a restaurant. The user sees the dining area, but behind the scenes there is a kitchen, a chef, ingredients, recipes, storage, cleanliness rules, waiters, a billing system, safety checks, a manager, and a supplier process.

Same with AI. The user may see only a chatbot or button, but behind the scenes there is a prompt, a model, data, retrieval, tools, guardrails, permissions, evaluation, monitoring, logging, and human review.

[!] AI UX is the front stage. AI architecture is the backstage system that makes it reliable.

>> This module is the backstage tour, everything the user never sees, but everything that determines whether the front stage actually works.$D5c85b250_585f_4193_af1a_8a9877353d0a$ where id = '5c85b250-585f-4193-af1a-8a9877353d0a';

update questions set choices = $D5c647aa4_681f_40c3_a005_3341a779175cQ$["An evaluation harness, a system with a golden dataset, test prompts, expected outputs, automated checks, and regression/safety tests that can be run repeatedly","Manual spot-checking is already sufficient and a repeatable harness adds no value","Evaluation should only happen once, before the very first launch, and never again afterward","Monitoring in production is a full substitute for pre-launch evaluation"]$D5c647aa4_681f_40c3_a005_3341a779175cQ$::jsonb where id = '5c647aa4-681f-40c3-a005-3341a779175c';

update questions set choices = $Dcc05956c_c5f0_420d_9a20_175ad6ca460dQ$["An output guardrail, it checks the AI response for unsupported claims and policy compliance before the message is shown to the user","An input guardrail, since the problem originated from the user's original question","An action guardrail, since no real-world action like a payment was taken yet","No guardrail is needed here, since customer-facing tone issues are not a safety concern"]$Dcc05956c_c5f0_420d_9a20_175ad6ca460dQ$::jsonb where id = 'cc05956c-c5f0-420d-9a20-175ad6ca460d';

update questions set choices = $Decd5d9a0_55e2_41e2_aa9f_b08d08f58c4bQ$["That is only the demo version, a real production AI product is a full system around the model, including UX, prompt instructions, retrieval, tools, memory, permissions, guardrails, monitoring, and a rollback plan","Nothing is missing, that description fully captures what a production AI product needs","The description is too complex and should be simplified further","Adding more layers around the model always makes the product worse"]$Decd5d9a0_55e2_41e2_aa9f_b08d08f58c4bQ$::jsonb where id = 'ecd5d9a0-55e2-41e2-aa9f-b08d08f58c4b';

update questions set choices = $D1f2bb5da_f46d_4264_a098_b4841fb3c1bbQ$["AI product architecture, a production AI system typically has around twelve layers spanning UX, application, orchestration, prompts, models, retrieval, tools, memory, permissions, guardrails, monitoring, and human workflow","This is unnecessary complexity and a single model call would be equivalent","This structure only applies to consumer chatbots, not enterprise AI products","Architecture layers are optional documentation and do not affect how the system behaves"]$D1f2bb5da_f46d_4264_a098_b4841fb3c1bbQ$::jsonb where id = '1f2bb5da-f46d-4264-a098-b4841fb3c1bb';

update questions set choices = $Dce1205f2_3187_4758_8571_042f52a98286Q$["It connects the AI to the product, handling authentication, request routing, data fetching, session management, business logic, tool execution, and error handling, so the one visible UX layer becomes trustworthy","The backend layer is unnecessary if the UX layer is well designed","Authentication and business logic belong in the model layer, not the backend","Direct frontend-to-model calls are the recommended architecture for production AI products"]$Dce1205f2_3187_4758_8571_042f52a98286Q$::jsonb where id = 'ce1205f2-3187-4758-8571-042f52a98286';

update questions set choices = $D16c2cc93_084f_42bb_9cbc_942ddab7d186Q$["The orchestration layer, it decides which model and prompt to use, whether retrieval or tools are needed, what order steps happen in, and whether human approval is required, acting as the traffic controller of the AI system","The user experience layer, since orchestration is a visual design concern","No layer is responsible, orchestration happens automatically inside any LLM","The model layer, since orchestration is a property of the model itself"]$D16c2cc93_084f_42bb_9cbc_942ddab7d186Q$::jsonb where id = '16c2cc93-084f-42bb-9cbc-942ddab7d186';

update questions set choices = $Dd7f4dd9b_7aaa_4ba1_bf02_c302b885ffdeQ$["Prompts translate policy into model behavior, but important rules should also be enforced in code, permissions, and guardrails, not left to the prompt alone","Prompt instructions are always sufficient on their own for enforcing any product policy, however high-risk","The prompt layer should be removed entirely and replaced only with code-level rules","High-risk rules are best left unenforced since users can be trusted to interpret model output correctly"]$Dd7f4dd9b_7aaa_4ba1_bf02_c302b885ffdeQ$::jsonb where id = 'd7f4dd9b-7aaa-4ba1-bf02-c302b885ffde';

update questions set choices = $Db2570695_a94c_4fca_b23c_e21982db0d12Q$["This is a mistake, different tasks need different models, so semantic search should use an embedding model, image understanding a vision model, and churn prediction a traditional ML model, not one model for everything","Using one model for every task type is the recommended best practice for simplicity","A model gateway is unnecessary once a team commits to a single model for everything","Model routing only matters for cost, not for matching task type to model type"]$Db2570695_a94c_4fca_b23c_e21982db0d12Q$::jsonb where id = 'b2570695-a94c-4fca-b23c-e21982db0d12';

update questions set choices = $D57e34a0f_aef1_4069_b00b_8d5506804715Q$["The RAG/retrieval layer, it retrieves grounding data such as approved policy documents and passes it to the model so responses are generated based on trusted content, with source citation","The memory/state layer, since retrieval is a form of long-term memory","The tool/API layer, since retrieving documents counts as calling an external API","No specific layer is needed, the base model already knows all company-specific policies"]$D57e34a0f_aef1_4069_b00b_8d5506804715Q$::jsonb where id = '57e34a0f-aef1-4069-b00b-8d5506804715';

update questions set choices = $D8ee7f5f4_3c98_4991_98c8_9d637fd21a6bQ$["Tools, the tool/API layer lets AI interact with real systems such as order databases, calendars, CRMs, and ticketing systems, turning AI from a talker into a worker","Nothing extra is needed, since any RAG-enabled system can already take real-world actions","A larger language model, since bigger models can inherently query live databases without tools","The memory/state layer, since remembering past orders is equivalent to looking one up live"]$D8ee7f5f4_3c98_4991_98c8_9d637fd21a6bQ$::jsonb where id = '8ee7f5f4-3c98-4991-98c8-9d637fd21a6b';

update questions set choices = $D850dc0d1_9745_48ad_82fb_c5fbc4afbc6fQ$["This is risky, agent permissions should be narrower than human admin permissions, and higher-risk write tools like issuing refunds should require approval below a threshold rather than unlimited access","This is ideal, since AI agents should always match the permission level of the most senior human admin","Read tools and write tools carry identical risk levels, so no distinction in permissions is needed","Tool permissions are handled automatically by the model and do not need explicit design"]$D850dc0d1_9745_48ad_82fb_c5fbc4afbc6fQ$::jsonb where id = '850dc0d1-9745-48ad-82fb-c5fbc4afbc6f';

update questions set choices = $Dfc717df1_c26b_4617_bac4_aebd10107941Q$["Memory/state, without tracking workflow state (like which step has been completed), the system cannot avoid duplicate tool calls, duplicate refunds, or lost workflow progress","A stronger model, since state tracking is purely a function of model quality rather than a distinct architecture layer","Nothing is missing, repeating tool calls is expected and harmless behavior for any agent","A better prompt, since state should always be fully re-derived from the prompt on every step"]$Dfc717df1_c26b_4617_bac4_aebd10107941Q$::jsonb where id = 'fc717df1-c26b-4617-bac4-aebd10107941';

update questions set choices = $Df776cc52_5242_45db_9cf6_c5db924af096Q$["What is stored and why, how long it is stored, whether the user can edit or delete it, whether it includes sensitive data, who can access it, and whether it is used for training or requires consent","None, memory features can be added freely without any privacy or retention considerations","Only whether the memory feature will increase user engagement metrics","Only whether the underlying model architecture technically supports a longer context window"]$Df776cc52_5242_45db_9cf6_c5db924af096Q$::jsonb where id = 'f776cc52-5242-45db-9cf6-c5db924af096';

update questions set choices = $Dae766126_955c_49e5_94ac_519448d69fe6Q$["Retrieval was not permission-aware, sources should be filtered by what the requesting user can access before they ever enter the prompt, not filtered only after generation","Nothing went wrong, since filtering restricted content after the model generates its response is equally safe","This is expected behavior, since RAG systems should retrieve from all available documents regardless of audience","The output guardrail layer should have caught this instead, since permission checks belong only at output time"]$Dae766126_955c_49e5_94ac_519448d69fe6Q$::jsonb where id = 'ae766126-955c-49e5-94ac-519448d69fe6';

update questions set choices = $D28461673_13f6_4315_b505_028690723c82Q$["Monitoring/observability, ongoing tracking of latency, cost, error rate, retrieval quality, tool failures, user feedback, and drift to confirm the system is still working after launch","Nothing further is needed, since a passing evaluation before launch guarantees performance indefinitely","A completely new model, since monitoring is not actually necessary for production AI systems","Only user complaints, since formal monitoring dashboards are not useful signals"]$D28461673_13f6_4315_b505_028690723c82Q$::jsonb where id = '28461673-13f6-4315-b505-028690723c82';

update questions set choices = $D837dc644_e728_491b_a1da_1eae78f3d6eeQ$["Pattern 1, Prompt-Only AI, the flow is simply user input, then prompt, then model, then output, which is appropriate because the user provides all needed context and risk is low","Pattern 2, RAG AI, because any text rewriting task requires retrieval from a document store","Pattern 4, Agentic AI, because rewriting a message requires multi-step planning and tool use","Pattern 9, Multi-Agent AI, because professional tone requires multiple specialized agents"]$D837dc644_e728_491b_a1da_1eae78f3d6eeQ$::jsonb where id = '837dc644-e728-491b-a1da-1eae78f3d6ee';

update questions set choices = $D5d94b56d_6c18_4601_93ec_48bbaa1726fdQ$["Pattern 3, Tool-Using AI, flow is orchestrator, then tool call, then tool result, then model; the key weakness is tool failure risk, permission complexity, and the need for logs and approvals","Pattern 1, Prompt-Only AI, which requires no special handling for live data or actions","Pattern 6, Batch AI, since any tool call should always run on a nightly schedule instead of live","Pattern 8, Edge/On-Device AI, since tool calls are always best run locally on the user's device"]$D5d94b56d_6c18_4601_93ec_48bbaa1726fdQ$::jsonb where id = '5d94b56d-6c18-4601-93ec-48bbaa1726fd';

update questions set choices = $D9fbbc71e_9472_440e_9f72_d2d656f1b69eQ$["Pattern 5, Human-in-the-Loop AI, use it when mistakes are costly but AI can still save preparation time, such as finance workflows and high-value refunds","Pattern 6, Batch AI, since human review always implies the workflow must run on a nightly schedule","Pattern 7, Real-Time AI, since human approval is a form of low-latency response","Pattern 9, Multi-Agent AI, since any human reviewer is functionally equivalent to an additional AI agent"]$D9fbbc71e_9472_440e_9f72_d2d656f1b69eQ$::jsonb where id = '9fbbc71e-9472-440e-9f72-d2d656f1b69e';

update questions set choices = $Dbf1b8eb9_eb55_490b_a856_fecc45d14014Q$["Pattern 8, Edge/On-Device AI, it trades some model power for privacy, speed, and local control, useful when data should stay local or the internet may be unavailable","Pattern 7, Real-Time AI, which requires a constant cloud connection and cannot run offline","Pattern 2, RAG AI, since on-device processing always requires a vector database in the cloud","Pattern 4, Agentic AI, since on-device models are inherently more autonomous than cloud models"]$Dbf1b8eb9_eb55_490b_a856_fecc45d14014Q$::jsonb where id = 'bf1b8eb9-eb55-490b-a856-fecc45d14014';

update questions set choices = $D037d0d8e_0d0f_46fb_8a75_6acbe413a50bQ$["Documents must be ingested, text extracted and chunked, embeddings created, and results stored in the vector database with metadata like owner, version, and permissions, all before any question is asked","Nothing needs to happen beforehand, since the model can search raw unprocessed documents live for every query","Employees must manually tag every document with the exact question it answers before ingestion","Only permission metadata matters; chunking and embeddings are optional steps that can be skipped"]$D037d0d8e_0d0f_46fb_8a75_6acbe413a50bQ$::jsonb where id = '037d0d8e-0d0f-46fb-8a75-6acbe413a50b';

update questions set choices = $Ddeb0b7b7_1895_44af_a30d_462bcf4e7d27Q$["For action agents, deterministic rules and approvals matter as much as the model, use rules for hard constraints like eligibility thresholds and AI for messier tasks like drafting messages","Deterministic rules are unnecessary once an LLM is involved, since the model can handle eligibility logic directly","The model should decide eligibility while deterministic rules should draft the customer message","Using both deterministic rules and an LLM in the same workflow is redundant and should be simplified"]$Ddeb0b7b7_1895_44af_a30d_462bcf4e7d27Q$::jsonb where id = 'deb0b7b7-1895-44af-a30d-462bcf4e7d27';

update questions set choices = $D6d490d31_0f0b_4c10_8b24_46a4a368cd07Q$["What data flows through the system, what user input enters the model, what documents are retrieved, what customer data is included, what gets logged, and what gets sent to external vendors","Only how large the underlying model is, since bigger models are inherently riskier regardless of data flow","Only how fast the AI responds, since latency and privacy risk are the same concern","Data flow does not matter once guardrails are in place, since guardrails eliminate all privacy risk"]$D6d490d31_0f0b_4c10_8b24_46a4a368cd07Q$::jsonb where id = '6d490d31-0f0b-4c10-8b24-46a4a368cd07';

update questions set choices = $D85c1015f_2a28_4dee_8afe_486ecb5f6abeQ$["AI cost includes far more than token usage, embeddings, vector database, tool/API calls, infrastructure, human review, evaluation, monitoring, and logging all contribute, so cost should be measured per successful task, not just per model call","Token usage is the only cost that matters and everything else is negligible by comparison","Cost measurement is not a PM concern and should be left entirely to finance","Human review costs should never be included in AI cost calculations since they are a fixed cost"]$D85c1015f_2a28_4dee_8afe_486ecb5f6abeQ$::jsonb where id = '85c1015f-2a28-4dee-8afe-486ecb5f6abe';

update questions set choices = $Df3ba2111_5e7a_43d8_96be_2c491925a7efQ$["A fallback design, such as telling the user the order system is unavailable and offering manual entry or escalation to human review, so the workflow keeps moving safely","Nothing; silent failure is the expected and acceptable behavior when a tool becomes unavailable","The system should have simply retried the same failing tool call indefinitely until it succeeded","Fallback behavior is only relevant for model failures, not for tool or API failures"]$Df3ba2111_5e7a_43d8_96be_2c491925a7efQ$::jsonb where id = 'f3ba2111-5e7a-43d8-96be-2c491925a7ef';

update questions set choices = $Db0962d09_5d28_4b57_85ba_65891eb8a6daQ$["Logging architecture and versioning, logs should capture prompt version, model version, retrieved sources, tool calls, and guardrail decisions, and every part of the system should be versioned so changes can be traced","Nothing was missing; without versioning, AI behavior changes are simply unexplainable by design","Only the final output needs to be logged; intermediate steps like retrieval and tool calls are not useful","Versioning only applies to the model itself, not to prompts, RAG indexes, or guardrails"]$Db0962d09_5d28_4b57_85ba_65891eb8a6daQ$::jsonb where id = 'b0962d09-5d28-4b57-85ba-65891eb8a6da';

update questions set choices = $D9785a4c0_faed_401f_97fe_2ef3715d7c1bQ$["Shadow mode, the AI runs without affecting users, letting the team learn from comparing recommendations to human decisions before giving the AI real power","Canary rollout, which instead releases the new capability to a small percentage of live users immediately","A kill switch, which is used to turn off a feature rather than to safely observe it before launch","Human-in-the-loop review, which requires the AI to already be taking live actions with human approval"]$D9785a4c0_faed_401f_97fe_2ef3715d7c1bQ$::jsonb where id = '9785a4c0-faed-401f-97fe-2ef3715d7c1b';

update questions set choices = $D10c1d5c4_abc5_4966_aab5_a8cf603da842Q$["A kill switch, the ability to disable the risky capability, such as switching to draft-only mode, disabling a tool, rolling back the model, or routing all cases to human review","Nothing is needed immediately; the team should wait for the next scheduled deployment to fix the issue","A completely new model trained from scratch, since kill switches are not a real architecture pattern","An increase in the model's permissions so it can fix its own mistakes autonomously"]$D10c1d5c4_abc5_4966_aab5_a8cf603da842Q$::jsonb where id = '10c1d5c4-abc5-4966-aab5-a8cf603da842';

update questions set choices = $D0302cafa_acaf_4f61_8360_76df658c1faaQ$["Whether the team needs speed, control, privacy, cost efficiency, or customization most, cloud models are faster to start but create vendor dependency, while self-hosted models offer more control but require more infrastructure and ML expertise","Self-hosted models should always be chosen because they are cheaper in every scenario regardless of scale","Cloud/API models should always be chosen because self-hosted models are never viable for production","This decision has no meaningful tradeoffs and either option is functionally identical"]$D0302cafa_acaf_4f61_8360_76df658c1faaQ$::jsonb where id = '0302cafa-acaf-4f61-8360-76df658c1faa';

update questions set choices = $D8022a62d_f747_401e_bdc8_bfd4b573eb10Q$["Workflow AI is usually easier to make valuable than a generic assistant, since it has a clear user, input, output, and metric, and embedded AI is often better than chat because it offers better context and easier measurement","Generic chat assistants are always superior to embedded, workflow-specific AI features","There is no meaningful difference between a generic assistant and workflow-specific AI in terms of measurability","Embedding AI into an existing workflow always increases user effort compared to a standalone chat tool"]$D8022a62d_f747_401e_bdc8_bfd4b573eb10Q$::jsonb where id = '8022a62d-f747-401e-bdc8-bfd4b573eb10';

update questions set choices = $D3372e1d8_fd94_42d8_b768_7d6ff71fc423Q$["Architecture risk is higher when AI can take real action, the refund agent needs deterministic thresholds, permission-limited tools, human approval for high-value cases, audit logs, rollback, and a kill switch, unlike a read-only knowledge assistant","There is no meaningful architecture difference between an agent that takes actions and an assistant that only answers questions","The refund agent needs a bigger model, and model size alone accounts for all the additional risk","Knowledge assistants require more architecture than action-taking agents since they handle more documents"]$D3372e1d8_fd94_42d8_b768_7d6ff71fc423Q$::jsonb where id = '3372e1d8-fd94-42d8-b768-7d6ff71fc423';
