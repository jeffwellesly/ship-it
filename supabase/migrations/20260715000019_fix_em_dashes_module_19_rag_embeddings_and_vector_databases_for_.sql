-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 19: RAG, Embeddings, and Vector Databases for PMs
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update modules set description = $M$The retrieval-side deep dive completing Modules 16-18, how RAG connects LLMs to trustworthy knowledge, from embeddings and chunking through failure modes and launch readiness.$M$ where id = '5288877a-2272-4e62-8806-50b9630854bd';

update lessons set content = $D3bf49241_a508_451a_ade1_4a1b03e4c82d$WHAT ARE EMBEDDINGS?

Embeddings are numeric representations of meaning. OpenAI describes an embedding as a vector, or list of floating-point numbers, that represents relatedness between text strings.

Example: "How do I return a damaged product?" and "My item arrived broken. Can I get a refund?" have similar meaning. Even though the words are different, embeddings can place them close together in meaning space.

**Embeddings turn meaning into numbers.**


WHY EMBEDDINGS MATTER

Traditional keyword search depends on exact words. If the user searches "money back for broken item" but the policy says "refund eligibility for damaged merchandise," keyword search may miss it.

Embedding search can understand that "money back" is close to "refund," and "broken item" is close to "damaged merchandise." This is why embeddings are useful for semantic search.

[!] OpenAI's embedding guide notes embeddings can be used for search, clustering, recommendations, anomaly detection, and classification, RAG is just one of many embedding use cases.

>> Embeddings are the reason RAG can find the right document even when the user's words do not match the document's words.$D3bf49241_a508_451a_ade1_4a1b03e4c82d$ where id = '3bf49241-a508-451a-ade1-4a1b03e4c82d';

update lessons set content = $D21e81eea_b2ea_4a17_ae9c_69c1acbc8991$GOLDEN DATASET FOR RAG

A golden dataset is a trusted test set. For RAG, it should include user questions, correct answers, correct source documents, correct source sections, acceptable citations, edge cases, questions with no answer, permission-sensitive cases, and outdated-document traps.

Example: question "can damaged items be returned after 45 days?", correct source is Refund Policy section 4 and exception section 5, expected answer: no standard exception found, escalate.

PM question: **"Do we have test questions with known correct sources and answers?"**


QUESTIONS WITH NO ANSWER

A good RAG system should know when the sources do not answer. Bad behavior: the model guesses. Good behavior: "the provided sources do not contain enough information to answer this."

This matters because not every user question will be answerable.

[!] PM question: "Does the model refuse or escalate when retrieval does not contain the answer?" This is a key hallucination control, and it belongs explicitly in the golden dataset, not left to chance.

>> A golden dataset that only tests answerable questions misses half the point, the questions with no answer are where hallucination risk actually lives.$D21e81eea_b2ea_4a17_ae9c_69c1acbc8991$ where id = '21e81eea-b2ea-4a17-ae9c-69c1acbc8991';

update lessons set content = $D41170245_bac9_4a3c_ab15_c4e461bf4c32$WHY THIS MODULE MATTERS

LLMs are powerful, but they have one big weakness: they do not automatically know your private, latest, or company-specific information.

An LLM may not know your company policy, product documentation, customer account status, internal process rules, latest pricing, contract terms, support history, new feature details, or updated compliance rules.

If you ask the model without giving it trusted context, it may guess, that creates hallucination risk.

RAG solves this problem by giving the model relevant source information before it answers.

**RAG helps AI answer from your knowledge, not just from its memory.**


WHAT IS RAG?

RAG stands for **Retrieval-Augmented Generation**.

Break it into two parts. Retrieval: the system searches for relevant information, for example, the refund policy, product docs, or customer records. Augmented generation: the LLM uses the retrieved information to generate a better answer.

Microsoft describes RAG as a pattern where a search system retrieves grounding data and passes it to a language model so the model can generate responses based on your content.

**RAG means search first, answer second.**


THE SIMPLEST MENTAL MODEL

Imagine a smart customer support agent. A bad agent answers from memory: "I think the return window is 60 days." A good agent first checks the official policy: "The return window is 30 days for damaged items, according to policy section 4."

RAG makes AI behave more like the good agent. It first retrieves relevant information, then answers using that information.

[!] The goal is not just a fluent answer. The goal is a grounded answer, one you can trace back to a real source.

>> RAG in one line: retrieve the relevant evidence first, then let the model write the answer from it.$D41170245_bac9_4a3c_ab15_c4e461bf4c32$ where id = '41170245-bac9-4a3c-ab15-c4e461bf4c32';

update lessons set content = $Dcaefd676_ef05_4cdd_b82c_4c138acfc12a$WHY LLM MEMORY IS NOT ENOUGH

LLMs are trained on large datasets, but training data has limits. The model may not know information created after training, private company documents, user-specific records, internal policies, live data, region-specific rules, or exact database values.

Also, even if the model has seen related information, it may still generate an incorrect answer.

**Use the LLM for language and reasoning. Use retrieval and tools for truth.**


WHEN SHOULD YOU USE RAG?

Use RAG when the answer depends on specific knowledge.

Good use cases: customer support (answers from approved policy), internal knowledge search (answers from company docs), product documentation Q&A (answers from current docs), legal document review (answers from contract clauses), HR policy assistant (answers from the employee handbook), sales enablement (answers from latest playbooks), finance operations (answers from invoices and reports), technical support (answers from troubleshooting docs), healthcare or regulated workflows (answers need source grounding), and compliance review (answers need traceability).

[!] Use RAG when accuracy matters, information changes often, sources are private, citations are needed, users need to verify the answer, or the model should not guess.

>> If a wrong answer would embarrass you, cost money, or create legal risk, and the answer depends on a source document, that is a RAG problem.$Dcaefd676_ef05_4cdd_b82c_4c138acfc12a$ where id = 'caefd676-ef05-4cdd-b82c-4c138acfc12a';

update lessons set content = $D86d83990_4071_4564_9943_78618676f5fb$WHEN RAG MAY NOT BE NEEDED

RAG is not always required. You may not need it when the task is pure writing or rewriting, the answer does not depend on private or current facts, the model already has enough context from the user, the task is creative brainstorming, you are generating drafts that humans will heavily edit, a simple database lookup is enough, or deterministic rules are better.

Example: "rewrite this email professionally" needs no RAG. "What is the customer's refund eligibility based on our latest policy and order history?" needs RAG or tools.


RAG VS. NORMAL SEARCH

Normal search returns documents or links. RAG returns an answer using retrieved documents.

Normal search: user asks "what is our refund policy for damaged items?", system returns policy article 1, FAQ page 2, support guideline 3.

RAG: system retrieves those sources and generates: "damaged items can be returned within 30 days if the customer provides proof of damage. This is based on Refund Policy section 4."

[!] Search finds documents. RAG uses documents to answer. Knowing which one your users actually need is the first product decision.

>> Not every AI feature needs RAG, but any feature where a wrong guess is costly, and the truth lives in a document, almost certainly does.$D86d83990_4071_4564_9943_78618676f5fb$ where id = '86d83990-4071-4564-9943-78618676f5fb';

update lessons set content = $Dbd2328bb_fe12_4bd4_bfa1_0af771a1d510$RAG VS. FINE-TUNING

This is one of the most important decisions.

Use RAG when you need knowledge, policies, product docs, contracts, customer records, internal documents, updated procedures, current facts. RAG gives information at answer time.

Use fine-tuning when you need behavior, specific tone, specific format, specialized classification, company writing style, consistent structured output, repeated task pattern. Fine-tuning changes model behavior.

**RAG gives the model knowledge. Fine-tuning changes how the model behaves.** Often, strong AI products use both.


RAG VS. LONG CONTEXT

Some models can accept very long context, so you may ask: "why not just put all documents into the prompt?"

Problems: cost increases, latency increases, the model may miss details, too much irrelevant context confuses the answer, access control becomes harder, updating documents becomes messy, and long prompts may still exceed context limits.

RAG is more efficient because it retrieves only the most relevant pieces.

[!] Long context is a bigger bucket. RAG is a smarter way to fill a smaller bucket with only what matters.

>> Long context gives the model more text. RAG gives the model the right text.$Dbd2328bb_fe12_4bd4_bfa1_0af771a1d510$ where id = 'bd2328bb-fe12-4bd4-bfa1-0af771a1d510';

update lessons set content = $D3f9d931b_8437_4c03_adf1_5c7e6b8517be$THE TWO PHASES OF RAG

RAG has two major phases: an indexing phase and a query phase.

The indexing phase happens before the user asks, the system prepares documents for search. The query phase happens when the user asks a question, the system retrieves relevant information and gives it to the LLM.

**Index first. Retrieve later.**


INDEXING PHASE: STEP BY STEP

The indexing phase usually works like this: collect documents, clean documents, split documents into chunks, convert chunks into embeddings, store embeddings in a vector database or search index, store metadata and source information, and keep the index updated.

Microsoft's Azure Files RAG overview describes RAG pipelines as converting documents into vector embeddings, storing them in a searchable vector database, and using an LLM to generate responses grounded in retrieved content.


QUERY PHASE: STEP BY STEP

When the user asks a question: the question is converted into an embedding, the system searches for similar document chunks, relevant chunks are retrieved, an optional re-ranker improves ordering, retrieved chunks are inserted into the prompt, the LLM generates an answer, the answer may include citations, and the system may validate or escalate.

[!] Simple flow: question, then search, then retrieve sources, then generate answer, then cite sources.

>> Indexing happens once (and gets refreshed periodically). Retrieval happens on every single question. Most RAG quality problems trace back to one phase or the other.$D3f9d931b_8437_4c03_adf1_5c7e6b8517be$ where id = '3f9d931b-8437-4c03-adf1-5c7e6b8517be';

update lessons set content = $D837ac610_1dad_499e_ba4f_5e48fc85bb00$WHAT IS SEMANTIC SEARCH?

Semantic search means search by meaning. Keyword search finds exact or similar words; semantic search finds similar meaning.

Example: a user asks "can I cancel after trial?" The system may retrieve a document titled "subscription termination rules for first-time users," even though it does not use the exact word "cancel."

**Keyword search matches words. Semantic search matches meaning.**


WHAT IS A VECTOR?

A vector is a list of numbers. A text chunk may become something like [0.12, -0.44, 0.88, 0.03, …], the actual vector may have hundreds or thousands of numbers.

You do not need to understand every number. The idea is: similar meanings produce vectors that are close to each other, and different meanings produce vectors that are farther apart.

**A vector is a numeric meaning fingerprint.**


WHAT IS A VECTOR DATABASE?

A vector database stores embeddings and helps retrieve similar ones quickly. Pinecone describes a vector database as a system that indexes and stores vector embeddings for fast retrieval and similarity search.

In RAG, a vector database stores document chunks, embeddings for those chunks, metadata, source links, permissions, and version information. When a user asks a question, the system finds the most similar vectors.

[!] A vector database is a search engine for embeddings, the same category of tool as a normal search index, just optimized for similarity instead of exact matching.

>> Meaning becomes numbers (embeddings), and a vector database is what makes searching those numbers fast at scale.$D837ac610_1dad_499e_ba4f_5e48fc85bb00$ where id = '837ac610-1dad-499e-ba4f-5e48fc85bb00';

update lessons set content = $De57e2f22_33c1_47ef_96f7_5fc03008bda9$WHY NOT USE A NORMAL DATABASE?

A normal database is good for exact queries, find order_id = 123. A vector database is good for similarity queries, find documents meaningfully related to "refund for broken item."

**Use normal databases for exact records. Use vector search for semantic similarity.** Many real systems use both.


WHAT GETS STORED IN A VECTOR DATABASE?

Usually, not the full original document as one giant item, the system stores chunks. Each chunk may include text content, an embedding vector, document title, document ID, section heading, source URL or file reference, date or version, author or team, access permissions, metadata tags, and a chunk number.

Example: a Refund Policy document's "Section 4: Damaged items can be returned within 30 days…" chunk might carry metadata like document_type: policy, department: support, effective_date: 2026-01-01, region: US, permission_group: support_agents.

[!] Metadata is extremely important for filtering and permissions, without it, a vector database can only search by meaning, with no way to restrict by region, recency, or who is allowed to see the result.

>> A vector database does not just store "what the text means", it stores enough metadata to know when and to whom that meaning should even be shown.$De57e2f22_33c1_47ef_96f7_5fc03008bda9$ where id = 'e57e2f22-33c1-47ef-96f7-5fc03008bda9';

update lessons set content = $D259ef61f_82d7_4797_a719_09493267df43$WHAT IS CHUNKING?

Chunking means splitting documents into smaller pieces. Why? Because retrieving a whole 100-page document is usually too much, the system should retrieve only the relevant section.

Example: a refund policy document may be split into chunks, return window, damaged items, non-returnable items, refund processing time, international returns, exceptions.

**Chunking turns big documents into searchable, answer-sized pieces.**


WHY CHUNK SIZE MATTERS

Chunk size affects RAG quality directly.

If chunks are too small, the answer may miss context, a chunk says "exceptions apply," but the actual exceptions are in the next chunk.

If chunks are too large, the retrieved context may include irrelevant information, which can confuse the model and increase cost.

[!] PM question: "Are chunks small enough to retrieve precisely, but large enough to preserve meaning?" There is no universal right size, it depends on how the source documents are structured.

>> Chunking is the single most underrated lever in RAG quality, get it wrong, and no amount of prompt tuning fixes it.$D259ef61f_82d7_4797_a719_09493267df43$ where id = '259ef61f-82d7-4797-a719-09493267df43';

update lessons set content = $D831baf91_9de2_4ca7_b4bf_08a6a818cfd4$Common chunking strategies:

FIXED-SIZE CHUNKING

Split every X words or tokens. Simple but may cut sentences or sections awkwardly.

SECTION-BASED CHUNKING

Split by headings. Good for policy docs, manuals, and structured documents.

PARAGRAPH-BASED CHUNKING

Keeps natural text units. Good for articles and reports.

SLIDING WINDOW CHUNKING

Chunks overlap slightly. Useful when important context crosses boundaries.

SEMANTIC CHUNKING

Split based on meaning. More advanced, but can improve retrieval quality.

[!] Chunking is not a minor technical detail. Bad chunking can break RAG quality no matter how good the embedding model or the prompt is.

>> Match the chunking strategy to the document's actual structure, a strictly formatted policy manual and a rambling meeting transcript need different approaches.$D831baf91_9de2_4ca7_b4bf_08a6a818cfd4$ where id = '831baf91-9de2-4ca7-b4bf-08a6a818cfd4';

update lessons set content = $Df6f5a778_d06d_47d4_9607_2c654558564a$WHAT IS METADATA FILTERING?

Metadata filtering means restricting search based on document attributes.

Example: a user asks about refund policy in India. Without metadata filtering, the system may retrieve the US refund policy. With metadata filtering, search only documents where region equals India.

Useful metadata filters: region, language, product, user permission, customer segment, document type, effective date, version, department, risk level, policy status.

**Metadata filtering helps retrieve the right source, not just a similar source.**


PERMISSIONS MATTER

RAG systems can create privacy and security risk if permissions are wrong.

Example: a user asks "what did leadership decide about layoffs?" If the RAG system retrieves confidential HR docs the user should not access, that is a serious issue.

RAG must respect access control. PM questions: can the user access the retrieved document? Are permissions checked before retrieval? Are permissions checked again before answer generation? Are sensitive documents excluded? Are retrieval logs audited?

[!] Simple rule: RAG should never reveal documents the user is not allowed to see. This is not an edge case to handle later, it is a launch-blocking requirement.

>> Metadata filtering gets you the right answer. Permission checks make sure you are allowed to show it to this user.$Df6f5a778_d06d_47d4_9607_2c654558564a$ where id = 'f6f5a778-d06d-47d4-9607-2c654558564a';

update lessons set content = $Dc8c42d76_0991_4205_b2ae_f5eec23659ec$WHAT IS TOP-K RETRIEVAL?

Top-k means retrieving the top K most relevant chunks. Example: top-5 retrieval means retrieve the 5 most similar chunks.

If K is too small, the system may miss important information. If K is too large, the model may get too much irrelevant context. Common values may be top 3, top 5, top 10, or more depending on the use case.

PM question: **"How many chunks are retrieved, and is that enough to answer accurately?"**


WHAT IS SIMILARITY SCORE?

Similarity score measures how close the query embedding is to a document chunk embedding. Higher similarity usually means the chunk is more relevant, but similarity score is not perfect.

A chunk can be semantically similar but still not answer the question. Example: question "can I return a damaged product after 45 days?", retrieved chunk "damaged products can be returned if inspected." This is related, but may not answer the 45-day question.

**Similarity is not the same as answer correctness.**


WHAT IS RE-RANKING?

Re-ranking means taking retrieved results and reordering them with a stronger relevance model.

Flow: vector search retrieves top 50 chunks, a re-ranker reviews them more carefully, and the system keeps the best 5 chunks for the LLM. The initial search is fast but rough; the re-ranker is slower but more precise.

[!] Pinecone's documentation discusses vector search and reranking as part of retrieval workflows, and Microsoft's RAG design materials also emphasize retrieval quality as central to RAG solutions.

>> Retriever finds candidates. Re-ranker chooses the best evidence. Skipping re-ranking is fine for simple use cases, but risky wherever accuracy really matters.$Dc8c42d76_0991_4205_b2ae_f5eec23659ec$ where id = 'c8c42d76-0991-4205-b2ae-f5eec23659ec';

update lessons set content = $D057ac31e_5c58_47f5_8eb3_6acc4b44abab$KEYWORD SEARCH VS. VECTOR SEARCH VS. HYBRID SEARCH

Keyword search is good for exact terms, example: policy code "RMA-417."

Vector search is good for meaning, example: "item arrived broken" matches "damaged merchandise."

Hybrid search combines keyword and vector search, and is often stronger than either alone. Example: a user asks "RMA-417 damaged item refund timeline", the system should match the exact policy code and the semantic meaning.

**Hybrid search often works better because users mix exact terms and natural language.**


WHAT IS BM25?

BM25 is a classic keyword search ranking method. You do not need the math, just know that BM25 is strong for exact keyword matching.

Example: if a user searches a policy ID, product SKU, error code, or contract clause, keyword search may outperform pure semantic search.

[!] PM question: "Are users searching with exact identifiers or natural language?" If both, consider hybrid retrieval.

>> Pure vector search can quietly fail on exact codes and IDs, this is one of the most common reasons real-world RAG systems end up hybrid.$D057ac31e_5c58_47f5_8eb3_6acc4b44abab$ where id = '057ac31e-5c58-47f5-8eb3-6acc4b44abab';

update lessons set content = $Df9bbc74d_0713_4221_a018_9fcb9625e9fb$WHAT IS THE RAG PROMPT?

After retrieval, the system builds a prompt for the LLM. A RAG prompt usually includes the user question, retrieved source chunks, instructions, citation rules, a missing-information rule, tone or format guidance, and safety constraints.

Example: "Answer the question using only the provided policy excerpts. If the excerpts do not contain the answer, say the policy does not contain enough information. Cite the source section used."

**RAG quality depends on both retrieval and prompt design.**


GROUNDED ANSWER VS. UNGROUNDED ANSWER

An ungrounded answer comes from the model's memory or guesswork. A grounded answer uses retrieved sources.

Ungrounded: "You can return damaged items within 60 days." Grounded: "According to Refund Policy section 4, damaged items can be returned within 30 days."

Grounded answers are usually safer for business workflows. PM question: **"Can the model show the source for each important claim?"**


CITATIONS

Citations show where the answer came from, helping with trust, verification, debugging, compliance, human review, and reduced hallucination risk.

But citations must be real and relevant. Bad citation: the answer says 30 days, but the cited source does not mention 30 days. Good citation: the answer directly cites the source section that says 30 days.

[!] PM question: "Are citations actually supporting the answer, or just attached decoration?"

>> A well-built RAG prompt is what turns retrieved documents into a grounded, citable answer instead of just more context the model might ignore.$Df9bbc74d_0713_4221_a018_9fcb9625e9fb$ where id = 'f9bbc74d-0713-4221-a018-9fcb9625e9fb';

update lessons set content = $D1d067a0a_aefc_4698_b9a4_991fa55afbc1$RAG EXAMPLE: CUSTOMER SUPPORT POLICY ASSISTANT

Business problem: support agents need fast, accurate policy answers.

User question: "Can a customer return a damaged item after 45 days?"

RAG flow: search the refund policy, retrieve the damaged-item return section, retrieve return-window exceptions, generate an answer, cite policy sections, escalate if policy is unclear.

Output: "The standard damaged-item return window is 30 days. The provided policy does not show an exception for 45 days, so this should be escalated for manual review."

Business value: faster support, fewer wrong answers, better policy consistency, lower training burden, better agent productivity.

Metrics: answer accuracy, agent acceptance rate, resolution time, escalation rate, wrong policy answer rate, CSAT.


RAG EXAMPLE: INTERNAL KNOWLEDGE ASSISTANT

Business problem: employees cannot find information across docs, Slack exports, wikis, and PDFs.

RAG system: indexes approved internal knowledge, retrieves relevant chunks, answers with citations, respects permissions, shows source documents.

Example question: "What is the process for launching a new vendor integration?" Output: a step-by-step answer with links to the official process doc.

Business value: faster onboarding, less repeated questioning, better process compliance, faster decision-making.

[!] Metrics: search success rate, time to answer, source click-through, answer helpfulness, reduced repeated questions, user satisfaction.

>> Same underlying RAG mechanics, two very different products, one answers customers with policy citations, the other answers employees across a messier, more scattered knowledge base.$D1d067a0a_aefc_4698_b9a4_991fa55afbc1$ where id = '1d067a0a-aefc-4698-b9a4-991fa55afbc1';

update lessons set content = $D1e33bd13_18f3_4935_83c7_2b577e345e22$RAG EXAMPLE: PRODUCT DOCUMENTATION Q&A

Business problem: users struggle to find answers in product documentation.

RAG can retrieve relevant docs, answer in plain language, link to the source page, ask a follow-up if the question is ambiguous, and suggest next steps.

Example question: "How do I connect my data warehouse?" Output: a step-by-step answer from the setup docs.

Business value: better self-service, lower support volume, faster activation, better documentation usage.

Metrics: self-service success, documentation deflection, support ticket reduction, activation rate, answer helpfulness, user satisfaction.


RAG EXAMPLE: CONTRACT REVIEW

Business problem: legal or procurement teams need to answer questions from contracts.

RAG can retrieve relevant clauses, summarize obligations, compare clauses, highlight missing terms, extract dates and amounts, and cite exact sections.

Example question: "What are the termination rights in this contract?" Output: a summary with clause references.

Risks: missing a clause, misinterpreting legal language, wrong citation, overstating certainty.

[!] PM recommendation: use RAG as a copilot, not final legal authority, unless there is strong human review and governance.

>> The higher the stakes of the domain, legal review versus product docs, the less RAG should be treated as a final answer, and the more it should be treated as a well-cited starting point for a human.$D1e33bd13_18f3_4935_83c7_2b577e345e22$ where id = '1e33bd13-18f3-4935-83c7-2b577e345e22';

update lessons set content = $D289a1656_5db5_4de1_bdb6_3986bca17408$A typical RAG system has these components:

Document ingestion brings documents into the system.

Text extraction pulls text out of PDFs, websites, docs, or databases.

Chunking splits text into useful pieces.

An embedding model converts text chunks into vectors.

A vector database or search index stores and retrieves chunks.

A retriever finds relevant chunks for a question.

A re-ranker improves relevance ordering.

A prompt builder combines the user question and retrieved sources.

The LLM generates the final answer.

A citation layer shows sources.

Evaluation and monitoring check quality after launch.

[!] Naming all eleven pieces matters because a "bad RAG answer" could be caused by any one of them, ingestion, chunking, embedding, retrieval, re-ranking, prompting, or generation, and debugging starts by figuring out which.

>> RAG is a system, not one model, a chain of components where any single weak link can quietly degrade the final answer.$D289a1656_5db5_4de1_bdb6_3986bca17408$ where id = '289a1656-5db5-4de1-bdb6-3986bca17408';

update lessons set content = $Db4222b93_658b_47fd_8541_ef4421d5686a$DATA INGESTION ISSUES

RAG quality starts with ingestion. Problems: PDFs parse badly, tables lose structure, images need OCR, headers and footers pollute content, duplicate documents create confusion, old versions stay indexed, permissions are missing, broken formatting changes meaning, documents are too long, and important metadata is missing.

PM question: **"Is the knowledge base clean enough for AI to use?"** Bad source content creates bad AI answers.


DOCUMENT FRESHNESS AND VERSIONING

RAG systems must keep knowledge updated. Example: an old refund policy says 60 days, a new refund policy says 30 days, if both are indexed, the AI may retrieve the wrong one.

Controls: effective dates, version tags, retiring old documents, freshness filters, source ownership, an update pipeline, document status (draft/approved/deprecated), and periodic index refresh.

PM question: **"How do we prevent the AI from using outdated documents?"**


SOURCE QUALITY

Not all documents should be treated equally. A high-authority source, like an official policy document, should outrank a low-authority source, like an old Slack discussion, if both mention refund policy.

PM questions: which sources are authoritative? Which are outdated or informal? Should some be excluded or ranked higher? Who owns source quality?

[!] Simple shortcut: RAG is only as trustworthy as its sources.

>> Ingestion, freshness, and authority are three separate reasons a RAG answer can go stale or wrong, none of them are fixed by better prompting.$Db4222b93_658b_47fd_8541_ef4421d5686a$ where id = 'b4222b93-658b-47fd-8541-ef4421d5686a';

update lessons set content = $Db2f4a168_140a_45b0_87c8_20755d871333$ACCESS CONTROL

Access control is critical. A sales employee should not get answers from confidential HR documents. A customer should not get answers from internal-only support notes. A regional manager should not see another region's confidential data.

Controls: user authentication, document-level permissions, metadata filtering, role-based access, source-level restrictions, audit logs, redaction of sensitive content.

PM question: **"Does retrieval respect the same permissions as the original documents?"**


RAG EVALUATION HAS TWO PARTS

RAG evaluation is harder than normal LLM evaluation because there are two systems: retrieval quality and generation quality.

Bad retrieval can cause bad generation. Good retrieval can still produce bad generation if the LLM misuses the sources. So you must evaluate both.

[!] Simple memory: did we retrieve the right evidence? Did we answer correctly from it? These are two separate questions with two separate failure modes.

>> Access control is a permissions problem layered on top of a retrieval problem, get either one wrong and the whole system becomes unsafe or unreliable.$Db2f4a168_140a_45b0_87c8_20755d871333$ where id = 'b2f4a168-140a-45b0-87c8-20755d871333';

update lessons set content = $D5ba0138c_95b0_44c9_978f_ce4c2c35a4b1$RETRIEVAL METRICS

Retrieval metrics check whether the system found the right sources.

Recall@K: did the correct source appear in the top K retrieved chunks? If the right policy section appears in the top 5, Recall@5 succeeds.

Precision@K: of the top K chunks, how many are actually relevant?

MRR (Mean Reciprocal Rank): measures how high the first correct result appears.

NDCG: rewards putting more relevant results near the top.

PM question: **"Is the correct source being retrieved before the LLM answers?"**


GENERATION METRICS

Generation metrics check the final answer, factual accuracy, groundedness, completeness, citation correctness, relevance, clarity, safety, refusal accuracy, hallucination rate, human acceptance, task success.

If the correct source is retrieved but the model still answers incorrectly, generation quality is the problem. PM question: **"Does the answer actually follow the retrieved evidence?"**


END-TO-END RAG METRICS

End-to-end metrics measure whether the full product works.

For support RAG: agent acceptance rate, wrong policy answer rate, resolution time, CSAT, escalation rate.

For internal knowledge RAG: answer helpfulness, time to answer, source click-through, reduced repeated questions, employee satisfaction.

For product docs RAG: self-service success, support deflection, activation improvement, documentation usage.

[!] Retrieval metrics prove the system found evidence. Product metrics prove the user got value. Neither one alone tells the whole story.

>> Three layers of metrics for three separate failure points: did retrieval work, did generation work, and did the product actually help.$D5ba0138c_95b0_44c9_978f_ce4c2c35a4b1$ where id = '5ba0138c-95b0-44c9-978f-ce4c2c35a4b1';

update lessons set content = $Dea5d4820_7979_43be_9ce6_bcac201a1278$FAILURE MODE 1: WRONG DOCUMENTS RETRIEVED

Example: a user asks about US refund policy, and the system retrieves UK refund policy.

Possible causes: missing metadata, bad query understanding, weak embeddings, no region filter, similar wording across documents, outdated documents.

Fixes: add metadata filters, improve chunking, use hybrid search, add re-ranking, improve source labeling, improve query rewriting.


FAILURE MODE 2: RIGHT DOCUMENT, WRONG CHUNK

Example: the correct policy document is retrieved, but not the section that answers the question.

Possible causes: chunks too large or too small, bad section boundaries, missing headings, poor semantic search, top-k too low.

Fixes: improve chunking, add overlapping chunks, retrieve more chunks, use re-ranking, include section hierarchy, add metadata.


FAILURE MODE 3: RIGHT EVIDENCE, WRONG ANSWER

Example: the retrieved source says 30 days, but the model answers 60 days.

Possible causes: prompt weakly instructs source use, too much irrelevant context, conflicting sources, model overuses prior knowledge, citation not enforced, answer not validated.

Fixes: stronger grounding prompt, remove irrelevant context, resolve source conflicts, require citations, add answer verification, use human review for high-risk cases.


FAILURE MODE 4: OUTDATED SOURCE

Example: an old policy is retrieved instead of the current policy.

Possible causes: old documents still indexed, missing effective dates, no source lifecycle process, index refresh delay, version metadata missing.

Fixes: version control, effective date filtering, remove deprecated documents, source ownership, scheduled re-indexing, freshness scoring.

[!] Notice the pattern: each failure mode has a distinct root cause and a distinct fix, treating "the RAG system gave a bad answer" as one problem, instead of diagnosing which of these four it actually is, wastes debugging time.

>> Wrong document, wrong chunk, wrong answer despite right evidence, and outdated source are four different failures with four different fixes, know which one you are looking at before you start fixing it.$Dea5d4820_7979_43be_9ce6_bcac201a1278$ where id = 'ea5d4820-7979-43be-9ce6-bcac201a1278';

update lessons set content = $D016ed246_dfb1_440a_808e_4c2e343f01f1$FAILURE MODE 5: PERMISSION LEAK

Example: a user asks a question and receives an answer based on a confidential document they cannot access.

Possible causes: no document-level permissions, permissions applied after retrieval instead of before, shared embeddings without access filtering, logs exposing sensitive snippets, a prompt that includes restricted content.

Fixes: permission-aware retrieval, access checks before generation, redaction, audit logs, separate indexes by permission group, security review.

[!] This is one of the highest-risk RAG failures, it is a security incident, not just a quality bug.


FAILURE MODE 6: CITATION MISMATCH

Example: the answer cites Policy A, but the claim came from nowhere in that document.

Possible causes: the model invents citations, the citation system is not tied to retrieved chunks, the prompt only asks for citations loosely, sources are not tracked properly.

Fixes: programmatically attach citation IDs, validate citations, show source snippets, require source-supported claims, human review for sensitive answers.

**A citation is useful only if it truly supports the claim.**


FAILURE MODE 7: TOO MUCH CONTEXT

More context is not always better. If too many chunks are inserted, the model may get confused, use irrelevant details, miss the key source, contradict itself, cost more, and respond slower.

Fixes: better retrieval, better re-ranking, lower top-k, summarize retrieved context, use metadata filters, improve prompt structure.

PM question: **"Are we giving the model the best evidence or just more evidence?"**


FAILURE MODE 8: BAD SOURCE DOCUMENTS

The AI cannot fix bad documentation. If source docs are outdated, conflicting, poorly written, duplicated, missing key details, unapproved, or inconsistent across teams, then RAG answers will be weak.

>> RAG projects often become knowledge-management projects. Before building AI search, clean the knowledge base.$D016ed246_dfb1_440a_808e_4c2e343f01f1$ where id = '016ed246-dfb1-440a-808e-4c2e343f01f1';

update lessons set content = $D44e8fcd9_5df9_4169_9d8d_d8f95fad6089$QUERY REWRITING

Sometimes user questions are messy. Example: "can I return it late?", the system may rewrite the query to "what is the return policy for late returns, including exceptions and return window?" Query rewriting can improve retrieval.

Useful when user queries are vague, acronyms are common, multiple terms mean the same thing, users ask conversational questions, or documents use formal language.


MULTI-STEP RETRIEVAL

Some questions require more than one retrieval step. Example: "can this customer get a refund?" needs order details, product condition, delivery date, refund policy, and region-specific exception. One retrieval may not be enough, the system may need tools and multiple queries.

**Simple questions need simple RAG. Workflow questions may need agentic retrieval and tools.**


GRAPH RAG

Graph RAG uses relationships between entities, people, teams, projects, products, policies, dependencies, decisions. A graph can help answer relationship-heavy questions, like "which teams are affected by this policy change?" Traditional vector search may find similar text; graph-based retrieval may better follow relationships. Graph RAG is useful when relationships matter, but it adds complexity.


MULTIMODAL RAG

Multimodal RAG retrieves from more than text, images, charts, tables, slides, PDFs, audio, video, screenshots. Example: "what does this chart say about Q3 churn?", the system must retrieve and understand chart content.

Risks: OCR errors, table parsing mistakes, chart misreading, missing image context, wrong source citation.

[!] PM question: "Are our sources text-only, or do we need image, table, or document understanding too?" Each of these four advanced techniques adds real capability, and real complexity, reach for them only when the basic RAG pattern genuinely cannot answer the question.

>> Query rewriting fixes messy questions. Multi-step retrieval fixes multi-fact questions. Graph RAG fixes relationship questions. Multimodal RAG fixes non-text sources. Each solves a different limitation of basic RAG.$D44e8fcd9_5df9_4169_9d8d_d8f95fad6089$ where id = '44e8fcd9-5df9-4169-9d8d-d8f95fad6089';

update lessons set content = $D3f96c36a_9c94_4c49_a53e_7f34ec0b45d3$RAG VS. AGENTS

RAG retrieves knowledge. Agents take actions.

Example RAG: "what is the refund policy?", answer: "policy says damaged items can be returned within 30 days."

Example agent: "process this refund if eligible", agent actions: look up order, check policy, create return label, draft customer reply, escalate if exception.

**RAG informs. Agents act.** Many AI agents use RAG as one step.


RAG SYSTEM DESIGN QUESTIONS FOR PMS

Before building RAG, ask: what user problem are we solving, and what questions should the system answer? What sources should it use, and which are authoritative? Which sources should be excluded? How often do sources change, and who owns document quality? Are documents structured or messy, and do we need OCR or table extraction? How should documents be chunked, and what metadata is needed? Do permissions matter, and do answers need citations? What happens when no answer is found? What is the acceptable latency and cost? Does the system need human review? What is the golden evaluation set, and what are the retrieval and answer quality metrics?

[!] This list is deliberately long, RAG systems fail quietly in ways that only surface once you ask each question explicitly, one at a time, rather than assuming the answer is obvious.

>> RAG is knowledge, agents are action, and most of the RAG design questions above need answering before a single line of retrieval code gets written.$D3f96c36a_9c94_4c49_a53e_7f34ec0b45d3$ where id = '3f96c36a-9c94-4c49-a53e-7f34ec0b45d3';

update lessons set content = $D1e95f97e_eed4_4863_b0b2_2ace0d4ad7c9$PM CHECKLIST FOR RAG LAUNCH READINESS

Before launching a RAG product, ask: are source documents approved, and are outdated documents removed or marked deprecated? Are permissions enforced before retrieval? Are chunks high quality, and is metadata complete? Does retrieval find the right sources, and does the model answer only from sources? Are citations accurate? Does it refuse when sources are insufficient, and does it handle conflicting sources? Does it handle long documents, and tables or images if needed? Is there a golden test set, and are retrieval and generation evaluated separately? Are high-risk cases escalated? Is cost and latency acceptable? Are logs safe and privacy-compliant? Is there monitoring after launch, and who owns source quality after launch?


METRICS FOR RAG PRODUCTS

Retrieval metrics: Recall@K, Precision@K, MRR, NDCG, source coverage, permission-filter accuracy.

Answer metrics: factual accuracy, groundedness, citation correctness, completeness, refusal accuracy, hallucination rate, human acceptance.

Product metrics: time to answer, search success rate, support deflection, resolution time, agent productivity, user satisfaction, reduced repeated questions, reduced escalations, task completion.

[!] Do not measure only answer fluency. Measure evidence, correctness, and business value, a RAG answer that reads beautifully but cites the wrong source, or costs too much to serve, is not actually working.

>> The launch checklist and the metrics list cover the same ground from two angles: one is "are we ready," the other is "how will we know if we were right."$D1e95f97e_eed4_4863_b0b2_2ace0d4ad7c9$ where id = '1e95f97e-eed4-4863-b0b2-2ace0d4ad7c9';

update lessons set content = $D241dc8c3_5a35_4536_953b_56854bc931a3$HOW TO EXPLAIN RAG TO LEADERSHIP

Simple version: "RAG lets an AI model answer using our trusted knowledge sources. Instead of relying only on the model's memory, the system retrieves relevant documents, gives them to the model as context, and asks the model to answer from those sources. This improves accuracy, allows citations, and helps keep answers current."

Support example: "For customer support, RAG can retrieve the latest approved policy and draft an answer with citations. This should reduce agent search time and improve policy consistency. We will measure answer accuracy, citation correctness, resolution time, agent acceptance, CSAT, and wrong-answer rate."

Internal knowledge example: "For internal knowledge search, RAG can help employees ask natural-language questions across approved documents. The key risks are outdated sources, permission leaks, and incorrect citations, so we need source governance, access control, and a golden test set before launch."


THE MEMORY SHORTCUT

RAG is search first, answer second. Embeddings are numbers that represent meaning. A vector database is a search engine for embeddings.

Remember: documents become chunks, chunks become embeddings, embeddings go into a vector database, the system retrieves, builds a prompt, and generates an answer with sources.

Use RAG when the model needs company knowledge, the answer depends on current or private facts, citations are needed, hallucination risk matters, users need source-grounded answers, or knowledge changes often.

Measure RAG with retrieval quality, answer accuracy, citation correctness, groundedness, refusal accuracy, user satisfaction, and business impact.

Watch out for wrong documents, bad chunking, outdated sources, permission leaks, citation mismatch, too much context, weak source quality, bad retrieval, hallucination despite retrieval, and no evaluation set.

[!] This module is the retrieval-side deep dive that completes the picture from Modules 16-18, those covered what LLMs and agents are, and how to prompt them; this one covers how to actually connect them to trustworthy knowledge.

>> The most important PM question: is the AI answering from the right trusted source, and can the user verify it?$D241dc8c3_5a35_4536_953b_56854bc931a3$ where id = '241dc8c3-5a35-4536-953b-56854bc931a3';

update questions set choices = $D22bf4cdb_8d50_4b51_9f6a_4646240396f8Q$["LLMs do not automatically know private, latest, or company-specific information, without retrieval, the model may guess at answers about company policy or current facts, creating hallucination risk; RAG helps it answer from your knowledge instead of just its memory","Powerful LLMs always have complete and current knowledge of any company's private documents by default","This is true as long as the model was trained recently enough","RAG is only needed for very small models, not powerful ones"]$D22bf4cdb_8d50_4b51_9f6a_4646240396f8Q$::jsonb where id = '22bf4cdb-8d50-4b51-9f6a-4646240396f8';

update questions set choices = $D2c6cb10d_9b2d_4b9e_a4d4_e053838362f6Q$["No, this is normal search, not RAG; RAG specifically means retrieving documents and then generating an answer using them, not just returning documents or links","Yes, any system that retrieves relevant documents is RAG by definition","Yes, as long as the documents are stored as embeddings","This distinction does not matter for product decisions"]$D2c6cb10d_9b2d_4b9e_a4d4_e053838362f6Q$::jsonb where id = '2c6cb10d-9b2d-4b9e-a4d4-e053838362f6';

update questions set choices = $Debdc8ebb_668f_4b67_b4b8_1efed1e38afaQ$["Fine-tuning changes behavior, not fast-moving knowledge, since the policy changes monthly, RAG (retrieving the current policy at answer time) is the better fit for keeping answers current, while repeated fine-tuning is a much heavier way to solve a knowledge problem","Fine-tuning is always the correct solution for any information that changes over time","RAG and fine-tuning cannot be combined in the same product","The model should just be given a longer context window instead of either RAG or fine-tuning"]$Debdc8ebb_668f_4b67_b4b8_1efed1e38afaQ$::jsonb where id = 'ebdc8ebb-668f-4b67-b4b8-1efed1e38afa';

update questions set choices = $Dff7e86d6_93e8_4123_ac33_e79b5f48a16eQ$["RAG has two phases, indexing (which happens before the user asks, preparing and chunking documents) and query (which happens at question time), and problems can originate in either phase, so quality issues are not always a query-phase problem","This assumption is correct, since indexing has no effect on answer quality once it is complete","The query phase and indexing phase are the same step and cannot be separated","Indexing only matters for very large document sets, not typical RAG systems"]$Dff7e86d6_93e8_4123_ac33_e79b5f48a16eQ$::jsonb where id = 'ff7e86d6-93e8-4123-ac33-e79b5f48a16e';

update questions set choices = $D0fc20db9_03e2_4224_8931_a5804e49156eQ$["Normal databases are built for exact queries like finding a specific order ID, while vector databases are built for similarity queries based on meaning, many real systems need both, used for their respective strengths","Normal databases and vector databases are functionally identical and interchangeable for any query type","Only vector databases can store any kind of data; normal databases cannot store text at all","Similarity-based queries are always slower and less reliable than exact queries regardless of database type"]$D0fc20db9_03e2_4224_8931_a5804e49156eQ$::jsonb where id = '0fc20db9-03e2-4224-8931-a5804e49156e';

update questions set choices = $D0bdb4a08_a588_4aea_b505_137872df2a73Q$["Metadata, without fields like region, effective date, and permission group, the system cannot filter search results by these attributes, which limits its ability to retrieve the right source or restrict access appropriately","Nothing is missing, since the embedding alone is sufficient for accurate and secure retrieval","Only the document title is needed in addition to the embedding; other metadata is optional in all cases","Metadata is only useful for multimodal RAG, not for text-based policy documents"]$D0bdb4a08_a588_4aea_b505_137872df2a73Q$::jsonb where id = '0bdb4a08-a588-4aea-b505-137872df2a73';

update questions set choices = $D5c364d75_629f_4fdd_82f7_d0259b6e58a6Q$["Metadata filtering, restricting the search to documents where region equals India would prevent retrieving the similarly-worded but incorrect US policy, since metadata filtering targets the right source, not just a similar-sounding one","Increasing the chunk size, since larger chunks always resolve region-specific retrieval errors","Switching to keyword-only search, since semantic search cannot be region-aware under any configuration","This can only be fixed by manually reviewing every single query before it reaches the system"]$D5c364d75_629f_4fdd_82f7_d0259b6e58a6Q$::jsonb where id = '5c364d75-629f-4fdd-82f7-d0259b6e58a6';

update questions set choices = $D0c09b543_b5c9_4ef9_b84d_196bdfc8fed6Q$["Whether top-k (the number of retrieved chunks) is too low for this use case, if K is too small, the system may miss important information, so increasing K or adding re-ranking to select from a larger candidate pool may help","Top-k has no effect on whether relevant details are missed; only chunk size matters","The fix is always to decrease top-k further, regardless of what is being missed","This is exclusively a permissions problem unrelated to retrieval configuration"]$D0c09b543_b5c9_4ef9_b84d_196bdfc8fed6Q$::jsonb where id = '0c09b543-b5c9-4ef9-b84d-196bdfc8fed6';

update questions set choices = $D38e5594e_c1e2_477c_9dd3_46700f1cd79fQ$["Hybrid search, combining keyword search (strong for exact terms like policy codes) with vector search (strong for meaning) typically performs better than either alone when users mix exact identifiers and natural language","Switching entirely to keyword search, since vector search should never be used when any exact codes exist","This is expected and not fixable, since exact codes cannot be handled by any retrieval approach","BM25 should be removed entirely from consideration since it only handles semantic queries, not exact matches"]$D38e5594e_c1e2_477c_9dd3_46700f1cd79fQ$::jsonb where id = '38e5594e-c1e2-477c-9dd3-46700f1cd79f';

update questions set choices = $Dbdf04e98_99b8_4847_ac35_63265d308218Q$["This is a citation mismatch, the model may have invented the citation or the citation system was not properly tied to retrieved chunks; fixes include programmatically attaching citation IDs to retrieved chunks and validating that citations actually support the claims made","This is a permission leak, which is fixed exclusively through access control and redaction","This is normal and acceptable RAG behavior that does not require any fix","This is a chunking problem best solved by increasing chunk size significantly"]$Dbdf04e98_99b8_4847_ac35_63265d308218Q$::jsonb where id = 'bdf04e98-99b8-4847-ac35-63265d308218';

update questions set choices = $D871afba7_f5c7_471e_b2a8_b720d0cb4060Q$["Both use the same core RAG mechanics (retrieve relevant chunks, generate a grounded answer with citations, respect permissions) but serve very different audiences and knowledge sources, customers/agents with policy documents versus employees with a broader, messier internal knowledge base","These two use cases require entirely different, incompatible retrieval technologies with no shared architecture","Internal knowledge assistants never need citations, unlike customer support assistants","Support policy assistants do not need to respect permissions since customers only see public information by default"]$D871afba7_f5c7_471e_b2a8_b720d0cb4060Q$::jsonb where id = '871afba7-f5c7-471e-b2a8-b720d0cb4060';

update questions set choices = $D98091c5f_4d1d_4421_af36_9273e9a936edQ$["Use RAG as a copilot, not final legal authority, unless there is strong human review and governance, contract review carries risks like missing a clause or misinterpreting legal language that make full automation inappropriate without those safeguards","This is an appropriate use of RAG since legal documents are well-structured and the risk of error is low","RAG should never be used for legal or compliance use cases under any circumstances","Human review is only needed if the contract is unusually long, not as a general rule for this use case"]$D98091c5f_4d1d_4421_af36_9273e9a936edQ$::jsonb where id = '98091c5f-4d1d-4421-af36-9273e9a936ed';

update questions set choices = $Da81c6a49_5e5d_424d_8453_7f82bbca46d8Q$["RAG is a system with many components, ingestion, chunking, embedding, the vector database, retrieval, re-ranking, prompt building, and generation, and a bad answer could originate from any of these stages, not just the final LLM generation step","The LLM generation step is indeed the only component that can cause a bad answer in a RAG system","RAG architecture has no distinct stages; it is effectively a single black-box model","Re-ranking and citation layers are optional add-ons that never affect answer quality"]$Da81c6a49_5e5d_424d_8453_7f82bbca46d8Q$::jsonb where id = 'a81c6a49-5e5d-424d-8453-7f82bbca46d8';

update questions set choices = $D7e636946_ab24_458c_99f8_27259298f1a5Q$["Document freshness and versioning controls, effective dates, version tags, retiring old documents, and periodic index refresh are needed to prevent the AI from retrieving and using outdated documents alongside current ones","This is purely a chunking problem and has nothing to do with document versioning","This cannot be prevented since RAG systems always retrieve the most recently indexed document by default","Data ingestion issues are unrelated to which version of a document gets retrieved"]$D7e636946_ab24_458c_99f8_27259298f1a5Q$::jsonb where id = '7e636946-ab24-458c-99f8-27259298f1a5';

update questions set choices = $D45f06834_8ee7_4d2d_8c74_d62278a732e7Q$["Access control failed, retrieval did not respect the same permissions as the original documents, and the system should have checked whether the user could access that document before retrieval and again before generating the answer","This is expected behavior, since RAG systems are designed to retrieve from all indexed documents regardless of the user asking","This is solely a chunking quality issue unrelated to permissions","Access control only matters for external, customer-facing RAG systems, not internal employee tools"]$D45f06834_8ee7_4d2d_8c74_d62278a732e7Q$::jsonb where id = '45f06834-8ee7-4d2d-8c74-d62278a732e7';

update questions set choices = $D8de8c438_956c_4bd9_b3a7_a2158af1de24Q$["Generation metrics (like factual accuracy and groundedness), not retrieval metrics, since the correct source was retrieved successfully (which retrieval metrics like Recall@K would confirm), the failure is in how the model used that evidence to generate the answer","Retrieval metrics like Recall@K, since they measure whether the final answer text is correct","This failure cannot be measured or detected by any evaluation metric","Only end-to-end product metrics like CSAT can catch this type of error, not retrieval or generation metrics specifically"]$D8de8c438_956c_4bd9_b3a7_a2158af1de24Q$::jsonb where id = '8de8c438-956c-4bd9-b3a7-a2158af1de24';

update questions set choices = $D68adc03f_c753_465e_9fd6_386361ae6e7bQ$["The dataset is missing questions with no answer, a key test of whether the model correctly refuses or escalates when sources do not contain the answer, which is one of the most important hallucination controls to validate before launch","There is no gap, since testing only answerable questions is sufficient for a complete golden dataset","The dataset should instead remove all edge cases and only include the simplest possible questions","Golden datasets are only useful for retrieval metrics, not for testing refusal behavior at all"]$D68adc03f_c753_465e_9fd6_386361ae6e7bQ$::jsonb where id = '68adc03f-c753-465e-9fd6-386361ae6e7b';

update questions set choices = $D885fe80c_53fc_4b51_b7a3_12833bedb8aeQ$["This matches \"wrong documents retrieved\", recommended fixes include adding metadata filters (like a region filter), using hybrid search, and improving source labeling to distinguish similarly worded documents from different regions","This matches \"right document, wrong chunk,\" which is fixed only by increasing chunk overlap","This matches \"citation mismatch,\" which is fixed only by validating citations after generation","This matches \"too much context,\" which is fixed only by lowering top-k across all queries"]$D885fe80c_53fc_4b51_b7a3_12833bedb8aeQ$::jsonb where id = '885fe80c-53fc-4b51-b7a3-12833bedb8ae';

update questions set choices = $D5b843c4a_f9c5_43c9_88c9_664664669d36Q$["Graph RAG, it uses relationships between entities like people, teams, projects, and policies, which is better suited to relationship-heavy questions than traditional vector search, which primarily finds semantically similar text","Query rewriting, since rewriting the question alone would resolve relationship-based reasoning without any other technique","Multimodal RAG, since this question involves only text and no images, charts, or other media","Standard single-step vector search is already sufficient for any relationship-based question of this kind"]$D5b843c4a_f9c5_43c9_88c9_664664669d36Q$::jsonb where id = '5b843c4a-f9c5-43c9-88c9-664664669d36';

update questions set choices = $Db73683fd_2b58_4163_8a5b_293612917de1Q$["RAG informs and agents act, the first feature is a RAG use case (retrieving and answering from knowledge), while the second is an agent use case (taking real actions), and many AI agents actually use RAG as one step within a larger action-taking workflow","These are the same technology with no meaningful distinction between them","Agents never use RAG as part of their process, since agents only rely on fine-tuning","RAG is a more advanced and risky capability than agents, which is the reverse of what this lesson describes"]$Db73683fd_2b58_4163_8a5b_293612917de1Q$::jsonb where id = 'b73683fd-2b58-4163-8a5b-293612917de1';

update questions set choices = $D923c7a36_351b_4201_bfc6_a0b40da61458Q$["No, fluent answers in a demo do not confirm launch readiness; the checklist requires verifying things like source approval, permission enforcement before retrieval, citation accuracy, refusal behavior, and monitoring plans, none of which fluency alone demonstrates","Yes, since fluent and well-written demo answers are the primary indicator of RAG launch readiness","Yes, as long as the underlying LLM is a well-known, powerful model","This cannot be determined without knowing the exact cost per query, which is the only remaining checklist item"]$D923c7a36_351b_4201_bfc6_a0b40da61458Q$::jsonb where id = '923c7a36-351b-4201-bfc6-a0b40da61458';

update questions set choices = $Dba37bdcc_e086_410f_88f9_686e40cca950Q$["RAG lets the model answer using the company's trusted knowledge sources instead of relying only on its memory, it retrieves relevant documents, gives them to the model as context, and requires the model to answer from those sources, which improves accuracy, enables citations, and keeps answers current regardless of how powerful the underlying model is","A sufficiently powerful chatbot always has equivalent accuracy to a RAG system, making RAG unnecessary regardless of the use case","RAG and model power are the same lever, so upgrading the model always replaces the need for retrieval","RAG is primarily a cost-saving measure and has no meaningful effect on answer accuracy or citations"]$Dba37bdcc_e086_410f_88f9_686e40cca950Q$::jsonb where id = 'ba37bdcc-e086-410f-88f9-686e40cca950';
