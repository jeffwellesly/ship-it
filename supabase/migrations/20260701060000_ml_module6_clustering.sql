-- ML for Everyone — Module 6: Clustering
-- 11 lessons covering clustering from a PM perspective

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
    'Module 6: Clustering',
    'Learn how clustering discovers hidden groups in unlabeled data — and how to turn those groups into actionable customer segments, product insights, and operational strategies.',
    6
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.1 — What Is Clustering and When Should You Use It?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is Clustering and When Should You Use It?',
    1,
    $M6L1$Clustering is a machine learning technique used to find natural groups in data.

Unlike regression or classification, clustering does not start with a known answer. There is no label like churned/not churned, fraud/not fraud, or sales amount. Instead, clustering asks:

**"Which data points look similar to each other?"**

**Clustering groups similar things together when we do not already know the groups.**

Examples:
  Group similar customers
  Group similar products
  Group similar stores
  Group similar support tickets
  Group similar browsing behaviors
  Find unusual outliers

Clustering is mainly used for exploration, segmentation, and pattern discovery.


SUPERVISED VS. UNSUPERVISED LEARNING

Supervised learning: you have historical examples with known answers.
  Example: customer data + whether they churned → the model learns to predict churn.
  Models: linear regression, logistic regression, decision trees, random forests.

Unsupervised learning: you have data but no known answer.
  Example: customer data, but no predefined segment labels → the model finds hidden structure.
  Models: k-means clustering, hierarchical clustering, DBSCAN.

Clustering is unsupervised learning. This means there is no single "correct answer" in the same way there is for churn prediction.


WHEN SHOULD YOU USE CLUSTERING?

  Business question                          | Clustering use
  What types of customers do we have?        | Customer segmentation
  Which products behave similarly?           | Product grouping
  Which stores have similar demand patterns? | Store clustering
  Which support tickets are similar?         | Ticket theme discovery
  Which transactions look unusual?           | Anomaly detection
  Which markets behave similarly?            | Market segmentation

Use clustering when you are exploring and do not know the groups in advance.

Do not use clustering when you already know the exact label you want to predict. If you already know who churned and want to predict it → use classification. If you want to discover natural customer groups → use clustering.

[!] A common mistake is using clustering to "confirm" groups that were defined in advance. Clustering discovers structure — it should not be used to rubber-stamp decisions already made.

>> Clustering answers: "What natural groups exist here?" Classification answers: "Which known group does this belong to?"$M6L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.2 — Inputs, Outputs, Similarity, Distance, and Scaling
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Inputs, Outputs, Similarity, Distance, and Scaling',
    2,
    $M6L2$WHAT ARE THE INPUTS?

The inputs are features — and there is no target column.

Example: customer clustering.

Features may include:
  Number of purchases, average order value, total spend,
  days since last purchase, website visits, discount usage,
  product categories purchased, return rate, email engagement.

Training data example:

  Customer | Purchases | Avg order | Days since purchase | Discount | Visits
  A        | 20        | $120      | 5                   | Low      | 80
  B        | 2         | $25       | 100                 | High     | 10
  C        | 15        | $200      | 8                   | Low      | 60
  D        | 1         | $15       | 200                 | High     | 5

The clustering model may group A and C together, B and D together.


WHAT IS THE OUTPUT?

The output is a cluster assignment — a group number for each data point.

  Customer | Cluster
  A        | Cluster 1
  B        | Cluster 2
  C        | Cluster 1
  D        | Cluster 2

The model does not automatically know what the clusters mean. It only gives group numbers. The PM and analytics team must interpret them.

This interpretation step is critically important. Clustering is not finished when the algorithm gives cluster numbers. It is finished only when the clusters are understandable and actionable.


SIMILARITY AND DISTANCE

The heart of clustering is similarity. The model decides: are these two data points similar?

Similarity is usually measured using distance. Close points are similar; far points are different.

Common distance measures:
  Euclidean distance — straight-line distance. Best for scaled numeric features.
  Manhattan distance — absolute differences. Like moving on city blocks.
  Cosine similarity — measures direction rather than size. Common for text and recommendations.
  Jaccard similarity — measures overlap between sets. Good for categorical features.


WHY SCALING IS CRITICAL

Suppose you cluster customers using:
  Age: 18 to 80
  Income: $20,000 to $200,000
  Website visits: 0 to 1,000

Income has much larger numbers than age. A $10,000 income difference may look enormous compared with a 10-year age difference — even if age matters more for your business question. Income will dominate the distance calculation and distort the clusters.

Solution: standardize features so each has mean = 0 and standard deviation = 1.

[!] Scaling is one of the most important steps in clustering. Skipping it often produces clusters driven by whichever feature has the largest scale, not by actual similarity.

PM question: "Were the numeric features scaled or normalized before clustering?"$M6L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.3 — K-Means: How It Works
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'K-Means: How It Works',
    3,
    $M6L3$K-means is the most commonly used clustering algorithm.

The "k" means the number of clusters you want. k = 3 means three groups; k = 5 means five groups.

K-means tries to group data points around cluster centers called **centroids**.

A centroid is the center of a cluster — like the average member of that group.

Example centroid for Cluster 1:
  Purchases = 18, avg order value = $150, days since purchase = 7, discount usage = low.
This represents the typical customer in Cluster 1.


HOW K-MEANS LEARNS

Step 1: Choose k (the number of clusters).
Step 2: Randomly place k centroids.
Step 3: Assign each data point to the nearest centroid.
Step 4: Move each centroid to the average position of the points assigned to it.
Step 5: Reassign all points to the nearest updated centroid.
Step 6: Repeat steps 4 and 5 until clusters stop changing.

**K-means keeps moving cluster centers until the groups become stable.**


WHY FEATURE SELECTION MATTERS

Clustering results depend heavily on which features you choose.

If you cluster customers using only demographics (age, income, location) → you get demographic segments.
If you cluster using behavior (purchase frequency, discount sensitivity, recency) → you get behavioral segments.

These are different. Neither is automatically right or wrong. It depends on the business question.

PM question: "What kind of similarity do we actually care about here?"

If the goal is marketing → behavior may matter more than demographics.
If the goal is logistics → geography and delivery patterns may matter more.
If the goal is personalization → usage and preference signals may matter more.

[!] Choosing features is a business decision, not just a technical one. The PM should own this choice with the data team.

>> The algorithm groups what you give it. If you give it the wrong features, you get the wrong clusters.$M6L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.4 — Choosing K: Elbow Method and Silhouette Score
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Choosing K: Elbow Method and Silhouette Score',
    4,
    $M6L4$K-means requires you to choose k in advance. This is not always easy.

Too few clusters (e.g., k = 2): too broad — important differences are hidden.
Too many clusters (e.g., k = 20): too fragmented — impossible for the business to act on.

The right k should be both statistically reasonable and business-useful.


THE ELBOW METHOD

K-means tries to minimize the total distance between each point and its cluster centroid. This is called inertia.

As k increases, inertia decreases — more clusters means each cluster can be tighter.

But after a point, adding more clusters gives only small improvement.

That turning point is called the elbow.

Example:
  k = 1: very high inertia
  k = 2: large improvement
  k = 3: large improvement
  k = 4: moderate improvement
  k = 5: small improvement
  k = 6: tiny improvement

The elbow may be at k = 3 or k = 4.

The elbow method is a guide, not a final answer. Business usefulness still determines the best k.


SILHOUETTE SCORE

The silhouette score measures how well-separated the clusters are.

It asks: is each point close to its own cluster and far from other clusters?

Range:
  Close to +1 → good, distinct clusters
  Around 0 → overlapping clusters
  Negative → points may be in the wrong cluster

A high silhouette score means clusters are more distinct. But again, statistical quality does not guarantee business usefulness.


WEAKNESSES OF K-MEANS

1. You must choose k in advance.
2. Results depend on random starting positions — different runs may give different clusters.
   Fix: run k-means multiple times and choose the best result.
3. Sensitive to outliers — extreme points pull centroids away from useful locations.
4. Assumes round-ish clusters — struggles when clusters are irregular or overlapping.
5. Scaling matters — unscaled features distort results.
6. Clusters may not be actionable — mathematically valid groups may not be useful for the business.

[!] The elbow method and silhouette score help narrow down k. The final choice should always be validated against business criteria — can you name the segments and treat them differently?

>> The right number of clusters is the smallest number that creates segments you can actually act on.$M6L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.5 — K-Means Customer Segmentation Example
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'K-Means Customer Segmentation Example',
    5,
    $M6L5$Business problem: a company wants to understand its customer types and design differentiated strategies.

Model: k-means clustering with k = 4.

Features used:
  Purchase frequency, average order value, days since last purchase,
  discount usage rate, website visits.


CLUSTER 1: LOYAL HIGH-VALUE CUSTOMERS

Profile:
  High purchase frequency
  High average order value
  Recent last purchase
  Low discount usage
  Frequent website visits

Size: 15% of customers.

Business actions:
  VIP benefits and early product access
  Loyalty rewards and exclusive events
  Premium customer success outreach
  Test price-insensitive premium upgrades


CLUSTER 2: DISCOUNT-DRIVEN BUYERS

Profile:
  Medium purchase frequency
  Low to medium order value
  High discount usage
  Purchase spikes around promotions

Size: 28% of customers.

Business actions:
  Targeted promotions with margin awareness
  Bundle offers to increase basket size
  Test gradually reducing discount dependency
  Avoid training these users to wait for sales


CLUSTER 3: INACTIVE CUSTOMERS

Profile:
  Low purchase frequency
  Long time since last purchase
  Low website activity

Size: 30% of customers.

Business actions:
  Win-back email campaigns
  Reactivation offers with time limit
  Feedback surveys to understand churn reason
  Decision: invest or deprioritize based on historical value


CLUSTER 4: BROWSERS WITH LOW CONVERSION

Profile:
  High website visits
  Low purchase rate
  Moderate interest signals

Size: 27% of customers.

Business actions:
  Improve product education and discovery
  Retargeting campaigns
  Better checkout UX and nudges
  Test personalized recommendations

The model gives cluster numbers. The PM makes them meaningful.

[!] Always ask: what different action will we take for each cluster? If all four clusters get the same email, this segmentation adds no value.

>> Segmentation is only valuable when it drives differentiated action. Clusters without different treatments are just labels.$M6L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.6 — Hierarchical Clustering and DBSCAN
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Hierarchical Clustering and DBSCAN',
    6,
    $M6L6$HIERARCHICAL CLUSTERING

Hierarchical clustering builds a tree of clusters. It does not require choosing k in advance.

The most common version is agglomerative (bottom-up):

  Step 1: Start with every data point as its own cluster.
  Step 2: Find the two closest clusters.
  Step 3: Merge them.
  Step 4: Repeat until everything is one large cluster.
  Step 5: Cut the tree at a chosen level to get final clusters.

Analogy: imagine a classroom where every student starts alone. The two most similar students pair up first. Similar pairs join into groups. Groups join into larger groups. The tree shows this full history.


THE DENDROGRAM

A dendrogram is the tree diagram produced by hierarchical clustering.

  At the bottom: each data point starts separately.
  As you move up: similar points merge into small clusters, then into larger ones.
  The height where clusters merge shows how different they are.

If two clusters merge at a low height → very similar.
If they merge at a high height → very different.

PMs can use the dendrogram to visually decide where to cut — how many clusters makes sense. A big jump in height before a merge is a natural cut point.


LINKAGE METHODS

Hierarchical clustering needs a rule for measuring distance between clusters.

  Single linkage   — distance = closest pair of points. Can create chain-like clusters.
  Complete linkage — distance = farthest pair. Creates compact clusters.
  Average linkage  — distance = average of all pairs. Balanced.
  Ward linkage     — minimizes increase in within-cluster variance. Often creates the most useful clusters.

PM question: "Which linkage method was used and why?"


K-MEANS VS. HIERARCHICAL

  Topic                | K-means              | Hierarchical
  Need k upfront?      | Yes                  | No
  Output               | k clusters           | Dendrogram + clusters
  Scale                | Better for large data| Better for smaller data
  Interpretability     | Medium               | High visual structure
  Assigning new points | Easy (nearest centroid) | Less direct

Use k-means for large-scale production segmentation.
Use hierarchical clustering to explore structure and relationships visually.


DBSCAN

DBSCAN groups points that are packed closely together and identifies outliers (noise).

Use it when: clusters have irregular shapes, you want to detect outliers, or you do not want to force every point into a cluster.

Example: anomaly detection. Most transactions form dense normal-behavior groups. Unusual transactions appear as isolated outliers — not assigned to any cluster.

Weakness: DBSCAN can be sensitive to parameter choices and struggles when clusters have very different densities.

[!] DBSCAN is especially useful for fraud and anomaly detection because it naturally identifies points that do not belong to any dense group. K-means always assigns every point to a cluster, even if that point is a true outlier.

>> Different clustering algorithms answer different questions. K-means scales. Hierarchical explains. DBSCAN detects outliers.$M6L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.7 — Clustering Applications: Products, Behavior, Support
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Clustering Applications: Products, Behavior, Support',
    7,
    $M6L7$CLUSTERING FOR PRODUCT STRATEGY

Business problem: a company wants to understand which products behave similarly to make better pricing, promotion, and inventory decisions.

Input features:
  Price, margin, sales velocity, return rate, review rating, seasonality,
  customer overlap, promotion sensitivity, inventory turnover.

Possible product clusters:
  High-margin premium products → protect pricing, invest in visibility
  Low-margin high-volume products → optimize supply chain, reduce handling cost
  Seasonal products → align promotions with timing
  High-return problem products → investigate quality, improve descriptions
  Products often bought together → build bundle strategies
  Slow-moving inventory → markdown or discontinue

Business actions: pricing strategy, promotion planning, bundling, inventory optimization, quality improvement.


CLUSTERING FOR USER BEHAVIOR

Business problem: understand how different users interact with the product to personalize and reduce drop-off.

Input features:
  Session length, pages viewed, features used, time of day, frequency of visits,
  conversion behavior, search behavior, cart abandonment, device type.

Possible behavior clusters:
  Power users → advanced features, upsell, referral programs
  Casual browsers → better discovery, lighter onboarding
  Search-first users → improve search and filter experience
  Abandoned-cart users → checkout nudges and retargeting
  Mobile-only users → prioritize mobile experience

Business actions: personalize UI, create targeted nudges, simplify flows, improve recommendations, design experiments per group.


CLUSTERING FOR SUPPORT OPERATIONS

Business problem: discover the most common types of customer issues to improve help content, routing, and product quality.

Input features:
  Ticket category, keywords, sentiment, product area, resolution time,
  escalation status, customer type, region, contact channel.

Possible clusters:
  Billing confusion → improve invoicing clarity and help center
  Login issues → better recovery flows
  Delivery complaints → investigate carrier or warehouse patterns
  Product defects → escalate to product team
  Policy questions → improve FAQ and self-service
  Technical setup problems → improve onboarding

For text-heavy clustering: ticket text may need to be converted into numeric representations (embeddings) before the algorithm can compute similarity.

[!] Clustering support tickets is one of the highest-leverage places to apply clustering for a PM — it reveals systematic product gaps that individual tickets obscure.

>> The same algorithm, applied to different data, produces different business insights. Choose features that match the business question.$M6L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.8 — Evaluating Clustering: Statistical Quality and Business Usefulness
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Evaluating Clustering: Statistical Quality and Business Usefulness',
    8,
    $M6L8$Evaluating clustering is harder than evaluating supervised models. There is usually no correct answer label to compare against.

Evaluation has two sides. Both matter.


STATISTICAL QUALITY METRICS

Inertia / within-cluster sum of squares
  How close are points to their cluster centroid?
  Lower inertia = tighter clusters.
  But adding more clusters always reduces inertia — use elbow method to find a meaningful stopping point.

Silhouette score
  Are points close to their own cluster and far from other clusters?
  Range: −1 to +1. Higher is better. Check that most points score positively.

Cluster size balance
  Check whether one cluster has 95% of users and the rest are tiny.
  Extreme imbalance may indicate a problem or may reflect a real business pattern — investigate.

Stability
  Run clustering on different random samples of the data.
  Do similar clusters appear each time?
  Unstable clusters are not trustworthy enough to build strategy on.


BUSINESS USEFULNESS CHECKS

1. Are clusters interpretable?
   Can you describe each cluster in plain language?
   Bad: "Cluster 1, Cluster 2, Cluster 3."
   Good: "High-value loyal customers. Discount-driven buyers. Inactive low-engagement customers."

2. Are clusters actionable?
   Can you treat each cluster differently?
   If all clusters get the same email, segmentation is pointless.

3. Are clusters large enough?
   A segment with 0.1% of users may not warrant a dedicated strategy unless it is very valuable or very risky.

4. Are clusters stable?
   If clusters change dramatically when re-run, they may not be reliable enough for production use.

5. Do clusters predict future behavior?
   After clustering, check whether clusters differ in actual future outcomes.
   Do clusters have different retention rates, revenue, conversion, support cost, or fraud risk?
   This is one of the most useful validation steps a PM can drive.


CLUSTER PROFILING

Cluster profiling means calculating and comparing the key metrics for each cluster.

Example:

  Metric                  | Cluster 1 | Cluster 2 | Cluster 3
  Avg spend               | $500      | $80       | $220
  Purchase frequency      | High      | Low       | Medium
  Discount usage          | Low       | High      | Medium
  Days since last purchase| 5         | 120       | 30
  Return rate             | Low       | Medium    | High

Then name the clusters:
  Cluster 1 → Loyal premium customers
  Cluster 2 → Inactive discount shoppers
  Cluster 3 → Moderate buyers with high returns

Profiling turns mathematical groups into business understanding.

>> Profiling is the bridge between the algorithm's output and the team's ability to act. Never skip it.$M6L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.9 — Clustering vs. Classification, Recommendations, and Personas
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Clustering vs. Classification, Recommendations, and Personas',
    9,
    $M6L9$CLUSTERING VS. CLASSIFICATION

  Topic           | Clustering               | Classification
  Learning type   | Unsupervised             | Supervised
  Has labels?     | No                       | Yes
  Output          | Group assignment         | Predicted class
  Example         | Discover customer types  | Predict churn
  Evaluation      | Harder, exploratory      | Easier, compare with truth
  Use when        | You do not know groups   | You know what to predict

Simple memory: clustering discovers groups. Classification predicts known categories.

A common workflow combines both:
  Step 1: Use clustering to discover segments.
  Step 2: Profile and name the segments.
  Step 3: Validate that segments behave differently.
  Step 4: Build a classification model that assigns new users to the discovered segments in real time.

This is useful because clustering may be too slow to run for every new incoming user.


CLUSTERING VS. RECOMMENDATIONS

Clustering can support recommendations but is not the same thing.

Clustering: groups similar users or products.
  "This user belongs to the premium fitness enthusiast segment."

Recommendation: predicts what specific item a specific user will likely want.
  "Recommend Product A, B, and C to this user."

Clustering can be one input into a recommendation system, but modern recommendation systems use more advanced approaches (collaborative filtering, matrix factorization, neural methods).


CLUSTERING VS. PERSONAS

Marketing teams define personas like "budget-conscious parent" or "tech enthusiast."

Clustering can help create data-driven personas — but with important caveats:

  A good cluster-based persona needs:
  Data support from the clustering
  A clear behavioral or attitudinal pattern
  Business relevance
  Actionability — different treatment is possible
  Validation — test whether targeting the segment differently actually improves outcomes

Cluster personas should be tested, not assumed.

Example: if you send different messages to each cluster, do conversion rates improve?

[!] A clustering exercise that produces a set of segments nobody acts on is a research project, not a product decision. Drive toward validation from the start.

>> Discover with clustering. Predict with classification. Act with both — but validate with business outcomes.$M6L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.10 — Clustering for Anomaly Detection and Fairness Considerations
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Clustering for Anomaly Detection and Fairness Considerations',
    10,
    $M6L10$CLUSTERING FOR ANOMALY DETECTION

Clustering can identify unusual cases by finding points that do not fit neatly into any cluster.

The idea:
  Most normal data points belong to clusters.
  Outliers are points that are far from any cluster center (k-means) or
  that do not belong to any dense group (DBSCAN).

Examples of anomaly detection use cases:
  Unusual transactions (fraud or payment errors)
  Strange login behavior (account takeover)
  Rare support ticket patterns (emerging product issues)
  Abnormal machine sensor readings (predictive maintenance)
  Suspicious seller or buyer behavior (marketplace integrity)

Important caveat: clustering does not automatically prove something is wrong or harmful. It only says "this point is unusual compared with others." A human or supervised model usually still needs to validate flagged cases.


NAMING CLUSTERS WELL

Good cluster names are simple, memorable, and grounded in data.

Good names:
  Loyal high-value customers
  Discount-driven buyers
  Inactive customers
  Heavy users
  New explorers
  High-support customers

Avoid names that are judgmental or not supported by the data.

Bad names:
  Bad customers
  Cheap customers
  Lazy users
  Unimportant users

The name should help teams take action without introducing bias into how they treat customers.


FAIRNESS AND BIAS CONSIDERATIONS

Clusters may unintentionally reflect sensitive attributes or protected groups.

Example: a cluster may map strongly to income level, geographic region, race, gender, or age — in ways that create unfair or discriminatory treatment when acted on.

This can happen even when sensitive attributes are not included as features, because other features may be proxies.

PM questions:
  "Could any of these clusters correlate with protected attributes?"
  "If we treat Cluster X differently, could that disadvantage a legally protected group?"
  "Have we audited the cluster composition across demographic dimensions?"

[!] Fairness is a PM responsibility, not just a data science responsibility. Clusters that look like neutral "behavior segments" may still encode unfair patterns.

>> Anomaly detection adds a new use case for clustering. Fairness concerns apply to all segmentation work.$M6L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 6.11 — PM Checklist, What Can Go Wrong, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist, What Can Go Wrong, and the Memory Shortcut',
    11,
    $M6L11$WHAT CAN GO WRONG

1. Bad feature selection
   Wrong features → wrong clusters. Clustering customers by age alone misses behavioral differences.
   PM question: "Are these features aligned with the business question?"

2. No scaling
   Features with large values dominate distance calculations.
   PM question: "Were numeric features scaled or normalized?"

3. Too many clusters
   The algorithm produces 15 clusters but the team can act on only 4.
   PM question: "How many segments can we realistically use?"

4. Clusters are not interpretable
   No one can explain what the clusters mean in plain language.
   PM question: "Can we describe each cluster clearly?"

5. Clusters are not actionable
   Every cluster gets the same treatment. Segmentation adds no value.
   PM question: "What different action will we take for each cluster?"

6. Clusters are unstable
   Different runs produce very different results.
   PM question: "Are the clusters stable across time and samples?"

7. Outliers distort clusters
   Extreme data points pull centroids away from useful positions.
   PM question: "How did we handle outliers?"

8. Bias and fairness issues
   Clusters may unintentionally reflect protected attributes.
   PM question: "Could these clusters lead to unfair or discriminatory outcomes?"

9. Treating clusters as objective truth
   Clusters are patterns found by an algorithm, not natural laws.
   PM question: "Have we validated that segments behave differently on real future outcomes?"

10. No link to business impact
    The clustering is mathematically clean but improves no metric.
    PM question: "How will using these clusters improve conversion, retention, cost, satisfaction, or efficiency?"


PM CHECKLIST FOR CLUSTERING

1.  What business question are we exploring?
2.  What objects are we clustering: customers, products, stores, tickets?
3.  What features are included, and why?
4.  Were features scaled or normalized?
5.  What distance or similarity measure is being used?
6.  Which clustering algorithm is being used?
7.  If k-means, how was k chosen?
8.  Were elbow method or silhouette score used?
9.  Are the clusters stable across different samples?
10. Are outliers handled?
11. Are clusters interpretable?
12. Can we name each cluster clearly?
13. Are clusters actionable?
14. Are cluster sizes practical for the business?
15. Do clusters differ on important business outcomes?
16. Will different teams treat each cluster differently?
17. How will new data points be assigned to clusters?
18. How often will clusters be refreshed?
19. Could the clusters create fairness or bias issues?
20. What business metric should improve because of this segmentation?


HOW TO EXPLAIN TO LEADERSHIP

Simple version:
  "We used clustering to discover natural groups in the data without predefining the groups. The model grouped customers based on similarity across selected behavioral features. After profiling the clusters, we identified meaningful segments that can support differentiated product, marketing, operations, or support strategies."

Customer segmentation example:
  "The analysis identified four customer segments: loyal high-value customers, discount-driven buyers, inactive customers, and active browsers with low conversion. Each segment has different behavior and should receive a different strategy. The next step is to test whether segment-specific actions improve retention, conversion, or revenue."

Support operations example:
  "We clustered support tickets based on topic, sentiment, and resolution patterns. The clusters revealed recurring billing confusion, technical setup issues, and delivery complaints — systematic product gaps that individual tickets obscure. This can drive improvements in self-service content, routing, and product quality."


THE MEMORY SHORTCUT

Clustering is: **finding hidden groups in unlabeled data.**

  Features → similarity / distance → groups → profiling → naming → action

Use it when: you do not already know the groups, you want to discover customer or product segments, you want to find behavior patterns, or you want to identify outliers.

Measure it with: elbow method, silhouette score, cluster stability, cluster interpretability, actionability, and whether clusters predict different future outcomes.

Watch for: bad feature selection, no scaling, too many clusters, unstable clusters, outlier distortion, non-actionable segments, bias or fairness risks, and treating clusters as objective truth.

The most important PM question:
  **Can we clearly name these groups, treat them differently, and prove that doing so improves a business outcome?**$M6L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 6.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'What makes clustering different from classification?',
    '["Clustering discovers groups without predefined labels; classification predicts known categories from labeled training data","Clustering only works on numeric data; classification works on any data type","Clustering requires more training data than classification","Clustering predicts a probability; classification predicts a number"]',
    0
  );

  -- Q2 — Lesson 6.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'Why is feature scaling critical before running k-means clustering?',
    '["Features with large numeric ranges dominate distance calculations and distort clusters, regardless of their actual business importance","Scaling improves model training speed but does not affect cluster quality","K-means cannot process features on different scales without causing an error","Scaling is only needed when mixing numeric and categorical features"]',
    0
  );

  -- Q3 — Lesson 6.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'A data team clusters customers using only age and income. A PM suspects the segments are not useful for marketing. What is the most likely root cause?',
    '["Wrong feature selection — behavioral features like purchase frequency and discount usage would better capture marketing-relevant similarity","The algorithm needs more iterations to converge on better clusters","K was set too low, creating clusters that are too broad","The data was not split into training and test sets before clustering"]',
    0
  );

  -- Q4 — Lesson 6.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'The elbow method suggests k = 4, but the business team says they can only act on 3 segments. What should the PM do?',
    '["Use k = 3 — the right k is the smallest number that creates actionable segments, not just the statistical optimum","Override the business team and use k = 4 because the elbow method is statistically correct","Run the elbow method again with a larger range of k values","Use the silhouette score instead, which will confirm k = 4"]',
    0
  );

  -- Q5 — Lesson 6.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'After k-means produces four customer clusters, the marketing team plans to send the same promotional email to all four groups. What does this reveal?',
    '["The segmentation has no business value — clustering is only useful when different clusters receive different treatments","The clustering failed and should be rerun with a different k","The clusters are not statistically valid","The marketing team needs to review the silhouette scores"]',
    0
  );

  -- Q6 — Lesson 6.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'When is DBSCAN a better choice than k-means for clustering?',
    '["When clusters have irregular shapes and you want to identify outliers that do not belong to any dense group","When you need to cluster millions of customers quickly in a production environment","When you need to choose the number of clusters upfront for operational consistency","When the dataset has only numeric features and no categorical variables"]',
    0
  );

  -- Q7 — Lesson 6.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A PM uses clustering to group support tickets. Which outcome would be most valuable?',
    '["Discovering that 40% of tickets relate to billing confusion — a systematic product gap that individual tickets do not reveal","Confirming that tickets from enterprise customers take longer to resolve","Producing 12 statistically distinct clusters with high silhouette scores","Finding that support tickets can be predicted from customer plan type"]',
    0
  );

  -- Q8 — Lesson 6.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A clustering solution has a high silhouette score. What additional validation should the PM require?',
    '["Check whether clusters differ on real future business outcomes like retention, revenue, or conversion — statistical quality does not guarantee business usefulness","No additional validation is needed since a high silhouette score confirms the clusters are correct","Run the same algorithm on a larger dataset to confirm the score holds","Convert the clustering to a classification model before validating"]',
    0
  );

  -- Q9 — Lesson 6.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A company discovers four customer segments through clustering and then builds a classification model to assign new customers to segments. Why is this useful?',
    '["Clustering may be too slow for real-time assignment — the classifier can assign new users to known segments instantly at scale","The classification model improves the original clustering quality","New customers cannot be assigned to existing clusters without rerunning k-means","Classification models always outperform clustering for segmentation accuracy"]',
    0
  );

  -- Q10 — Lesson 6.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A clustering model groups customers into segments based on purchase behavior. The PM notices that one segment maps strongly to a specific geographic region with lower income. What should happen next?',
    '["Audit whether treating this cluster differently could create unfair outcomes for a protected group — geographic and income proxies can encode discriminatory patterns","Remove geography from the feature set and rerun clustering","Reduce the number of clusters so the geographic segment merges with a larger group","Confirm the cluster has a low silhouette score and exclude it from the analysis"]',
    0
  );

  -- Q11 — Lesson 6.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the most important PM question for any clustering project?',
    '["Can we clearly name these groups, treat them differently, and prove that doing so improves a business outcome?","What silhouette score did the clustering achieve?","How many iterations did k-means take to converge?","Was Ward or average linkage used in the hierarchical method?"]',
    0
  );

end $$;
