-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 23: AI Product UX and Copilot Design
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update modules set description = $M$Designing how humans and AI work together, interaction patterns, trust calibration, control points, and copilot/agent UX for AI that fits naturally into real workflows.$M$ where id = '793d58f5-c92c-4cbf-b25b-ef857a32c322';

update lessons set content = $D0ce03f7f_6be1_4009_9861_5d63e808da94$DESIGNING FOR MISTAKES

AI will make mistakes. Design should assume that. Mistake-friendly design includes easy correction, undo, report issue, human escalation, source verification, draft mode, confirmation before action, error labels, safe defaults, logs, and rollback.

PM question: **"When AI is wrong, can the user recover quickly?"**


HUMAN HANDOFF

Human handoff should be smooth. Bad handoff: "AI could not help. Contact support." Good handoff: "I am escalating because the policy does not cover this exception. I checked the order date, item condition, and refund policy. Here is a summary for the human reviewer."

Good handoff includes the user request, AI summary, sources checked, tools used, missing information, the reason for escalation, and a recommended next step.

[!] A good handoff should save the human time.

>> Designing for mistakes covers recovery when the AI itself is wrong. Human handoff covers the case where the AI correctly recognizes it has reached its own limit, both are forms of graceful failure.$D0ce03f7f_6be1_4009_9861_5d63e808da94$ where id = '0ce03f7f-6be1-4009-9861-5d63e808da94';

update lessons set content = $D3294bcfc_b4aa_44d8_bb73_eaa8a6200510$AI MEMORY UX

If AI remembers things, users should understand and control it. Memory UX should answer: what does AI remember? Why does it remember this? Can the user edit it? Can the user delete it? Can the user turn memory off? Is sensitive data remembered? Who can access memory? Does memory affect future answers?

[!] Memory can feel helpful or creepy. Design for consent and control.


PERSONALIZATION UX

AI can personalize experiences, preferred tone, user role, recent activity, saved preferences, frequent tasks, language, workflow shortcuts. But personalization must be transparent and useful.

Bad personalization: AI makes assumptions the user did not approve. Good personalization: "using your saved preference for concise summaries."

PM question: **"Is personalization helping the user, or making the experience feel invasive?"**

>> Memory is the mechanism that makes personalization possible across sessions. Both need the same underlying safeguard: the user should always know what is remembered and be able to say no.$D3294bcfc_b4aa_44d8_bb73_eaa8a6200510$ where id = '3294bcfc-b4aa-44d8-bb73-eaa8a6200510';

update lessons set content = $D2951013e_145b_41c5_9cab_303440a300a4$DATA BOUNDARY UX

Users should understand what data AI can access. Examples: "this answer uses only this document." "This assistant can access your open ticket and public help center articles." "This copilot cannot access customer payment details." "This agent will use your calendar only after permission."

[!] Users should know what the AI sees.


PERMISSION UX

For tool-using AI, users may need to grant permissions. Example: "to schedule this meeting, I need access to your calendar availability."

Good permission UX explains what access is requested, why it is needed, what action AI will take, whether it is one-time or ongoing, how to revoke access, and what data is not accessed.

PM question: **"Can the user make an informed permission decision?"**

>> Data boundary UX describes what the AI already can see. Permission UX is the moment-by-moment process of asking for more, together they keep data access visible instead of implicit.$D2951013e_145b_41c5_9cab_303440a300a4$ where id = '2951013e-145b-41c5-9cab-303440a300a4';

update lessons set content = $D0aee2121_8d7b_4dc7_bc8a_978b31f6f341$AGENT UX

Agent UX needs stronger design because agents act. Good agent UX shows the goal, the plan, the steps, the tools used, progress, approval points, the final action, a summary, undo/rollback if possible, and an escalation path.

Example plan: "1. Look up order. 2. Check refund policy. 3. Determine eligibility. 4. Draft response. 5. Ask for your approval before sending."

**Agents need visible plans and approval gates.**


SHOWING AGENT PROGRESS

For multi-step agents, show progress, "reading customer request," "looking up order," "checking policy," "drafting response," "waiting for approval." This reduces anxiety and helps users catch errors early.

Example: if the agent says "checking order #456" and the user expected #123, they can stop it.

PM question: **"Can the user intervene before the agent makes a mistake?"**

>> Agent UX is the overall design requirement. Showing progress is the specific mechanism that makes intervention possible mid-task, not just before or after.$D0aee2121_8d7b_4dc7_bc8a_978b31f6f341$ where id = '0aee2121-8d7b-4dc7-bc8a-978b31f6f341';

update lessons set content = $De394295c_f364_493f_900f_2cdada142efc$Measure AI UX with product and quality metrics.

Adoption: feature usage, repeat usage, activation, prompt suggestion clicks.

Efficiency: time saved, tasks completed faster, fewer clicks, reduced search time, reduced manual effort.

Quality: acceptance rate, edit distance, factual accuracy, source correctness, human review pass rate.

Trust and satisfaction: CSAT, helpfulness rating, thumbs up/down, user complaints, reported wrong answers.

Safety: escalation rate, wrong-action rate, unsafe output rate, privacy incidents, human override rate.

[!] Measure both usefulness and safety.

>> Five metric categories, and none of them alone tells the full story, a feature can look great on adoption while quietly failing on safety, or look safe while nobody actually uses it.$De394295c_f364_493f_900f_2cdada142efc$ where id = 'e394295c-f364-493f-900f-2cdada142efc';

update lessons set content = $D56dd2b87_6614_4b51_9a0d_91431409ad08$AI UX VS. NORMAL UX

Normal UX is usually deterministic, if a user clicks a button, the same thing happens. AI UX is probabilistic, the same input may produce slightly different outputs. That changes product design.

AI products need extra care around uncertainty, trust, explainability, feedback, human control, error recovery, source visibility, safety, permissions, and monitoring.

**Traditional UX designs clear actions. AI UX designs collaboration with an imperfect assistant.**


THE CORE AI UX QUESTION

Before designing any AI feature, ask: **where should AI fit in the user's existing workflow?**

Do not start with "should we add chat?" Start with: what is the user trying to accomplish? Where are they stuck? What takes too much time? What requires too much reading? What requires repetitive writing? What requires searching across sources? What requires decision support? What should stay human-controlled?

AI should reduce friction in a workflow. It should not become an extra task.

>> The core AI UX question is the single filter every other lesson in this module runs through, if a design choice does not answer "where does this fit in the workflow," it is decoration.$D56dd2b87_6614_4b51_9a0d_91431409ad08$ where id = '56dd2b87-6614-4b51-9a0d-91431409ad08';

update lessons set content = $Daaecbc5c_c341_49a5_b206_f3786187e22b$ASSISTANT, COPILOT, AUTOPILOT

There are different levels of AI involvement. An assistant answers or explains, example, "explain this policy." A copilot helps a human complete work, example, "draft a reply for me to review." An autopilot acts with little or no human review, example, "automatically resolve eligible refund requests."

**Assistant informs. Copilot assists. Autopilot acts.**

Move from assistant to autopilot only when the task is low-risk, well-tested, and properly monitored.


COPILOT DESIGN PRINCIPLE

A copilot should make the human better, not remove the human too early.

A good copilot saves time, reduces the blank-page problem, suggests next steps, shows evidence, lets the user edit, lets the user reject, learns from feedback, and keeps the human accountable.

A bad copilot creates confident wrong output, hides sources, makes editing hard, takes action too early, makes users over-trust it, interrupts the workflow, or requires more checking than doing manually.

[!] A copilot should reduce cognitive load, not create review burden.

>> Assistant, copilot, and autopilot are levels of autonomy; the copilot design principle is specifically about getting the middle level right, since that is where most real AI products actually live.$Daaecbc5c_c341_49a5_b206_f3786187e22b$ where id = 'aaecbc5c-c341-49a5-b206-f3786187e22b';

update lessons set content = $Df40ea3a5_e581_4191_975e_7d7c1351e4cc$START WITH THE USER JOURNEY

For AI UX, map the user journey. Example, a support agent workflow: read customer message, understand issue, search policy, check order, decide next step, write response, send response, update ticket.

AI can help at multiple points, summarize issue, retrieve policy, check order, suggest next step, draft reply, flag risk, update ticket. But not every step should be automated.

PM question: **"Where does the user need speed, accuracy, judgment, or control?"**


DESIGN AROUND USER INTENT

AI should understand what the user is trying to do. A user may say "help me with this customer", that is vague. Possible intents: summarize the issue, draft a response, find policy, check eligibility, escalate the ticket, identify sentiment, recommend next step.

Good UX can help by offering intent shortcuts, summarize, draft reply, find policy, check eligibility, escalate, create action items. Nielsen Norman Group notes that helpful site-specific AI chatbots clearly state capabilities, offer relevant prompt suggestions, and signal they understand what users are looking at.

[!] Do not make users guess how to use the AI. Show what it can do.

>> Mapping the journey tells you where AI could help. Designing around intent is how you make each of those moments actually usable instead of a blank box.$Df40ea3a5_e581_4191_975e_7d7c1351e4cc$ where id = 'f40ea3a5-e581-4191-975e-7d7c1351e4cc';

update lessons set content = $D836a9313_4fcd_4ef4_ac6b_4ba2fba9732a$CAPABILITY DISCLOSURE

Users need to know what the AI can and cannot do. Bad: "ask me anything", this creates unrealistic expectations. Better: "I can summarize this ticket, find relevant policy, draft a reply, or suggest next steps."

Capability disclosure should explain what AI can do, what it cannot do, what sources it uses, whether it can take action, whether human review is needed, and what data it can access.

PM question: **"Does the user understand the AI's scope?"**


FIRST-USE EXPERIENCE

The first-use experience matters. Users should quickly learn what this AI does, when to use it, what input it needs, what output to expect, whether output is editable, whether it uses sources, whether it can act, and how to give feedback.

Microsoft's Human-AI Interaction Guidelines cover how AI systems should behave during initial interaction, regular interaction, when wrong, and over time.

[!] The first experience should teach the user how to trust and control the AI.

>> Capability disclosure is what you tell the user. First-use experience is whether they actually absorb it in practice, the same information delivered badly on first use gets ignored.$D836a9313_4fcd_4ef4_ac6b_4ba2fba9732a$ where id = '836a9313-4fcd-4ef4-ac6b-4ba2fba9732a';

update lessons set content = $Df5db1db6_eed3_4d09_8020_17df924962af$EMPTY STATE DESIGN

The empty state is what users see before they interact. Bad empty state: a blank chat box. Better empty state: "I can help you with: summarize this document, extract action items, draft a reply, find relevant policy, explain this metric."

Good empty state reduces anxiety and gives examples.

PM question: **"What should the user try first?"**


PROMPT SUGGESTIONS

Prompt suggestions help users get useful output quickly. Examples: "summarize this in 5 bullets," "draft a professional reply," "find risks in this PRD," "extract action items," "explain this chart," "compare these options," "create an experiment plan."

Good prompt suggestions are context-aware, specific, useful, short, and based on user workflow. Bad prompt suggestions are generic, "ask me anything," "write something," "analyze this."

[!] Prompt suggestions are UX, not decoration.

>> An empty state without prompt suggestions is a wasted opportunity, the first thing a user sees is the best place to teach them what "good" looks like.$Df5db1db6_eed3_4d09_8020_17df924962af$ where id = 'f5db1db6-eed3-4d09-8020-17df924962af';

update lessons set content = $Df0e4eff4_0bba_4019_9f0a_d2ca2686f691$CONTEXT AWARENESS

AI feels useful when it understands the current context. Example: a user viewing a support ticket should see AI suggestions like summarize ticket, find policy, draft reply, detect sentiment, suggest escalation, not "write a poem" or "generate marketing copy."

Context-aware AI uses the current page, selected text, user role, workflow state, the current document, relevant data, and permissions.

PM question: **"What context should the AI automatically know, and what should the user provide?"**


USER CONTROL

AI should not make users feel powerless. Control options: edit output, regenerate, shorten, change tone, accept, reject, undo, view source, ask a follow-up, escalate to a human, stop the task, change settings, remove memory, disable the AI feature.

[!] The more powerful the AI, the more control the user needs.

>> Context awareness reduces how much the user has to explain. User control makes sure that even with less explaining, the user never loses the ability to steer or stop the AI.$Df0e4eff4_0bba_4019_9f0a_d2ca2686f691$ where id = 'f0e4eff4-0bba-4019-9f0a-d2ca2686f691';

update lessons set content = $D60a9e9c0_871a_4be2_8bea_8373f43966e6$DRAFT-FIRST DESIGN

For many workflows, AI should draft before acting. Examples: draft email, human sends; draft support reply, agent approves; draft report, analyst reviews; draft CRM note, sales rep edits; draft meeting summary, user confirms.

Draft-first design is safer because humans can review. Use it when user-facing communication is involved, the task has business risk, output could be wrong, tone matters, policy matters, or user trust matters.

**Draft is safer than auto-send.**


APPROVAL FLOWS

Approval flows are needed when AI action has risk. Example: "I found the order and policy. This case appears eligible for a return label. Approve creating the label?"

Good approval UX should show what action will happen, why AI recommends it, source evidence, risk level, what data will change, who will be notified, and whether the action can be undone.

PM question: **"Does the user understand what they are approving?"**

>> Draft-first is the default safety pattern for content. Approval flows are the equivalent pattern for actions, same underlying idea, applied to a different kind of output.$D60a9e9c0_871a_4be2_8bea_8373f43966e6$ where id = '60a9e9c0-871a-4be2-8bea-8373f43966e6';

update lessons set content = $D4e13358f_6db6_4309_90f2_ad22a69a80c4$UNDO AND RECOVERY

AI can make mistakes. Users need recovery options: undo a CRM update, reopen a ticket, revert a document, cancel a scheduled email, void a draft, restore a previous version, remove AI-generated text, escalate after a bad answer.

Some actions cannot be fully undone, a sent email, an issued refund, deleted data, an external notification, a public post.

[!] If an AI action cannot be undone, require stronger confirmation before action.


TRANSPARENCY

Transparency means users can understand what AI did. For low-risk tasks, simple transparency may be enough, example, "draft generated from selected text." For higher-risk tasks, show more, example, "used Refund Policy section 4 and Order #123 delivery date to recommend escalation."

Transparency can include sources used, tools called, data accessed, confidence reason, missing information, action taken, and next step.

**Transparency should match risk.**

>> Undo and recovery are what protect the user after a mistake happens. Transparency is what helps them notice the mistake happened at all.$D4e13358f_6db6_4309_90f2_ad22a69a80c4$ where id = '4e13358f-6db6-4309-90f2-ad22a69a80c4';

update lessons set content = $D9076da9a_d4f9_4e4f_aa99_557e7050009c$SOURCE VISIBILITY

For grounded AI, sources should be visible, a policy section, a document quote, a customer record field, an analytics table, a contract clause, a knowledge base article.

Good source UX shows the source title, shows the relevant excerpt, links to the full source, makes citation easy to verify, and clearly separates source from AI interpretation. Bad source UX shows a vague citation, links to an irrelevant document, hides evidence, or invents source names.

PM question: **"Can the user verify the answer quickly?"**


CONFIDENCE UX

Showing confidence can help, but it can also mislead. Bad: "confidence: 92%", the user may over-trust it without knowing why. Better: "confidence: medium, policy confirms return window, but product category exception is unclear."

Good confidence UX explains what evidence supports the answer, what information is missing, whether sources agree, whether human review is needed, and what action is safe.

[!] Confidence should be explained, not just scored.

>> Source visibility gives the user something to check. Confidence UX tells them how hard they need to check it, the two work together to calibrate exactly how much scrutiny a given answer deserves.$D9076da9a_d4f9_4e4f_aa99_557e7050009c$ where id = '9076da9a-d4f9-4e4f-aa99-557e7050009c';

update lessons set content = $D7c22b095_223b_4687_a376_4385385d8ba4$LOADING AND PROGRESS UX

AI tasks may take time. For short tasks, a spinner may be fine. For longer tasks, show progress, "searching policy…", "checking order…", "drafting response…", "waiting for approval…" This helps users trust the system.

For agents, progress visibility is critical because the AI may take multiple steps.

PM question: **"Does the user know what the AI is doing while they wait?"**


STREAMING OUTPUT

Streaming means showing the answer as it is generated. Useful for long text, drafting, summaries, and chat answers. Benefits: feels faster, the user sees progress, the user can stop early, and it reduces waiting anxiety.

But streaming may be bad when output needs validation first, safety checks happen after generation, partial output could be misleading, or structured output must be complete.

[!] Stream low-risk text. Validate high-risk output before showing.

>> Progress UX and streaming solve the same underlying problem, users hate silent waiting, but streaming only works when partial output is safe to show as-is.$D7c22b095_223b_4687_a376_4385385d8ba4$ where id = '7c22b095-223b-4687-a376-4385385d8ba4';

update lessons set content = $D382149e5_2ba8_437d_938c_971b06ae275f$EDITABILITY

AI output should often be editable, a customer reply, email, PRD, summary, meeting notes, report, CRM note.

Good edit UX lets the user revise directly, lets AI shorten/expand/change tone, makes changes visible, lets the user check the original source, and lets the user accept or reject suggestions.

**For copilots, editing is part of the workflow, not an afterthought.**


REVIEW BURDEN

AI can create hidden work. Example: AI drafts long support replies, and the agent now spends more time checking the draft than writing from scratch. Bad AI increases review burden.

Measure time saved, edit distance, acceptance rate, rejection reason, human confidence, error rate, and review time.

[!] A copilot is useful only if review time is lower than manual work time.

>> Editability is the mechanism. Review burden is the metric that tells you whether that mechanism is actually saving time or just relocating the work.$D382149e5_2ba8_437d_938c_971b06ae275f$ where id = '382149e5-2ba8-437d-938c-971b06ae275f';

update lessons set content = $D8ac408b8_f17e_4803_87db_5c53908b0154$FEEDBACK LOOPS FROM USERS

Users should be able to give feedback, thumbs up/down, "this was wrong," "source was irrelevant," "too long," "wrong tone," "missing information," "unsafe," "report issue," edit tracking, accept/reject behavior.

Feedback should feed into evaluation, prompt improvement, retrieval improvement, fine-tuning data, product analytics, and safety monitoring.

PM question: **"What feedback tells us whether the AI was actually useful?"**


IMPLICIT FEEDBACK

Not all feedback is explicit. Implicit signals: the user accepted the draft, edited heavily, regenerated, copied the answer, ignored the AI, clicked the source, escalated, undid the action, abandoned the workflow, or asked a follow-up.

These signals help measure usefulness, but be careful, copying an answer does not always mean it was correct.

[!] Implicit feedback is useful, but interpret it carefully.

>> Explicit feedback is what users tell you directly. Implicit feedback is what their behavior tells you whether they meant to or not, both matter, and neither alone is the full picture.$D8ac408b8_f17e_4803_87db_5c53908b0154$ where id = '8ac408b8-f17e-4803-87db-5c53908b0154';

update lessons set content = $Da044694e_5271_44ed_a63c_b6910707d96b$TRUST CALIBRATION

The goal is not maximum trust. The goal is appropriate trust. Over-trust means the user accepts wrong AI output. Under-trust means the user ignores useful AI output.

Good UX helps users know when to trust, verify, edit, or escalate. Trust calibration tools: sources, confidence explanation, human review, clear limitations, editability, feedback, risk labels, audit trail, consistent behavior.

**Good AI UX creates calibrated trust.**


EXPLAINABILITY

Explainability means helping users understand why AI gave an output. Examples: "recommended because customer mentioned damaged item and policy section 4 applies." "Escalated because order value exceeds approval threshold." "Classified as Billing because customer says they were charged twice." "Confidence is low because no delivery date was found."

Explainability is especially useful when AI influences decisions.

[!] Explain the reason when the user needs to decide, approve, or trust.

>> Trust calibration is the overall goal. Explainability is one of its most important tools, a well-explained answer is much easier to trust the right amount.$Da044694e_5271_44ed_a63c_b6910707d96b$ where id = 'a044694e-5271-44ed-a63c-b6910707d96b';

update lessons set content = $D696fbdf0_abd0_4f7c_8f13_b68595909094$AI INSIDE EXISTING TOOLS

AI is most useful when it lives where work happens, in the support console, in the CRM, in the analytics dashboard, in the document editor, in the email composer, in the code editor, in the project management tool, in the search experience.

Bad UX: the user must copy-paste between tools. Good UX: AI has the right context and returns output where the user needs it.

**The best AI UX often disappears into the workflow.**


DESIGNING AI SEARCH UX

AI search is different from normal search. Normal search returns links. AI search may return a direct answer, a summary, sources, suggested follow-ups, related documents, and confidence/limitations.

Good AI search UX should include the answer, sources, a "view source" link, follow-up suggestions, "not enough info" behavior, feedback, and the ability to refine the query.

PM question: **"Does AI search help users verify, not just answer?"**

>> "AI inside existing tools" is the general placement principle; AI search UX is one of the specific interfaces that principle gets applied to.$D696fbdf0_abd0_4f7c_8f13_b68595909094$ where id = '696fbdf0-abd0-4f7c-8f13-b68595909094';

update lessons set content = $Dc3e33e34_6f0d_4a49_aa81_139e056f585f$DESIGNING AI WRITING UX

AI writing UX should support the writer. Good features: draft, rewrite, shorten, expand, change tone, make executive-ready, make simpler, convert to bullets, suggest a subject line, preserve meaning, compare versions.

Important rule: for business writing, AI should not add unsupported facts.

**Writing AI should improve expression, not invent substance.**


DESIGNING AI SUMMARIZATION UX

Summaries must be trustworthy. Good summarization UX includes a clear summary type, length control, source references, action items, owners/deadlines, missing-information labels, the ability to expand, and a link back to the original.

Example summary types: executive summary, action-item summary, customer issue summary, decision summary, risk summary.

PM question: **"What kind of summary does this user actually need?"**

>> Writing UX and summarization UX are two sides of the same coin, one expands input into more polished output, the other compresses it into less, and both share the same rule against inventing content that was not there.$Dc3e33e34_6f0d_4a49_aa81_139e056f585f$ where id = 'c3e33e34-6f0d-4a49-aa81-139e056f585f';

update lessons set content = $D31f8636a_8183_4d27_b04d_5b429682a9a3$DESIGNING AI ANALYTICS UX

Analytics AI is risky because wrong numbers can mislead decisions. Good analytics AI UX shows the query used, the data source, the metric definition, separates facts from hypotheses, allows analyst review, shows a chart/table, avoids unsupported causality, flags missing data, and links to the dashboard.

Bad: "revenue dropped because of pricing." Better: "revenue dropped 8% week over week. The data shown here does not prove cause. Possible drivers to investigate: traffic decline, conversion drop, pricing change, or product mix."

[!] Analytics AI must not hallucinate numbers or causes.


DESIGNING AI SUPPORT UX

Support AI must protect customer trust. Good support AI UX retrieves approved policy, shows source, drafts reply, flags risky cases, requires approval before send, shows customer context, avoids unsupported promises, escalates legal/safety/angry cases, and logs the final answer.

Metrics: agent acceptance, resolution time, CSAT, wrong-answer rate, escalation quality.

PM question: **"Should AI answer the customer directly, or assist the agent first?"**

>> Both domains share the same underlying risk: a confident, wrong output that a user acts on before checking it, the UX design in each case exists specifically to slow that down.$D31f8636a_8183_4d27_b04d_5b429682a9a3$ where id = '31f8636a-8183-4d27-b04d-5b429682a9a3';

update lessons set content = $D33dcb642_3d7b_4adf_a3c5_bf6228cc9682$DESIGNING AI DOCUMENT UX

Document AI should handle long and complex information. Good UX highlights source passages, extracts fields into a structured table, shows confidence by field, lets the user correct fields, links each extracted value to source, flags missing or ambiguous fields, preserves the original document, and escalates high-risk fields.

Example: invoice extraction should show where the total amount came from.

**For document AI, every important extracted answer should trace back to the document.**


DESIGNING AI RECOMMENDATION UX

AI recommendations should be understandable and controllable. Good recommendation UX explains "why this," allows feedback, allows hide/not-interested, provides diversity, avoids repetition, respects preferences, makes sponsored/business-driven items clear, and avoids creepy personalization.

Example explanations: "because you viewed hiking shoes." "Popular with users who bought this." "New in a category you follow." "Similar to your saved items."

PM question: **"Does the user feel helped or manipulated?"**

>> Document UX earns trust through traceability back to a source document. Recommendation UX earns trust through traceability back to a stated reason, the same "show your work" principle applied to two very different outputs.$D33dcb642_3d7b_4adf_a3c5_bf6228cc9682$ where id = '33dcb642-3d7b-4adf-a3c5-bf6228cc9682';

update lessons set content = $D5f228ecb_146c_4a3c_8caa_34f1c41da772$AI UX should work for different users. Consider language, reading level, screen readers, keyboard navigation, voice input/output, color contrast, cognitive load, different accents, different technical skill levels, mobile vs. desktop, and low-bandwidth environments.

Microsoft's responsible AI principles include inclusiveness alongside fairness, reliability/safety, privacy/security, transparency, and accountability.

[!] AI should reduce barriers, not create new ones.

>> Accessibility is not a separate checklist tacked onto AI UX, every pattern covered earlier in this module (capability disclosure, confirmation design, error messages) needs to actually work for a screen reader user, a non-native speaker, and a low-bandwidth connection, not just for the design team's own setup.$D5f228ecb_146c_4a3c_8caa_34f1c41da772$ where id = '5f228ecb-146c-4a3c-8caa-34f1c41da772';

update lessons set content = $D688ea5b9_9bab_48ff_94ae_753ff6b83db0$EDIT DISTANCE

Edit distance measures how much the user changes AI output. Example: AI drafts an email, the user edits 80% of it, that may mean the draft was poor. If the user edits only 10%, it may be useful.

But interpret carefully. Low edit distance does not always mean correct, the user may accept wrong output. So combine edit distance with human rating, accuracy checks, source correctness, business outcome, and user satisfaction.

**Edit distance measures usefulness, not truth.**


ACCEPTANCE RATE

Acceptance rate measures how often users accept AI output, an agent accepts a support draft, a user inserts an AI summary, a sales rep uses an account brief, an analyst accepts generated SQL, a PM uses generated release notes.

High acceptance can show value, but again, acceptance does not guarantee correctness.

PM question: **"Are users accepting because the output is good, or because they over-trust AI?"**

>> Both metrics have the exact same blind spot: they measure whether users liked the output, not whether the output was actually right, this is why implicit feedback always needs pairing with an accuracy check.$D688ea5b9_9bab_48ff_94ae_753ff6b83db0$ where id = '688ea5b9-9bab-48ff-94ae-753ff6b83db0';

update lessons set content = $D4529aeaf_421f_469d_9529_b112cbe4b3df$TIME SAVED

Time saved is a strong AI UX metric. Example: before AI, an agent spends 8 minutes writing a response; after AI, the agent reviews a draft in 3 minutes, 5 minutes saved per ticket.

But measure end-to-end. Do not count only generation time, include reading, reviewing, editing, verifying sources, correcting errors, approving, and escalating.

[!] AI saves time only if total workflow time decreases.


COMMON AI UX FAILURE MODES

A chatbot slapped onto the product with no workflow integration. Vague capability, where the user does not know what AI can do. No source visibility, so the user cannot verify output. No edit control, so the user cannot fix output easily. Auto-action too early, taking risky action without approval. Poor failure states, leaving the user unsure what went wrong. Overconfident answers that hide uncertainty. Too much review burden, where AI creates more work than it saves. Creepy personalization, making the user feel watched or manipulated. No feedback loop, so the product team cannot learn from failures.

>> Time saved is the metric this whole module is ultimately trying to protect; every failure mode in this lesson's list is a specific way a feature can quietly erase it.$D4529aeaf_421f_469d_9529_b112cbe4b3df$ where id = '4529aeaf-421f-469d-9529-b112cbe4b3df';

update lessons set content = $Ddf292290_4c76_436e_970e_294fda114855$A good AI UX process: map the workflow, identify user pain, decide the AI's role, choose the interaction pattern, define data/context, define the output, define control points, define the risk level, design feedback and correction, prototype, test with real users, evaluate quality and usefulness, add guardrails, roll out gradually, and monitor after launch.

Google's People + AI Guidebook is built as a practical guide for creating useful, responsible AI applications and includes UX/ML guidance, patterns, and workshops.

[!] This fifteen-step process is essentially every lesson in this module, in the order you would actually apply them to a real feature.

>> Treat this lesson as the table of contents for the whole module, each step maps to a cluster of lessons already covered.$Ddf292290_4c76_436e_970e_294fda114855$ where id = 'df292290-4c76-436e-970e-294fda114855';

update lessons set content = $D9e5307e4_c31c_49ce_b2c0_e3255f58f2e8$Before designing AI UX, ask: what workflow are we improving, and what user pain are we solving? Is AI the right solution? Should this be chat, button, inline, panel, or agent? What does the user already know, and what context should AI know? What should the user provide, and what output format is most useful? Should output be editable? Should AI show sources, confidence, or uncertainty? What actions require confirmation or human approval? Can users undo AI actions? How does AI fail gracefully, and how does it hand off to humans? How do users give feedback? How do we measure usefulness and safety? How do we prevent over-trust?

[!] This checklist is the general-purpose version; the next two lessons specialize it for copilots and agents specifically.

>> Walk through this checklist for any new AI feature before a single mockup gets drawn, most of the failure modes covered earlier in this module trace back to a question on this list that was never asked.$D9e5307e4_c31c_49ce_b2c0_e3255f58f2e8$ where id = '9e5307e4-c31c-49ce-b2c0-e3255f58f2e8';

update lessons set content = $Dabe95c71_9203_4346_b7cb_ace2cdd7d4d2$Ask: who is the human user, and what work does the copilot help with? Does it draft, suggest, retrieve, classify, or act? What should the human review, and what should they approve? What should the copilot never do? What sources should it use, and what tools can it access? What does the user see before accepting, and can they edit or reject easily? Can they ask for revision? Are sources visible, and are risky cases escalated? Is the final action logged, and is there a rollback? Does it reduce total workflow time and improve quality? Does it increase user confidence while preserving human accountability?

[!] This checklist is the copilot design principle from earlier in this module, expanded into twenty concrete questions.

>> A copilot that scores well on this checklist is, by construction, reducing cognitive load rather than creating review burden, the two ideas are the same test applied at different levels of detail.$Dabe95c71_9203_4346_b7cb_ace2cdd7d4d2$ where id = 'abe95c71-9203-4346-b7cb-ace2cdd7d4d2';

update lessons set content = $D5aee1cdc_8224_4e53_b75b_8bb1f3e702e3$Ask: what goal does the agent pursue, and what plan does it show? What tools can it use, and what data can it access? What steps are visible to the user? What requires confirmation, and what requires human approval? What can be undone, and what cannot? How does the user stop the agent? How does it handle failure and escalate? What summary does it provide at the end, and what actions are logged? How does the user report a mistake? How do we prevent duplicate actions and prompt injection? How do we monitor unsafe actions? What is the kill switch? What level of autonomy is safe?

[!] Notice how much of this checklist pulls directly from the agents module and the evaluation/safety module, agent UX is where product design and safety engineering meet most directly.

>> An agent that cannot answer most of these questions clearly is not ready for real users, regardless of how good its underlying task performance is.$D5aee1cdc_8224_4e53_b75b_8bb1f3e702e3$ where id = '5aee1cdc-8224-4e53-b75b-8bb1f3e702e3';

update lessons set content = $Ddd3c67ad_c119_4634_8ab1_2c1459843134$HOW TO EXPLAIN AI UX TO LEADERSHIP

Simple explanation: "AI product success is not just model quality. We need to design how users interact with the AI, verify its output, stay in control, and recover from mistakes. The right UX pattern may be a button, inline suggestion, copilot panel, or agent workflow, not always a chatbot."

Support example: "for the support copilot, AI should first summarize the ticket, retrieve policy, and draft a response for agent approval. The UX should show the policy source, let the agent edit, and require approval before sending. We will measure agent acceptance, edit distance, resolution time, CSAT, and wrong-answer rate."

Agent example: "for an AI agent, the UX must show what action the agent plans to take, what data it used, and where human approval is required. The user should be able to stop, edit, approve, or escalate before any high-risk action happens."


THE MEMORY SHORTCUT

AI UX is designing how humans and AI work together. Copilot design is helping humans do work faster and better while keeping them in control. Agent UX is making AI actions visible, controllable, reversible, and safe.

Remember: workflow, then AI role, then interaction pattern, then evidence, then control, then feedback, then metrics.

Use chat when user intent is broad, conversation helps, exploration matters, or natural language is better than menus. Use buttons/panels/inline AI when the task is specific, the workflow is clear, the user needs fast action, or output should appear inside the existing tool. Use a copilot when human judgment matters, drafting/review helps, risk needs approval, or AI should assist but not fully automate. Use an agent when the task is multi-step, tools are needed, the workflow is repeated, and permissions and guardrails are strong.

Watch out for a chatbot slapped onto the product, no capability disclosure, no source visibility, overconfident output, no edit/undo, auto-action too early, poor failure states, too much review burden, weak feedback loops, and creepy personalization.

[!] This module closes the loop on the entire AI/GenAI arc from Modules 16-22, everything about what LLMs, RAG, agents, fine-tuning, and safety can do only matters if the resulting product is actually usable, trustworthy, and controllable by a real person.

>> The most important PM question: does the AI fit naturally into the workflow while keeping the user informed, in control, and able to recover from mistakes?$Ddd3c67ad_c119_4634_8ab1_2c1459843134$ where id = 'dd3c67ad-c119-4634-8ab1-2c1459843134';

update questions set choices = $D48f80717_a767_491c_b509_7d890ff2413aQ$["Model quality alone is not enough for AI product success, AI product design is not just \"add a chatbot,\" it is designing how humans and AI work together safely and usefully, and this feature is missing the trust, control, and recovery elements that make that collaboration work","Correct answers are sufficient for AI product success, and none of these UX gaps matter as long as the output is accurate","This is purely an engineering bug, not a product design issue","Users will naturally figure out how to trust and control an AI feature over time without any UX design needed"]$D48f80717_a767_491c_b509_7d890ff2413aQ$::jsonb where id = '48f80717-a767-491c-b509-7d890ff2413a';

update questions set choices = $D0ae03521_5969_4771_ba70_e1fb0bd37ed4Q$["AI UX is probabilistic, not deterministic, the same input may produce slightly different outputs, unlike a normal UX button click, so AI products need extra design care around uncertainty, trust, explainability, and error recovery that deterministic UX does not require","AI systems always produce identical output for identical input, just like a button click","Deterministic and probabilistic systems require exactly the same design approach","This distinction only matters for agents, not for simpler AI features"]$D0ae03521_5969_4771_ba70_e1fb0bd37ed4Q$::jsonb where id = '0ae03521-5969-4771-ba70-e1fb0bd37ed4';

update questions set choices = $D327eb4c8_4a1f_42f8_be56_6617b4acd444Q$["Start with the core AI UX question: \"where should AI fit in the user's existing workflow?\", asking what the user is trying to accomplish, where they are stuck, and what takes too much time, rather than starting from a specific interface choice like chat","Starting with \"should we add chat\" is the correct first question for any AI product","Chatbots are always the right interface regardless of the underlying workflow","The order in which these questions are asked has no effect on the resulting product design"]$D327eb4c8_4a1f_42f8_be56_6617b4acd444Q$::jsonb where id = '327eb4c8-4a1f-42f8-be56-6617b4acd444';

update questions set choices = $D3c06fb86_94c5_4697_b323_6b41b12a008eQ$["This jumps straight to autopilot (acting with little or no human review) without first building trust through assistant and copilot stages, this lesson recommends moving to autopilot only when the task is low-risk, well-tested, and properly monitored, none of which applies to a brand-new, unproven use case","Autopilot is the correct starting point for any new AI feature, regardless of how proven or low-risk it is","Assistant, copilot, and autopilot are interchangeable terms with no meaningful difference in risk or design","Human review is unnecessary once an AI system has passed basic functional testing"]$D3c06fb86_94c5_4697_b323_6b41b12a008eQ$::jsonb where id = '3c06fb86-94c5-4697-b323-6b41b12a008e';

update questions set choices = $Dc02b98ac_8603_480a_b236_9bc3fb84f5a1Q$["Not every step in a mapped workflow should be automated, this lesson explicitly asks \"where does the user need speed, accuracy, judgment, or control?\" as a way to decide which specific points in the journey are good candidates for AI help versus which should remain human-controlled","Mapping the user journey means every single step should always be automated with AI","User journey mapping is only useful for identifying automation opportunities, not for identifying where humans should retain control","This approach is correct since automating every step always produces the best outcome"]$Dc02b98ac_8603_480a_b236_9bc3fb84f5a1Q$::jsonb where id = 'c02b98ac-8603-480a-b236-9bc3fb84f5a1';

update questions set choices = $Daec99aac_0724_41ec_8b2d_7f61442d4949Q$["Capability disclosure, clearly stating what the AI can and cannot do, like \"I can summarize this ticket, find relevant policy, draft a reply, or suggest next steps,\" since \"ask me anything\" creates unrealistic expectations and leaves users guessing about the AI's actual scope","\"Ask me anything\" is the ideal framing for any AI feature since it maximizes perceived flexibility","Capability disclosure is unnecessary as long as the underlying model is capable enough","Users should be expected to discover an AI feature's capabilities entirely through trial and error"]$Daec99aac_0724_41ec_8b2d_7f61442d4949Q$::jsonb where id = 'aec99aac-0724-41ec-8b2d-7f61442d4949';

update questions set choices = $D20d7ade2_e80a_4d10_b520_efd30f368580Q$["Design a better empty state with example prompt suggestions, like \"summarize this document,\" \"extract action items,\" or \"draft a reply\", a blank chat box is called out as a bad empty state, since good empty states reduce anxiety and show users what to try first","A blank chat box is the ideal empty state design since it gives users maximum creative freedom","Empty state design has no meaningful effect on how users engage with an AI feature","Prompt suggestions should only be generic, like \"ask me anything,\" rather than specific to the user's context"]$D20d7ade2_e80a_4d10_b520_efd30f368580Q$::jsonb where id = '20d7ade2-e80a-4d10-b520-efd30f368580';

update questions set choices = $Dd952ed8b_ecaf_45b0_8802_5ee8811bf1f7Q$["Context awareness, the AI is not using the current page, workflow state, or relevant data to tailor its suggestions to what the user is actually doing, and should instead surface options like \"summarize ticket,\" \"find policy,\" or \"draft reply\" that match the support ticket context","This is expected behavior, since AI suggestions should always be generic and unrelated to the current context","Context awareness only matters for agents, not for suggestion-based AI features","Users should be expected to ignore irrelevant suggestions without any need for the product to adapt them"]$Dd952ed8b_ecaf_45b0_8802_5ee8811bf1f7Q$::jsonb where id = 'd952ed8b-ecaf-45b0-8802-5ee8811bf1f7';

update questions set choices = $D2715b463_bd8b_4204_9878_7152858fadafQ$["Draft-first design, since user-facing communication is involved and the task carries business risk, the AI should draft the email and let a human review and send it, rather than auto-sending immediately, since draft is safer than auto-send","Auto-sending immediately is the recommended approach for any AI-generated customer communication","Draft-first design is only relevant for internal communications, not customer-facing ones","Review steps should be skipped whenever the AI-generated content appears well-written"]$D2715b463_bd8b_4204_9878_7152858fadafQ$::jsonb where id = '2715b463-bd8b-4204-9878-7152858fadaf';

update questions set choices = $D1da9e33f_2dec_43e1_84f0_053244bfd23cQ$["Good source visibility, sources should show the source title, the relevant excerpt, a link to the full source, and make citation easy to verify, none of which this vague \"Company Policy\" label provides, making it hard for the user to verify the answer quickly","This citation is sufficient, since any citation label is better than no citation at all regardless of detail","Source visibility only matters for RAG-based products, not for general AI features that cite sources","Users should be expected to search for the source themselves without any excerpt or link provided"]$D1da9e33f_2dec_43e1_84f0_053244bfd23cQ$::jsonb where id = '1da9e33f-2dec-43e1-84f0-053244bfd23c';

update questions set choices = $Dfa497a00_073c_4ee7_843a_a144f01562e3Q$["Show progress messages like \"searching policy…\", \"checking order…\", \"drafting response…\", for longer tasks, especially multi-step agent tasks, progress visibility is critical to help users trust the system and understand what is happening while they wait","A generic spinner is always sufficient regardless of how long or how many steps the AI task involves","Progress visibility is only relevant for chat-based AI features, not for agent workflows","Users do not need any indication of what the AI is doing during a wait, regardless of task length"]$Dfa497a00_073c_4ee7_843a_a144f01562e3Q$::jsonb where id = 'fa497a00-073c-4ee7-843a-a144f01562e3';

update questions set choices = $Dc9877f57_7303_4cb6_965e_62cec5e7e654Q$["This is review burden, a copilot is useful only if review time is lower than manual work time, and if reviewing the AI draft actually takes longer than writing from scratch, the copilot is creating more work than it saves, even though the drafts are technically editable","This is expected and acceptable behavior for any AI copilot, since editing is always part of the workflow regardless of how long it takes","Editability and review burden are the same concept, so having an editable draft automatically means review burden is low","This problem cannot occur as long as the AI output is factually accurate"]$Dc9877f57_7303_4cb6_965e_62cec5e7e654Q$::jsonb where id = 'c9877f57-7303-4cb6-965e-62cec5e7e654';

update questions set choices = $Dc15a1166_8cbc_4f22_9261_fe2e77d0e2b1Q$["This is implicit feedback, and it should be interpreted carefully, copying an answer does not always mean it was correct, so this signal alone should not be treated as proof of accuracy without combining it with other evaluation methods like human rating or accuracy checks","Copying an AI answer is explicit feedback that definitively proves the answer was correct","Implicit feedback signals like this should always be taken at face value with no need for careful interpretation","Users clicking or not clicking a source link has no relationship to feedback about the AI's usefulness"]$Dc15a1166_8cbc_4f22_9261_fe2e77d0e2b1Q$::jsonb where id = 'c15a1166-8cbc-4f22-9261-fe2e77d0e2b1';

update questions set choices = $D7f6fa8ca_357c_40e7_ad05_825d486bc479Q$["Calibrated trust, not maximum or zero trust, the goal is appropriate trust, where good UX (like showing sources, confidence explanations, and clear limitations) helps users know when to trust, verify, edit, or escalate, avoiding both over-trust and under-trust","Maximum trust is always the correct goal, and the product should be designed to get users to accept AI output as often as possible","Zero trust is the safest approach, and products should be designed to make users independently verify everything regardless of context","Trust calibration is not a real design consideration and this pattern of behavior cannot be influenced by product design"]$D7f6fa8ca_357c_40e7_ad05_825d486bc479Q$::jsonb where id = '7f6fa8ca-357c-40e7-ad05-825d486bc479';

update questions set choices = $D91344bc4_0c32_4a37_a756_9bc7733ae794Q$["This is a bad handoff, a good handoff should include the user request, an AI summary, sources checked, tools used, missing information, the reason for escalation, and a recommended next step, so the human reviewer does not have to start their investigation from scratch","This handoff message is sufficient, since the human reviewer is expected to start their own independent investigation regardless of what the AI found","Human handoff design has no effect on how much time the human reviewer spends resolving the issue","Providing a reason for escalation is only necessary for agent-based systems, not for simpler AI assistants"]$D91344bc4_0c32_4a37_a756_9bc7733ae794Q$::jsonb where id = '91344bc4-0c32-4a37-a756-9bc7733ae794';

update questions set choices = $Dbf5006d0_7ac5_4c76_bfd0_a0464f9b9a5eQ$["AI memory UX, users should be able to understand and control what the AI remembers, including whether they can edit it, delete it, turn memory off, and know whether sensitive data is included, since memory can feel helpful or creepy depending on whether it is designed for consent and control","Memory should always operate silently in the background with no user-facing controls, since this creates the smoothest experience","Users do not need to know what an AI system remembers about them as long as the remembered information improves output quality","Memory UX only matters for enterprise AI products, not for consumer-facing assistants"]$Dbf5006d0_7ac5_4c76_bfd0_a0464f9b9a5eQ$::jsonb where id = 'bf5006d0-7ac5-4c76-bfd0-a0464f9b9a5e';

update questions set choices = $Dfcb6d36d_2da6_443a_a14e_2716fbda8d7dQ$["Good permission UX, which should explain what access is requested, why it is needed, what action the AI will take, whether access is one-time or ongoing, and how to revoke it, none of which this vague permission request provides, leaving the user unable to make an informed decision","This permission request is sufficient, since users do not need to understand why access is being requested as long as the AI eventually completes the task","Permission UX is unnecessary for internal, low-risk features like calendar access","Revocation options are not a meaningful part of permission UX design"]$Dfcb6d36d_2da6_443a_a14e_2716fbda8d7dQ$::jsonb where id = 'fcb6d36d-2da6-443a-a14e-2716fbda8d7d';

update questions set choices = $D7acdb666_3693_455b_b5ae_4764c90c239dQ$["Agent UX with visible plans and progress, good agent UX shows the goal, plan, steps, and progress so the user can catch a mistake early, such as noticing the agent checking the wrong order number before it takes an irreversible action, rather than only seeing the outcome after the fact","Nothing is missing, since showing only the final result is the ideal UX for any agent, regardless of task complexity","Progress visibility is only useful for entertainment value and does not affect the user's ability to catch errors","Agents should never show their plan or steps, since this would overwhelm and confuse the user"]$D7acdb666_3693_455b_b5ae_4764c90c239dQ$::jsonb where id = '7acdb666-3693-455b-b5ae-4764c90c239d';

update questions set choices = $D8598f444_6d8b_427f_b6f8_aa79db7c9c68Q$["Specific confirmation design that includes the action, target, consequence, whether it is reversible, and risk level, for example, \"Approve sending this email to Priya Shah about Order #123? This will notify the customer and update the ticket status,\" since good confirmation should confirm the consequence, not just the click","A generic \"Are you sure?\" dialog is sufficient for any AI action regardless of its consequences","Confirmation dialogs should be avoided entirely since they slow down the workflow","Specific confirmation details are only necessary for agent-based systems, not for simpler AI features"]$D8598f444_6d8b_427f_b6f8_aa79db7c9c68Q$::jsonb where id = '8598f444-6d8b-427f-b6f8-aa79db7c9c68';

update questions set choices = $D1a673086_81e9_41b6_a826_12a5ed0c0848Q$["This violates the principle that AI is most useful when it lives where work happens, good UX means AI has the right context and returns output where the user needs it, and requiring users to copy-paste between tools is called out as bad UX; the best AI UX often disappears into the existing workflow","Requiring users to switch between separate tools is the recommended approach for any AI feature, since it keeps concerns cleanly separated","This design has no meaningful effect on user experience or adoption as long as the AI output itself is high quality","AI features should always exist as separate, standalone tools rather than being embedded inside existing workflows"]$D1a673086_81e9_41b6_a826_12a5ed0c0848Q$::jsonb where id = '1a673086-81e9-41b6-a826-12a5ed0c0848';

update questions set choices = $D075dc2f9_3942_4b8a_a26e_30cabe7d940fQ$["Writing AI should improve expression, not invent substance, for business writing, AI should not add unsupported facts, and adding a discount detail that was not in the original draft or any source is exactly the kind of substance-inventing behavior this lesson warns against","Adding helpful new information like a discount is a positive and expected behavior for AI writing assistants","This behavior is only a problem if the added fact happens to be factually incorrect, not if it is simply unsupported by the original content","Writing AI is expected to add supporting details regardless of whether they were present in the source material"]$D075dc2f9_3942_4b8a_a26e_30cabe7d940fQ$::jsonb where id = '075dc2f9-3942-4b8a-a26e-30cabe7d940f';

update questions set choices = $D6e1eb67c_9328_45e8_9392_fcd94fe47054Q$["This is exactly the kind of unsupported causality this lesson warns against, good analytics AI UX should separate facts from hypotheses and avoid unsupported causality, presenting something like \"revenue dropped 8%; the data does not prove cause; possible drivers to investigate include pricing, traffic, and conversion\" instead of stating a cause as settled fact","Stating a definitive cause like this is acceptable as long as the revenue drop percentage itself is accurate","Analytics AI is expected to identify a single definitive cause for any metric change to be useful to executives","This behavior is only a problem if the executive acts on the information without further investigation"]$D6e1eb67c_9328_45e8_9392_fcd94fe47054Q$::jsonb where id = '6e1eb67c-9328-45e8-9392-fcd94fe47054';

update questions set choices = $Dcecfcc70_30fb_4aa0_87a8_85a1b90b827fQ$["Traceability back to the source document, for document AI, every important extracted answer should trace back to the document, and this lesson specifically uses invoice extraction as the example: the total amount should show where in the document it came from so the user can verify it","This is acceptable behavior since document extraction tools are expected to be fully trusted without any traceability","Traceability to source is only necessary for RAG-based chat features, not for document extraction tools","Users should independently re-read the entire original document rather than expecting the AI to show where extracted values came from"]$Dcecfcc70_30fb_4aa0_87a8_85a1b90b827fQ$::jsonb where id = 'cecfcc70-30fb-4aa0-87a8-85a1b90b827f';

update questions set choices = $D05ff4f2c_c8ec_4342_a40e_84f24fd7502eQ$["This is a gap in accessibility and inclusive AI UX, AI UX patterns like capability disclosure, confirmation design, and error messages need to actually work for screen reader users, non-native speakers, and low-bandwidth connections, not just for the design team's own setup, since AI should reduce barriers, not create new ones","Accessibility only needs to be considered for traditional UX features, not for AI-specific UX patterns like confirmation dialogs or error messages","This approach is acceptable as long as the majority of users are unaffected by these gaps","Inclusive design principles do not apply to AI products in the same way they apply to traditional software"]$D05ff4f2c_c8ec_4342_a40e_84f24fd7502eQ$::jsonb where id = '05ff4f2c-c8ec-4342-a40e-84f24fd7502e';

update questions set choices = $D1ac3825a_785f_418b_bf83_cb2b7f637b0cQ$["Safety metrics, this lesson explicitly lists five metric categories (adoption, efficiency, quality, trust/satisfaction, and safety), and a feature can look great on adoption and satisfaction while quietly failing on safety, so measuring both usefulness and safety is necessary for a complete picture","Adoption and CSAT alone are sufficient to declare an AI feature fully successful","Safety metrics are only relevant for agent-based features, not for features with high user satisfaction","Efficiency and quality metrics are redundant with adoption and trust metrics, so tracking all five categories is unnecessary"]$D1ac3825a_785f_418b_bf83_cb2b7f637b0cQ$::jsonb where id = '1ac3825a-785f-418b-bf83-cb2b7f637b0c';

update questions set choices = $Da90e5f76_e063_4cb5_935d_fbe4eb48eb4cQ$["Low edit distance measures usefulness, not truth, users may accept wrong output without editing it, so low edit distance alone does not guarantee correctness, and it should be combined with human rating, accuracy checks, and source correctness rather than treated as proof of accuracy on its own","Low edit distance is definitive proof that AI output is accurate and requires no further verification","Edit distance and accuracy are the same metric and always move together in the same direction","This conclusion is valid as long as the acceptance rate is also high"]$Da90e5f76_e063_4cb5_935d_fbe4eb48eb4cQ$::jsonb where id = 'a90e5f76-e063-4cb5-935d-fbe4eb48eb4c';

update questions set choices = $Da8835dbc_d113_4206_b652_3a699c5fede7Q$["Time saved should be measured end-to-end, including reading, reviewing, editing, verifying sources, correcting errors, approving, and escalating, not just generation time, AI only saves time if total workflow time decreases, and generation speed alone does not capture that","Measuring only generation time is the correct and complete way to calculate time saved for any AI feature","Review, editing, and verification time should never be included in time-saved calculations since they are considered separate from the AI feature itself","This measurement approach is valid as long as the AI generates output quickly"]$Da8835dbc_d113_4206_b652_3a699c5fede7Q$::jsonb where id = 'a8835dbc-d113-4206-b652-3a699c5fede7';

update questions set choices = $D3da5a7ab_c125_4fba_aa37_1d6f020c1bb0Q$["Several of the earlier steps in the fifteen-step process, mapping the workflow, identifying user pain, deciding the AI's role, defining control points and risk level should happen before prototyping, since this process is meant to be followed roughly in order, and skipping straight to building risks missing foundational product decisions","Prototyping and building are the only steps that actually matter, and the earlier planning steps are optional","The order of these fifteen steps has no bearing on the quality of the resulting AI feature","Workflow mapping and risk-level definition are only relevant for agent-based features, not for simpler AI products"]$D3da5a7ab_c125_4fba_aa37_1d6f020c1bb0Q$::jsonb where id = '3da5a7ab-c125-4fba-aa37-1d6f020c1bb0';

update questions set choices = $D2f83314e_0bed_4d92_a66e_0b8eb15fadbeQ$["Ask \"where do you need help?\" instead of only \"would you use AI?\", this lesson explicitly warns against asking only the generic adoption-interest question, and recommends asking about slow workflow parts, hard decisions, trusted sources, and acceptable versus serious mistakes to actually identify where AI would help","\"Would you use AI here?\" is the single most important and sufficient question for AI product user research","User research is unnecessary for AI products since prototype testing alone is sufficient","Asking about acceptable versus serious mistakes is not a relevant question for AI product user research"]$D2f83314e_0bed_4d92_a66e_0b8eb15fadbeQ$::jsonb where id = '2f83314e-0bed-4d92-a66e-0b8eb15fadbe';

update questions set choices = $Dd6032cdf_6cd1_4605_a00b_980e770ab110Q$["No, the PM checklist for AI UX includes many additional questions beyond interface choice, such as whether output should be editable, whether sources and confidence should be shown, what requires confirmation or approval, and how usefulness and safety will be measured, none of which have been addressed here","Yes, since choosing the interface pattern (chat) is the only decision required before launching an AI feature","Editability and source visibility are optional considerations that do not need to be addressed before launch","This checklist only applies to copilot and agent features, not to simpler chat-based AI features"]$Dd6032cdf_6cd1_4605_a00b_980e770ab110Q$::jsonb where id = 'd6032cdf-6cd1-4605-a00b-980e770ab110';

update questions set choices = $D8c9fa6a0_5e72_425c_be82_3ffce2bfa1abQ$["All three gaps, the checklist explicitly includes what the copilot should never do, whether sources are visible, and whether the final action is logged, all of which help ensure the copilot reduces cognitive load rather than creating review burden, and preserves human accountability","None of these gaps matter as long as the copilot successfully drafts useful content","Only logging the final action matters; source visibility and defining forbidden actions are optional for copilots","This checklist only applies to fully autonomous agents, not to copilots that require human review"]$D8c9fa6a0_5e72_425c_be82_3ffce2bfa1abQ$::jsonb where id = '8c9fa6a0-5e72-425c-be82-3ffce2bfa1ab';

update questions set choices = $D8d665092_2414_41fa_9be0_2b3d9c29a801Q$["No, the checklist explicitly asks about the kill switch, what requires human approval, and how prompt injection is prevented, all of which are unaddressed here; this checklist pulls directly from agent design and safety concepts, since agent UX is where product design and safety engineering meet most directly","Yes, since these three items are optional extras that do not affect whether an agent is ready for real users","Kill switches and approval requirements are only relevant for read-only agents, not for action-taking agents","Prompt injection testing is a purely technical concern unrelated to agent UX design"]$D8d665092_2414_41fa_9be0_2b3d9c29a801Q$::jsonb where id = '8d665092-2414-41fa-9be0-2b3d9c29a801';

update questions set choices = $D6f053195_ed6c_492d_bcd9_e2f5d6c553dfQ$["Explain that AI product success is not just model quality, the team needs to design how users interact with the AI, verify its output, stay in control, and recover from mistakes, since a good model can still fail in production if users cannot trust it, understand it, or undo its mistakes","Model performance in testing is the only factor that determines whether an AI feature is ready to ship","Confirmation flows, source visibility, and undo mechanisms are nice-to-have polish items that can always be safely skipped or added much later","UX design work is only necessary for chat-based AI features, not for simpler AI-powered capabilities"]$D6f053195_ed6c_492d_bcd9_e2f5d6c553dfQ$::jsonb where id = '6f053195-ed6c-492d-bcd9-e2f5d6c553df';
