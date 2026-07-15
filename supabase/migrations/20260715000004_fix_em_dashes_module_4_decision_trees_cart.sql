-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 4: Decision Trees / CART
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update modules set description = $M$Learn how decision trees make predictions using sequences of if/then questions, and how to use them for both classification and regression problems.$M$ where id = 'b2e9fa2c-dd65-466f-aaa2-03b7ef169dde';

update lessons set content = $D5e21a275_f5b3_4177_907b_f3e7ec7e7980$A decision tree is a machine learning model that makes predictions using a sequence of simple questions.

It looks like a flowchart.

Example:

  Question 1: Has the customer used the product in the last 7 days?
    If yes → go left
    If no  → go right

  Question 2: Has the customer opened more than 2 support tickets?
    If yes → predict high churn risk
    If no  → predict medium churn risk

**A decision tree predicts by asking a series of if/then questions.**

This is why decision trees are easier to explain than many other ML models, you can follow the path from start to prediction and show every decision that was made.


WHAT DOES CART MEAN?

CART stands for **Classification and Regression Trees**.

That name tells you two important things:

Classification tree:
  Used when the output is a category.
  Examples: churn / not churn, fraud / not fraud, high / medium / low risk.

Regression tree:
  Used when the output is a number.
  Examples: predicted revenue, delivery time, demand, customer lifetime value.

So CART is not only for yes/no prediction. The same tree concept works for predicting numbers too.


THE SIMPLEST MENTAL MODEL

Imagine a doctor making a diagnosis:

  Do you have a fever?
  Do you have a cough?
  How many days have symptoms continued?

Each answer changes the next question. The tree works the same way, one question at a time, narrowing down the prediction.

Business example, lead scoring:

  Has the user visited the pricing page?
  Did the user request a demo?
  Is the company size above 500 employees?

Final prediction: high conversion probability.

The tree is basically a set of learned business rules.

>> Decision trees are often called "white box" models because the reasoning behind any prediction can be expressed in plain if/then logic, exactly the kind of explanation stakeholders ask for.$D5e21a275_f5b3_4177_907b_f3e7ec7e7980$ where id = '5e21a275-f5b3-4177-907b-f3e7ec7e7980';

update lessons set content = $D50a3981c_2d3e_4faf_817d_9e30c5bed33d$WHEN SHOULD YOU USE A DECISION TREE?

Use a decision tree when:
  You want an explainable model
  You want rule-like logic that stakeholders can review
  You expect non-linear patterns
  You expect interactions between features
  You need an easy-to-communicate baseline
  Stakeholders ask: "Why did the model make this prediction?"

Decision trees are especially powerful when explanation matters:
  Credit decisions
  Risk scoring
  Operational triage
  Customer targeting
  Compliance workflows
  Medical support tools


WHAT ARE THE INPUTS?

The inputs are features, the signals the model uses to make predictions.

Example: predicting churn.

Features may include:
  Days since last login
  Usage decline
  Number of support tickets
  Plan type (monthly vs. annual)
  Payment failures
  Tenure
  Customer satisfaction score
  Email engagement

Training data example:

  Days since login | Support tickets | Plan type | Usage decline | Churned?
  3                | 0               | Annual    | 5%            | No
  40               | 4               | Monthly   | 80%           | Yes
  12               | 1               | Monthly   | 20%           | No
  60               | 3               | Monthly   | 75%           | Yes

The tree learns which questions best separate churners from non-churners.


WHAT IS THE OUTPUT?

Classification tree output:
  A class or probability.
  Example: churn probability = 82%
  Example: fraud probability = 91%
  Example: lead quality = high

Regression tree output:
  A number.
  Example: predicted demand = 12,000 units
  Example: predicted delivery time = 4.5 days
  Example: predicted customer lifetime value = $720

In a tree, the final prediction comes from the leaf node where the example ends up after answering all the questions.

[!] The output type is determined by the problem, not the algorithm. Ask first: am I predicting a category or a number? That tells you which type of tree to build.$D50a3981c_2d3e_4faf_817d_9e30c5bed33d$ where id = '50a3981c-2d3e-4faf-817d-9e30c5bed33d';

update lessons set content = $Dfb333769_d0f2_4a49_9752_1ec9038166af$Understanding decision tree vocabulary helps you read reports, ask sharp questions, and navigate conversations with data teams.


ROOT NODE

The first question in the tree.

Example:
  "Days since last login > 30?"

This is the starting point. Every example enters here and is routed left or right.


INTERNAL NODE

A question inside the tree (not the first, not the last).

Example:
  "Support tickets > 2?"

Internal nodes narrow down the prediction by splitting the data further.


BRANCH

The path from one question to the next.

Each question has two branches:
  Yes branch
  No branch

(For multi-class features, there may be more, but binary splits are the most common.)


LEAF NODE

The final endpoint of any path through the tree.

The leaf contains the prediction.

Example:
  "High churn risk"
  or
  "Predicted delivery time = 5.2 days"

A leaf is reached when no more splits are needed, either because the group is pure enough, or because a stopping rule (like max depth) was reached.


DEPTH

How many levels deep the tree goes.

A tree with depth 1 has just one question.
A tree with depth 4 has up to four levels of questions.

Example for a depth-3 tree:
  Level 1, root: "Days since last login > 30?"
  Level 2, internal: "Support tickets > 2?"
  Level 3, leaf: "High churn risk"

Depth matters because:
  Shallow tree → fewer rules → easier to explain → may miss complex patterns
  Deep tree → more rules → captures complexity → risk of overfitting

[!] Depth is one of the most important hyperparameters in a decision tree. Ask the data team what depth they chose and why.

>> A decision tree flows from root to leaf. Every prediction is a path.$Dfb333769_d0f2_4a49_9752_1ec9038166af$ where id = 'fb333769-d0f2-4a49-9752-1ec9038166af';

update lessons set content = $D2a5976d5_f42f_44de_b04f_2556eb1ded9a$HOW DOES A DECISION TREE LEARN?

A decision tree learns by repeatedly splitting the data.

At each step, it asks:
  "Which question best separates the data into useful groups?"

Example: predicting churn.

The tree may test many possible questions:
  Days since last login > 7?
  Days since last login > 14?
  Days since last login > 30?
  Support tickets > 1?
  Support tickets > 3?
  Usage decline > 50%?
  Monthly plan?
  Payment failure?

It chooses the question that creates the cleanest separation.

Before split:
  100 customers, 50 churned, 50 did not churn. Very mixed.

After best split:
  Group A, active recently: 5 churned, 45 did not churn. Mostly non-churners.
  Group B, inactive 30+ days: 45 churned, 5 did not churn. Mostly churners.

The tree then repeats this process inside each group until it reaches a stopping rule.


PURITY

A group is pure when most examples belong to the same class.

Mixed: 50 churned, 50 did not churn → impure
Pure: 95 churned, 5 did not churn → very pure

For classification, the tree tries to make leaf nodes as pure as possible.

For regression, the tree tries to make each leaf contain examples with similar numeric values.


GINI IMPURITY

Gini impurity measures how mixed a group is.

Lower Gini = cleaner group.

A group that is all one class has a Gini of 0 (perfectly pure).
A group split 50/50 has a Gini of 0.5 (maximally impure).

The tree picks the split that most reduces Gini across the two groups it creates. This is the default split criterion in most decision tree implementations.


ENTROPY AND INFORMATION GAIN

Entropy is another way to measure disorder or uncertainty.

High entropy = mixed group.
Low entropy = clean group.

Information gain = how much uncertainty was reduced by making this split.

Simple interpretation:
  The tree asks: "Which question gives me the most useful information?"

Both Gini and entropy aim at the same thing, clean groups. In practice, they often produce similar trees.

[!] PMs do not need to calculate Gini or entropy. But knowing what they measure, group cleanliness after a split, helps you understand why the tree chose one question over another.

>> Every split is the algorithm's answer to: "What question most cleanly separates the cases?"$D2a5976d5_f42f_44de_b04f_2556eb1ded9a$ where id = '2a5976d5-f42f-44de-b04f-2556eb1ded9a';

update lessons set content = $De878ccb5_7933_42d5_9ef2_af1c69cc7b0b$CLASSIFICATION TREE EXAMPLE: CHURN PREDICTION

Business problem:
  Predict whether a customer will churn.

Possible tree:

  Root: Has the customer logged in during the last 14 days?

  Yes branch:
    Question: Has product usage dropped more than 50%?
    Yes → medium churn risk
    No  → low churn risk

  No branch:
    Question: Has the customer opened more than 2 support tickets?
    Yes → high churn risk
    No  → medium churn risk

Final learned rules:
  Rule 1: Logged in recently + usage stable → low churn risk
  Rule 2: Inactive for 14+ days + many support tickets → high churn risk
  Rule 3: Inactive for 14+ days + few support tickets → medium churn risk

Output: churn probability or churn class.


REGRESSION TREE EXAMPLE: DELIVERY TIME PREDICTION

Business problem:
  Predict how long a delivery will take.

Possible tree:

  Root: Distance > 500 miles?

  Yes branch:
    Question: Shipping method = express?
    Yes → predicted delivery = 3 days
    No  → predicted delivery = 6 days

  No branch:
    Question: Warehouse processing time > 24 hours?
    Yes → predicted delivery = 4 days
    No  → predicted delivery = 2 days

Output: a number (days).

Regression trees are especially useful when the relationship between features and the outcome is not a straight line, which is very common in operations, logistics, and pricing.


WHY DECISION TREES CAPTURE NON-LINEAR PATTERNS

Linear and logistic regression assume a relatively smooth, consistent relationship between features and the outcome.

Decision trees do not.

They can learn rules like:
  If the customer is new and usage is low → high churn risk.
  But if the customer is old and usage is low → medium risk.
  But if the customer is old, usage is low, and satisfaction is high → low risk.

This is called an **interaction:** the effect of one feature depends on the value of another.

Decision trees naturally capture interactions without needing them to be specified manually.

>> If you notice stakeholders saying "it depends", that's usually an interaction, and trees handle it well.$De878ccb5_7933_42d5_9ef2_af1c69cc7b0b$ where id = 'e878ccb5-7933-42d5-9ef2-af1c69cc7b0b';

update lessons set content = $Dc9f94a3d_b876_4df4_8174_a40f7e45adcd$WHY DECISION TREES CAN OVERFIT

Decision trees can become too detailed.

Example of an overfit rule:
  If customer is from ZIP code 98105
  and logged in exactly 3 times
  and bought on Tuesday
  and used coupon A
  and contacted support at 2pm
  then churn risk is high.

This rule may match some historical customers perfectly but fail for future customers. The tree has memorized noise instead of learning general patterns.

Overfitting is the single biggest weakness of decision trees.

It gets worse as the tree gets deeper, a deep tree can create a unique path for almost every example in the training set.


HOW TO PREVENT OVERFITTING

There are five main controls.

1. Limit tree depth
   Set a maximum number of levels.
   Example: allow only 4 levels of questions.
   This prevents the tree from becoming overly detailed.

2. Minimum samples per leaf
   Require each leaf to have enough examples.
   Example: each leaf must contain at least 100 customers.
   This prevents rules based on tiny, unreliable groups.

3. Minimum samples to split
   Require enough examples before creating another split.
   Example: do not split a group unless it has at least 200 examples.

4. Pruning
   Pruning means cutting back branches that do not improve performance on validation data.
   Think of it like trimming a plant, remove the parts that do not help.

   Pre-pruning: stop the tree from growing too large in the first place.
   Post-pruning: grow the full tree first, then remove weak branches.

5. Cross-validation
   Test different settings on validation data to choose the version that generalizes best.


PM INTERPRETATION

Pre-pruning = "Do not make overly detailed rules."
Post-pruning = "Make the tree, then remove rules that do not help."

[!] If training performance is much better than test performance, the tree is overfitting. That gap is the red flag. Always check both numbers.

PM question: "How does training accuracy compare with test accuracy? What depth and pruning settings were used?"

>> A decision tree that fits training data perfectly but fails on new data is worse than useless. Overfitting is the tree's most common failure mode.$Dc9f94a3d_b876_4df4_8174_a40f7e45adcd$ where id = 'c9f94a3d-b876-4df4-8174-a40f7e45adcd';

update lessons set content = $Dfb6aae06_ea77_431f_be4d_e18ab1d2b8d9$WHAT IS FEATURE IMPORTANCE?

Decision trees can measure which features were most useful for making splits.

Example: churn prediction feature importance.

  Days since last login   35%
  Usage decline           25%
  Support tickets         18%
  Plan type               12%
  Payment failure         10%

This means the tree used "days since last login" most often and most effectively to separate churners from non-churners.

Feature importance is a useful signal, but handle it carefully.


FEATURE IMPORTANCE IS NOT CAUSATION

A feature being important means it helped the model predict, not that it causes the outcome.

Example:
  Support tickets are associated with churn.
  This does not prove that reducing support tickets will reduce churn.
  Maybe unhappy customers open tickets and churn due to an underlying product problem.

PM question:
  "Are we using this for prediction, or claiming this feature causes the outcome?"


ARE THE IMPORTANT FEATURES ACTIONABLE?

Even when a feature is genuinely predictive, it may not be actionable.

Non-actionable features:
  Customer age
  Account tenure
  Geographic region

Actionable features:
  Usage decline → design re-engagement actions
  Payment failure → trigger proactive billing support
  Support ticket volume → improve the product areas generating tickets

PM question:
  "Can we act on the top features this model identifies?"


DECISION TREES AS BUSINESS RULES

One distinctive benefit of decision trees is that they can be converted into readable business rules.

Example:
  If user has not logged in for 30 days
  and usage declined more than 60%
  and support tickets are greater than 2
  then mark as high churn risk.

This makes trees especially useful when:
  You need transparent rules
  You need stakeholder trust
  You want to create operational playbooks
  You need to explain model behavior to compliance or legal teams
  You are building an early version before investing in more complex ML

But remember, a tree learned from data may find patterns that are statistically useful but not always business-logical. PMs should review whether the rules make sense before acting on them.

>> Feature importance shows what the model found useful. You decide whether it is actionable and whether the rules pass a business logic review.$Dfb6aae06_ea77_431f_be4d_e18ab1d2b8d9$ where id = 'fb6aae06-ea77-431f-be4d-e18ab1d2b8d9';

update lessons set content = $Dca37fd07_46cf_419a_a86b_d0a439e78be7$STRENGTHS

1. Easy to understand
   A tree is like a flowchart. Stakeholders can follow the reasoning without ML knowledge.

2. Works for classification and regression
   Same algorithm, two types of output.

3. Captures non-linear patterns
   No assumption of a straight-line relationship.

4. Captures feature interactions naturally
   "Feature A matters only when Feature B is high", trees learn this automatically.

5. Less preprocessing needed
   Trees usually work without feature scaling. Income and age can be on different scales.

6. Useful for rule discovery
   Trees can reveal business logic hidden in data.

7. Good baseline
   A simple tree is a useful starting point before trying random forests or gradient boosting.


WEAKNESSES

1. Overfitting
   Deep trees memorize training data. This is the biggest weakness.

2. Instability
   Small changes in data can produce a very different tree structure, making it unreliable.

3. Lower accuracy than ensemble models
   A single tree usually performs worse than random forests or gradient boosted trees.

4. Not good at extrapolation
   Trees predict based on learned groups. They do not extrapolate smoothly beyond the range of training data.
   Example: if the highest price in training data was $100, the tree may not handle $500 pricing well.

5. Can be hard to explain at large depth
   A tree with hundreds of branches loses the explainability advantage.

6. Vulnerable to class imbalance
   If one class dominates, the tree may over-predict that class.


METRIC SELECTION

For classification trees: use the same metrics as logistic regression.
  Precision, recall, F1, AUC, confusion matrix, lift, calibration.

For regression trees: use regression metrics.
  MAE, RMSE, R², error by segment.

Metric choice depends on the business problem.

  Fraud detection → recall (missing fraud is costly)
  Lead scoring → precision (sales time is limited)
  Support routing → per-queue accuracy (each team needs reliable volume)
  Credit risk → AUC, calibration, fairness, business loss
  Delivery prediction → RMSE (large errors are most painful)

[!] PMs should always connect the technical metric to a business metric. "Our tree has 0.82 AUC" means little. "Our tree identifies the top 10% highest-risk customers who convert at 5x the average rate" is a business statement.

>> Use the strength (explainability) and respect the weakness (overfitting). Match the metric to what the business actually cares about.$Dca37fd07_46cf_419a_a86b_d0a439e78be7$ where id = 'ca37fd07-46cf-419a-a86b-d0a439e78be7';

update lessons set content = $Dcab0e5c4_8537_4214_9b45_19541543bfaf$DECISION TREE VS. LOGISTIC REGRESSION

  Topic              | Logistic regression           | Decision tree
  Output             | Probability                   | Class, probability, or number
  Explanation style  | Coefficients (weights)        | If/then rules (paths)
  Relationship type  | Smooth and relatively linear  | Non-linear, rule-based
  Interactions       | Must be added manually        | Learned automatically
  Overfitting risk   | Usually lower                 | Higher if tree is deep
  Best use           | Simple probability baseline   | Explainable rule-based decisions

Simple example:

Logistic regression says:
  "Payment failure increases churn odds."

Decision tree says:
  "If payment failure happened and usage dropped more than 50%, churn risk is high."

Both are useful but explain differently. Trees create conditions; logistic regression creates weights.


DECISION TREE VS. RANDOM FOREST

A random forest is many decision trees working together.

  Decision tree         | Random forest
  One tree              | Many trees (often hundreds)
  Easier to explain     | Harder to explain
  More transparent      | Less transparent
  More likely to overfit| Usually much less overfit
  Often less accurate   | Usually more accurate
  More stable           | More stable

How random forest reduces overfitting: each tree is trained on a random subset of data and features. The predictions are then combined by voting (classification) or averaging (regression). This averages out the errors of any single overfit tree.

When to choose a decision tree over a random forest:
  Explainability is required (e.g., compliance, credit, medical)
  Stakeholders need to review and approve the rules
  Building a first version before committing to a complex model
  Rule extraction is the goal

When to choose a random forest:
  Predictive accuracy is the priority
  Explainability matters less
  You have enough data to benefit from an ensemble

[!] In most real business ML projects, random forests outperform single trees on accuracy. But single trees win when the explanation needs to be auditable. Often both are built, the tree for communication, the forest for production.

>> A single tree explains. A forest predicts. Sometimes you need both.$Dcab0e5c4_8537_4214_9b45_19541543bfaf$ where id = 'cab0e5c4-8537-4214-9b45-19541543bfaf';

update questions set choices = $D9cbd52fa_fd9d_42aa_9a73_a09b0f59d531Q$["Classification and Regression Trees, the same tree idea works for both yes/no categories and numeric predictions","Classification and Ranking Trees, used only when there are three or more output categories","Clustered And Routed Trees, used only for routing decisions","Conditional Accuracy and Recall Threshold, a metric for decision-tree performance"]$D9cbd52fa_fd9d_42aa_9a73_a09b0f59d531Q$::jsonb where id = '9cbd52fa-fd9d-42aa-9a73-a09b0f59d531';

update questions set choices = $D30fea874_78d1_432b_b703_0db167cd9686Q$["The final endpoint of a path through the tree, the node that contains the prediction","The first question the tree asks about every example","The middle questions that split data into branches","The measure of how mixed a group is after a split"]$D30fea874_78d1_432b_b703_0db167cd9686Q$::jsonb where id = '30fea874-78d1-432b-b703-0db167cd9686';

update questions set choices = $D9d7bd7d1_2656_4fc4_a179_86da9cf328cbQ$["Overfitting, the tree memorized the training data and does not generalize to new examples","Underfitting, the tree is too shallow and misses important patterns","A data leakage problem with the training labels","Normal behavior, training accuracy is always higher"]$D9d7bd7d1_2656_4fc4_a179_86da9cf328cbQ$::jsonb where id = '9d7bd7d1-2656-4fc4-a179-86da9cf328cb';

update questions set choices = $De94c8502_f8d9_4f22_ac86_0f25e64d5582Q$["Can we act on this? Age is not something we can change, so what actionable features also matter?","Should we retrain the model with age removed?","Does this mean older customers cause higher churn?","Should we set the threshold higher to reduce false positives for older customers?"]$De94c8502_f8d9_4f22_ac86_0f25e64d5582Q$::jsonb where id = 'e94c8502-f8d9-4f22-ac86-0f25e64d5582';

update questions set choices = $Db29a75a7_4706_48d3_898e_1f5e9fe053a8Q$["Per-queue accuracy and the cost of misrouting escalations, overall accuracy hides important segment failures","Increasing tree depth to capture more patterns","Switching to logistic regression since it handles routing better","Retraining the model with a lower minimum samples per leaf"]$Db29a75a7_4706_48d3_898e_1f5e9fe053a8Q$::jsonb where id = 'b29a75a7-4706-48d3-898e-1f5e9fe053a8';

update questions set choices = $Db2fb24d7_2e40_4de7_ad0e_67ad1d9cfea9Q$["Overfitting, deep trees memorize training data and may fail on new examples","Inability to handle categorical features like plan type or region","Requiring feature scaling before training","Always producing lower AUC than logistic regression"]$Db2fb24d7_2e40_4de7_ad0e_67ad1d9cfea9Q$::jsonb where id = 'b2fb24d7-2e40-4de7-ad0e-67ad1d9cfea9';
