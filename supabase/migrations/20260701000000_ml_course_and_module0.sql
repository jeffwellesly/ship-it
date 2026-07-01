-- ML Learning for Everyone — Course + Module 0: Machine Learning Basics for Product Managers
-- 11 lessons covering the PM perspective on ML fundamentals

do $$
declare
  v_course_id uuid;
  v_module_id uuid;
  v_l1  uuid; v_l2  uuid; v_l3  uuid; v_l4  uuid; v_l5  uuid; v_l6  uuid;
  v_l7  uuid; v_l8  uuid; v_l9  uuid; v_l10 uuid; v_l11 uuid;
begin

  -- ─────────────────────────────────────────────────────────────────
  -- NEW COURSE
  -- ─────────────────────────────────────────────────────────────────
  insert into courses (title, description, icon, sort_order) values (
    'ML for Everyone',
    'Understand machine learning from a product and business perspective — no math degree required.',
    '🧠',
    2
  ) returning id into v_course_id;

  -- ─────────────────────────────────────────────────────────────────
  -- MODULE 0
  -- ─────────────────────────────────────────────────────────────────
  insert into modules (course_id, title, description, sort_order) values (
    v_course_id,
    'Module 0: Machine Learning Basics for Product Managers',
    'Learn what ML is, how it works, and how to ask the right questions as a PM or builder.',
    0
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.1 — Why PMs Need to Understand ML
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Why PMs Need to Understand ML',
    1,
    $M0L1$As a PM, you usually do not need to build models yourself.

But you do need to understand:
  What problem the model is solving
  What data it needs
  What output it gives
  Whether the output is useful for the business
  How to measure whether the model is working
  Where the model can fail
  What questions to ask the data science or ML team

[!] A model is not useful just because it is technically accurate. It is useful only if it helps the product or business make better decisions.


ML PROBLEMS WORTH SOLVING

ML can help with:
  Predict which customers may churn
  Forecast demand for a product
  Detect fraud or abuse
  Recommend products or content
  Estimate delivery time
  Segment customers into meaningful groups
  Predict whether a lead will convert
  Identify risky transactions
  Detect defects in images or documents

Notice the pattern. Each of these is a decision someone needs to make. The ML model makes that decision faster, cheaper, or at scale.

>> A model is useful only when its prediction changes a decision and improves an outcome.


THE PM'S JOB IN AN ML PROJECT

Your job is to connect the model to a real decision.

You do not need to understand gradient descent. You do need to understand:
  What decision is this model improving?
  Who will use the prediction?
  What action will they take?
  Is that action creating business value?

If you cannot answer those questions, the model is not ready to ship.


ANALOGY

[!] Think of a thermometer. A doctor does not need to understand how the thermometer is built. But the doctor must understand what the reading means and what to do with it. A PM's relationship to ML models is similar — understand the output, understand the limits, decide what to do.


MINI EXERCISE

Pick one real or hypothetical product you know.

Write:
  The ML problem this product could use:
  The prediction it needs:
  The action that follows:
  The business metric it should improve:

Example:
  Product: e-commerce site
  ML problem: churn prediction
  Prediction: which users are likely to stop buying in 30 days
  Action: send a personalized retention email
  Business metric: repeat purchase rate$M0L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.2 — How Machine Learning Works: The Core Idea
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'How Machine Learning Works: The Core Idea',
    2,
    $M0L2$Machine learning is a way for computers to learn patterns from past data and use those patterns to make predictions or decisions on new data.

The simplest mental model:

  Past examples go in.
  The model learns patterns.
  A new case arrives.
  The model gives a prediction.

The model is not "thinking" like a human. It is finding patterns in data.


EXAMPLES OF WHAT MODELS LEARN

From customer activity, complaints, usage, payment history:
  → Which customers are likely to churn

From product price, seasonality, ads, past sales:
  → Future demand

From transaction amount, device, location, past behavior:
  → Fraud risk

From user clicks, views, purchases:
  → Product recommendations

The pattern is the same in every case: historical examples teach the model what to look for when a new case arrives.


ANALOGY

[!] Think of spam filters. Early spam filters relied on rules: if the email says "click here to win" block it. ML spam filters learn from millions of past emails marked as spam by humans. They discover patterns you could never manually write — subtle combinations of words, sender behavior, and timing. Then they classify new emails you have never seen before.


WHY "LEARNING FROM DATA" IS POWERFUL

Rule-based systems need humans to write every rule.

ML systems learn rules from data automatically.

This matters when:
  The rules are too complex to write manually
  The rules change over time
  The scale is too large for human review
  The patterns are subtle and non-obvious

>> Machine learning does not replace human judgment. It scales human judgment by learning from past decisions.


WHAT MODELS CANNOT DO

A model cannot:
  Work well without enough historical data
  Predict events that have never happened before
  Tell you why it made a prediction (usually)
  Guarantee perfect accuracy
  Learn the right thing from bad data
  Fix a poorly defined problem

Understanding limits is as important as understanding capabilities.$M0L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.3 — Features and Labels: Inputs and Outputs
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Features and Labels: Inputs and Outputs',
    3,
    $M0L3$Every ML model has inputs and outputs.

The inputs are called **features**. The output is called the **label** or **target**.


FEATURES

Features are the input variables used by the model.

Example for churn prediction, features may include:
  Number of logins
  Days since last activity
  Number of customer support tickets
  Subscription plan
  Payment failures
  Usage frequency
  Customer tenure

**Features are the clues given to the model.**

Good features are signals that actually predict the outcome. Irrelevant features add noise. Missing features leave the model blind to important signals.


LABEL / TARGET

The label, or target, is the thing we want the model to predict.

Examples:
  Churn prediction → churned or did not churn
  Demand forecasting → number of units sold
  Fraud detection → fraud or not fraud
  Lead scoring → converted or did not convert
  Delivery prediction → delivery time in days
  Recommendation → user clicked or purchased

**The target is the answer the model is trying to learn.**


FEATURE QUALITY MATTERS

A model is only as good as its features.

Strong features for churn:
  Days since last login (high signal)
  Number of payment failures in last 90 days (high signal)
  Number of support tickets opened (moderate signal)
  User age in years (probably low signal)

[!] PMs should think carefully about which signals matter in the business. Choosing the right features is not just a data science task. It requires product and business knowledge.


MINI EXERCISE

For one ML problem, write 5 features and the target.

Example:
  Problem: predict whether a sales lead will convert

  Features:
  1. Company size
  2. Industry
  3. Number of marketing emails opened
  4. Demo requested (yes/no)
  5. Time from first contact to demo

  Target:
  Converted to paying customer within 60 days (yes or no)

>> The PM who understands features can have a real conversation with the ML team about what signals matter.$M0L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.4 — Training Data, Test Data, and Predictions
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Training Data, Test Data, and Predictions',
    4,
    $M0L4$For a model to learn, it needs data.

That data is divided into two sets.


TRAINING DATA

**Training data** is the historical data used to teach the model.

Example: if we want to predict churn, we give the model old customer data where we already know who churned and who stayed.

The model studies that historical data and learns patterns.

Example pattern a churn model may learn:
  Customers who stop using the product for 30 days and open multiple
  support tickets have higher churn risk.


TEST DATA

**Test data** is data the model has not seen during training.

This matters because we do not only want the model to memorize old examples. We want it to work on future customers, future orders, future transactions.

A common split is:
  70–80% of data for training
  20–30% of data for testing

Training data teaches the model. Test data checks whether the model actually learned.

[!] A model that performs well only on training data is like a student who memorized the answer key but cannot solve a new problem. Always check test performance before trusting a model.


PREDICTION

**Prediction** is the model's output for a new case.

Examples:
  Churn model: this customer has 78% churn risk
  Demand model: expected sales next week = 12,000 units
  Fraud model: this transaction has high fraud risk
  Recommendation model: this user is likely to click Product A
  Delivery model: expected delivery time = 4.5 days

A prediction can be:
  A number (demand, price, delivery time)
  A probability (churn risk, fraud risk)
  A yes/no answer (fraud or not)
  A category (customer segment)
  A ranking (recommended products in order)


DATA QUALITY RULE

The quality of the data is often more important than the choice of model.

A sophisticated model trained on bad data gives bad predictions.

A simpler model trained on clean, relevant data can outperform the sophisticated one.

PM question:
  Where does this data come from?
  How complete is it?
  How far back does it go?
  Is it representative of the customers we have today?$M0L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.5 — Probability and Thresholds: Numbers into Decisions
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Probability and Thresholds: Numbers into Decisions',
    5,
    $M0L5$Many ML models do not say "yes" or "no" directly. They give a **probability**.

Example:
  The model says: "This customer has a 72% probability of churning."

That does not mean the model is 100% sure. It means that among similar customers in the training data, many churned in the past.


WHY PROBABILITY MATTERS FOR PMs

Product decisions often depend on thresholds.

Example:
  If churn risk is above 70% → send a retention offer
  If fraud risk is above 90% → block the transaction
  If fraud risk is between 50% and 90% → send for manual review

That blocking rule and that review rule are product decisions, not data science decisions.


THRESHOLD

A **threshold** turns a probability into an action.

Example churn model output:
  Customer A: 82% churn risk
  Customer B: 61% churn risk
  Customer C: 35% churn risk

If the threshold is 70%:
  Customer A → high risk (gets retention offer)
  Customer B → not high risk
  Customer C → not high risk

>> The threshold is a PM decision, not a model decision. The data science team builds the model. The PM decides what to do with the score.


TRADE-OFF IN THRESHOLDS

A lower threshold catches more risky cases but creates more false alarms.
A higher threshold creates fewer false alarms but misses more real cases.

Neither is simply "better." The right threshold depends on:
  What is the cost of missing a real case?
  What is the cost of a false alarm?
  What is the capacity of the team acting on flags?
  What action happens when you flag someone?

Example:
  Fraud detection: missing real fraud is expensive. Lower threshold may be right.
  Customer outreach: too many false positives annoy real customers. Higher threshold may be right.

[!] This is one of the most important PM decisions in any ML product. It requires business judgment, not just technical knowledge.


MINI EXERCISE

Pick a churn model. The team proposes a threshold of 60%.

Write:
  What action happens when a customer crosses 60%?
  What is the cost if we flag a non-churning customer?
  What is the cost if we miss a real churning customer?
  Should the threshold be higher or lower? Why?$M0L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.6 — Supervised vs. Unsupervised Learning
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Supervised vs. Unsupervised Learning',
    6,
    $M0L6$There are two broad types of machine learning that PMs encounter most often.


SUPERVISED LEARNING

**Supervised learning** means the model learns from examples where the correct answer is already known.

Example:
  We have past customer data and we already know who churned.
  The model learns: given these behaviors, predict whether a future
  customer will churn.

Supervised learning is used when we know what outcome we want to predict.

Common supervised learning problems:
  Predict churn
  Predict fraud
  Predict demand
  Predict revenue
  Predict delivery time
  Predict conversion
  Predict credit risk
  Predict product defect

The word "supervised" comes from the fact that the model gets the right answer during training. It is supervised — given labeled examples.


UNSUPERVISED LEARNING

**Unsupervised learning** means the model does not have a known answer. It tries to find patterns or groups on its own.

Example:
  We give the model customer behavior data, but we do not tell it
  who belongs to which type of customer.

  The model may discover groups like:
    Heavy users
    Discount-driven users
    Occasional users
    Premium users
    At-risk users

Common unsupervised learning problems:
  Customer segmentation
  Product grouping
  Behavior pattern discovery
  Anomaly detection
  Market segmentation

Unsupervised learning is useful when we are exploring data and trying to understand hidden structure.

[!] Unsupervised models do not predict a known label. They reveal structure that was not predefined. The PM must then decide whether the discovered structure is meaningful and actionable.


THE KEY QUESTION

To choose:
  Do we know the answer we want to predict? → Supervised.
  Are we exploring to discover patterns? → Unsupervised.

Example:
  "Predict which customers will cancel next month." → Supervised.
  "Find natural groups of customer behavior for targeting." → Unsupervised.

>> Supervised learning predicts a known outcome. Unsupervised learning discovers unknown structure.$M0L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.7 — Regression, Classification, and Clustering
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Regression, Classification, and Clustering',
    7,
    $M0L7$Most ML problems can be understood by asking one simple question:

What kind of output do we need?

Three output types cover most PM use cases.


REGRESSION

Use **regression** when the output is a number.

Examples:
  Predict sales revenue
  Predict demand (units)
  Predict delivery time (days)
  Predict price
  Predict customer lifetime value
  Predict cost per acquisition

Output example:
  Expected demand next week = 15,000 units.

The model is not predicting "yes" or "no." It is predicting a continuous value.


CLASSIFICATION

Use **classification** when the output is a category.

Examples:
  Will the customer churn? Yes or no.
  Is this transaction fraud? Yes or no.
  Will this user click? Yes or no.
  Which category does this support ticket belong to?
  Which customer segment is this user most likely in?

Output example:
  Fraud probability = 87%.

Classification problems with two outcomes are called binary classification.
Problems with more than two outcomes are called multi-class classification.


CLUSTERING

Use **clustering** when you want to discover natural groups.

Clustering is unsupervised. You do not tell the model which groups exist in advance.

Examples:
  Group similar customers for targeted marketing
  Group similar products for merchandising
  Group similar stores for regional strategy
  Find unusual outlier behavior

Output example:
  Customer belongs to Segment 3: high-value, frequent buyer.


HOW TO IDENTIFY THE PROBLEM TYPE

Quick guide:
  Output is a number → regression
  Output is a category or yes/no → classification
  No predefined output, discover groups → clustering

[!] Many real ML products use multiple model types together. A recommendation system may use classification to predict click probability and ranking to order results. Understanding the pieces helps you ask better questions.


MINI EXERCISE

For each product scenario, identify the output type:
  1. Predict next quarter revenue → ______
  2. Predict whether a user will unsubscribe → ______
  3. Group products into natural categories → ______
  4. Predict delivery time in hours → ______
  5. Identify which customer type a new user belongs to → ______

Answers:
  1. Regression
  2. Classification
  3. Clustering
  4. Regression
  5. Classification (if predefined segments) or Clustering (if discovering new ones)$M0L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.8 — The ML Workflow: Define, Collect, and Build
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The ML Workflow: Define, Collect, and Build',
    8,
    $M0L8$Every ML project follows a similar flow. This lesson covers the first four steps, which are where PMs have the most influence.


STEP 1 — DEFINE THE BUSINESS PROBLEM

Bad framing:
  "Let's build an ML model."

Good framing:
  "We want to identify customers likely to churn in the next 30 days
   so the retention team can intervene before cancellation."

The business problem should clearly answer:
  What decision are we trying to improve?
  Who will use the prediction?
  What action will they take?
  What business metric should improve?

[!] This step is owned by the PM. The data science team cannot define the business problem. Only someone with product and business context can do that.


STEP 2 — DEFINE THE TARGET

The target is the exact thing the model should predict.

Not clear:
  "Predict bad customers."

Clear:
  "Predict whether a customer will cancel their subscription within
   the next 30 days."

Good target definitions include:
  What event we are predicting
  Time window (30 days? 90 days? next quarter?)
  Unit of prediction (customer, transaction, product, order)
  Positive and negative class

Churn example:
  Unit = customer
  Positive class = customer cancels
  Time window = within 30 days
  Negative class = customer stays active


STEP 3 — COLLECT DATA

The model needs historical data.

For a churn model, data may include:
  Customer profile
  Product usage logs
  Payment history
  Support tickets
  Marketing interaction data
  Plan type
  Past churn status

For a demand model, data may include:
  Historical sales
  Price history
  Promotions
  Seasonality and holidays
  Inventory levels
  Marketing spend

>> Data quality is often more important than model sophistication. A better algorithm cannot fix garbage inputs.


STEP 4 — CREATE FEATURES

**Feature engineering** means turning raw data into useful signals for the model.

Raw data:
  Customer login timestamps

Useful features derived from that data:
  Number of logins in last 7 days
  Number of logins in last 30 days
  Days since last login
  Change in usage compared with previous month

Good features make the model much stronger.

PMs should help the data team think about which signals actually matter in the business. This requires product knowledge, not just SQL.


DATA LEAKAGE WARNING

[!] Data leakage means the model uses information that would not be available at prediction time.

Example of leakage:
  Using "refund processed" to predict whether a customer will request a refund.
  That information is only known after the event happens.

PM question to always ask:
  Would this feature be available at the moment we need to make the prediction?$M0L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.9 — The ML Workflow: Validate, Deploy, and Monitor
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The ML Workflow: Validate, Deploy, and Monitor',
    9,
    $M0L9$This lesson covers the final four steps of the ML workflow — where models often succeed or fail in practice.


STEP 5 — TRAIN THE MODEL

Training means the model learns patterns from historical data.

The model compares its predictions with the true answers and adjusts itself to reduce errors over many iterations.

Different models learn differently:
  Linear regression learns weights for each input
  Logistic regression learns probability of a yes/no outcome
  Decision trees learn rules (if X then Y)
  Random forests combine many trees
  Neural networks learn complex patterns through many layers

As a PM, you do not need to understand the math. You do need to ask: does this model type make sense for our problem and our data?


STEP 6 — VALIDATE THE MODEL

Validation means testing whether the model works on data it has never seen.

This helps answer:
  Is the model useful?
  Does it generalize to new cases?
  Is it better than a simple baseline?
  Does it work across important segments?

A model can look good in training and fail in real life. Validation catches that.

[!] Validation on overall data can hide problems. A model may perform well on average but fail on important sub-groups — specific regions, demographics, product types. Always ask about segment-level performance.


STEP 7 — DEPLOY THE MODEL

Deployment means connecting the model to the real product or business process.

Examples:
  Showing recommendations on a website
  Flagging risky transactions in real time
  Sending churn-risk users to the retention team
  Predicting demand for inventory planning
  Ranking search results
  Routing support tickets by category

A model is not a product until its output is connected to an action.

>> Training and validating a model is about 20% of the work. Getting it into a product and making it useful is the other 80%.


STEP 8 — MONITOR THE MODEL

Models can degrade over time. This is called **model drift**.

Why drift happens:
  Customer behavior changes
  Markets change
  Competitors change
  Product flows change
  Fraudsters adapt
  Data pipelines break

PMs should ensure there is a monitoring plan.

Track:
  Prediction accuracy over time
  Business metric impact
  Data quality and feature distribution changes
  Segment-level performance
  False positive and false negative rates
  User complaints or operational issues

PM question:
  What happens if this model silently starts performing worse?
  Who is responsible for catching that?
  How quickly can we retrain?$M0L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.10 — Overfitting, Underfitting, and Baselines
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Overfitting, Underfitting, and Baselines',
    10,
    $M0L10$These three concepts help you evaluate whether a model is actually working.


OVERFITTING

**Overfitting** means the model memorized the training data too well.

It performs very well on old data but poorly on new data.

Analogy:
  A student memorizes exact homework answers but cannot solve new exam questions.

Signs of overfitting:
  Very high accuracy on training data
  Much lower accuracy on test data
  Performance drops significantly after launch

PM question:
  "Is the model performing similarly on training data and test data?"

If the gap is large, the model may have overfitted.


UNDERFITTING

**Underfitting** means the model is too simple and misses important patterns.

Analogy:
  A student learns only one formula and tries to apply it to every problem.

Signs of underfitting:
  Poor performance on training data
  Poor performance on test data
  Model misses patterns that are obvious to humans

PM question:
  "Is the model too simple for the complexity of this problem?"


BASELINE MODEL

A **baseline** is the simple comparison point.

It is the model or rule that exists before the ML project. The new model must beat it meaningfully.

Examples:
  Demand forecasting baseline = use last week as forecast for this week
  Churn baseline = predict that no customer ever churns
  Fraud baseline = existing rule-based system
  Recommendations baseline = show most popular products

A new ML model must beat the baseline enough to justify its cost and complexity.

[!] Without a baseline, you cannot know if the ML model is actually better. A team saying "the model has 92% accuracy" is not impressive if a baseline of "predict always no fraud" also gets 95% accuracy because fraud is rare.

>> The right question is not "how good is the model?" It is "how much better is the model than what we already have?"


PM QUESTIONS FOR QUALITY

  How does training accuracy compare to test accuracy?
  What is our baseline, and by how much does the model beat it?
  Is the performance consistent across customer segments?
  Has the team stress-tested the model on edge cases?$M0L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 0.11 — What PMs Should Always Ask (and What Goes Wrong)
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What PMs Should Always Ask (and What Goes Wrong)',
    11,
    $M0L11$Two critical concepts close out this module: how to evaluate model success from a business perspective, and the most common ways ML projects fail.


OFFLINE METRICS VS. BUSINESS METRICS

**Offline metrics** are technical measurements calculated before launch.

Examples: accuracy, precision, recall, F1 score, AUC, RMSE, R-squared.

These tell us whether the model is statistically performing well.

**Business metrics** tell us whether the model actually improved the product.

Examples: revenue, conversion, retention, fraud loss reduction, time saved, manual review reduction.

[!] A model can have excellent offline metrics and still fail to create business value.

Example:
  A churn model predicts churn accurately.
  But the retention team has no good offer to send at-risk customers.
  Churn does not improve.
  The model is statistically accurate and business-useless.

PM question:
  "What decision will change because of this model's prediction?"


FALSE POSITIVES AND FALSE NEGATIVES

When a model predicts a yes/no outcome, there are two types of mistakes.

**False positive**: the model says "yes" but the answer is "no."
  Example: blocking a valid transaction because the fraud model fired.

**False negative**: the model says "no" but the answer is "yes."
  Example: a fraudulent transaction passes through undetected.

Which is worse depends entirely on the business context:
  In fraud detection, false negatives are expensive.
  In customer messaging, false positives annoy real people.
  In medical diagnosis, false negatives can be dangerous.
  In sales lead scoring, false positives waste sales team time.

PMs must decide which error is more costly and set thresholds accordingly.


COMMON THINGS THAT GO WRONG

1. Wrong problem
   The team builds a model without a real decision to improve.
   Fix: start with the business decision, not the algorithm.

2. Poor target definition
   "Predict customer quality" is vague.
   Fix: "Predict whether a customer will make a second purchase within 60 days."

3. Bad data quality
   The model learns from incomplete, outdated, or biased data.
   Fix: audit the data before training.

4. Data leakage
   The model uses information unavailable at prediction time.
   Fix: always ask "would this feature exist when we need to predict?"

5. Optimizing the wrong metric
   High technical accuracy but no business improvement.
   Fix: tie model metrics to business cost and value.

6. No action plan
   Predictions exist but no process uses them.
   Fix: define the action before building the model.

7. No monitoring
   The model works at launch but slowly degrades.
   Fix: agree on a monitoring and retraining plan before shipping.


PM CHECKLIST BEFORE ANY ML PROJECT

Before starting:
  1. What business decision are we improving?
  2. What is the exact prediction target?
  3. Who will use the prediction?
  4. What action will they take?
  5. What data do we have?
  6. Is the data available at prediction time?
  7. What is the current baseline?
  8. What metric will prove the model is useful?
  9. What is the cost of false positives?
  10. What is the cost of false negatives?
  11. How will we test before full launch?
  12. How will we monitor after launch?


THE SIMPLE MEMORY SHORTCUT

ML for PMs is:

  Input → Model → Output → Action → Business impact

If any part is missing, the project is incomplete.

  Input: what data does the model receive?
  Model: what pattern does it learn?
  Output: what does it predict?
  Action: what do we do with the prediction?
  Business impact: what metric improves?

>> A model is only valuable when its prediction changes a decision and improves an outcome.$M0L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 0.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'What is the main job of a PM in an ML project?',
    '["Connect the model output to a real business decision and action","Build the neural network architecture","Write the training data SQL queries","Choose the programming language"]',
    0
  );

  -- Q2 — Lesson 0.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What is the core idea of machine learning?',
    '["Learn patterns from past data to make predictions on new data","Replace all human decision-making","Memorize a fixed set of rules written by engineers","Predict the future with 100% accuracy"]',
    0
  );

  -- Q3 — Lesson 0.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'In ML terminology, what are features and labels?',
    '["Features are inputs to the model; labels are the outcomes it predicts","Features are the database columns; labels are the row IDs","Features are the model weights; labels are the error rates","Features are test cases; labels are training cases"]',
    0
  );

  -- Q4 — Lesson 0.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'Why is test data kept separate from training data?',
    '["To check whether the model can apply learned patterns to new unseen cases","To make the dataset smaller","To reduce training time","Because test data is always low quality"]',
    0
  );

  -- Q5 — Lesson 0.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'What is a threshold in an ML product?',
    '["A cutoff that turns a probability score into a product action","The maximum size of the training dataset","The number of layers in a neural network","The minimum number of features required"]',
    0
  );

  -- Q6 — Lesson 0.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'What is the key difference between supervised and unsupervised learning?',
    '["Supervised learns from labeled examples with known answers; unsupervised discovers patterns without predefined labels","Supervised uses more data; unsupervised uses less","Supervised is used only for images; unsupervised is for text","Supervised is cheaper; unsupervised requires a bigger team"]',
    0
  );

  -- Q7 — Lesson 0.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A model predicts whether a user will click an ad. What type of ML problem is this?',
    '["Classification","Regression","Clustering","Reinforcement learning"]',
    0
  );

  -- Q8 — Lesson 0.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'What is data leakage?',
    '["Using a feature in training that would not be available at actual prediction time","Accidentally deleting training data","Sharing model weights with competitors","A slow data pipeline"]',
    0
  );

  -- Q9 — Lesson 0.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'What is model drift?',
    '["A gradual decline in model performance after deployment as real-world conditions change","A model that is too complex to deploy","A bug in the training script","When training accuracy is lower than test accuracy"]',
    0
  );

  -- Q10 — Lesson 0.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A churn model has 98% accuracy on training data but 60% accuracy on test data. What is this called?',
    '["Overfitting","Underfitting","A good result","Data leakage"]',
    0
  );

  -- Q11 — Lesson 0.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'A fraud model has excellent precision and recall but fraud losses did not decrease after launch. What is the most likely root cause?',
    '["No action was connected to the model output — predictions existed but no process used them","The model needs more training data","The threshold was set too high","The model used regression instead of classification"]',
    0
  );

end $$;
