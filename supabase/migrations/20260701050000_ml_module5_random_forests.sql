-- ML for Everyone — Module 5: Random Forests
-- 11 lessons covering random forests from a PM perspective

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
    'Module 5: Random Forests',
    'Learn how combining many decision trees produces more stable and accurate predictions — and how to apply random forests to real business problems.',
    5
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.1 — What Is a Random Forest and Why Do We Need It?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is a Random Forest and Why Do We Need It?',
    1,
    $M5L1$A random forest is a machine learning model made by combining many decision trees.

A single decision tree is like one expert making a decision.

A random forest is like asking many experts and taking the group decision.

**A random forest is a collection of decision trees that vote together.**

For classification problems, each tree votes for a class.

Example — will this customer churn?
  Tree 1: churn
  Tree 2: churn
  Tree 3: not churn
  Tree 4: churn
  Tree 5: not churn
  Final prediction: churn (3 votes vs. 2)

For regression problems, each tree predicts a number and the forest averages the results.

Example — predict delivery time:
  Tree 1: 4.2 days
  Tree 2: 5.0 days
  Tree 3: 4.7 days
  Tree 4: 4.5 days
  Tree 5: 4.9 days
  Final prediction: 4.66 days (average)

A random forest is not a completely new idea. It is an improved version of decision trees.


WHY DO WE NEED RANDOM FORESTS?

A single decision tree has real problems:
  It can overfit — memorizing noise in the training data
  It can be unstable — small data changes produce a different tree
  It may not be as accurate as stronger models

Random forest solves this by using many trees instead of one.

Each tree sees a slightly different version of the data and learns slightly different rules.

Then the forest combines all their opinions.

Simple analogy:
  If one person gives advice, they may be biased.
  If 500 different people give advice and most agree, the final answer is more reliable.

This is the core intuition. Not one narrow rule path — many views, averaged.

>> A single tree may be noisy. Many trees together are calmer. The group averages out individual mistakes.$M5L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.2 — What Does "Random" Mean? Bagging and Random Features
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Does "Random" Mean? Bagging and Random Features',
    2,
    $M5L2$The word "random" in random forests comes from two types of deliberate randomness.


RANDOMNESS 1: RANDOM ROWS (BAGGING)

Each tree is trained on a random sample of the training data.

This is called **bagging** — short for **bootstrap aggregating**.

Bootstrap means sampling with replacement: the same row can appear more than once in a sample, while other rows may not appear at all.

Example — original data: A, B, C, D, E

  Tree 1 sample: A, A, C, D, E
  Tree 2 sample: B, C, C, D, E
  Tree 3 sample: A, B, D, D, E

Each tree gets a slightly different dataset. This forces the trees to learn different views of the world.

For classification the predictions are combined by voting. For regression they are averaged.


RANDOMNESS 2: RANDOM FEATURES AT EACH SPLIT

At each split within a tree, the algorithm does not consider all available features.

It considers only a random subset.

Example — available features:
  Price, discount, website visits, tenure, support tickets,
  email engagement, product usage, payment failures, customer segment

At one split the tree might only consider: support tickets, tenure, payment failures.
At the next split: website visits, discount, product usage.

This prevents all trees from becoming too similar to each other.

If every tree asked the same questions in the same order, combining them would give little benefit.


WHY BOTH MATTER

The power of a random forest comes from many trees making different mistakes.

When you average many diverse trees, the random errors cancel out while the true signal survives.

[!] Neither source of randomness is a flaw — they are deliberate design choices that make the forest more reliable than any single tree.

>> Random rows + random features = diverse trees = more stable predictions.$M5L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.3 — Bias, Variance, and Why Averaging Helps
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Bias, Variance, and Why Averaging Helps',
    3,
    $M5L3$To understand why random forests work, it helps to understand two failure modes: bias and variance.


BIAS

Bias means the model is too simple and misses real patterns.

Example:
  Using only price to predict demand while ignoring seasonality, marketing, and inventory.

The model cannot fit the complexity of the problem.

A biased model gives consistently wrong predictions — it is systematically off.


VARIANCE

Variance means the model is too sensitive to the specific training data it saw.

Example:
  A single deep decision tree creates a very specific rule from a small group of customers.
  Change the training data slightly and the tree looks completely different.

A high-variance model is unstable — it overreacts to noise.


HOW RANDOM FORESTS ADDRESS VARIANCE

Random forests mainly help reduce variance.

Each individual tree is allowed to be flexible (and potentially noisy), but then many trees are averaged so the final prediction is stable.

Some trees may overestimate.
Some trees may underestimate.
Some trees may follow noisy rules.
But most trees will agree on the true signal.

When you average them, the random errors cancel and the signal survives.

This is variance reduction through averaging.


WHAT RANDOM FORESTS DO NOT FIX

Random forests do not automatically fix bias.

If every tree in the forest is trained on bad features or the wrong target, averaging 1,000 bad trees still gives a bad prediction.

Garbage in → garbage out, regardless of how many trees you use.

[!] The PM's job is to make sure the training data, features, and target are correct. No amount of model sophistication can compensate for a misspecified problem.

>> Random forests reduce variance (instability) by averaging. They do not reduce bias (systematic error). Good input data and target definition are still the PM's responsibility.$M5L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.4 — Inputs, Outputs, and How the Forest Learns
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Inputs, Outputs, and How the Forest Learns',
    4,
    $M5L4$WHAT ARE THE INPUTS?

The inputs are features — the signals used to make predictions.

Example: fraud detection.

Features may include:
  Transaction amount
  Device type
  Location mismatch flag
  Account age
  Payment method
  Failed login count
  Purchase frequency
  Time of transaction
  Past chargebacks
  Shipping address mismatch

Target: fraud or not fraud.

Training data example:

  Transaction amount | Device mismatch | Account age | Failed logins | Fraud?
  $40                | No              | 2 years     | 0             | No
  $950               | Yes             | 3 days      | 5             | Yes
  $80                | No              | 1 year      | 0             | No
  $1,200             | Yes             | 1 week      | 3             | Yes

The forest trains hundreds of trees on different random samples of this data.


WHAT IS THE OUTPUT?

Classification output: predicted class, probability, or risk score.
  Example: fraud probability = 91%
  Example: churn risk = high
  Example: lead conversion probability = 64%

Regression output: a number.
  Example: predicted demand = 8,500 units
  Example: predicted delivery time = 3.8 days
  Example: predicted customer value = $920


HOW DOES A RANDOM FOREST LEARN?

The training sequence is:

  1. Create many random bootstrap samples from the training data.
  2. Train one decision tree on each sample.
  3. At each split within a tree, consider only a random subset of features.
  4. Let each tree make its prediction on new data.
  5. Combine all predictions: majority vote for classification, average for regression.

That is the complete algorithm.

[!] Random forests need minimal preprocessing. Features do not need to be scaled or normalized. Income and age can be on completely different scales without harming the model.

PM question:
  "What features are included, and would all of them be available at the time the prediction is needed?"$M5L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.5 — Feature Importance and Model Explainability
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Feature Importance and Model Explainability',
    5,
    $M5L5$WHAT IS FEATURE IMPORTANCE IN A RANDOM FOREST?

Random forests can estimate which features contributed most to the predictions across all trees.

Example: churn model feature importance.

  Days since last login   28%
  Usage decline           24%
  Support tickets         18%
  Payment failure         14%
  Plan type                9%
  Email engagement         7%

Feature importance helps PMs understand:
  Which signals drive predictions
  Which data sources matter most
  Which product behaviors are predictive
  Which operational levers may be worth investigating


FEATURE IMPORTANCE IS NOT CAUSATION

A feature being important in the forest means it helped the model predict — not that it causes the outcome.

Example:
  Support tickets are associated with churn.
  This does not prove that reducing support tickets will reduce churn.
  Maybe unhappy customers both open tickets and churn due to an underlying product problem.

PM question: "Are we using this for prediction, or claiming this feature causes the outcome?"


ARE THE IMPORTANT FEATURES ACTIONABLE?

Even when a feature is genuinely predictive, it may not be actionable.

Non-actionable examples: customer age, geographic region, account tenure.

Actionable examples:
  Usage decline → design re-engagement triggers
  Payment failure → proactive billing support
  Support ticket volume → identify the product areas generating the most friction


GLOBAL VS. LOCAL EXPLANATION

Global explanation answers: "What features matter most overall?"
  Feature importance gives global explanation.
  Example: across all customers, usage decline is the top churn predictor.

Local explanation answers: "Why did the model flag this specific customer?"
  Example: this customer was flagged because usage dropped sharply, payment failed, and login stopped.

For local explanations on individual predictions, teams may use methods like SHAP or LIME. As a PM, you do not need to know the math — but you should ask:

  "Can we explain individual predictions clearly enough for this use case?"

This matters most for high-stakes decisions: credit, healthcare, compliance, high-value customer interventions.

[!] A forest with strong AUC and useful feature importance may still be insufficient if individual predictions need to be explainable to regulators or affected users.

>> Feature importance is a starting point, not a conclusion. It shows what the model used — not what you should change.$M5L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.6 — Important Hyperparameters and Out-of-Bag Evaluation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Important Hyperparameters and Out-of-Bag Evaluation',
    6,
    $M5L6$Hyperparameters are settings chosen before training — they shape how the model is built. Understanding the key ones helps PMs ask the right questions during design and review.


NUMBER OF TREES

More trees usually improve stability but increase training and serving cost.

Common choices: 100, 500, 1,000 trees.

PM question: "Does adding more trees improve performance enough to justify the cost?"


MAXIMUM TREE DEPTH

Controls how deep each tree can grow. Deeper trees capture complex patterns but may overfit.

PM question: "Are the trees too deep, causing the model to memorize training data?"


MINIMUM SAMPLES PER LEAF

Controls how many examples must be in each final leaf. Higher values reduce overfitting.

PM question: "Are predictions based on enough examples, or are some based on tiny groups?"


NUMBER OF FEATURES CONSIDERED AT EACH SPLIT

Controls how much randomness is introduced. Too many → trees become similar. Too few → trees become weak.

PM question: "Was the feature randomness tuned?"


CLASS WEIGHTS

For imbalanced classification (fraud is 1% of transactions, churn is 5% of customers), the model may need to give more weight to the rare class.

PM question: "Are we handling class imbalance properly, and what approach was used?"


OUT-OF-BAG EVALUATION

Because each tree is trained on a bootstrap sample, some rows are left out for that tree.

These left-out rows are called **out-of-bag (OOB)** examples.

The model can test each tree on rows it did not see during training. This gives an internal estimate of performance without needing a separate validation set.

PM-friendly explanation: OOB evaluation is like each tree having a built-in mini test set.

However, teams should still validate on a proper held-out test set before production — especially if there is any time structure in the data (e.g., predicting future events with past data requires time-based splitting, not random splitting).

[!] A model tuned well on OOB data but evaluated with poor time-splitting can give an overly optimistic performance estimate. Always ask how the test set was constructed.

>> Hyperparameters shape the model's behavior. As a PM, you do not need to tune them — but you should know what to ask.$M5L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.7 — Churn Prediction and Fraud Detection Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Churn Prediction and Fraud Detection Examples',
    7,
    $M5L7$EXAMPLE 1: CUSTOMER CHURN PREDICTION

Business problem: predict which customers may cancel in the next 30 days.

Model: random forest classification.

Input features:
  Days since last login, usage frequency, usage decline, support tickets,
  payment failures, plan type, tenure, satisfaction score, email engagement.

Target: churned or did not churn.
Output: churn probability = 81%.

Tiered actions:
  Above 80% → proactive customer success outreach
  60–80% → personalized retention offer
  40–60% → automated re-engagement email
  Below 40% → no action

Technical metrics: AUC, precision, recall, F1, lift in top-risk group, calibration, segment performance.

Business metrics: churn reduction, retained revenue, intervention ROI, offer cost, save rate.

Key PM questions:
  What threshold marks a customer as high risk?
  How many customers will be flagged? Can the team act on that volume?
  Which important features are actionable?
  Does the model perform well for new customers, not just tenured ones?
  Is the model meaningfully better than logistic regression on this data?


EXAMPLE 2: FRAUD DETECTION

Business problem: identify risky transactions before processing.

Model: random forest classification.

Input features:
  Transaction amount, device fingerprint, location mismatch, account age,
  failed login attempts, payment method, purchase velocity, past disputes.

Target: fraud or not fraud.
Output: fraud risk score = 94%.

Tiered actions:
  Above 95% → decline automatically
  70–95% → manual review
  Below 70% → approve

Technical metrics: precision, recall, AUC, PR AUC, false positive rate, false negative rate.

Business metrics: fraud loss reduction, customer friction, approval rate for good customers, chargeback reduction.

Key PM questions:
  Are false positives or false negatives more costly in our context?
  Are rare or novel fraud patterns being caught?
  How often does fraud behavior change? Is the model monitored for drift?
  What happens when the model is uncertain — who decides?
  Are explanations needed for declined transactions under our policies?

[!] Fraud models operate on adversarial data — fraudsters actively change their behavior to evade detection. Monitor drift more aggressively than in stable domains like churn.

>> Both examples follow the same structure: features → forest probability → threshold → tiered action → business metric.$M5L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.8 — Demand Forecasting and Ticket Prioritization Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Demand Forecasting and Ticket Prioritization Examples',
    8,
    $M5L8$EXAMPLE 3: DEMAND FORECASTING

Business problem: predict weekly product demand so operations can plan inventory, staffing, and suppliers.

Model: random forest regression.

Input features:
  Historical sales, price, discount, marketing spend, season, holiday flag,
  inventory level, product rating, competitor price, website traffic.

Target: units sold next week.
Output: predicted demand = 14,200 units.

Actions driven by the forecast:
  Inventory planning and reorder triggers
  Promotion timing and sizing
  Supplier order quantities
  Warehouse and staffing allocation

Technical metrics: MAE, RMSE, R², error by product category, error by season.

Business metrics: stockout reduction, overstock reduction, forecast accuracy, inventory carrying cost, revenue captured, waste reduction.

Key PM questions:
  Is the model meaningfully better than a simple seasonal baseline?
  Does it work for new products with limited history?
  Does it perform well during promotions and holiday periods?
  Are large forecast misses concentrated in certain categories?
  What is the business cost of over-forecasting vs. under-forecasting?
    (Over-forecast → excess inventory and waste. Under-forecast → stockouts and lost revenue.)


EXAMPLE 4: SUPPORT TICKET ESCALATION PREDICTION

Business problem: identify which support tickets are likely to escalate before they do, so the team can act early.

Model: random forest classification.

Input features:
  Customer plan, ticket topic, sentiment signals, number of previous tickets,
  time since ticket opened, product area, account value, past escalation history.

Target: escalated or not escalated.
Output: escalation probability = 67%.

Actions:
  High probability → route to senior agent, add SLA warning, trigger proactive communication
  Medium probability → assign priority queue
  Low probability → standard handling

Technical metrics: precision, recall, AUC, lift among top-risk tickets, calibration.

Business metrics: escalation reduction, faster resolution, customer satisfaction, SLA compliance, support cost.

Key PM questions:
  What escalation threshold should trigger priority handling?
  How many tickets will be flagged daily? Can the support team handle the volume?
  Are we over-prioritizing high-value accounts at the cost of fairness to smaller customers?
  Does early intervention actually improve resolution outcomes?

[!] In both examples, the model is only as useful as the action it triggers. A well-calibrated escalation model with no differentiated response process adds no value.

>> Demand and operations use regression forests; churn, fraud, and escalation use classification forests. The algorithm is the same — the target changes.$M5L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.9 — Metrics for Classification and Regression Forests
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Metrics for Classification and Regression Forests',
    9,
    $M5L9$CLASSIFICATION METRICS

Use these when predicting categories.

  Accuracy         — useful when classes are balanced; misleading when imbalanced
  Precision        — of all flagged, how many are actual positives?
  Recall           — of all actual positives, how many did we find?
  F1 score         — balance of precision and recall
  AUC (ROC)        — ranking quality across all thresholds
  PR AUC           — more informative than ROC for very imbalanced problems
  Confusion matrix — breakdown of TP, TN, FP, FN
  Lift             — how much better is the top group vs. average?
  Calibration      — does predicted 70% probability mean ~70% actually happen?
  Business impact  — revenue saved, fraud loss prevented, cost reduced

For rare events like fraud or defects:
  Precision, recall, and PR AUC matter more than overall accuracy or ROC AUC.

For sales leads where team capacity is limited:
  Precision matters — do not send the team to bad leads.

For fraud where missing a case is expensive:
  Recall matters — catch as much fraud as the operational system can handle.


REGRESSION METRICS

Use these when predicting numbers.

  MAE  — mean absolute error; easy to explain in business units
  RMSE — root mean squared error; penalizes large errors more
  R²   — how much of the variance the model explains
  Error by segment — critical for finding where the model fails
  Business impact  — stockout rate, delivery accuracy, revenue captured

For delivery time prediction where large errors are most painful:
  RMSE matters more than MAE (large errors are penalized heavily).

For lifetime value where dollar accuracy matters:
  Report error in dollars, not just percentages. "$50 average error on a $300 LTV prediction" is more meaningful than "R² = 0.74."


ALWAYS CONNECT TO BUSINESS METRICS

Technical metrics are necessary but not sufficient. Every model evaluation should include:

  Revenue lift
  Cost reduction
  Better targeting efficiency
  Fewer fraud losses
  Lower churn
  Better operational efficiency
  Customer satisfaction improvement

[!] A random forest with AUC of 0.87 tells you the model ranks well. It does not tell you whether the business should use it. That answer comes from the business metric.

>> The technical metric shows the model works. The business metric shows it matters.$M5L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.10 — Comparisons: Decision Tree, Logistic Regression, Gradient Boosting
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Comparisons: Decision Tree, Logistic Regression, Gradient Boosting',
    10,
    $M5L10$RANDOM FOREST VS. DECISION TREE

  Topic              | Decision tree       | Random forest
  Structure          | One tree            | Many trees
  Explainability     | High — clear path   | Medium — hundreds of paths
  Overfitting risk   | Higher              | Lower
  Stability          | Lower               | Higher
  Accuracy           | Usually lower       | Usually higher
  Feature importance | Available           | More stable, averaged across trees
  Best use           | When rules must be auditable or explained individually | When accuracy and stability matter more than transparent rules

Choose a decision tree when: rules need to be auditable, readable, or approved by stakeholders.
Choose a random forest when: predictive accuracy is the priority and less direct explainability is acceptable.


RANDOM FOREST VS. LOGISTIC REGRESSION

  Topic                      | Logistic regression           | Random forest
  Model type                 | Linear probability model      | Ensemble of trees
  Explainability             | High — coefficients           | Medium — feature importance
  Handles non-linearity      | Limited                       | Strong
  Handles feature interactions | Limited without manual work | Strong, learned automatically
  Training speed             | Fast                          | Slower
  Accuracy                   | Good baseline                 | Often higher
  Best use                   | Simple explainable classification | More complex tabular prediction

Use logistic regression when you need a fast, explainable baseline.
Use random forest when you need stronger prediction and the pattern may be non-linear.


RANDOM FOREST VS. GRADIENT BOOSTING

You will often hear comparisons with XGBoost, LightGBM, or CatBoost.

Simple difference:
  Random forest builds many trees independently and combines them.
  Gradient boosting builds trees sequentially — each new tree tries to fix mistakes from previous ones.

Random forests are often:
  Easier to tune with fewer sensitive hyperparameters
  More robust out of the box
  A strong general-purpose baseline

Gradient boosting is often:
  More accurate on well-tuned tabular problems
  More sensitive to hyperparameter choices
  Slower to train if not optimized

PM-friendly takeaway:
  Random forest is a strong, stable choice.
  Gradient boosting may perform better, but it needs more careful tuning and monitoring.
  Start with random forest; move to gradient boosting if there is evidence it is needed.

[!] In practice, the data quality, feature engineering, and target definition usually matter more than the choice between random forest and gradient boosting.

>> No model choice compensates for bad data. Choose the simplest model that meets the business requirement.$M5L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 5.11 — PM Checklist, What Can Go Wrong, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist, What Can Go Wrong, and the Memory Shortcut',
    11,
    $M5L11$WHAT CAN GO WRONG

1. Accurate model, no actionable output
   The model predicts well but the top drivers cannot be acted on.
   PM question: "What action will we take from this prediction?"

2. Segment failures hidden by good overall metrics
   Strong AUC overall but poor performance for new users or small accounts.
   PM question: "How does performance vary by segment?"

3. Poorly chosen threshold
   A fraud model catches most fraud but also blocks many good customers.
   PM question: "What business cost does this threshold optimize?"

4. Feature importance treated as causation
   Team says "feature X causes churn" based on importance scores alone.
   PM question: "Are we claiming prediction or causation?"

5. Production cost too high
   The forest is accurate but too slow or memory-heavy for real-time use.
   PM question: "What is the inference latency and infrastructure cost?"

6. Data leakage
   Model uses information not available at prediction time.
   PM question: "Would every feature be available at the exact moment of prediction?"

7. Model drift
   User behavior, fraud patterns, or market conditions change, weakening the model.
   PM question: "How often will we monitor performance and retrain?"

8. Poor handling of rare classes
   The forest under-detects fraud or defects unless class imbalance is explicitly addressed.
   PM question: "Are we using class weights, oversampling, or another imbalance technique?"


PM CHECKLIST FOR RANDOM FORESTS

1.  Are we solving classification or regression?
2.  What is the exact target?
3.  What is the prediction time window?
4.  What features are used?
5.  Are all features available at prediction time? (leakage check)
6.  What is the baseline comparison?
7.  How does it compare with logistic regression or a single tree?
8.  How many trees are used?
9.  What is the maximum tree depth?
10. What is the minimum samples per leaf?
11. Was class imbalance handled?
12. What are the main technical metrics?
13. What are the business success metrics?
14. How does performance vary by segment?
15. What are the most important features?
16. Are the important features actionable?
17. Are probabilities calibrated?
18. What threshold triggers action?
19. What is the cost of false positives?
20. What is the cost of false negatives?
21. What is the expected operational volume per day or week?
22. Can the business process handle that volume?
23. What is the inference latency?
24. What is the infrastructure cost?
25. How will the model be monitored after launch?
26. When will it be retrained?


HOW TO EXPLAIN TO LEADERSHIP

Simple version:
  "We used a random forest, which is a model made of many decision trees. Each tree learns from a slightly different sample of the data and considers different features. For classification, the trees vote. For regression, their predictions are averaged. This usually gives more stable and accurate predictions than relying on a single decision tree."

Churn example:
  "The model identifies customers most likely to churn in the next 30 days. The top 10% highest-risk customers churn at 4 times the average rate. We recommend piloting retention interventions for this group and measuring saved revenue against offer cost."

Demand example:
  "The model predicts weekly product demand using sales history, price, promotions, and seasonality. It reduces average forecast error compared with our current baseline. The next step is testing whether better forecasts translate into fewer stockouts and less excess inventory."


THE MEMORY SHORTCUT

A random forest is: **many decision trees voting together.**

  Random rows + random features + many trees = more stable prediction

Use it when: you want better accuracy than one tree, you have tabular business data, you expect non-linear patterns or feature interactions, and you can accept less direct interpretability.

Measure it with: precision, recall, F1, AUC, PR AUC, lift, calibration (classification) — or MAE, RMSE, R², segment error (regression) — plus a business impact metric.

Watch for: data leakage, misleading feature importance, poor calibration, segment failures, production cost, model drift, and confusing prediction with causation.

The most important PM question:
  **Does the improved accuracy justify the added complexity compared with a simpler model?**$M5L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 5.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'How does a random forest make a classification prediction?',
    '["Each tree votes for a class; the class with the most votes wins","One tree is chosen as the best and makes the final prediction","The predictions are multiplied together to find the consensus","The tree with the highest training accuracy makes the prediction"]',
    0
  );

  -- Q2 — Lesson 5.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What are the two sources of randomness in a random forest?',
    '["Random rows (bootstrap samples) and random features at each split","Random initialization of weights and random learning rate","Random train/test split and random pruning","Random feature scaling and random target encoding"]',
    0
  );

  -- Q3 — Lesson 5.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'Random forests mainly reduce which type of model error?',
    '["Variance — instability caused by over-sensitivity to the training data","Bias — systematic errors caused by a model that is too simple","Data leakage — information from the future used in training","Class imbalance — too many negative examples in the training set"]',
    0
  );

  -- Q4 — Lesson 5.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'Which preprocessing step is typically required before training a random forest?',
    '["None — random forests work directly with features on different scales","Feature scaling so all variables have the same range","One-hot encoding of every categorical variable","Principal component analysis to reduce dimensionality"]',
    0
  );

  -- Q5 — Lesson 5.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A random forest shows that customer age is the most important feature for churn. What should the PM do first?',
    '["Ask whether age is actionable — if not, identify which actionable features also matter","Remove age from the model since it cannot be changed","Conclude that age causes churn and design age-specific products","Retrain the model without age to see if performance drops"]',
    0
  );

  -- Q6 — Lesson 5.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'What is out-of-bag (OOB) evaluation in a random forest?',
    '["Testing each tree on the training rows it did not see, providing an internal performance estimate","A separate held-out test set used for final model evaluation","A technique for removing noisy features before training","A method for pruning the weakest trees from the forest"]',
    0
  );

  -- Q7 — Lesson 5.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'Why should fraud models be monitored for drift more aggressively than churn models?',
    '["Fraudsters actively change their behavior to evade detection, making patterns shift faster","Fraud datasets are always larger and harder to retrain","Churn models use more features and are inherently more stable","Fraud labels are more accurate, so the baseline is harder to beat"]',
    0
  );

  -- Q8 — Lesson 5.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A demand forecasting model has low average error but frequently misses during holiday periods. What should the PM prioritize?',
    '["Segment-level error analysis for holiday periods — average error hides important failures","Increasing the number of trees to improve overall accuracy","Switching from regression to classification for seasonal periods","Removing holiday flag from the feature set since it introduces noise"]',
    0
  );

  -- Q9 — Lesson 5.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A fraud random forest achieves 99% accuracy. Why might this be misleading?',
    '["Fraud is rare, so a model predicting not-fraud every time also achieves ~99% accuracy — precision, recall, and PR AUC matter more","99% accuracy is the theoretical maximum and confirms the model is perfect","Accuracy is only misleading for regression models, not classification","This means the model has 1% false positives, which is acceptable for most fraud systems"]',
    0
  );

  -- Q10 — Lesson 5.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'When should a PM recommend gradient boosting over a random forest?',
    '["When there is evidence that gradient boosting performs better on this data and the team can invest in careful tuning and monitoring","Whenever accuracy is mentioned as a goal","When the model needs to be explainable to regulators","When the dataset has fewer than 10,000 rows"]',
    0
  );

  -- Q11 — Lesson 5.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the most important PM question for any random forest project?',
    '["Does the improved accuracy justify the added complexity compared with a simpler model?","How many trees does the forest use?","What Gini impurity threshold was used at each split?","Is the model implemented in scikit-learn or XGBoost?"]',
    0
  );

end $$;
