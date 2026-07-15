-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 6: Clustering
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update modules set description = $M$Learn how clustering discovers hidden groups in unlabeled data, and how to turn those groups into actionable customer segments, product insights, and operational strategies.$M$ where id = '9d31ca86-c046-4146-9280-5a64d14faf30';

update lessons set content = $D8d7f7128_262c_4c62_ae32_f118699d289f$Clustering is a machine learning technique used to find natural groups in data.

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

[!] A common mistake is using clustering to "confirm" groups that were defined in advance. Clustering discovers structure, it should not be used to rubber-stamp decisions already made.

>> Clustering answers: "What natural groups exist here?" Classification answers: "Which known group does this belong to?"$D8d7f7128_262c_4c62_ae32_f118699d289f$ where id = '8d7f7128-262c-4c62-ae32-f118699d289f';

update lessons set content = $Dcc588111_ed1d_491a_8f94_afb8453f5fc6$WHAT ARE THE INPUTS?

The inputs are features, and there is no target column.

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

The output is a cluster assignment, a group number for each data point.

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
  Euclidean distance, straight-line distance. Best for scaled numeric features.
  Manhattan distance, absolute differences. Like moving on city blocks.
  Cosine similarity, measures direction rather than size. Common for text and recommendations.
  Jaccard similarity, measures overlap between sets. Good for categorical features.


WHY SCALING IS CRITICAL

Suppose you cluster customers using:
  Age: 18 to 80
  Income: $20,000 to $200,000
  Website visits: 0 to 1,000

Income has much larger numbers than age. A $10,000 income difference may look enormous compared with a 10-year age difference, even if age matters more for your business question. Income will dominate the distance calculation and distort the clusters.

Solution: standardize features so each has mean = 0 and standard deviation = 1.

[!] Scaling is one of the most important steps in clustering. Skipping it often produces clusters driven by whichever feature has the largest scale, not by actual similarity.

PM question: "Were the numeric features scaled or normalized before clustering?"$Dcc588111_ed1d_491a_8f94_afb8453f5fc6$ where id = 'cc588111-ed1d-491a-8f94-afb8453f5fc6';

update lessons set content = $Dffc22834_c591_4eb7_acd7_fe0e7d18fe00$K-means is the most commonly used clustering algorithm.

The "k" means the number of clusters you want. k = 3 means three groups; k = 5 means five groups.

K-means tries to group data points around cluster centers called **centroids**.

A centroid is the center of a cluster, like the average member of that group.

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

>> The algorithm groups what you give it. If you give it the wrong features, you get the wrong clusters.$Dffc22834_c591_4eb7_acd7_fe0e7d18fe00$ where id = 'ffc22834-c591-4eb7-acd7-fe0e7d18fe00';

update lessons set content = $Df71989dd_d10c_422e_b31a_98edaebb5a0d$K-means requires you to choose k in advance. This is not always easy.

Too few clusters (e.g., k = 2): too broad, important differences are hidden.
Too many clusters (e.g., k = 20): too fragmented, impossible for the business to act on.

The right k should be both statistically reasonable and business-useful.


THE ELBOW METHOD

K-means tries to minimize the total distance between each point and its cluster centroid. This is called inertia.

As k increases, inertia decreases, more clusters means each cluster can be tighter.

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
2. Results depend on random starting positions, different runs may give different clusters.
   Fix: run k-means multiple times and choose the best result.
3. Sensitive to outliers, extreme points pull centroids away from useful locations.
4. Assumes round-ish clusters, struggles when clusters are irregular or overlapping.
5. Scaling matters, unscaled features distort results.
6. Clusters may not be actionable, mathematically valid groups may not be useful for the business.

[!] The elbow method and silhouette score help narrow down k. The final choice should always be validated against business criteria, can you name the segments and treat them differently?

>> The right number of clusters is the smallest number that creates segments you can actually act on.$Df71989dd_d10c_422e_b31a_98edaebb5a0d$ where id = 'f71989dd-d10c-422e-b31a-98edaebb5a0d';

update lessons set content = $D2b70dc29_0bbf_4b9a_adf7_1ccb99bbc9f8$HIERARCHICAL CLUSTERING

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

PMs can use the dendrogram to visually decide where to cut, how many clusters makes sense. A big jump in height before a merge is a natural cut point.


LINKAGE METHODS

Hierarchical clustering needs a rule for measuring distance between clusters.

  Single linkage, distance = closest pair of points. Can create chain-like clusters.
  Complete linkage, distance = farthest pair. Creates compact clusters.
  Average linkage, distance = average of all pairs. Balanced.
  Ward linkage, minimizes increase in within-cluster variance. Often creates the most useful clusters.

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

Example: anomaly detection. Most transactions form dense normal-behavior groups. Unusual transactions appear as isolated outliers, not assigned to any cluster.

Weakness: DBSCAN can be sensitive to parameter choices and struggles when clusters have very different densities.

[!] DBSCAN is especially useful for fraud and anomaly detection because it naturally identifies points that do not belong to any dense group. K-means always assigns every point to a cluster, even if that point is a true outlier.

>> Different clustering algorithms answer different questions. K-means scales. Hierarchical explains. DBSCAN detects outliers.$D2b70dc29_0bbf_4b9a_adf7_1ccb99bbc9f8$ where id = '2b70dc29-0bbf-4b9a-adf7-1ccb99bbc9f8';

update lessons set content = $Da4c21cf5_68d5_4e1e_b980_4c550471098b$CLUSTERING FOR PRODUCT STRATEGY

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

[!] Clustering support tickets is one of the highest-leverage places to apply clustering for a PM, it reveals systematic product gaps that individual tickets obscure.

>> The same algorithm, applied to different data, produces different business insights. Choose features that match the business question.$Da4c21cf5_68d5_4e1e_b980_4c550471098b$ where id = 'a4c21cf5-68d5-4e1e-b980-4c550471098b';

update lessons set content = $D0c3aecf3_ef41_46d0_9dde_2ed028dfa36b$Evaluating clustering is harder than evaluating supervised models. There is usually no correct answer label to compare against.

Evaluation has two sides. Both matter.


STATISTICAL QUALITY METRICS

Inertia / within-cluster sum of squares
  How close are points to their cluster centroid?
  Lower inertia = tighter clusters.
  But adding more clusters always reduces inertia, use elbow method to find a meaningful stopping point.

Silhouette score
  Are points close to their own cluster and far from other clusters?
  Range: −1 to +1. Higher is better. Check that most points score positively.

Cluster size balance
  Check whether one cluster has 95% of users and the rest are tiny.
  Extreme imbalance may indicate a problem or may reflect a real business pattern, investigate.

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

>> Profiling is the bridge between the algorithm's output and the team's ability to act. Never skip it.$D0c3aecf3_ef41_46d0_9dde_2ed028dfa36b$ where id = '0c3aecf3-ef41-46d0-9dde-2ed028dfa36b';

update lessons set content = $Df7de4e26_c4f0_4ba1_819d_6c963cf52f73$CLUSTERING VS. CLASSIFICATION

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

Clustering can help create data-driven personas, but with important caveats:

  A good cluster-based persona needs:
  Data support from the clustering
  A clear behavioral or attitudinal pattern
  Business relevance
  Actionability, different treatment is possible
  Validation, test whether targeting the segment differently actually improves outcomes

Cluster personas should be tested, not assumed.

Example: if you send different messages to each cluster, do conversion rates improve?

[!] A clustering exercise that produces a set of segments nobody acts on is a research project, not a product decision. Drive toward validation from the start.

>> Discover with clustering. Predict with classification. Act with both, but validate with business outcomes.$Df7de4e26_c4f0_4ba1_819d_6c963cf52f73$ where id = 'f7de4e26-c4f0-4ba1-819d-6c963cf52f73';

update lessons set content = $D3a2895b6_e1f5_4f82_b3de_9a66f123a0a9$CLUSTERING FOR ANOMALY DETECTION

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

Example: a cluster may map strongly to income level, geographic region, race, gender, or age, in ways that create unfair or discriminatory treatment when acted on.

This can happen even when sensitive attributes are not included as features, because other features may be proxies.

PM questions:
  "Could any of these clusters correlate with protected attributes?"
  "If we treat Cluster X differently, could that disadvantage a legally protected group?"
  "Have we audited the cluster composition across demographic dimensions?"

[!] Fairness is a PM responsibility, not just a data science responsibility. Clusters that look like neutral "behavior segments" may still encode unfair patterns.

>> Anomaly detection adds a new use case for clustering. Fairness concerns apply to all segmentation work.$D3a2895b6_e1f5_4f82_b3de_9a66f123a0a9$ where id = '3a2895b6-e1f5-4f82-b3de-9a66f123a0a9';

update lessons set content = $Dc675bba0_7bfb_4a0b_bf51_fe40879d8c6e$WHAT CAN GO WRONG

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
  "We clustered support tickets based on topic, sentiment, and resolution patterns. The clusters revealed recurring billing confusion, technical setup issues, and delivery complaints, systematic product gaps that individual tickets obscure. This can drive improvements in self-service content, routing, and product quality."


THE MEMORY SHORTCUT

Clustering is: **finding hidden groups in unlabeled data.**

  Features → similarity / distance → groups → profiling → naming → action

Use it when: you do not already know the groups, you want to discover customer or product segments, you want to find behavior patterns, or you want to identify outliers.

Measure it with: elbow method, silhouette score, cluster stability, cluster interpretability, actionability, and whether clusters predict different future outcomes.

Watch for: bad feature selection, no scaling, too many clusters, unstable clusters, outlier distortion, non-actionable segments, bias or fairness risks, and treating clusters as objective truth.

The most important PM question:
  **Can we clearly name these groups, treat them differently, and prove that doing so improves a business outcome?**$Dc675bba0_7bfb_4a0b_bf51_fe40879d8c6e$ where id = 'c675bba0-7bfb-4a0b-bf51-fe40879d8c6e';

update questions set choices = $D7c096693_30f1_4516_aa68_3ab0af715681Q$["Wrong feature selection, behavioral features like purchase frequency and discount usage would better capture marketing-relevant similarity","The algorithm needs more iterations to converge on better clusters","K was set too low, creating clusters that are too broad","The data was not split into training and test sets before clustering"]$D7c096693_30f1_4516_aa68_3ab0af715681Q$::jsonb where id = '7c096693-30f1-4516-aa68-3ab0af715681';

update questions set choices = $Dff501bae_2120_4847_b0f0_6e52753f15d6Q$["Use k = 3, the right k is the smallest number that creates actionable segments, not just the statistical optimum","Override the business team and use k = 4 because the elbow method is statistically correct","Run the elbow method again with a larger range of k values","Use the silhouette score instead, which will confirm k = 4"]$Dff501bae_2120_4847_b0f0_6e52753f15d6Q$::jsonb where id = 'ff501bae-2120-4847-b0f0-6e52753f15d6';

update questions set choices = $Ddfe57d7b_85b5_4948_9ce2_3b8c8e9e55d4Q$["The segmentation has no business value, clustering is only useful when different clusters receive different treatments","The clustering failed and should be rerun with a different k","The clusters are not statistically valid","The marketing team needs to review the silhouette scores"]$Ddfe57d7b_85b5_4948_9ce2_3b8c8e9e55d4Q$::jsonb where id = 'dfe57d7b-85b5-4948-9ce2-3b8c8e9e55d4';

update questions set choices = $D0c30dfd0_f88a_4e24_9943_eb781dfe5788Q$["Discovering that 40% of tickets relate to billing confusion, a systematic product gap that individual tickets do not reveal","Confirming that tickets from enterprise customers take longer to resolve","Producing 12 statistically distinct clusters with high silhouette scores","Finding that support tickets can be predicted from customer plan type"]$D0c30dfd0_f88a_4e24_9943_eb781dfe5788Q$::jsonb where id = '0c30dfd0-f88a-4e24-9943-eb781dfe5788';

update questions set choices = $Dd0415747_e1eb_4df9_ad6b_39cf73c3588bQ$["Check whether clusters differ on real future business outcomes like retention, revenue, or conversion, statistical quality does not guarantee business usefulness","No additional validation is needed since a high silhouette score confirms the clusters are correct","Run the same algorithm on a larger dataset to confirm the score holds","Convert the clustering to a classification model before validating"]$Dd0415747_e1eb_4df9_ad6b_39cf73c3588bQ$::jsonb where id = 'd0415747-e1eb-4df9-ad6b-39cf73c3588b';

update questions set choices = $Dd4cfc56f_0586_4aad_9cb9_74898485fe8eQ$["Clustering may be too slow for real-time assignment, the classifier can assign new users to known segments instantly at scale","The classification model improves the original clustering quality","New customers cannot be assigned to existing clusters without rerunning k-means","Classification models always outperform clustering for segmentation accuracy"]$Dd4cfc56f_0586_4aad_9cb9_74898485fe8eQ$::jsonb where id = 'd4cfc56f-0586-4aad-9cb9-74898485fe8e';

update questions set choices = $Dc5ee7b67_ed64_44ba_9863_333eed7a19a0Q$["Audit whether treating this cluster differently could create unfair outcomes for a protected group, geographic and income proxies can encode discriminatory patterns","Remove geography from the feature set and rerun clustering","Reduce the number of clusters so the geographic segment merges with a larger group","Confirm the cluster has a low silhouette score and exclude it from the analysis"]$Dc5ee7b67_ed64_44ba_9863_333eed7a19a0Q$::jsonb where id = 'c5ee7b67-ed64-44ba-9863-333eed7a19a0';
