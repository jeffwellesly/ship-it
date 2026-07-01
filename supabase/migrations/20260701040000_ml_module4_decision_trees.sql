-- ML for Everyone — Module 4: Decision Trees / CART
-- 11 lessons covering decision trees from a PM perspective

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
    'Module 4: Decision Trees / CART',
    'Learn how decision trees make predictions using sequences of if/then questions — and how to use them for both classification and regression problems.',
    4
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.1 — What Is a Decision Tree and What Does CART Mean?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is a Decision Tree and What Does CART Mean?',
    1,
    $M4L1$A decision tree is a machine learning model that makes predictions using a sequence of simple questions.

It looks like a flowchart.

Example:

  Question 1: Has the customer used the product in the last 7 days?
    If yes → go left
    If no  → go right

  Question 2: Has the customer opened more than 2 support tickets?
    If yes → predict high churn risk
    If no  → predict medium churn risk

**A decision tree predicts by asking a series of if/then questions.**

This is why decision trees are easier to explain than many other ML models — you can follow the path from start to prediction and show every decision that was made.


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

Each answer changes the next question. The tree works the same way — one question at a time, narrowing down the prediction.

Business example — lead scoring:

  Has the user visited the pricing page?
  Did the user request a demo?
  Is the company size above 500 employees?

Final prediction: high conversion probability.

The tree is basically a set of learned business rules.

>> Decision trees are often called "white box" models because the reasoning behind any prediction can be expressed in plain if/then logic — exactly the kind of explanation stakeholders ask for.$M4L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.2 — When to Use, Inputs, and Outputs
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'When to Use, Inputs, and Outputs',
    2,
    $M4L2$WHEN SHOULD YOU USE A DECISION TREE?

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

The inputs are features — the signals the model uses to make predictions.

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

[!] The output type is determined by the problem, not the algorithm. Ask first: am I predicting a category or a number? That tells you which type of tree to build.$M4L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.3 — Tree Vocabulary: Nodes, Branches, Depth
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Tree Vocabulary: Nodes, Branches, Depth',
    3,
    $M4L3$Understanding decision tree vocabulary helps you read reports, ask sharp questions, and navigate conversations with data teams.


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

A leaf is reached when no more splits are needed — either because the group is pure enough, or because a stopping rule (like max depth) was reached.


DEPTH

How many levels deep the tree goes.

A tree with depth 1 has just one question.
A tree with depth 4 has up to four levels of questions.

Example for a depth-3 tree:
  Level 1 — root: "Days since last login > 30?"
  Level 2 — internal: "Support tickets > 2?"
  Level 3 — leaf: "High churn risk"

Depth matters because:
  Shallow tree → fewer rules → easier to explain → may miss complex patterns
  Deep tree → more rules → captures complexity → risk of overfitting

[!] Depth is one of the most important hyperparameters in a decision tree. Ask the data team what depth they chose and why.

>> A decision tree flows from root to leaf. Every prediction is a path.$M4L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.4 — How Trees Learn: Splits, Purity, Gini, Entropy
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'How Trees Learn: Splits, Purity, Gini, Entropy',
    4,
    $M4L4$HOW DOES A DECISION TREE LEARN?

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
  Group A — active recently: 5 churned, 45 did not churn. Mostly non-churners.
  Group B — inactive 30+ days: 45 churned, 5 did not churn. Mostly churners.

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

Both Gini and entropy aim at the same thing — clean groups. In practice, they often produce similar trees.

[!] PMs do not need to calculate Gini or entropy. But knowing what they measure — group cleanliness after a split — helps you understand why the tree chose one question over another.

>> Every split is the algorithm's answer to: "What question most cleanly separates the cases?"$M4L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.5 — Classification and Regression Tree Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Classification and Regression Tree Examples',
    5,
    $M4L5$CLASSIFICATION TREE EXAMPLE: CHURN PREDICTION

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

Regression trees are especially useful when the relationship between features and the outcome is not a straight line — which is very common in operations, logistics, and pricing.


WHY DECISION TREES CAPTURE NON-LINEAR PATTERNS

Linear and logistic regression assume a relatively smooth, consistent relationship between features and the outcome.

Decision trees do not.

They can learn rules like:
  If the customer is new and usage is low → high churn risk.
  But if the customer is old and usage is low → medium risk.
  But if the customer is old, usage is low, and satisfaction is high → low risk.

This is called an **interaction** — the effect of one feature depends on the value of another.

Decision trees naturally capture interactions without needing them to be specified manually.

>> If you notice stakeholders saying "it depends" — that's usually an interaction, and trees handle it well.$M4L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.6 — Overfitting and How to Prevent It
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Overfitting and How to Prevent It',
    6,
    $M4L6$WHY DECISION TREES CAN OVERFIT

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

It gets worse as the tree gets deeper — a deep tree can create a unique path for almost every example in the training set.


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
   Think of it like trimming a plant — remove the parts that do not help.

   Pre-pruning: stop the tree from growing too large in the first place.
   Post-pruning: grow the full tree first, then remove weak branches.

5. Cross-validation
   Test different settings on validation data to choose the version that generalizes best.


PM INTERPRETATION

Pre-pruning = "Do not make overly detailed rules."
Post-pruning = "Make the tree, then remove rules that do not help."

[!] If training performance is much better than test performance, the tree is overfitting. That gap is the red flag. Always check both numbers.

PM question: "How does training accuracy compare with test accuracy? What depth and pruning settings were used?"

>> A decision tree that fits training data perfectly but fails on new data is worse than useless. Overfitting is the tree's most common failure mode.$M4L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.7 — Feature Importance and Business Rules
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Feature Importance and Business Rules',
    7,
    $M4L7$WHAT IS FEATURE IMPORTANCE?

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

A feature being important means it helped the model predict — not that it causes the outcome.

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

But remember — a tree learned from data may find patterns that are statistically useful but not always business-logical. PMs should review whether the rules make sense before acting on them.

>> Feature importance shows what the model found useful. You decide whether it is actionable and whether the rules pass a business logic review.$M4L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.8 — Four Real Product Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Four Real Product Examples',
    8,
    $M4L8$EXAMPLE 1: LEAD SCORING

Business problem: prioritize sales leads so the team focuses on the highest-intent prospects.

Model: decision tree classification.
Input features: company size, industry, pricing page visits, demo request, email engagement, job title.
Target: converted or did not convert.
Output: high / medium / low conversion likelihood.

Example path:
  Visited pricing page? Yes.
  Requested demo? Yes.
  Company size > 500 employees? Yes.
  Prediction: high conversion likelihood.

Business metrics: sales conversion rate, revenue per lead, pipeline quality, time saved.

Key PM question: "Is the model better than the current manual lead scoring rules?"


EXAMPLE 2: SUPPORT TICKET ROUTING

Business problem: route incoming support tickets to the correct team without manual triage.

Model: decision tree classification.
Input features: ticket category, product area, customer plan, urgency keywords, account value.
Target: correct support queue.
Output: billing team / technical support / retention team / escalation team.

Business metrics: first response time, resolution time, customer satisfaction, misrouting rate.

Key PM question: "Which misrouting mistakes are most costly, and how does the model handle low-confidence predictions?"


EXAMPLE 3: DELIVERY TIME PREDICTION

Business problem: give customers an accurate delivery estimate at checkout.

Model: regression tree.
Input features: distance, shipping method, processing time, region, carrier, weight, holiday period.
Target: actual delivery time.
Output: predicted delivery time = 5.2 days.

Example path:
  Distance > 500 miles? Yes.
  Shipping method = standard? Yes.
  Holiday period? Yes.
  Prediction: 7.5 days.

Business metrics: delivery promise accuracy, late delivery reduction, refund reduction, customer satisfaction.

Key PM question: "Does the model perform well during holidays, and can it handle new routes with limited history?"


EXAMPLE 4: CREDIT RISK DECISION SUPPORT

Business problem: predict whether a loan applicant may default.

Model: decision tree classification.
Input features: income, existing debt, credit history, employment length, loan amount, debt-to-income ratio.
Target: default or no default.
Output: default risk category.

Business metrics: default loss reduction, approval quality, fairness, compliance.

Key PM question: "Can we explain decisions clearly, and are protected attributes handled properly?"

[!] Credit and other high-stakes uses require special care. A tree that looks explainable may still produce decisions that are unfair or non-compliant. Always plan for human review of high-stakes decisions and audit the model for fairness across groups.

>> All four examples follow the same pattern: features → if/then path → prediction → action. Mastering that pattern lets you engage with any decision tree project.$M4L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.9 — Strengths, Weaknesses, and Metric Selection
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Strengths, Weaknesses, and Metric Selection',
    9,
    $M4L9$STRENGTHS

1. Easy to understand
   A tree is like a flowchart. Stakeholders can follow the reasoning without ML knowledge.

2. Works for classification and regression
   Same algorithm, two types of output.

3. Captures non-linear patterns
   No assumption of a straight-line relationship.

4. Captures feature interactions naturally
   "Feature A matters only when Feature B is high" — trees learn this automatically.

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

>> Use the strength (explainability) and respect the weakness (overfitting). Match the metric to what the business actually cares about.$M4L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.10 — Decision Tree vs. Logistic Regression vs. Random Forest
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Decision Tree vs. Logistic Regression vs. Random Forest',
    10,
    $M4L10$DECISION TREE VS. LOGISTIC REGRESSION

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

[!] In most real business ML projects, random forests outperform single trees on accuracy. But single trees win when the explanation needs to be auditable. Often both are built — the tree for communication, the forest for production.

>> A single tree explains. A forest predicts. Sometimes you need both.$M4L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 4.11 — PM Checklist, What Can Go Wrong, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist, What Can Go Wrong, and the Memory Shortcut',
    11,
    $M4L11$WHAT CAN GO WRONG

1. Tree is too deep
   Overfits to training data.
   PM question: "What depth was used, and how does test performance compare with training performance?"

2. Leaves are too small
   Predictions from 2–3 examples are not reliable.
   PM question: "What is the minimum number of samples per leaf?"

3. The tree looks explainable but is unstable
   A small data change may produce a very different tree structure.
   PM question: "Is this tree stable across different samples of the data?"

4. Accuracy looks good but the minority class is missed
   On imbalanced data, a tree that always predicts the majority class achieves high accuracy but zero usefulness.
   PM question: "What are precision and recall for the positive or rare class?"

5. Feature importance is treated as causation
   A feature being important in a tree does not prove it causes the outcome.
   PM question: "Are we using this for prediction or claiming this feature causes the result?"

6. Data leakage
   The tree uses features not available at prediction time.
   PM question: "Would every feature be known at the moment of prediction?"

7. Rules are not actionable
   The tree identifies risk based on things the company cannot change.
   PM question: "Can we act on the drivers this model identifies?"

8. Model fails in important segments
   Overall performance may look good while specific groups are poorly served.
   PM question: "How does performance vary by segment?"


PM CHECKLIST FOR DECISION TREES

1.  Are we solving classification or regression?
2.  What is the exact target?
3.  What are the input features?
4.  Are all features available at prediction time? (leakage check)
5.  What is the tree depth?
6.  What is the minimum number of samples per leaf?
7.  Was pruning used?
8.  How does training performance compare with test performance?
9.  Is the tree stable across different samples?
10. What are the most important features?
11. Are the learned rules business-logical?
12. Are the rules actionable?
13. What are the relevant metrics (precision/recall/AUC for classification, MAE/RMSE/R² for regression)?
14. How does performance vary by segment?
15. How does it compare with logistic regression or linear regression?
16. How does it compare with random forest or gradient boosting?
17. What happens when data is missing or out of range?
18. What is the cost of false positives and false negatives?
19. What business metric should improve?
20. Is this tree simple enough to trust, accurate enough to use, and actionable enough to improve a real decision?


HOW TO EXPLAIN TO LEADERSHIP

Simple version:
  "We built a model that works like a flowchart. It asks a sequence of questions about each case and uses the answers to reach a prediction. This makes the model easier to explain than many complex ML models. We controlled tree depth and pruning to reduce overfitting."

Churn example:
  "The tree identifies high-risk customers using rules based on recent usage, support activity, payment issues, and plan type. The model produces readable rules that can be converted into operational playbooks. Before scaling, we should validate that the rules are stable and that interventions actually reduce churn."

Delivery example:
  "The regression tree predicts delivery time by splitting orders into groups based on distance, shipping method, region, and processing time. It outperforms a simple historical average, but we need to monitor large errors during holiday periods and unusual operational conditions."


THE MEMORY SHORTCUT

A decision tree is: **a flowchart that learns rules from data.**

  Input features → if/then questions → path through tree → leaf prediction

Use it when: you want explainability, rule-like decisions, non-linear patterns, or a simple classification or regression baseline.

Measure it with: precision/recall/AUC (classification) or MAE/RMSE/R² (regression) plus a business impact metric.

Watch for: overfitting, deep trees, tiny leaves, instability, data leakage, misleading accuracy, non-actionable rules, and confusing feature importance with causation.

The most important PM question:
  **Is this tree simple enough to trust, accurate enough to use, and actionable enough to improve a real decision?**$M4L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 4.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'What does CART stand for, and why does it matter for PMs?',
    '["Classification and Regression Trees — the same tree idea works for both yes/no categories and numeric predictions","Classification and Ranking Trees — used only when there are three or more output categories","Clustered And Routed Trees — used only for routing decisions","Conditional Accuracy and Recall Threshold — a metric for decision-tree performance"]',
    0
  );

  -- Q2 — Lesson 4.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'Which situation is a decision tree best suited for, compared with logistic regression?',
    '["When you expect non-linear patterns or feature interactions and want explainable rule-based logic","When you only need a smooth probability and the relationship is simple and linear","When you have no labeled training data","When the output is a ranking rather than a category or number"]',
    0
  );

  -- Q3 — Lesson 4.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'What is a leaf node in a decision tree?',
    '["The final endpoint of a path through the tree — the node that contains the prediction","The first question the tree asks about every example","The middle questions that split data into branches","The measure of how mixed a group is after a split"]',
    0
  );

  -- Q4 — Lesson 4.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'What does a decision tree use Gini impurity or entropy to decide?',
    '["Which question most cleanly separates the data into useful groups at each split","How many layers deep the tree should grow","Which features to remove before training","Whether to use classification or regression"]',
    0
  );

  -- Q5 — Lesson 4.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'Why are decision trees useful for capturing feature interactions?',
    '["They naturally learn rules like ''Feature A matters only when Feature B is high'' without manual specification","They require the PM to define all interaction rules in advance","They are the only model type that works on both classification and regression","They perform better than random forests when interactions are present"]',
    0
  );

  -- Q6 — Lesson 4.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A decision tree has 100% accuracy on training data but 62% on the test set. What does this indicate?',
    '["Overfitting — the tree memorized the training data and does not generalize to new examples","Underfitting — the tree is too shallow and misses important patterns","A data leakage problem with the training labels","Normal behavior — training accuracy is always higher"]',
    0
  );

  -- Q7 — Lesson 4.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A decision tree shows that customer age is the most important feature for churn prediction. What is the most important PM follow-up question?',
    '["Can we act on this? Age is not something we can change — so what actionable features also matter?","Should we retrain the model with age removed?","Does this mean older customers cause higher churn?","Should we set the threshold higher to reduce false positives for older customers?"]',
    0
  );

  -- Q8 — Lesson 4.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A support ticket routing tree has 88% overall accuracy, but escalation tickets are misrouted 40% of the time. What should the PM focus on?',
    '["Per-queue accuracy and the cost of misrouting escalations — overall accuracy hides important segment failures","Increasing tree depth to capture more patterns","Switching to logistic regression since it handles routing better","Retraining the model with a lower minimum samples per leaf"]',
    0
  );

  -- Q9 — Lesson 4.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'Which is the biggest practical weakness of a single decision tree?',
    '["Overfitting — deep trees memorize training data and may fail on new examples","Inability to handle categorical features like plan type or region","Requiring feature scaling before training","Always producing lower AUC than logistic regression"]',
    0
  );

  -- Q10 — Lesson 4.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'When should a PM choose a single decision tree over a random forest?',
    '["When the decision rules need to be auditable, explainable, or approved by stakeholders","When maximum predictive accuracy is the only goal","When the dataset is very large and training speed matters","When the outcome has more than two classes"]',
    0
  );

  -- Q11 — Lesson 4.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the most important PM question for any decision tree project?',
    '["Is this tree simple enough to trust, accurate enough to use, and actionable enough to improve a real decision?","What depth and pruning settings were used during training?","Does the tree use Gini impurity or entropy as the split criterion?","Is the tree implemented in scikit-learn or a different library?"]',
    0
  );

end $$;
