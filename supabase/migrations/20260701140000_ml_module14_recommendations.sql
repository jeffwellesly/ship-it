-- ML for Everyone — Module 14: Recommendation Systems and Ranking
-- 11 lessons covering recommendations from a PM perspective

do $$
declare
  v_course_id uuid;
  v_module_id uuid;
  v_l1  uuid; v_l2  uuid; v_l3  uuid; v_l4  uuid; v_l5  uuid; v_l6  uuid;
  v_l7  uuid; v_l8  uuid; v_l9  uuid; v_l10 uuid; v_l11 uuid;
begin

  select id into v_course_id from courses where sort_order = 2;

  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 14: Recommendation Systems and Ranking',
    'Learn how recommendation systems rank items for users — and how to evaluate, apply, and communicate about them as a PM.',
    14
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.1 — What Is a Recommendation System, Inputs, and Outputs
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is a Recommendation System, Inputs, and Outputs',
    1,
    $M14L1$A recommendation system is an ML system that helps choose what to show a user from many possible options.

Examples: which product to recommend, which movie to show next, which article to surface, which course to suggest, which search result to rank first.

**A recommendation system predicts what a user is likely to find useful, relevant, or valuable.**

Unlike a classification model that predicts one yes/no answer, a recommendation system ranks many options. Instead of asking "will this user click Product A?" it asks: "Out of 1 million products, which 10 should we show this user right now?"


THE SALESPERSON MENTAL MODEL

A good salesperson does not show every product. They think: what has this customer looked at? What did they buy before? What do similar customers buy? What is popular and in stock? What fits the price range?

A recommendation system does something similar with data — combining user behavior, item information, similar users, similar items, context, popularity, and business rules — then ranking items and showing the best ones.


RECOMMENDATION VS. PREDICTION

A normal model predicts one outcome: churn probability = 80%.

A recommendation system ranks many possible choices:

  For this user, recommend: 1. Product A, 2. Product C, 3. Product F, 4. Product B, 5. Product D.

So recommendation is a ranking problem. The system asks: "Which item is better than the others for this user right now?" Position matters — the first item gets more attention than the tenth.


WHAT GOES IN?

User features: past purchases, clicks, search history, ratings, cart activity, subscription type, device.
Item features: category, brand, price, rating, description, availability, popularity, freshness.
Interaction features: clicks, purchases, watches, likes, skips, hides, ratings, returns.
Context features: time of day, device, location, current search query, current session behavior.

**Recommendation systems become powerful by combining user, item, interaction, and context signals.**


WHAT COMES OUT?

A ranked list with scores:
  Rank 1: Product A — score 0.94
  Rank 2: Product B — score 0.89
  Rank 3: Product C — score 0.81

The score may represent click probability, purchase probability, engagement, expected value, or utility. The product shows only the top few items.

[!] "Score" is not always a true calibrated probability. Scores in recommendation systems are often used for ranking only, not as absolute probability estimates. Before designing a threshold rule, confirm how the score is defined.

>> Recommendation = ranking problem. Best items for this user → right now → in the right order.$M14L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.2 — Multi-Stage Architecture: Candidate Generation, Ranking, Re-Ranking
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Multi-Stage Architecture: Candidate Generation, Ranking, Re-Ranking',
    2,
    $M14L2$Large recommendation systems cannot deeply score every possible item for every user. Imagine: 100 million users, 10 million items, real-time recommendations. Fully evaluating every user-item pair is too expensive.

So production systems use a multi-stage pipeline.

Simple memory: **Find possible items → score them → adjust final list**


STAGE 1: CANDIDATE GENERATION

Narrows a huge item catalog into a smaller set of possibilities.

Example: start with 10 million products, return 1,000 possible candidates.

This is a rough but fast step. The goal is not perfection — it is to quickly find a manageable set of potentially relevant items.

Sources of candidates:
  Similar items: "users who viewed this also viewed…"
  Similar users: "users like you liked…"
  Popular candidates: trending or best-selling
  Fresh candidates: new items or content
  Personalized category: items from the user''s favorite categories
  Session-based: items related to current browsing
  Search-intent: items related to the current query
  Business-rule: items needing strategic exposure

Using multiple candidate sources improves coverage and diversity.


STAGE 2: RANKING / SCORING

The ranking model scores each candidate more deeply.

From 1,000 candidates, the model may predict click probability, purchase probability, expected value, or long-term satisfaction — then sort by score.

Example:
  Product A: 18% purchase probability
  Product B: 12%
  Product C: 7%
  Product D: 3%

The ranker uses richer features than candidate generation — user history, item details, cross-features, context, price, inventory — but only evaluates a smaller set.


STAGE 3: RE-RANKING

Re-ranking adjusts the final list after scoring because the highest-scoring items may not create the best user experience.

Example: without re-ranking, top 4 results might all be "Black Running Shoe." Re-ranked: Black running shoe, Blue running shoe, Running socks, Shoe cleaner — better for discovery.

Re-ranking may consider:
  Diversity: avoid showing identical items
  Freshness: include newer content
  Availability: exclude out-of-stock items
  Business rules: respect policy constraints
  Safety: remove harmful items
  User preferences: honor blocked categories
  Exploration: show some new items to learn user interests

**The highest model score is not always the best final product experience.**

[!] Teams often treat re-ranking as an engineering detail. PMs should own re-ranking rules because they encode product values: what does "good recommendation" mean beyond raw engagement score? Diversity, fairness, and safety are re-ranking decisions.

>> Candidate generation is fast and broad. Ranking is deep and precise. Re-ranking enforces product values. All three stages are PM-relevant.$M14L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.3 — Feedback Types, Collaborative Filtering, Content-Based, and Hybrid
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Feedback Types, Collaborative Filtering, Content-Based, and Hybrid',
    3,
    $M14L3$EXPLICIT VS. IMPLICIT FEEDBACK

Explicit feedback: the user directly tells you what they think.
  Examples: star ratings, likes/dislikes, thumbs up/down, reviews, favorites.
  Clear signal, but sparse — most users do not rate everything.

Implicit feedback: the system infers preference from behavior.
  Examples: clicks, views, watch time, purchases, add-to-cart, searches, shares, skips, hides, returns.
  Abundant, but noisy.

Example of noise: a click does not always mean the user liked the item. A purchase does not always mean satisfaction. A long watch time does not always mean the content was good.

PM question: "What does a non-click actually mean in this product — did the user not like the item, not see it, see it in a bad position, or end the session?"

**Explicit feedback is clearer but less common. Implicit feedback is common but needs careful interpretation.**


COLLABORATIVE FILTERING

Recommends items based on behavioral patterns across users and items.

Simple idea: users who behaved similarly in the past may like similar items in the future.

Example: User A bought Products 1, 2, 3. User B bought Products 1, 2. The system may recommend Product 3 to User B.

Good for: products, movies, music, courses, articles — any domain with rich interaction data.

Weakness: struggles with cold start. If a new item has no interactions, the model cannot recommend it. If a new user has no history, the model does not know what to recommend.


CONTENT-BASED RECOMMENDATION

Uses item features to recommend similar items.

Simple idea: recommend items similar to what the user liked before.

Example: a user often watches cooking videos → recommend more cooking videos. A user buys running shoes → recommend related fitness products.

Useful for cold-start items — can recommend a new item based on its attributes even before many users have interacted with it.

Weakness: may become too narrow. If the user buys one running shoe, the system recommends only running shoes forever, reducing discovery.


HYBRID RECOMMENDATION

Most strong systems combine multiple signals: collaborative filtering, content features, popularity, context, search intent, freshness, diversity, embeddings, and business rules.

Why hybrid? Because no single method is perfect:
  Collaborative filtering is strong when interaction data is rich.
  Content-based methods help with new items.
  Popularity helps when user history is limited.
  Context helps with current intent.
  Re-ranking enforces product quality and diversity.

**Production recommendation systems almost always combine many signals.**

[!] When a team says "we use collaborative filtering," ask what other signals are incorporated. A pure collaborative filtering system has exploitable cold-start and popularity-bias problems. Hybrid design is the norm in production.

>> Explicit feedback is clean. Implicit feedback is abundant but noisy. Collaborative filtering matches similar users. Content-based matches similar items. Hybrid combines both.$M14L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.4 — Embeddings, Two-Tower Models, Ranking Models, and Learning to Rank
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Embeddings, Two-Tower Models, Ranking Models, and Learning to Rank',
    4,
    $M14L4$EMBEDDINGS IN RECOMMENDATION

Modern recommendation systems use embeddings — numerical vectors that represent meaning or preference.

Users have embeddings. Items have embeddings. If a user embedding is close to an item embedding in vector space, the item may be relevant.

User embedding captures: fitness interest, budget preference, brand taste, recent browsing intent.
Item embedding captures: category, style, price level, similarity to other items.

**Embeddings help match users and items in a shared preference space.**

Matrix factorization is an older approach that learns hidden preference dimensions from user-item interaction data. Example hidden dimensions for movies: action preference, romance preference, family-friendly preference. If user vector is close to item vector, recommend it.


TWO-TOWER MODELS

A two-tower model is common in large-scale retrieval (candidate generation).

It has two parts:
  User tower: creates a user embedding from history, profile, and context.
  Item tower: creates an item embedding from category, text, image, metadata, and popularity.

The system compares user and item embeddings. If they are close, the item becomes a candidate.

Why useful? Item embeddings can be precomputed. Retrieval can then be very fast even at catalog scales of millions of items.

**Two-tower models help quickly find items that match a user from a very large catalog.**


RANKING MODELS

After candidates are generated, a ranking model scores them more deeply using richer cross-features: user-item interaction features, context, current session, price, inventory, business constraints.

The ranker may predict click probability, purchase probability, watch time, rating, or expected value.

Rankers can be logistic regression, gradient boosted trees, neural networks, deep ranking models, or transformer-based sequence models. The ranker is more expensive than candidate generation but evaluates a much smaller set.


LEARNING TO RANK

Learning to rank means training a model specifically to order items, not just score them.

Three approaches:
  Pointwise: score each item independently, then sort. (Predict click probability for each item.)
  Pairwise: learn which of two items should rank higher. (Product A should rank above Product B for this user.)
  Listwise: learn the quality of the whole ranked list. (Is the full top 10 list good?)

PM-level takeaway: ranking is not only about individual item prediction. It is about the quality of the ordering. A model that predicts every item''s score well but puts them in the wrong order fails the user.

[!] Teams sometimes say "we predict purchase probability and sort by that." This is a pointwise approach and ignores interaction effects between items in the list — if all top items are identical, the experience suffers. Re-ranking and listwise approaches address this.

>> Embeddings power fast retrieval. Two-tower models scale candidate generation. Ranking models score candidates deeply. Learning to rank optimizes the list quality.$M14L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.5 — Exploration vs. Exploitation, Cold Start, Popularity Bias, and Feedback Loops
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Exploration vs. Exploitation, Cold Start, Popularity Bias, and Feedback Loops',
    5,
    $M14L5$EXPLORATION VS. EXPLOITATION

Recommendation systems face a core trade-off.

Exploitation: show what the model already knows the user likes.
  Example: a user watches cooking videos, so show more cooking videos.

Exploration: show something new to learn more about the user.
  Example: try a travel video or fitness video.

Too much exploitation: the product becomes repetitive and narrow.
Too much exploration: recommendations feel random and irrelevant.

PM question: "How much of the experience should be familiar vs. exploratory, and how does that change over the user lifecycle?"


COLD START PROBLEM

Cold start happens when there is not enough data to make good predictions.

New user cold start: a new user has no history. Solutions: ask onboarding preferences, show popular items, use context (device, language, location), explore actively in early sessions, use first-session behavior immediately.

New item cold start: a new item has no interactions. Solutions: use item content features and embeddings, give limited exploration exposure, use editorial or business rules to promote new items in controlled ways.

PM question: "How do new users and new items get a fair chance at being recommended?"


POPULARITY BIAS

Recommendation systems can over-recommend already popular items.

Loop: popular items get more exposure → more exposure creates more clicks → more clicks make them look even more popular → the cycle continues.

Impact: new items struggle to surface, niche items disappear, users see less variety, creators/sellers feel treated unfairly, long-term discovery suffers.

PM question: "Are we balancing popularity with personalization, novelty, and fairness to new and niche items?"


POSITION BIAS

Items shown higher get more clicks simply because of their position — not because they are inherently better.

This creates biased training data: if Item A at rank 1 gets clicked and Item B at rank 10 does not, the model may incorrectly learn that Item A is much better. In reality, Item B may never have gotten a fair chance.

Possible approaches: debiasing methods during training, randomized exploration to collect unbiased signal, counterfactual evaluation.

PM question: "How are we accounting for position bias in our training data and evaluation?"


FEEDBACK LOOPS

The recommendation system influences the data it later learns from.

Example: the system recommends fitness content → user clicks fitness content because that is what they see → model learns the user only likes fitness → it recommends even more fitness → experience narrows over time.

PM questions: are recommendations becoming too narrow? Are we measuring diversity over time? Are we giving users control? Are we exploring enough?

[!] Feedback loops are silent — they compound slowly and become obvious only after user satisfaction has already declined. Monitor diversity and long-term engagement metrics from launch, not after users complain.

>> Exploitation delivers known value. Exploration discovers new value. Cold start, popularity bias, and position bias all require active PM attention.$M14L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.6 — Diversity, Novelty, Business vs. User Goals, and Ranking Metrics
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Diversity, Novelty, Business vs. User Goals, and Ranking Metrics',
    6,
    $M14L6$DIVERSITY, NOVELTY, AND SERENDIPITY

Good recommendations are not only accurate — they should also feel useful and fresh.

  Diversity: the list contains different types of items.
  Novelty: the user sees something new, not only obvious items.
  Serendipity: the user discovers something unexpectedly useful.

Example of serendipity: a user who buys running shoes discovers a beginner marathon training plan. Not just similar — meaningfully useful in a new dimension.

PM question: "Are we optimizing for relevance only, or also for discovery and long-term interest development?"


PERSONALIZATION VS. BUSINESS GOALS

Recommendation systems balance user value and business goals. Business goals may include: revenue, margin, inventory movement, supplier fairness, content freshness, marketplace health, subscription retention.

If business goals overpower user relevance, trust declines. Showing high-margin items users do not want hurts long-term engagement.

PM question: "How do we balance short-term business value with long-term user trust?"


RANKING METRICS: PRECISION@K

Precision@K: how many of the top K recommendations are relevant?

Example: show top 10 items. 6 are relevant. Precision@10 = 6/10 = 60%.

Use when users only see a small number of items and quality at the top matters most. If the top 5 recommendations are bad, users may not scroll further.


RANKING METRICS: RECALL@K

Recall@K: how many of all relevant items appear in the top K?

Example: there are 20 items the user would like. The top 10 contain 5. Recall@10 = 5/20 = 25%.

Use when missing relevant items matters — typically for evaluating candidate generation or broad retrieval quality.


RANKING METRICS: NDCG (Normalized Discounted Cumulative Gain)

NDCG measures ranking quality while giving more credit when relevant items appear near the top.

Why this matters: a relevant item at rank 1 is more valuable than the same item at rank 20.

Example: List A has relevant items at ranks 1, 2, 3. List B has them at ranks 8, 9, 10. Both have the same count of relevant items, but List A is a much better experience. NDCG captures this.

**NDCG rewards putting the best items near the top.**


RANKING METRICS: MRR AND MAP

MRR (Mean Reciprocal Rank): focuses on the rank of the first relevant result.
  Rank 1 = score 1.0. Rank 2 = 0.5. Rank 5 = 0.2.
  Use when the user mainly needs one good answer — search, FAQ, document retrieval.

MAP (Mean Average Precision): evaluates quality across multiple relevant items in the list.
  Use when there may be several correct results — search, product discovery, content recommendation.

[!] All four offline metrics can improve simultaneously while the product gets worse — if the model makes recommendations more repetitive, or over-optimizes for clicks, or hurts new item discovery. Offline metrics are necessary but not sufficient for judging product quality.

>> Precision@K measures top-list quality. Recall@K measures coverage. NDCG rewards better ordering. MRR rewards a fast path to the first good result.$M14L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.7 — Online Metrics, CTR Limitations, and Short-Term vs. Long-Term
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Online Metrics, CTR Limitations, and Short-Term vs. Long-Term',
    7,
    $M14L7$OFFLINE VS. ONLINE METRICS

Offline ranking metrics (Precision@K, Recall@K, NDCG, MRR, MAP) are useful before launch.

But online metrics matter more for product success:
  Click-through rate, conversion rate, add-to-cart rate, watch time, purchase rate, retention, repeat usage, user satisfaction, hide/report rate, revenue, long-term engagement.

A model can improve offline NDCG but fail online because:
  It recommends repetitive items
  It optimizes clicks but not satisfaction
  It hurts diversity
  It increases returns
  It promotes low-quality items
  It creates user fatigue

PM question: "What online experiment proves that this ranking improves user value?"


CTR IS NOT ENOUGH

Click-through rate is common but misleading on its own.

A click does not always mean the recommendation was good:
  Clickbait titles may get clicks but disappoint users.
  A user may click and immediately bounce.
  A user may buy and then return the item.

Better metrics alongside CTR:
  Conversion (did they complete a desired action?)
  Dwell time quality (how long did they engage after clicking?)
  Return rate (did they bring it back?)
  Repeat engagement (did they come back?)
  Hide/report rate (did they explicitly reject it?)
  Downstream value (lifetime value impact of this recommendation?)

PM question: "Are we optimizing for clicks, or for real user satisfaction?"


SHORT-TERM VS. LONG-TERM METRICS

Recommendation systems can over-optimize short-term behavior at the expense of long-term health.

Example: maximize watch time today → user fatigue, lower trust, fewer future sessions.

Long-term metrics to track:
  Retention: are users coming back?
  Repeat sessions: are they engaging consistently?
  Subscription renewal: are they staying paid?
  Customer lifetime value: are they worth more over time?
  Satisfaction: do they report the recommendations as useful?
  Diversity of engagement: are they exploring more content types?

PM question: "What long-term metric prevents us from over-optimizing short-term engagement?"


BUSINESS METRICS BY USE CASE

E-commerce: CTR, add-to-cart, conversion, revenue per session, return rate, repeat purchase, retention.
Video/music: watch/listen time, completion rate, saves, return visits, subscription retention, diversity.
Search: success rate, CTR, reformulation rate, zero-result rate, time-to-result, conversion.
Content feed: engagement, retention, hide/report rate, diversity, creator health, safety metrics.
Learning/courses: enrollment, completion, learning outcomes, satisfaction, skill progression.

[!] Recommendation teams often show only CTR and conversion in metrics reviews. PMs should require long-term metrics (retention, diversity, satisfaction) and negative signal metrics (hide rate, report rate, return rate). If only positive short-term signals are tracked, the system will optimize toward them — even at the expense of the user.

>> Online metrics prove product value. CTR alone is not enough. Long-term metrics prevent short-term gaming. Match metric choice to what "good recommendation" actually means.$M14L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.8 — A/B Testing, Evaluation Bias, Latency, and Batch vs. Real-Time
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'A/B Testing, Evaluation Bias, Latency, and Batch vs. Real-Time',
    8,
    $M14L8$A/B TESTING RECOMMENDATION SYSTEMS

Recommendation systems should usually be tested online before full rollout.

A/B test example:
  Control: existing recommendation system.
  Treatment: new ranking model.

Measure: CTR, conversion, revenue, satisfaction, retention, hide/report rate, latency, diversity, return rate.

Do not only measure immediate click lift. Also check guardrail metrics:
  Latency: did we slow down the page?
  Error rate: are failures increasing?
  Customer complaints: did negative feedback increase?
  Content quality: are lower-quality items appearing?
  Diversity: did variety decline?
  Long-term retention: are users returning less?
  Negative feedback: did hide/report rate increase?

PM question: "What are the success metrics and guardrail metrics for this experiment?"


INTERLEAVING TESTS

Interleaving is an alternative evaluation method for ranking: instead of showing one user only Ranking A or Ranking B, results from both rankers are mixed into one list and the system observes which model''s items users prefer.

This can detect ranking quality differences more sensitively than a standard A/B test because both systems compete for the same user attention in the same session.

PM-level takeaway: know that interleaving exists and ask whether it is appropriate when evaluating search or feed ranking systems.


EVALUATION BIAS

Recommendation evaluation can be biased because historical data comes from the old recommendation system — which may have over-shown popular items.

Example: the old system mostly showed popular products, so the data has many interactions for popular items and very few for new or niche ones. A new model trained only on this data may repeat old biases.

PM questions:
  Was training data generated by a previous recommender?
  Are we only learning from what users were actually exposed to?
  Are we generating exploration traffic to collect unbiased signal?
  How do we evaluate items users never had a chance to interact with?


LATENCY AND SCALE

Recommendation systems often operate at large scale: millions of users, millions of items, real-time context, fast response requirements.

PM questions:
  How many items are in the catalog?
  How many candidates does the system generate?
  How many candidates are deeply ranked?
  What is the latency requirement?
  What happens if the ranking service is slow?
  Can recommendations be cached for common users or contexts?
  Is personalization real-time or batch?

A more accurate model that is too slow may not be usable.


BATCH VS. REAL-TIME RECOMMENDATIONS

Batch: recommendations generated periodically (e.g., every night for email campaigns, home page modules, or low-frequency personalization). Lower infrastructure cost.

Real-time: recommendations generated based on current user activity (e.g., user views a camera → immediately recommend memory cards and camera bags). Better for shopping sessions, feed ranking, and high-frequency personalization.

PM question: "Does this surface need real-time personalization, or is batch good enough?"

[!] Recommendation A/B tests often take weeks to show long-term effects. Stopping an experiment early because CTR looks positive may miss delayed negative effects — user fatigue, quality decline, or diversity loss that appear later. Define minimum experiment duration before launch.

>> A/B tests prove online impact. Guardrail metrics prevent gaming. Evaluation bias must be managed. Latency is a product constraint. Match batch vs. real-time to the surface.$M14L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.9 — Explainability, User Control, Safety, Fairness, and Privacy
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Explainability, User Control, Safety, Fairness, and Privacy',
    9,
    $M14L9$EXPLAINABILITY IN RECOMMENDATIONS

Users and internal teams may ask: "Why am I seeing this?"

Explanation examples:
  "Because you watched X"
  "Similar to items you bought"
  "Popular in your area"
  "New from a creator you follow"
  "Frequently bought together"

Explanations can improve trust and help users calibrate their expectations. But they must be accurate — bad or vague explanations feel creepy or misleading.

PM question: "Should we explain recommendations to users, and what explanation is honest and useful?"


USER CONTROL

Recommendation systems should give users meaningful control:
  Not interested / hide this item
  Show more / show less like this
  Reset recommendations
  Follow or unfollow topics/categories
  Clear history
  Block creator or category

User controls help: improve trust, collect explicit negative feedback, reduce bad recommendations, handle sensitive personal preferences.

PM question: "How can users correct the recommender when it gets something wrong?"


SAFETY AND POLICY

Recommendations can amplify harmful or low-quality content if not controlled.

Safety risks: harmful content, misinformation, low-quality products, age-inappropriate content, spam, scams, manipulative content, policy-violating items.

A recommendation system should include safety filters and policy constraints applied at the re-ranking stage.

PM question: "What should never be recommended, even if it would generate high engagement?"


FAIRNESS AND MARKETPLACE HEALTH

Recommendations affect exposure. If the system always recommends the same popular sellers, creators, restaurants, or content sources, others may get no visibility. This can harm marketplace health.

PM questions:
  Are new items and new creators getting exposure?
  Are small sellers completely buried by popular ones?
  Are users seeing diverse options across price, style, and source?
  Are ranking rules transparent enough for affected suppliers/creators?
  Are there appeal mechanisms for those who feel unfairly ranked?

PM question: "Who benefits and who loses from this ranking system?"


PRIVACY

Recommendation systems use user behavior data that can be sensitive.

Privacy considerations:
  What data is collected, and did users consent?
  Is sensitive data used (health searches, financial behavior)?
  Can users delete history?
  Are recommendations revealing private inferences?
  Are there sensitive categories to avoid using as signals?

Example: if a product recommendation reveals a private medical condition or personal situation, that can cause real harm.

PM question: "Could this recommendation reveal something sensitive about the user that they did not choose to disclose?"

[!] Safety and fairness decisions belong to the PM, not just the trust and safety team. The recommendation system encodes priorities through its scoring function and re-ranking rules. If safety is not explicitly designed in, the model will optimize for engagement — which can include harmful content.

>> Explainability builds trust. User control collects better signals. Safety is a re-ranking requirement. Fairness affects the whole ecosystem. Privacy protects users.$M14L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.10 — Twelve Common Failure Modes
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Twelve Common Failure Modes',
    10,
    $M14L10$Understanding how recommendation systems fail helps PMs prevent problems before they reach users.


1. REPETITIVE RECOMMENDATIONS
The user sees the same type of item again and again. The system found a signal and over-exploits it.
PM question: "Are we measuring item diversity in the final list?"


2. POPULARITY BIAS
Only already-popular items get exposure. New and niche items can never gain traction.
PM question: "Are we actively promoting new items and measuring exposure distribution?"


3. COLD START FAILURE
New users get poor recommendations. New items never surface.
PM question: "What is the specific strategy for cold-start users and items?"


4. CLICKBAIT OPTIMIZATION
The model optimizes clicks but not satisfaction. High CTR with poor downstream value.
PM question: "Are we measuring conversion, completion, and return rate — not just clicks?"


5. FILTER BUBBLE
The user sees only a narrow range of content, progressively narrowing over time.
PM question: "Are we measuring topic diversity over time, not just relevance at each request?"


6. LOW DIVERSITY IN THE TOP LIST
The top N items are nearly identical. The experience fails for discovery.
PM question: "Does re-ranking enforce minimum diversity in the final list?"


7. BAD FEEDBACK INTERPRETATION
A click is treated as strong positive signal even when the user bounced immediately.
PM question: "What engagement quality signals do we use beyond raw click rate?"


8. POSITION BIAS IN TRAINING DATA
Items shown at rank 1 accumulate clicks regardless of quality. Model incorrectly learns they are better.
PM question: "How are we debiasing training data for position effects?"


9. LATENCY ISSUES
The recommender is too slow, hurting conversion or page experience.
PM question: "Is recommendation latency within the product requirement?"


10. SAFETY FAILURES
The system recommends harmful, misleading, or policy-violating items because engagement is high.
PM question: "Are safety filters applied before results are shown to users?"


11. PRIVACY CREEPINESS
The recommendation feels too personal or reveals a sensitive inference the user did not intend to share.
PM question: "Did we audit recommendations for sensitive signal combinations?"


12. NO BUSINESS IMPACT
Offline ranking metrics improve but online outcomes do not change.
PM question: "What online experiment or business metric proves that this model actually improved the product?"

[!] Failure modes 4, 5, and 12 are the most insidious because they are invisible in offline metrics. A model can score well on NDCG, generate high CTR, and still be slowly degrading user satisfaction and trust. That is why long-term metrics and guardrail metrics are non-negotiable.

>> Most recommendation failures come from optimizing the wrong metric — not from building a bad model. Define what "good recommendation" means before building the system.$M14L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 14.11 — PM Checklist, How to Explain, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist, How to Explain, and the Memory Shortcut',
    11,
    $M14L11$PM CHECKLIST FOR RECOMMENDATION SYSTEMS

1.  What user problem are we solving with recommendations?
2.  What are we recommending, and where will recommendations appear?
3.  How many items can we show at once?
4.  What user data is available?
5.  What item data is available?
6.  What interaction signals exist (clicks, purchases, watches, skips, returns)?
7.  Which signals are positive, and which are negative?
8.  Is CTR sufficient or do we need downstream satisfaction signals?
9.  Is this search ranking, feed ranking, or recommendation?
10. Do we need multi-stage candidate generation?
11. What candidate sources are used?
12. What model scores candidates, and what does the score represent?
13. What re-ranking rules are needed (diversity, freshness, safety, availability)?
14. How do we handle cold start for new users?
15. How do we handle cold start for new items?
16. How do we combat popularity bias?
17. How do we account for position bias in training?
18. What offline ranking metrics are used?
19. What online product metrics matter?
20. What guardrail metrics are required?
21. What A/B test will prove real product impact?
22. Is latency acceptable?
23. Is cost acceptable?
24. Can recommendations be explained to users?
25. Can users give feedback and correct the recommender?
26. What should never be recommended regardless of engagement?
27. Are there privacy concerns with the signals being used?
28. Are there fairness or marketplace-health concerns?
29. How will we monitor diversity, feedback loops, and drift?
30. What business outcome should improve?


HOW TO EXPLAIN TO LEADERSHIP

Simple version:
  "A recommendation system ranks many possible items and chooses what to show each user. It usually works in stages: first generating a smaller candidate set, then scoring those candidates, then re-ranking based on product constraints like diversity, freshness, safety, and business rules."

E-commerce example:
  "The model recommends products by combining user behavior, item metadata, and contextual signals. Offline metrics show better ranking quality, but the launch decision depends on online metrics: conversion, add-to-cart rate, revenue, return rate, and customer satisfaction. We will also track diversity, latency, and negative feedback as guardrails."

Content feed example:
  "The new content ranking model improves predicted engagement, but we should not optimize only for clicks or watch time. We will measure long-term retention, hide/report rate, satisfaction, and diversity to ensure the feed remains healthy for users and for content creators."


THE MEMORY SHORTCUT

A recommendation system is: **a ranking system that chooses the best items to show a user.**

Remember: User + item + context → candidates → ranking → re-ranking → user experience

Use recommendation systems when:
  There are many possible items to show
  Users need help discovering relevant options
  Personalization can improve experience
  Ranking order affects user behavior
  The product has search, feed, content, product, or next-action surfaces

Measure with:
  Offline: Precision@K, Recall@K, NDCG, MRR, MAP
  Online: CTR, conversion, add-to-cart, watch time, retention, satisfaction, revenue, long-term engagement
  Guardrails: diversity, freshness, latency, negative feedback, return rate, safety, fairness, privacy

Watch for:
  Popularity bias and position bias
  Cold start for users and items
  Repetitive recommendations and filter bubbles
  Over-optimizing clicks at the expense of satisfaction
  Feedback loops narrowing the experience
  Privacy creepiness and safety failures
  Offline metrics not translating to business impact

The most important PM question:
  **Are we ranking items in a way that improves real user value and long-term product health — not just short-term clicks?**$M14L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 14.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'How does a recommendation system differ from a standard binary classification model?',
    '["A recommendation system ranks many items to find the best ones for a specific user at a specific moment, while a binary classifier simply predicts yes or no for a single item","A recommendation system uses more training data than a binary classifier and therefore achieves higher accuracy","A recommendation system always uses neural networks, while binary classifiers can use simpler models","A recommendation system predicts user behavior, while a binary classifier predicts item attributes"]',
    0
  );

  -- Q2 — Lesson 14.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'Why do large-scale recommendation systems use a multi-stage pipeline instead of scoring all items with the ranking model?',
    '["Scoring every item in a large catalog with a deep ranking model for every user in real time is computationally impossible — candidate generation quickly narrows millions of items to thousands before the expensive ranker evaluates them","Multi-stage pipelines improve recommendation quality by allowing different models to specialize in different aspects of the user experience","The ranking model can only process a limited number of features, so candidate generation pre-selects features before scoring","Multi-stage systems are required to comply with data privacy regulations that limit how many items can be evaluated per user request"]',
    0
  );

  -- Q3 — Lesson 14.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'A recommendation system relies entirely on collaborative filtering. It performs well for established products but fails to surface any new items. What is the root cause?',
    '["Cold start — collaborative filtering requires interaction data, and new items have none, so they are invisible to the model regardless of their quality or relevance","The model needs more user data to learn which users are similar enough to generalize to new items","The training data needs to be refreshed more frequently to include recent item additions","New items should be handled by a separate binary classifier before being added to the collaborative filtering corpus"]',
    0
  );

  -- Q4 — Lesson 14.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'A two-tower model precomputes item embeddings nightly. A user is browsing in real time. How does the system generate recommendations quickly?',
    '["The user tower computes a fresh user embedding from current session behavior, then the system uses approximate nearest-neighbor search to find the precomputed item embeddings closest to the user embedding — no full re-scoring of all items is needed","The system scores all items using the user tower output against each item in the catalog in real time","The system uses the precomputed item embeddings to train a new user embedding from scratch at each request","The system caches the top-1000 recommendations for every user nightly so no real-time computation is needed"]',
    0
  );

  -- Q5 — Lesson 14.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A music app''s recommendation model aggressively exploits the user''s strong preference for jazz. After three months, users report feeling bored and engagement declines. What trade-off was neglected?',
    '["Exploration — the system never tried to discover new preferences outside jazz, so the experience became repetitive and the model never learned about other potential interests","Calibration — the model''s confidence in jazz preferences was too high and needs to be regularized","Diversity in the training data — the model needs more varied interaction data to recommend different genres","Cold start handling — new genres were not properly seeded into the candidate generation stage"]',
    0
  );

  -- Q6 — Lesson 14.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'Two recommendation lists each contain 3 relevant items in a top-10 result. List A has them at positions 1, 2, 3. List B has them at positions 8, 9, 10. Which metric distinguishes these lists and declares List A better?',
    '["NDCG (Normalized Discounted Cumulative Gain) — it applies a discount to lower positions, so the same relevant items score much higher when they appear near the top","Precision@10 — it counts relevant items in the top 10 and would give both lists the same score since both have 3 relevant items","Recall@10 — it measures what fraction of all relevant items are captured in the top 10 and does not consider position","MRR (Mean Reciprocal Rank) — it measures the position of the first relevant result and both lists would score 1.0"]',
    0
  );

  -- Q7 — Lesson 14.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A product recommendation model increases click-through rate by 15% in an A/B test. The team wants to ship it immediately. What should the PM check before approving launch?',
    '["Whether downstream metrics — add-to-cart rate, conversion, return rate, and long-term retention — also improved, since higher CTR can come from clickbait-style recommendations that disappoint users after clicking","Whether the offline NDCG metric also improved by at least 15% to confirm the ranking quality is genuinely better","Whether the A/B test reached statistical significance at p < 0.01 rather than the standard p < 0.05","Whether the model''s latency is below 100ms since faster recommendations tend to generate higher click rates"]',
    0
  );

  -- Q8 — Lesson 14.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A recommendation team trained a new model on historical interaction data from the old recommendation system. After launch, the new model still mostly surfaces the same popular items as the old one. What is the root cause?',
    '["Evaluation bias — the historical data reflects what the old system chose to show, not what users would have engaged with from the full catalog, so the new model learned the old system''s biases rather than true user preferences","The new model architecture is too similar to the old one and needs a fundamentally different approach","The training data is too old and needs to be refreshed with more recent interactions","The candidate generation stage is too narrow and should include more sources to surface diverse items"]',
    0
  );

  -- Q9 — Lesson 14.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A marketplace recommendation system consistently ranks the 20 most popular sellers at the top, even for users whose behavior suggests interest in niche products. Small sellers report zero discovery traffic. What is the PM responsibility?',
    '["Define re-ranking rules that explicitly balance popularity with novelty, personalization, and marketplace fairness — exposure distribution is a product policy decision that must be encoded into the system","Ask the data science team to retrain the model with more balanced data to naturally surface smaller sellers","Remove popularity as a ranking signal and rely entirely on personalization signals","Accept the result as a natural market outcome and focus instead on helping small sellers improve their conversion rate"]',
    0
  );

  -- Q10 — Lesson 14.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A video recommendation model achieves excellent NDCG in offline evaluation and high watch time in the first week after launch. After two months, new user acquisition slows and existing users report feeling "stuck in a loop." Which failure mode best explains this?',
    '["Filter bubble and feedback loop — the model found content the user engages with and narrowed recommendations to that content, which drove engagement short-term but created a self-reinforcing loop that gradually reduced content diversity and user satisfaction","Cold start failure — the model struggles with new users who have little history","Popularity bias — the model is over-recommending already popular content to all users regardless of individual preference","Position bias — items shown higher are getting more engagement simply because of their position, inflating watch time metrics"]',
    0
  );

  -- Q11 — Lesson 14.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'The most important PM question for a recommendation system is: "Are we ranking items in a way that improves real user value and long-term product health?" Which checklist item most directly operationalizes this?',
    '["What guardrail metrics — diversity, latency, negative feedback rate, return rate — are required alongside the primary success metric to prevent gaming the system?","What offline ranking metric (Precision@K, Recall@K, NDCG) will we use to evaluate the model before launch?","How many candidate sources does the system use in the first stage of the pipeline?","Is the ranking model a neural network or gradient-boosted trees?"]',
    0
  );

end $$;
