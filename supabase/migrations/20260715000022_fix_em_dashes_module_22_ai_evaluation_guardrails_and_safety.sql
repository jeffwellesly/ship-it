-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 22: AI Evaluation, Guardrails, and Safety
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update modules set description = $M$Proving an AI system is useful, safe, measurable, and controlled enough for the real workflow it will enter, golden datasets, guardrail layers, red teaming, incident response, and launch readiness.$M$ where id = 'eaca4b28-3796-4cd1-97eb-b8d3f550833f';

update lessons set content = $Db31bf4ec_e04b_4ca9_aa1a_4b9504502ee0$Agents are harder to evaluate because they act.

Evaluate goal understanding (did the agent understand the task?), planning (did it choose sensible steps?), tool selection (did it choose the right tools?), tool order (did it use tools in the right sequence?), tool interpretation (did it understand tool results correctly?), action safety (did it avoid risky or forbidden actions?), escalation (did it stop and escalate when needed?), task completion (did it complete the workflow?), and auditability (can we reconstruct what happened?).

[!] Agent eval = answer quality + tool quality + action safety + workflow success, four layers, any one of which can fail independently of the others.

>> An agent can plan perfectly, select the right tools, and still fail on action safety, evaluating only the final output would miss that entirely.$Db31bf4ec_e04b_4ca9_aa1a_4b9504502ee0$ where id = 'b31bf4ec-e04b-4ca9-aa1a-4b9504502ee0';

update lessons set content = $D0146b174_c3da_4a56_ae96_cef01eb752f8$Depending on use case, use different metric sets.

For support AI: factual accuracy, policy compliance, agent acceptance rate, wrong-answer rate, resolution time, CSAT, escalation correctness.

For AI search/RAG: Recall@K, citation correctness, answer helpfulness, search success, source click-through, time to answer.

For an AI writing assistant: draft acceptance, edit distance, user satisfaction, time saved, reuse rate.

For AI extraction: field-level accuracy, missing-field rate, false extraction rate, format validity, human correction rate.

For an AI agent: task completion rate, wrong-action rate, human override rate, tool failure rate, unsafe action rate, cost per completed task.

[!] Notice how none of these five metric sets are identical, the right metrics come from the specific task, not from a generic "AI quality" template.

>> This lesson is a reference table more than a concept, bookmark it mentally for whenever a new AI feature needs its metrics defined.$D0146b174_c3da_4a56_ae96_cef01eb752f8$ where id = '0146b174-c3da-4a56-ae96-cef01eb752f8';

update lessons set content = $D8ca3f308_58f5_4a1e_a53d_3215c0318d61$OFFLINE EVALUATION

Testing before launch. Examples: golden dataset, human review, automated test cases, red-team prompts, regression tests, source-grounding checks.

Offline evaluation answers: "is this AI good enough to test with users?"


ONLINE EVALUATION

Testing after launch with real usage. Examples: user feedback, task completion, CSAT, deflection rate, agent acceptance, error reports, escalations, cost per task, safety incidents.

Online evaluation answers: "is this AI improving the real product?"

[!] Offline eval proves readiness. Online eval proves value. Skipping either one leaves a real gap, a model can pass every offline test and still fail to move the business metric, or ship without offline testing and cause an incident before anyone notices.

>> Offline and online evaluation are sequential, not interchangeable, one earns the right to launch, the other earns the right to stay launched.$D8ca3f308_58f5_4a1e_a53d_3215c0318d61$ where id = '8ca3f308-58f5-4a1e-a53d-3215c0318d61';

update lessons set content = $D6128eff8_e48d_49f6_a0c4_61221ce712fb$WHY THIS MODULE MATTERS

AI products can look amazing in demos and still fail in production. A demo may show good writing, good summaries, good answers, smooth conversation, and impressive automation. But production asks harder questions: is the answer correct? Is it grounded in the right source? Is it safe? Is it consistent? Does it protect private data? Does it work on edge cases? Does it refuse when it should? Does it escalate risky cases? Does it improve the business metric? Can we monitor it after launch?

**AI evaluation checks whether the AI is actually good enough to trust in a real product.**


THE SIMPLEST MENTAL MODEL

Think of AI like a new employee. You would not say "they gave one good answer, so let them handle all customers." You would test them: can they handle common cases? Can they handle angry customers? Can they follow policy? Can they say "I don't know"? Can they avoid making promises? Can they escalate risky issues? Can they protect confidential information? Can they work consistently every day?

AI needs the same discipline. A good AI product is not judged by one impressive response, it is judged by repeated performance across many real and risky cases.

>> The gap between "impressive demo" and "trustworthy product" is exactly what this module is about closing.$D6128eff8_e48d_49f6_a0c4_61221ce712fb$ where id = '6128eff8-e48d-49f6-a0c4-61221ce712fb';

update lessons set content = $Dfba155f5_11e5_4c52_97fa_bd7e631424a8$WHAT IS AI EVALUATION?

AI evaluation means testing an AI system to measure whether it performs correctly, safely, and usefully. OpenAI describes evals as structured tests for measuring model performance and reliability, especially because AI systems can be variable or nondeterministic.

AI evaluation can test accuracy, factuality, helpfulness, safety, relevance, grounding, citation quality, format compliance, tool-use correctness, refusal behavior, privacy protection, bias/fairness, latency, cost, and business impact.

**Evaluation is how we replace "this feels good" with measurable quality.**


WHY AI EVALUATION IS HARDER THAN CLASSIC ML EVALUATION

Classic ML often has clear labels, actual churn is yes or no, prediction is yes or no, so evaluation is straightforward.

But AI/LLM output is often open-ended. "Summarize this customer call" may have many acceptable summaries. One answer may be mostly correct, slightly incomplete, good tone, missing one important action item, too long, or lacking a source citation. So AI evaluation must check multiple dimensions at once.

[!] Classic ML evaluation asks: was the prediction correct? AI evaluation asks: was the output correct, useful, safe, grounded, and appropriate?

>> Multiple dimensions, not one score, that single shift is why AI evaluation needs more structure than a simple accuracy number.$Dfba155f5_11e5_4c52_97fa_bd7e631424a8$ where id = 'fba155f5-11e5-4c52-97fa-bd7e631424a8';

update lessons set content = $Dc294d60c_9f76_45e7_bc83_95663b712f6c$AI evaluation should happen at three levels.

Level 1, output quality: is the answer good? Examples: correct, helpful, complete, clear, follows format.

Level 2, system behavior: did the AI system behave correctly? Examples: retrieved the right source, used the right tool, refused an unsafe request, escalated a risky case, protected private data.

Level 3, product impact: did the AI improve the real workflow? Examples: saved time, reduced cost, improved CSAT, increased task completion, reduced errors, improved retention.

[!] Answer quality is not enough. System behavior and product impact also matter, a fluent, correct-sounding answer that retrieved the wrong source, or that never actually moves the business metric, still represents a failure worth catching.

>> These three levels map directly onto the earlier modules in this course: output quality is the LLM/prompting layer, system behavior is the RAG/agent layer, and product impact is the metrics layer.$Dc294d60c_9f76_45e7_bc83_95663b712f6c$ where id = 'c294d60c-9f76-45e7-bc83-95663b712f6c';

update lessons set content = $Db97b013a_065d_45b3_a7c1_4bf3e1b71b3c$GOLDEN DATASET

A golden dataset is a trusted test set. It contains real or realistic examples with known expected outputs.

For a support AI, a golden dataset may include the customer question, correct answer, correct policy source, correct escalation decision, risk level, approved tone, and expected structured fields.

For a RAG system, it may include the user question, correct source document, correct source section, expected answer, expected citation, no-answer cases, and permission-sensitive cases.

**A golden dataset is your AI quality exam.** Without one, teams often rely on vibes. Bad: "this answer looks good." Better: "on our 500-case golden dataset, factual accuracy improved from 82% to 91%, with no increase in unsafe answers."


WHAT SHOULD GO INTO A GOLDEN DATASET?

A good golden dataset should include common cases (the normal requests users ask every day), hard cases (where the AI is likely to fail), edge cases (unusual but important scenarios), no-answer cases (where the source does not contain the answer), conflicting-source cases (when two documents disagree), outdated-source traps (where old documents say something different from current ones), permission-sensitive cases (questions that should not retrieve restricted content), safety cases (legal, medical, financial, harmful, or sensitive topics), and prompt injection cases (inputs that try to override system rules).

[!] PM question: "Does our test set include the cases that could hurt users or the business?"

>> A golden dataset stuffed only with easy, common cases will pass every test and still fail in production, the hard and adversarial cases are the ones actually worth testing for.$Db97b013a_065d_45b3_a7c1_4bf3e1b71b3c$ where id = 'b97b013a-065d-45b3-a7c1-4bf3e1b71b3c';

update lessons set content = $D9aaf374e_a4d2_4582_96a9_e1a5b5913423$HUMAN EVALUATION

Human evaluation means people review AI outputs using a clear rubric. Humans can judge whether an answer is factually correct, complete, helpful, grounded in the source, has appropriate tone, followed policy, should have escalated, or carries any safety risk.

Human evaluation is especially important for open-ended outputs, summaries, support replies, legal summaries, medical explanations, product recommendations, AI-generated reports, and agent decisions.

**Humans judge quality where simple labels are not enough.**


HUMAN EVALUATION RUBRIC

A rubric defines how reviewers score AI output, for example, scoring 1 to 5 on factuality (incorrect/unsupported at 1, fully correct and source-supported at 5), completeness, relevance, clarity, tone, safety, and format compliance.

Bad evaluation: "looks good." Good evaluation: "factuality 4/5, completeness 3/5, tone 5/5, missing source citation for refund timeline."

[!] PM question: "Are reviewers using the same quality standard?"

>> A rubric turns "I liked it" into a number that can be compared across reviewers, across time, and across model versions.$D9aaf374e_a4d2_4582_96a9_e1a5b5913423$ where id = '9aaf374e-a4d2-4582-96a9-e1a5b5913423';

update lessons set content = $D78a47d77_f799_41a2_9ec0_3f190e38a465$INTER-RATER AGREEMENT

If two human reviewers judge the same AI output, do they agree? If reviewers disagree a lot, the rubric may be unclear. Example: reviewer A says the answer is correct, reviewer B says it is unsafe, that disagreement means the team needs clearer guidelines.

**If humans cannot evaluate consistently, the AI cannot be improved consistently.**

Improve by writing better guidelines, adding examples, training reviewers, clarifying labels, creating escalation rules, and reviewing disagreement cases.


AUTOMATED EVALUATION

Automated evaluation uses software or another model to check AI outputs. Useful checks: is JSON valid? Are required fields present? Is the answer under the word limit? Does it include citations? Does the citation source exist? Does the output contain restricted content? Did it refuse an unsafe request? Did it choose an allowed category? Did it call the required tool? Did it avoid forbidden tools?

[!] Automated evals help scale quality checks. Human evals help judge deeper quality, neither replaces the other.

>> Inter-rater agreement is how you know whether your human evaluation process is trustworthy in the first place; automated evaluation is how you scale checks once it is.$D78a47d77_f799_41a2_9ec0_3f190e38a465$ where id = '78a47d77-f799-41a2-9ec0-3f190e38a465';

update lessons set content = $D52088bc6_b6a4_434c_b87a_8ff67a94e587$LLM-AS-JUDGE

LLM-as-judge means using another AI model to evaluate AI output. A judge model might check: is the answer grounded? Does it match the source? Did the assistant follow instructions? Is the output safe? Is the response complete?

This can be useful, but be careful. Risks: the judge model can be wrong, it may prefer fluent answers, it may miss subtle errors, it may be biased, and it may not match human judgment.

[!] Use LLM-as-judge as a helper, not the only authority for high-risk evaluation.


REGRESSION TESTING

Regression testing checks whether a new AI version breaks something that used to work. This matters because small changes can affect behavior, a new prompt, a new model, new RAG chunking, new retrieval settings, a new tool, a new fine-tuned model, a new guardrail, or a new workflow.

Regression tests should check common cases, edge cases, safety cases, refusal behavior, source-grounding, tool-use, format compliance, and latency/cost.

PM question: **"What got worse after this change?"**

>> LLM-as-judge can help regression testing scale, but for the highest-risk changes, human review still needs the final word.$D52088bc6_b6a4_434c_b87a_8ff67a94e587$ where id = '52088bc6-b6a4-434c-b87a-8ff67a94e587';

update lessons set content = $D72869aff_b07e_47ad_8143_ce5f1d549332$For LLM products, evaluate these dimensions: factuality (is the answer true?), groundedness (is it supported by the provided source?), relevance (does it answer the user's actual question?), completeness (does it include all important information?), conciseness (is it not unnecessarily long?), instruction following (did it follow the prompt and product rules?), format compliance (did it return the required structure?), safety (does it avoid harmful or disallowed content?), privacy (does it avoid revealing sensitive data?), tone (is it appropriate for the user and brand?), and usefulness (does it help the user complete the task?).

[!] Do not use one generic "quality score" without understanding what quality actually means for this specific task, a single number hides which of these eleven dimensions is actually failing.

>> This eleven-dimension list is the general-purpose checklist; the next two lessons specialize it for RAG products and agents specifically.$D72869aff_b07e_47ad_8143_ce5f1d549332$ where id = '72869aff-b07e-47ad-8143-ce5f1d549332';

update lessons set content = $Dbe45f00f_d782_4789_927c_01808570c8f9$HALLUCINATION

Hallucination means the AI produces information that sounds correct but is wrong or unsupported, inventing a company policy, making up a citation, giving wrong product details, inventing legal rules, summarizing text that was not present, creating fake analytics numbers, or claiming an action was completed when it was not.

**Hallucination is dangerous because the answer can sound confident.**


HALLUCINATION EVALUATION

To evaluate hallucination, test whether the answer includes unsupported claims, whether it cites real sources, whether citations support the claims, whether it says "not enough information" when needed, whether it avoids inventing numbers or policies, and whether it distinguishes facts from assumptions.

Good test cases: questions with no answer in the source, questions with a partial answer, questions with conflicting sources, questions requiring live data, and questions outside product scope.

[!] PM question: "When the AI does not know, does it admit that or does it guess?"

>> Hallucination evaluation is really "no-answer behavior" evaluation in disguise, the test cases that expose hallucination are the same ones that expose weak refusal.$Dbe45f00f_d782_4789_927c_01808570c8f9$ where id = 'be45f00f-d782-4789-927c-01808570c8f9';

update lessons set content = $D5cdf85aa_3062_4639_9327_1dae8492d78e$GROUNDEDNESS

Groundedness means the AI answer is supported by trusted source material.

Example: source says "refunds are allowed within 30 days for damaged items." Grounded answer: "damaged items can be refunded within 30 days." Ungrounded answer: "damaged items can be refunded within 60 days."

Groundedness is critical for support, legal, healthcare, finance, HR, product documentation, internal knowledge, and compliance.

**Grounded AI answers from evidence. Ungrounded AI guesses.**


CITATION CORRECTNESS

Citation correctness means the cited source actually supports the claim.

Bad: answer says "refunds are allowed after 45 days," citation points to a page that only says "refunds are reviewed case by case." Good: answer says "the provided policy does not confirm refunds after 45 days," citation points to the exact policy section.

[!] PM question: "Are citations real evidence or just decoration?"

>> Groundedness asks whether the answer as a whole is supported. Citation correctness asks whether the specific pointer to that support is actually accurate, a subtle but important difference when auditing a failure.$D5cdf85aa_3062_4639_9327_1dae8492d78e$ where id = '5cdf85aa-3062-4639-9327-1dae8492d78e';

update lessons set content = $D0c81725a_047a_4afa_b063_a7bac801a982$REFUSAL ACCURACY

Refusal accuracy means the AI refuses when it should and answers when it should.

Under-refusal: the AI answers unsafe or unsupported questions, example, gives legal advice without an approved source. Over-refusal: the AI refuses safe, normal questions, example, refuses to summarize a harmless document.

**A safe AI should not be reckless, but it should also not be useless.**


GUARDRAILS

Guardrails are controls that help keep AI behavior safe, reliable, and within product rules. Guardrails can happen before the model, during model reasoning or tool use, after model output, at the workflow or action layer, and during monitoring.

Google's Responsible Generative AI Toolkit provides guidance and tools for designing, building, and evaluating AI models responsibly, while Microsoft's responsible AI materials emphasize fairness, reliability and safety, privacy and security, inclusiveness, transparency, and accountability.

[!] Guardrails are seatbelts, brakes, and traffic rules for AI systems, no single one is sufficient alone.

>> Refusal accuracy is what you're measuring. Guardrails are the mechanisms that actually produce good refusal accuracy (and everything else safe) in practice, the next several lessons cover each layer of guardrail in turn.$D0c81725a_047a_4afa_b063_a7bac801a982$ where id = '0c81725a-047a-4afa-b063-a7bac801a982';

update lessons set content = $Dd371b0d3_7cbe_4a88_9a5f_cb28a6cce812$PROMPT GUARDRAILS

Prompt guardrails are instructions that shape model behavior, use only provided sources, do not invent facts, ask clarifying questions when needed, escalate legal threats, do not promise refunds, return valid JSON only, keep tone professional, refuse unsafe requests.

Prompt guardrails help, but they are not enough alone.

**Important rules should not live only in prompts.**


OUTPUT GUARDRAILS

Output guardrails check the model's response before showing it or taking action. Examples: check for unsafe content, check for private data leakage, check citation presence, check JSON validity, check policy violations, check unsupported claims, check tone, check length, check banned phrases, and check hallucination risk.

Example: if AI drafts "we guarantee a refund," the output guardrail can block it if the policy source does not support that claim.

[!] Output guardrails catch mistakes before users see them, the last checkpoint before the model's words actually reach someone.

>> Prompt guardrails are instructions the model might follow. Output guardrails are code that checks whether it actually did, the second is what makes the first enforceable.$Dd371b0d3_7cbe_4a88_9a5f_cb28a6cce812$ where id = 'd371b0d3-7cbe-4a88-9a5f-cb28a6cce812';

update lessons set content = $Db7f2bd0c_bafd_4030_99c0_3c41ff5db08f$SAFETY FILTERS

Safety filters detect or block unsafe content. They may check for hate or harassment, violence, self-harm, sexual content, illegal activity, private data, malware or cyber abuse, dangerous instructions, and policy-violating content.

Google's AI safety page describes safeguards such as safety classifiers used to filter model inputs and outputs to protect users from undesirable outcomes.

PM question: **"Which content categories must be filtered for this product?"**


RISK-BASED CONTROLS

Not every AI use case needs the same guardrails.

Low-risk example: AI suggests blog title ideas, controls: light safety check, user editing. Medium-risk example: AI drafts support replies, controls: RAG, citations, human approval, policy checks. High-risk example: AI changes account status or approves refunds, controls: tool restrictions, approval gates, audit logs, rollback, monitoring, legal/compliance review.

NIST's AI Risk Management Framework is intended to help organizations manage AI risks and incorporate trustworthiness considerations into AI systems.

[!] Match guardrails to risk. Do not overbuild for low-risk tasks or underbuild for high-risk tasks.

>> Safety filters are one specific type of guardrail (content-based). Risk-based controls is the broader principle for deciding how much of every guardrail layer a given use case actually needs.$Db7f2bd0c_bafd_4030_99c0_3c41ff5db08f$ where id = 'b7f2bd0c-bafd-4030-99c0-3c41ff5db08f';

update lessons set content = $D134d0d7f_2114_4a3b_a4fa_22229504472f$Common AI risks include: factual risk (AI gives wrong information), safety risk (AI provides harmful advice or unsafe output), privacy risk (AI reveals sensitive information), security risk (AI is manipulated or misuses tools), bias/fairness risk (AI performs worse for certain groups), legal/compliance risk (AI violates rules or gives unsupported advice), brand risk (AI responds in a way that damages trust), operational risk (AI breaks workflows or overloads teams), financial risk (AI causes wrong refunds, payments, or decisions), and user trust risk (users over-rely on wrong AI output).

PM question: **"What type of risk is most important for this AI use case?"**

[!] Different AI products carry very different risk profiles, a blog-title generator and a refund-processing agent share almost none of these top risks in common.

>> Naming which risk category matters most for a given feature is what determines which guardrails from the last several lessons actually need to be built first.$D134d0d7f_2114_4a3b_a4fa_22229504472f$ where id = '134d0d7f-2114-4a3b-a4fa-22229504472f';

update lessons set content = $Db627f85e_d0a1_4bb1_b71b_8466e729654d$PERMISSION EVALUATION

Permission evaluation checks whether the AI respects access control.

Example: user A has access to Document 1 but not Document 2, the AI should retrieve and answer only from Document 1.

Tests: a user without permission asks a restricted question, a user with partial access asks a broad question, a customer asks an internal-only policy question, an employee asks about another team's confidential data, the AI tries to summarize a restricted source.

PM question: **"Does the AI follow the same permission rules as the original system?"**


BIAS AND FAIRNESS EVALUATION

Bias evaluation checks whether AI quality or outcomes differ unfairly across groups or contexts. Microsoft's responsible AI principles include fairness, reliability and safety, privacy and security, inclusiveness, transparency, and accountability.

Test performance by language, region, accent, device type, customer segment, user type, content type, and demographic group where appropriate and legally allowed.

Examples: support AI works better in English than other languages, speech AI performs worse for some accents, hiring AI favors certain resume styles, credit AI treats groups differently, image AI fails under different lighting or skin tones.

[!] PM question: "Who gets worse outcomes if this AI is wrong?"

>> Permission evaluation checks whether access rules are respected. Bias and fairness evaluation checks whether quality itself is equally good for everyone who does have access.$Db627f85e_d0a1_4bb1_b71b_8466e729654d$ where id = 'b627f85e-d0a1-4bb1-b71b-8466e729654d';

update lessons set content = $D81e0324f_cd27_4d1a_90a9_ff7c8fb6b092$SAFETY BY USER SEGMENT

Different users may need different safety handling. A new user needs simpler explanations. An enterprise admin may have more permissions. A minor or vulnerable user needs stronger safety controls. An angry customer needs escalation sensitivity. A high-value transaction user needs stronger approval. An internal employee may access internal data, but still needs role-based permissions.

**Safety is not only about content. It is also about user context.**


TOOL-USE SAFETY EVALUATION

For agents, test whether the AI called the right tool, called tools in the right order, avoided forbidden tools, asked approval before action, handled tool errors, avoided duplicate actions, used live data instead of guessing, logged actions, and stopped when tool output was unclear.

Example failure: AI issues a refund before checking policy. That is not only an answer issue, it is a workflow safety failure.

[!] For agents, wrong tool use can be more dangerous than wrong text.

>> Segment-based safety adapts the rules to who is asking. Tool-use safety adapts the rules to what the AI can actually do about it, both are context the content itself does not reveal.$D81e0324f_cd27_4d1a_90a9_ff7c8fb6b092$ where id = '81e0324f-cd27-4d1a-90a9-ff7c8fb6b092';

update lessons set content = $D62ede85d_631b_43e7_b976_3b92d4e94b09$CONFIDENCE

Confidence can be useful, but be careful, AI confidence is not always reliable. Instead of only showing a confidence score, consider source quality, retrieval relevance, missing information, agreement across sources, historical accuracy, human review requirement, and risk level.

Example: "confidence: medium, because the policy confirms the return window but does not mention this product category."

**Confidence should be based on evidence, not just model vibes.**


CALIBRATION

Calibration means the system's confidence matches reality. Example: among answers marked 90% confident, about 90% should actually be correct. If confidence is poorly calibrated, users may over-trust bad answers.

PM question: **"When the AI says confidence is high, is it actually usually right?"**

Calibration is especially important when AI output triggers automation, humans rely heavily on AI, risk varies by confidence level, or low-confidence outputs are escalated.

[!] An uncalibrated confidence score is worse than no confidence score, it invites trust the evidence does not actually support.

>> Confidence is the label the system shows. Calibration is whether that label is actually honest, you can only trust the first once you have measured the second.$D62ede85d_631b_43e7_b976_3b92d4e94b09$ where id = '62ede85d-631b-43e7-b976-3b92d4e94b09';

update lessons set content = $De690b6b8_4e88_4f89_a89e_b66fe5dbd53a$MONITORING AFTER LAUNCH

AI evaluation does not stop at launch. Monitor user feedback, error reports, safety incidents, hallucination reports, escalations, human overrides, cost, latency, tool failures, retrieval quality, drift in user questions, quality by segment, prompt injection attempts, and policy violations.

**AI quality can degrade after launch because users, data, policies, and workflows change.**


AI OBSERVABILITY

Observability means being able to inspect what happened inside the AI system. For AI products, observe the user input, prompt version, model version, retrieved documents, tool calls, tool outputs, final answer, guardrail decisions, human approvals, errors, latency, and cost.

PM question: **"Can we debug why the AI gave this answer or took this action?"**

Without observability, AI incidents become hard to investigate.

>> Monitoring tells you something changed. Observability is what lets you find out why, one without the other leaves you either blind or unable to diagnose what you can see.$De690b6b8_4e88_4f89_a89e_b66fe5dbd53a$ where id = 'e690b6b8-4e88-4f89-a89e-b66fe5dbd53a';

update lessons set content = $Df8358a46_7845_44ff_a729_61dab0f847fc$LOGGING AND AUDIT TRAILS

Audit logs matter especially for agents. Track who asked, what data was accessed, what sources were used, what tools were called, what action was taken, whether a human approved, the timestamp, model/prompt version, the final output, and the error or escalation reason.

**If an AI action affects users or business records, it must be auditable.**


INCIDENT RESPONSE

AI products need incident plans. Examples of AI incidents: AI gives wrong policy to many users, AI leaks private data, AI sends wrong customer emails, AI issues duplicate refunds, AI fails to escalate a safety issue, AI retrieves restricted documents, AI cost spikes due to a loop, AI produces biased or harmful output.

Incident plan should include a kill switch, rollback, human escalation, user communication, log review, root cause analysis, a prompt/model/tool fix, a monitoring update, and a post-incident review.

PM question: **"What do we do in the first hour after a serious AI failure?"**

>> Logging is what makes incident response possible, without an audit trail, root cause analysis after an incident becomes guesswork.$Df8358a46_7845_44ff_a729_61dab0f847fc$ where id = 'f8358a46-7845-44ff-a729-61dab0f847fc';

update lessons set content = $D5e395706_e535_4cc6_bcd0_deaa3fc32b07$GUARDRAIL FAILURE MODES

Guardrails can fail too. Examples: a safety filter blocks too much, a safety filter misses harmful content, a retrieval filter uses wrong permissions, a prompt rule is ignored, an output validator misses an unsupported claim, a human review queue is overloaded, a tool permission is too broad, an escalation rule is unclear, a guardrail increases latency too much.

**Guardrails themselves need evaluation.**


OVER-RELIANCE RISK

Users may trust AI too much. Examples: an agent sends an AI-drafted reply without reading it, a manager trusts an AI summary without checking sources, a user follows AI financial/legal/health guidance, an analyst accepts AI-generated SQL without review, a support team relies on AI even when confidence is low.

Mitigations: show sources, show limitations, require review, use confidence/risk labels, make edits easy, train users, design for appropriate trust.

PM question: **"Are users trusting the AI more than they should?"**

>> A guardrail that fails silently is itself a source of over-reliance, the team believes a safety net exists when it does not, which is arguably worse than knowing no safety net exists at all.$D5e395706_e535_4cc6_bcd0_deaa3fc32b07$ where id = '5e395706-e535-4cc6-bcd0-deaa3fc32b07';

update lessons set content = $Dc6c6a9e8_b5d3_4459_82bd_74baedf24268$UNDER-RELIANCE RISK

Users may also trust AI too little. Examples: the AI is helpful but hidden, output lacks sources, the user cannot tell why the answer is correct, the AI makes early mistakes and loses trust, the workflow makes review harder than doing it manually.

Mitigations: improve transparency, show source evidence, let users edit, start with low-risk tasks, show clear value, provide a feedback loop.

**Good AI UX creates appropriate trust, not blind trust or zero trust.**


SAFETY AND UX

Safety is not only backend rules, UX matters. Examples: confirm before action, show source citations, show what the AI is doing, allow undo, make escalation easy, show uncertainty, ask clarifying questions, avoid hiding risky automation, let users give feedback, separate draft from sent message.

[!] Safe AI is designed into the user experience, not bolted on afterward.

>> Over-reliance and under-reliance are opposite failures with the same root cause: the UX did not clearly communicate how much to trust the AI in this specific moment.$Dc6c6a9e8_b5d3_4459_82bd_74baedf24268$ where id = 'c6c6a9e8-b5d3-4459-82bd-74baedf24268';

update lessons set content = $D61e15222_8438_4dd4_b633_2d11690a16dc$Before launch, run a readiness review. Check the problem definition, use case risk level, evaluation results, golden dataset coverage, safety testing, privacy review, security review, legal/compliance review if needed, guardrails, human review process, monitoring, rollback, incident response, and owner.

**AI launch readiness is product readiness plus risk readiness.**

[!] This checklist is deliberately the union of everything covered in this module so far, evaluation, guardrails, safety, and governance all converge into one final gate before real users see the system.

>> Nothing in this lesson is new information, it is the single moment where every earlier lesson in this module gets checked off before launch, together.$D61e15222_8438_4dd4_b633_2d11690a16dc$ where id = '61e15222-8438-4dd4-b633-2d11690a16dc';

update lessons set content = $Df576cbc5_7f4c_49b7_858d_3cccce330632$Use case: AI drafts support responses for agents.

Quality: factual accuracy, policy compliance, tone, completeness, source citation.

Safety: does not promise unsupported refunds, escalates legal threats, avoids private data leaks, refuses out-of-scope advice.

Product impact: agent acceptance, resolution time, CSAT, escalation rate, wrong-answer rate, cost per ticket.

Guardrails: RAG from approved policy, citation requirement, human approval before send, high-risk escalation.

Launch path: offline eval, internal pilot, agent copilot, limited rollout, monitor quality and CSAT.

[!] Notice this example touches every layer from this module, quality dimensions, safety checks, product metrics, guardrails, and a phased launch path, applied to one concrete feature.

>> This worked example is the template: any new AI feature can be evaluated by walking through these same five categories in order.$Df576cbc5_7f4c_49b7_858d_3cccce330632$ where id = 'f576cbc5-7f4c-49b7-858d-3cccce330632';

update lessons set content = $D25b3970f_9b9c_4128_85c4_e36f7c38bccf$Use case: AI answers business metric questions.

Quality: correct SQL, correct metric definition, correct numbers, clear explanation, separates fact from hypothesis.

Safety: respects data permissions, does not hallucinate metrics, does not reveal restricted data, flags uncertainty.

Product impact: time to insight, analyst acceptance, query success, decision usefulness, error rate.

Guardrails: metric-definition RAG, database tool access, SQL validation, human review for executive reporting.

[!] An analytics AI that invents numbers is worse than no AI, a wrong number that looks confident can drive a real business decision in the wrong direction.

>> Compare this example to the support copilot: same five-category structure, completely different specific risks (hallucinated numbers here vs. unsupported refund promises there).$D25b3970f_9b9c_4128_85c4_e36f7c38bccf$ where id = '25b3970f-9b9c-4128-85c4-e36f7c38bccf';

update lessons set content = $Dc7e6ba57_5b65_410e_8a97_b277272e651f$Use case: refund workflow agent.

Workflow quality: correctly identifies refund intent, looks up order, checks policy, uses current policy, applies threshold rules, escalates exceptions, drafts correct reply.

Safety: does not issue unauthorized refunds, does not duplicate actions, does not access the wrong customer record, requires approval for high-value cases, logs every action.

Business impact: resolution time, refund error rate, CSAT, manual workload, escalation quality, cost per resolved case.

Guardrails: permission-limited tools, approval gates, idempotency, audit logs, kill switch.

[!] This example brings back the agent-specific controls from Module 20, idempotency, approval gates, audit logs, kill switch, now framed explicitly as part of an evaluation and safety plan, not just an agent design plan.

>> Three examples, three different risk shapes: content risk (support copilot), factual risk (analytics assistant), and action risk (refund agent), each needing its guardrails weighted differently.$Dc7e6ba57_5b65_410e_8a97_b277272e651f$ where id = 'c7e6ba57-5b65-410e-8a97-b277272e651f';

update lessons set content = $D8fe03b20_ffeb_4e31_b467_c9f45a21efb2$PM CHECKLIST FOR AI EVALUATION

Before launch, ask: what exact task is the AI performing, and what does good output mean? What does unsafe output mean? Do we have a golden dataset, and does it include common cases, edge cases, no-answer cases, safety cases, and prompt injection cases? Who reviews outputs, what rubric do they use, and are reviewers consistent? What automated evals and human evals exist? What metrics define launch readiness, product success, and safety? What happens if quality drops? How will we monitor after launch, and who owns evaluation after launch?


PM CHECKLIST FOR GUARDRAILS

Ask: what user inputs are allowed or blocked? What sources can the AI retrieve, and are permissions enforced? Are outdated sources excluded? Does the prompt require grounding, and are citations required? Are outputs validated, and are unsafe outputs filtered? Are private data leaks checked? Which tools can the AI use, which are read-only, and which require approval? Are irreversible actions blocked or confirmed? Is human review required for high-risk cases? Are all actions logged? Is there a kill switch and a rollback plan? Are guardrails tested and monitored?

[!] These two checklists are the practical distillation of this entire module, every question traces back to a lesson covered earlier.

>> Keep both checklists next to the launch-readiness checklist from the previous lesson; together they cover evaluation, guardrails, and the final go/no-go decision.$D8fe03b20_ffeb_4e31_b467_c9f45a21efb2$ where id = '8fe03b20-ffeb-4e31-b467-c9f45a21efb2';

update lessons set content = $D2d7befc0_1d39_4d7b_881a_7c1004f7590e$PM CHECKLIST FOR AI SAFETY

Ask: what is the worst-case failure, and who could be harmed? What decisions does the AI influence, is money, access, legal status, health, safety, or employment affected? Does the AI handle sensitive data, and does it need legal, privacy, or security review? Could users over-trust or manipulate it? Could it reveal confidential data, make biased recommendations, or take unsafe actions? Can humans override it, and can users appeal? Can we explain the output and audit the action? Can we stop the system quickly and recover from mistakes? Who is accountable?


HOW TO EXPLAIN AI EVALUATION AND SAFETY TO LEADERSHIP

Simple explanation: "AI evaluation is how we measure whether the system is accurate, useful, safe, and ready for production. For generative AI, we cannot rely on one good demo because outputs can vary and may look fluent even when wrong. We need a golden dataset, human review, automated checks, red-team tests, guardrails, monitoring, and a rollback plan."

Support example: "for the support copilot, we will evaluate factual accuracy, policy compliance, citation correctness, tone, escalation behavior, and agent acceptance. The AI will only draft replies at first; humans will approve before sending. High-risk cases will be escalated. We will monitor wrong-answer rate, CSAT, resolution time, and safety incidents."

Agent example: "for the refund agent, safety is more important because it can take action. We will restrict tools, require approval for high-value refunds, log all tool calls, prevent duplicate actions, and maintain a kill switch. Launch will start in shadow mode before any automation."


THE MEMORY SHORTCUT

AI evaluation is testing whether AI is good enough for the real world. Guardrails are controls that keep AI inside safe product boundaries. AI safety is reducing harm when AI is wrong, misused, or over-trusted.

Remember: golden dataset, then eval rubric, then guardrails, then red team, then launch monitoring, then incident response.

Evaluate accuracy, factuality, groundedness, citation correctness, refusal behavior, safety, privacy, tool use, escalation, and business impact.

Guard against hallucination, prompt injection, privacy leaks, wrong tool use, unsafe actions, bias, over-reliance, outdated sources, permission failures, and no rollback.

[!] This module completes the course's full arc, from ML foundations, through modern AI and LLMs, prompting, RAG, agents, and fine-tuning, to the discipline of proving any of it is actually safe and ready for real users.

>> The most important PM question: have we proven this AI system is useful, safe, measurable, and controlled enough for the real workflow it will enter?$D2d7befc0_1d39_4d7b_881a_7c1004f7590e$ where id = '2d7befc0-1d39-4d7b-881a-7c1004f7590e';

update questions set choices = $D30215a43_859b_4e4b_8ffa_196e6a1fac15Q$["This is like assuming a new employee is ready for the job after one good answer, a good AI product is judged by repeated performance across many real and risky cases, not by one impressive demo response","One impressive demo answer is sufficient evidence that an AI feature is ready for full production use","Demos and production performance are always identical, so no further testing is needed","This conclusion is valid as long as the demo answer was reviewed by at least one person"]$D30215a43_859b_4e4b_8ffa_196e6a1fac15Q$::jsonb where id = '30215a43-859b-4e4b-8ffa-196e6a1fac15';

update questions set choices = $Daf05aaf8_9765_46fb_98f0_9f16dfda5e96Q$["AI/LLM evaluation is harder than classic ML evaluation because output is open-ended, a single score hides whether the output is correct, useful, safe, grounded, and appropriate, all of which need to be checked separately, unlike a simple yes/no prediction like churn","A single quality score is just as appropriate for LLM outputs as it is for churn prediction accuracy","Classic ML evaluation and AI evaluation are identical in difficulty and structure","Open-ended outputs cannot be evaluated at all, so no scoring system should be attempted"]$Daf05aaf8_9765_46fb_98f0_9f16dfda5e96Q$::jsonb where id = 'af05aaf8-9765-46fb-98f0-9f16dfda5e96';

update questions set choices = $Dcc38674c_7fb0_4fcb_81fe_8cd70b77d2adQ$["Levels 2 and 3, system behavior (did it retrieve the right source, use the right tool, escalate correctly) and product impact (did it save time, reduce cost, improve CSAT) are both separate levels of evaluation from output quality, and skipping them leaves major gaps","Nothing is missing, since output quality alone is a complete evaluation","System behavior only matters for agents, not for simpler AI features like this one","Product impact can only be measured before launch, not incorporated into evaluation planning"]$Dcc38674c_7fb0_4fcb_81fe_8cd70b77d2adQ$::jsonb where id = 'cc38674c-7fb0-4fcb-81fe-8cd70b77d2ad';

update questions set choices = $Db794e47e_e9b0_44a2_a2e6_d11397e1537fQ$["The team has offline evaluation but no online evaluation, offline eval proves the AI is good enough to test with users, but online eval is what proves the AI is actually improving the real product after launch, and skipping it leaves that question unanswered","Offline evaluation alone is sufficient and online evaluation is optional once a golden dataset has been used","Online evaluation should replace offline evaluation entirely rather than complementing it","This gap only matters for RAG systems, not for other types of AI products"]$Db794e47e_e9b0_44a2_a2e6_d11397e1537fQ$::jsonb where id = 'b794e47e-e9b0-44a2-a2e6-d11397e1537f';

update questions set choices = $D888e75ca_c27f_4c6c_a2dc_5ae634fdd4b1Q$["Hard cases, edge cases, no-answer cases, conflicting-source cases, outdated-source traps, permission-sensitive cases, safety cases, and prompt injection cases, a golden dataset limited to easy common cases will not reveal how the AI handles the situations most likely to cause real harm","Nothing is missing, since testing the ten most common questions is sufficient for a complete golden dataset","Golden datasets should only ever include cases the AI is expected to answer correctly","Edge cases and safety cases are only relevant for agent evaluation, not for a support AI golden dataset"]$D888e75ca_c27f_4c6c_a2dc_5ae634fdd4b1Q$::jsonb where id = '888e75ca-c27f-4c6c-a2dc-5ae634fdd4b1';

update questions set choices = $D4c8a94b2_1cfa_45b2_8f1c_c550fc2a41ccQ$["Low inter-rater agreement, which usually means the rubric or guidelines are unclear, if humans cannot evaluate consistently, the AI cannot be improved consistently, so the team should review the disagreement, clarify guidelines, and add examples rather than ignore it","This disagreement is unimportant and does not need to be investigated or resolved","This means one of the two reviewers should simply be replaced without examining the rubric","Inter-rater disagreement only matters for automated evaluation, not human evaluation"]$D4c8a94b2_1cfa_45b2_8f1c_c550fc2a41ccQ$::jsonb where id = '4c8a94b2-1cfa-45b2-8f1c-c550fc2a41cc';

update questions set choices = $Def15358a_b4f5_4528_8700_38cc3561b32aQ$["Retrieval quality metrics (like Recall@K) would confirm the correct source was retrieved, while answer quality metrics (like factual accuracy and groundedness) would catch that the final answer was still wrong despite having the right evidence, RAG evaluation requires checking both separately","Retrieval quality metrics alone would catch both the retrieval success and the answer failure","Product quality metrics are the only relevant category for this scenario","This scenario cannot be diagnosed by any evaluation category described in this lesson"]$Def15358a_b4f5_4528_8700_38cc3561b32aQ$::jsonb where id = 'ef15358a-b4f5-4528-8700-38cc3561b32a';

update questions set choices = $D31ca2100_bc1e_48f4_ae8a_bbd249b0e009Q$["Tool interpretation and action safety, the agent understood which tools to use and in what order (planning and tool selection succeeded), but failed at correctly interpreting the tool results and then took an unsafe action, which are separate evaluation dimensions from tool selection and ordering","Tool selection is the only relevant dimension, and this failure means tool selection itself was wrong","This failure cannot be caught by any of the evaluation dimensions described in this lesson","Goal understanding is the only dimension that matters for this type of failure"]$D31ca2100_bc1e_48f4_ae8a_bbd249b0e009Q$::jsonb where id = '31ca2100-bc1e-48f4-ae8a-bbd249b0e009';

update questions set choices = $D67a48bd7_ae6d_4222_9ee1_6541943dfa8cQ$["Field-level accuracy, missing-field rate, false extraction rate, format validity, and human correction rate, these are the metrics this lesson specifically lists for AI extraction, since resolution time is more relevant to a support AI use case, not an extraction task","Resolution time is the universal metric appropriate for any AI use case, including extraction","CSAT is the only metric that matters regardless of the specific AI product type","Metrics should never be tailored to the specific use case and should always be identical across all AI features"]$D67a48bd7_ae6d_4222_9ee1_6541943dfa8cQ$::jsonb where id = '67a48bd7-ae6d-4222-9ee1-6541943dfa8c';

update questions set choices = $D23579ecd_3e0b_43f3_8d4e_bf5637fbadf0Q$["This is hallucination, the AI produced information that sounds correct but is unsupported; hallucination evaluation should test whether answers include unsupported claims, whether citations support the claims, and whether the AI says \"not enough information\" instead of guessing when the source does not contain the answer","This is expected and acceptable behavior as long as the answer sounds confident and plausible","This can only be prevented by increasing the model's context window size","Hallucination only matters for numerical claims, not for date or scheduling information like this example"]$D23579ecd_3e0b_43f3_8d4e_bf5637fbadf0Q$::jsonb where id = '23579ecd-3e0b-43f3-8d4e-bf5637fbadf0';

update questions set choices = $D2716ff4d_ca76_49da_ac0c_60ffd2f3a654Q$["This is a citation correctness failure, the cited source does not actually support the claim, which is a distinct and more specific problem than general groundedness, since the answer has a citation attached but that citation is not real evidence, just decoration","This is identical to a groundedness failure with no meaningful distinction between the two concepts","Citation correctness only applies to legal documents, not to policy documents like refund policies","This is not a real problem as long as some citation is present, regardless of whether it supports the claim"]$D2716ff4d_ca76_49da_ac0c_60ffd2f3a654Q$::jsonb where id = '2716ff4d-ca76-49da-ac0c-60ffd2f3a654';

update questions set choices = $Df325eabd_92d2_40f8_a78c_dce19da8af70Q$["This is over-refusal, the AI refuses safe, normal questions, which is one of two refusal accuracy failure types this lesson describes (the other being under-refusal, where the AI answers things it should refuse); a safe AI should not be reckless, but it should also not be useless","This is under-refusal, since the AI is refusing to provide an answer","This is expected and desirable behavior for any well-designed AI safety system","Refusal accuracy only applies to unsafe requests, not to overly cautious refusals of safe requests"]$Df325eabd_92d2_40f8_a78c_dce19da8af70Q$::jsonb where id = 'f325eabd-92d2-40f8-a78c-dce19da8af70';

update questions set choices = $D4b87ed83_efa4_422f_ad3d_408ac96259ccQ$["Retrieval guardrails, specifically permission-aware retrieval and blocking confidential sources, since a customer-facing AI should not retrieve internal legal escalation notes; this is a retrieval-layer failure, not an input-layer or output-layer one","Input guardrails alone would have caught this, since the customer's original question was the source of the problem","This can only be prevented by output guardrails checking the final answer text, not by controlling what gets retrieved","No guardrail layer described in this lesson is designed to prevent this specific type of failure"]$D4b87ed83_efa4_422f_ad3d_408ac96259ccQ$::jsonb where id = '4b87ed83-efa4-422f-ad3d-408ac96259cc';

update questions set choices = $Daa42fc82_63fd_4f66_a866_d3b084c1eec4Q$["Output guardrails, a check on the model's response before it is shown or acted on, since prompt guardrails alone are not enough and important rules should not live only in prompts; an output guardrail could specifically block an unsupported refund promise even if the prompt rule was not perfectly followed","Prompt guardrails alone are always sufficient and no additional output-layer check is needed","Input guardrails would be the correct addition here, not output guardrails","This gap can only be addressed by switching to a different, more capable underlying model"]$Daa42fc82_63fd_4f66_a866_d3b084c1eec4Q$::jsonb where id = 'aa42fc82-63fd-4f66-a866-d3b084c1eec4';

update questions set choices = $D671e3298_ba9c_4ddb_aa8d_2c9c1fd565aaQ$["This overbuilds for a low-risk task, guardrails should match risk level, and a blog-title suggestion tool needs only light safety checks and user editing, not the heavy controls appropriate for high-risk cases like changing account status or approving refunds","Every AI feature should always receive the exact same maximum level of guardrails regardless of risk level","Risk-based controls only apply to high-risk use cases, not to decisions about low-risk features","Safety filters and risk-based controls are the same concept and cannot be distinguished"]$D671e3298_ba9c_4ddb_aa8d_2c9c1fd565aaQ$::jsonb where id = '671e3298-ba9c-4ddb-aa8d-2c9c1fd565aa';

update questions set choices = $D9dd39145_6322_4617_a128_253c35009022Q$["Different AI risk categories matter differently depending on the use case, and the PM question \"what type of risk is most important for this AI use case?\" should be asked explicitly, for a loan-recommendation feature, financial risk and bias/fairness risk are both likely to be highly relevant given the decision's real-world consequences","All ten risk categories always carry identical priority regardless of the specific AI use case","Privacy risk is always the single most important category for any AI feature, regardless of context","Risk categories are a purely theoretical framework with no practical bearing on which use case needs which controls"]$D9dd39145_6322_4617_a128_253c35009022Q$::jsonb where id = '9dd39145-6322-4617-a128-253c35009022';

update questions set choices = $D540952f4_3b58_4e59_8e7f_eeaa5238edb3Q$["Red teaming, intentionally trying to make the AI fail through prompt injection, jailbreaks, unsafe requests, edge cases, and adversarial inputs, which is different from standard functional testing and is specifically designed to find failures before real users do","Standard functional testing is equivalent to red teaming and covers the same failure modes","Red teaming is only relevant for RAG systems, not for agents that take actions like canceling subscriptions","This gap is acceptable as long as an impact assessment was completed at some point"]$D540952f4_3b58_4e59_8e7f_eeaa5238edb3Q$::jsonb where id = '540952f4-3b58-4e59-8e7f-eeaa5238edb3';

update questions set choices = $D46ea04b7_8543_4743_9ab4_e06de1695542Q$["Missing prompt injection testing, specifically indirect prompt injection inside documents, any AI that reads user or external content needs this kind of testing, since malicious or manipulated content can try to override system instructions","This is a privacy evaluation gap, unrelated to prompt injection testing","This type of attack is only relevant to agents, not to any AI system that reads retrieved documents","This scenario cannot occur in real systems and does not need to be tested for"]$D46ea04b7_8543_4743_9ab4_e06de1695542Q$::jsonb where id = '46ea04b7-8543-4743-9ab4-e06de1695542';

update questions set choices = $D4e08cc30_849e_4bf7_a8e0_554ac7b5fa92Q$["Permission evaluation, this checks whether the AI respects access control, which is exactly what this lesson describes when testing whether an employee can access another team's confidential data or restricted sources they should not see","Bias and fairness evaluation, since salary data evaluation is inherently a fairness concern rather than a permissions concern","This type of test is not covered by any evaluation category described in this lesson","Hallucination evaluation, since incorrect access would only be a factual accuracy problem"]$D4e08cc30_849e_4bf7_a8e0_554ac7b5fa92Q$::jsonb where id = '4e08cc30-849e-4bf7-a8e0-554ac7b5fa92';

update questions set choices = $D6780d953_96a4_4b8c_a4f5_8ba49111ca67Q$["Bias and fairness evaluation, testing performance by language, region, accent, device type, customer segment, and other relevant factors is exactly what this lesson recommends, since AI quality can differ unfairly across groups, and this speech AI accent issue is a concrete example of that risk","This is expected and acceptable variation that does not need to be tested or addressed","Accent-based performance differences are a hardware issue unrelated to AI evaluation","Bias and fairness evaluation only applies to hiring or credit AI, not to speech recognition systems"]$D6780d953_96a4_4b8c_a4f5_8ba49111ca67Q$::jsonb where id = '6780d953-96a4-4b8c-a4f5-8ba49111ca67';

update questions set choices = $D66c44394_687c_4bee_b13d_cd78e3d7be75Q$["This is a workflow safety failure specific to tool-use, the agent used a tool (issuing the refund) out of the correct sequence, without checking policy first, which this lesson explicitly calls out as more dangerous than wrong text because it results in a real, potentially costly action","This is purely a hallucination problem unrelated to tool-use safety","This failure is not significant since the refund itself is easily reversible in all cases","This type of failure can only occur in support AI, not in agent workflows"]$D66c44394_687c_4bee_b13d_cd78e3d7be75Q$::jsonb where id = '66c44394-687c-4bee-b13d-cd78e3d7be75';

update questions set choices = $D59b75c61_5373_4334_b8ab_dea972ccc2c4Q$["Confidence should be based on evidence like source quality, retrieval relevance, and agreement across sources, not shown as a static or unexamined number, and if this constant high confidence does not actually correlate with accuracy, the system is also poorly calibrated, which invites users to over-trust the AI's answers","Showing a high confidence score on every answer is good practice and builds user trust regardless of whether it reflects actual evidence","Confidence scores have no relationship to calibration and are two entirely separate, unrelated concepts","This design is fine as long as the number displayed is technically generated by the model"]$D59b75c61_5373_4334_b8ab_dea972ccc2c4Q$::jsonb where id = '59b75c61-5373-4334-b8ab-dea972ccc2c4';

update questions set choices = $D05062439_881c_4270_b00b_be25d6be407bQ$["Effective incident response, since logging and audit trails are what make root cause analysis possible, and without them, understanding what happened, why, and how to fix it becomes largely guesswork, undermining the entire incident response plan","This gap has no meaningful impact on the team's ability to respond to the incident","Audit trails are only useful for compliance purposes, not for actual incident investigation","Incident response can proceed effectively using only user complaints, without needing any internal logs"]$D05062439_881c_4270_b00b_be25d6be407bQ$::jsonb where id = '05062439-881c-4270-b00b-be25d6be407b';

update questions set choices = $Dfbbd7ae0_03e7_4b34_8a1e_1dbad9395375Q$["A kill switch, every high-risk AI feature needs a fast way to stop harm, such as disabling a specific tool or routing all cases to human review, and this should be planned before launch, not built reactively during an active incident","This gap is acceptable since code deployments are always fast enough to serve as an adequate incident response mechanism","Kill switches are only relevant for agent systems that use multiple tools, not for single-tool agents like this refund tool","Rollback and kill switch are the same mechanism, so having a rollback plan alone would have been sufficient here"]$Dfbbd7ae0_03e7_4b34_8a1e_1dbad9395375Q$::jsonb where id = 'fbbd7ae0-03e7-4b34-8a1e-1dbad9395375';

update questions set choices = $D3ebb13bf_61d4_4052_8c78_bbfbc8e43bcaQ$["Guardrails themselves need evaluation, a safety filter that never triggers could mean it is working perfectly, or it could mean it is missing harmful content entirely (a guardrail failure mode this lesson explicitly describes), and the team cannot know which without testing the guardrail itself","A guardrail that has never produced a false positive can always be assumed to be functioning correctly","Guardrail failure modes only apply to tool/action guardrails, not to safety filters","This assumption is reasonable and does not require any further verification"]$D3ebb13bf_61d4_4052_8c78_bbfbc8e43bcaQ$::jsonb where id = '3ebb13bf-61d4-4052-8c78-bbfbc8e43bca';

update questions set choices = $D059597ac_ae1f_4d5f_b4e6_32089b83c2c8Q$["Under-reliance risk, users trust the AI too little because it lacks transparency (hidden placement, no source evidence, no way to tell why an answer is correct), and this lesson recommends improving transparency, showing source evidence, and demonstrating clear value to fix it","This is over-reliance risk, since the tool is described as genuinely useful","This is a technical bug rather than a UX or trust issue, and cannot be addressed through design changes","Low adoption in this scenario is unrelated to any concept covered in this lesson"]$D059597ac_ae1f_4d5f_b4e6_32089b83c2c8Q$::jsonb where id = '059597ac-ae1f-4d5f-b4e6-32089b83c2c8';

update questions set choices = $D188fa953_ec35_4a9d_8884_c4a5b677db48Q$["AI governance (no clear ownership for launch approval, monitoring, or incident handling) and the absence of a model/system card (no documentation of intended use, known limitations, or safety risks that a future team could reference), together these mean the AI has effectively become nobody's responsibility","This scenario only reflects a governance problem, and model cards are unrelated to this situation","This is expected and acceptable for any AI feature that has been stable for a long period of time","Documentation and ownership are the same concept and this scenario only illustrates one gap, not two"]$D188fa953_ec35_4a9d_8884_c4a5b677db48Q$::jsonb where id = '188fa953-ec35-4a9d-8884-c4a5b677db48';

update questions set choices = $D47a4837a_a7ce_4df4_aacf_a383fba17426Q$["No, AI launch readiness is product readiness plus risk readiness, and the readiness review explicitly checks guardrails, monitoring, rollback, incident response, and ownership in addition to evaluation results and safety testing, so several required items are still missing","Yes, since evaluation results and safety testing are the only two items required for launch readiness","Guardrails and monitoring are optional items that can be added after launch without affecting readiness","Ownership assignment has no bearing on whether a feature is ready to launch"]$D47a4837a_a7ce_4df4_aacf_a383fba17426Q$::jsonb where id = '47a4837a-a7ce-4df4-aacf-a383fba17426';

update questions set choices = $D89bc6f04_2bcf_4e83_862c_a9c5c21f5831Q$["Safety (like escalating legal threats and avoiding private data leaks) and guardrails (like human approval before send), the support copilot example in this lesson explicitly includes quality, safety, product impact, and guardrails as the full evaluation picture, not quality alone","Nothing is missing, since factual accuracy and completeness are the only two categories relevant to a support copilot","Safety and guardrail categories are only relevant to agent use cases, not to a copilot that only drafts replies","This gap is acceptable as long as the product impact metrics are tracked after launch"]$D89bc6f04_2bcf_4e83_862c_a9c5c21f5831Q$::jsonb where id = '89bc6f04-2bcf-4e83-862c-a9c5c21f5831';

update questions set choices = $D4e211f07_934a_48cd_b63e_e235f850dbd1Q$["An analytics AI that invents numbers is worse than no AI, since a wrong number that looks confident can drive a real business decision in the wrong direction, this is exactly the kind of hallucinated-metric risk this lesson calls out as the key danger of this use case","Having an AI analytics assistant is always better than not having one, regardless of whether it occasionally fabricates numbers","This type of failure is a minor issue since executives are expected to verify all numbers before using them","This risk only applies to support AI, not to internal analytics assistants"]$D4e211f07_934a_48cd_b63e_e235f850dbd1Q$::jsonb where id = '4e211f07-934a-48cd-b63e-e235f850dbd1';

update questions set choices = $D62ab877e_62a0_4bee_be22_02b9f01f686aQ$["Safety, this lesson's agent example specifically calls out not issuing unauthorized refunds, not duplicating actions (idempotency), requiring approval for high-value cases, and logging every action as essential safety checks for a refund agent, none of which are covered by evaluating reply quality alone","Nothing is being neglected, since reply quality is the most important factor for any support-related AI feature","Idempotency and audit logs are only relevant to analytics assistants, not to refund agents","Business impact metrics are the only category that matters for evaluating an agent, not safety checks"]$D62ab877e_62a0_4bee_be22_02b9f01f686aQ$::jsonb where id = '62ab877e-62a0-4bee-be22-02b9f01f686a';

update questions set choices = $D528ffa64_7055_48b1_b30d_98ca6bfcf083Q$["Whether the golden dataset includes no-answer cases and prompt injection cases, whether citations are required and validated, and whether high-risk cases have a human review process, all of these appear explicitly in the PM checklists for AI evaluation and guardrails in this lesson","Only checking whether the AI produces grammatically correct sentences, since language quality is the sole focus of these checklists","Skipping guardrail checks entirely, since the evaluation checklist alone is sufficient for launch readiness","Checking only cost and latency, since these are the only items covered by the checklists in this lesson"]$D528ffa64_7055_48b1_b30d_98ca6bfcf083Q$::jsonb where id = '528ffa64-7055-48b1-b30d-98ca6bfcf083';

update questions set choices = $Dcc246e54_aac8_4f7a_a017_0c3497835c92Q$["Explain that generative AI outputs can vary and may look fluent even when wrong, so a good demo alone does not prove production readiness, the team needs a golden dataset, human review, automated checks, red-team tests, guardrails, monitoring, and a rollback plan to actually measure and control accuracy, safety, and risk before and after launch","A good demo is sufficient evidence of production readiness, and additional evaluation and safety steps are unnecessary overhead","Golden datasets and red-team testing are only necessary for agent-based features, not for other types of AI products","Rollback plans and guardrails can always be added after launch without any risk, so they do not need to be prepared beforehand"]$Dcc246e54_aac8_4f7a_a017_0c3497835c92Q$::jsonb where id = 'cc246e54-aac8-4f7a-a017-0c3497835c92';
