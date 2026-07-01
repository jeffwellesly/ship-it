-- ML for Everyone — Module 3: Logistic Regression
-- 11 lessons covering logistic regression from a PM perspective

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
    'Module 3: Logistic Regression',
    'Learn how to predict yes/no outcomes as probabilities — and how to turn those probabilities into business decisions.',
    3
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.1 — What Is Logistic Regression and When to Use It
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is Logistic Regression and When to Use It',
    1,
    $M3L1$Logistic regression is a machine learning model used when you want to predict a **yes/no outcome**.

It is used when the output is not a number but a category like:
  Yes or no
  Fraud or not fraud
  Churn or not churn
  Click or no click
  Convert or not convert
  Approve or reject
  Defective or not defective

**Logistic regression predicts the probability that something will happen.**

Examples:
  A churn model may say: "This customer has a 78% chance of churning."
  A fraud model may say: "This transaction has a 91% chance of being fraud."
  A marketing model may say: "This user has a 34% chance of clicking this email."

The output is a probability between 0 and 1.


WHY NOT USE LINEAR REGRESSION FOR THIS?

Linear regression predicts numbers. It can produce values like -0.3 or 1.4 — which are impossible as probabilities.

Logistic regression fixes this by forcing the output to always stay between 0 and 1 using the sigmoid function (an S-shaped curve that converts any score into a valid probability).

[!] Simple rule: if the answer is a number → linear regression. If the answer is a category or probability of yes/no → logistic regression.


WHEN TO USE LOGISTIC REGRESSION

Use logistic regression when:
  You need a probability
  You want a simple and explainable classification model
  You need a strong baseline before using complex models
  You want to understand which features increase or decrease risk
  You need something easier to explain than neural networks

Good use cases:
  Will this customer churn? → Churn / not churn
  Will this user click the ad? → Click / no click
  Will this lead convert? → Convert / not convert
  Is this transaction fraud? → Fraud / not fraud
  Will this borrower default? → Default / no default
  Is this product defective? → Defective / not defective

>> The core strength of logistic regression is not just the prediction — it is the explainability of what drives the probability.$M3L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.2 — Inputs, Probabilities, and Thresholds
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Inputs, Probabilities, and Thresholds',
    2,
    $M3L2$THE SIMPLEST MENTAL MODEL

Imagine deciding whether a customer is likely to cancel a subscription.

You look at signals like:
  Has the customer stopped using the product?
  Did usage drop recently?
  Did they open support tickets?
  Did a payment fail?
  Are they on a monthly plan?
  Did they ignore renewal emails?

Each clue increases or decreases churn risk.

Logistic regression combines these clues and gives a probability.

Customer A — low usage, multiple complaints, payment failed, monthly plan:
  Churn probability = 82%

Customer B — high usage, no complaints, annual plan, active recently:
  Churn probability = 9%


FROM PROBABILITY TO DECISION: THE THRESHOLD

The model gives a probability. But the product needs a decision.

A **threshold** is the cutoff used to convert probability into action.

Example:
  If churn probability > 70% → mark as high risk → trigger retention offer

  Customer A: 82% → high risk
  Customer B: 72% → high risk
  Customer C: 48% → not high risk
  Customer D: 15% → not high risk

The default threshold is often 50%, but that is not always the right business choice.


WHY THRESHOLD CHOICE MATTERS

Imagine a fraud model.

Threshold too low (20%):
  Catches more fraud, but also blocks many good customers.

Threshold too high (95%):
  Blocks fewer good customers, but more fraud slips through.

The PM must help choose the threshold based on business cost.

  For fraud: which is more expensive — missing fraud or blocking good customers?
  For churn: which is more expensive — wasted retention offers or missed churners?
  For leads: which is worse — sales time on bad leads or missing good ones?

[!] There is no universally correct threshold. The right threshold depends on the product, cost of each error type, operational capacity, and business goal.

>> Setting the threshold is a PM decision, not a data science decision. The model gives the probability. You decide what to do with it.$M3L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.3 — Coefficients and Odds Ratios
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Coefficients and Odds Ratios',
    3,
    $M3L3$Like linear regression, logistic regression has **coefficients**.

But the interpretation is slightly different.

In linear regression: a coefficient tells how much the predicted number changes.

In logistic regression: a coefficient tells how much the feature changes the odds of the outcome.

In simple terms:

  Positive coefficient → feature increases the probability of the event.
  Negative coefficient → feature decreases the probability of the event.


EXAMPLE: CHURN PREDICTION COEFFICIENTS

  Days since last login  Positive  More inactive days → higher churn risk
  Number of complaints   Positive  More complaints → higher churn risk
  Annual plan            Negative  Annual plan → lower churn risk
  High product usage     Negative  More usage → lower churn risk
  Payment failure        Positive  Payment problems → higher churn risk

As a PM, the most important things to ask are:
  Which features increase risk?
  Which features reduce risk?
  Are these relationships believable given our product knowledge?
  Are they actionable?


ODDS AND ODDS RATIOS

If churn probability is 75%:
  Probability of churn = 0.75
  Probability of not churn = 0.25
  Odds = 0.75 / 0.25 = 3

This means the customer is 3 times more likely to churn than not churn.

An **odds ratio** tells how much a feature multiplies the odds.

Example: if payment failure has odds ratio = 2.5:
  Customers with payment failure have 2.5 times the odds of churning,
  compared with similar customers without payment failure.

PM-friendly language:
  "Payment failure is strongly associated with higher churn risk."

[!] You usually do not need to explain odds ratios to leadership. But you should understand them when reviewing model output with data teams — so you can translate the finding into plain language.


WHAT MAKES A GOOD COEFFICIENT STORY?

Coefficients are useful when they:
  Confirm what the business already suspects (builds confidence)
  Reveal something unexpected but logical (generates hypotheses to test)
  Show something actionable (creates a retention, prevention, or intervention lever)

Coefficients are risky when they:
  Show association but are mistaken for causation
  Come from features that are correlated with each other (multicollinearity)
  Come from features that are only available after the event (data leakage)$M3L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.4 — The Confusion Matrix: TP, TN, FP, FN
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'The Confusion Matrix: TP, TN, FP, FN',
    4,
    $M3L4$A confusion matrix shows how many predictions were right and wrong.

For a yes/no model, there are four outcomes.

  ┌─────────────────┬────────────────────┬────────────────┐
  │                 │ Predicted negative │ Predicted yes  │
  ├─────────────────┼────────────────────┼────────────────┤
  │ Actual negative │ True Negative  TN  │ False Positive │
  │ Actual positive │ False Negative FN  │ True Positive  │
  └─────────────────┴────────────────────┴────────────────┘


TRUE POSITIVE

The model predicted yes, and the actual answer was yes.

Example: model said customer will churn. Customer actually churned.

This is a correct positive prediction. We want more of these.


TRUE NEGATIVE

The model predicted no, and the actual answer was no.

Example: model said customer will not churn. Customer did not churn.

This is a correct negative prediction. We want more of these too.


FALSE POSITIVE (False Alarm)

The model predicted yes, but the actual answer was no.

Example: model said customer will churn. Customer would not have churned.

Business impact:
  Wasted retention offer. Customer may feel patronized. Cost without benefit.

For fraud: model said fraud, but transaction was legitimate.
  Good customer may get blocked or frustrated.


FALSE NEGATIVE (Missed Case)

The model predicted no, but the actual answer was yes.

Example: model said customer will not churn. Customer actually churned.

Business impact:
  Missed chance to save the customer. Revenue lost.

For fraud: model said not fraud, but it was actually fraud.
  Company loses money.

[!] In every yes/no model, false positives and false negatives have different costs. The PM's job is to understand which error is more expensive — and configure the threshold accordingly.

>> The confusion matrix is your starting point for every conversation about classification model quality. Do not skip it.$M3L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.5 — Accuracy and Why It Misleads
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Accuracy and Why It Misleads',
    5,
    $M3L5$Accuracy = correct predictions / total predictions.

Example: out of 1,000 predictions, 900 were correct. Accuracy = 90%.

Sounds good. But accuracy can be dangerously misleading.


THE FRAUD DETECTION TRAP

Out of 10,000 transactions:
  9,900 are not fraud
  100 are fraud

A model that predicts "not fraud" for every single transaction:
  Gets 9,900 correct out of 10,000 → accuracy = 99%

That looks excellent. But the model caught zero fraud cases. It is completely useless.

This is the **class imbalance** problem.

**Class imbalance** means one outcome is much more common than the other.

Real examples where imbalance is common:
  Fraud is rare — maybe 0.1% to 2% of transactions
  Churn may be 3–10% of customers per period
  Loan defaults may be 2–8%
  Product defects may be under 1%
  Serious medical conditions may be rare

[!] In imbalanced problems, a model that always predicts "no" can achieve high accuracy. But that model is worthless. Always ask about class balance before trusting accuracy.


BETTER METRICS FOR IMBALANCED PROBLEMS

Instead of (or in addition to) accuracy, use:
  Precision
  Recall
  F1 score
  AUC
  Precision-recall curve
  Business cost metrics (fraud loss, churn revenue saved)

PM question:
  "What is the positive class rate in our data?
   Is accuracy a reliable metric here, or should we use something else?"

>> When your data scientist says the model has 99% accuracy, your first question should be: what percentage of cases are actually positive?$M3L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.6 — Precision and Recall
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Precision and Recall',
    6,
    $M3L6$Precision and recall are the two most important metrics for classification problems.

They measure complementary things. Understanding both is essential for PMs.


PRECISION

Precision answers: of all the cases the model flagged as positive, how many actually were?

  Precision = True Positives / (True Positives + False Positives)

Example: the model flags 100 customers as high churn risk. 80 actually churn.

  Precision = 80 / 100 = 80%

Meaning: when the model raises an alert, it is right 80% of the time.

Use precision when **false positives are costly**:
  Sales team should not waste time on weak leads
  Good customers should not be wrongly blocked
  Manual review team should not be overloaded
  Users should not receive unnecessary warnings

High precision = fewer false alarms.


RECALL

Recall answers: of all the actual positive cases, how many did the model find?

  Recall = True Positives / (True Positives + False Negatives)

Example: 200 customers actually churned. The model caught 150 of them.

  Recall = 150 / 200 = 75%

Meaning: the model found 75% of all churners.

Use recall when **false negatives are costly**:
  Catching fraud (missing fraud costs money)
  Detecting dangerous defects (missing defects causes harm)
  Identifying at-risk customers (missing them means lost revenue)
  Finding compliance or safety risks

High recall = fewer missed cases.


THE TRADE-OFF

Precision and recall often move against each other.

Lower threshold → more cases flagged → recall usually increases → precision may fall.
Higher threshold → fewer cases flagged → precision usually increases → recall may fall.

Example:
  Churn threshold = 40%: catch many churners, but some false alarms. High recall, lower precision.
  Churn threshold = 80%: only flag very risky users. Fewer false alarms. High precision, lower recall.

The PM must decide which error matters more for the business.

[!] There is no "correct" balance between precision and recall. It depends on the cost of each error type and the operational capacity of the team acting on predictions.

>> Precision protects your team from false alarms. Recall protects you from missed cases. Know which matters more before setting the threshold.$M3L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.7 — F1, AUC, Calibration, and Lift
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'F1, AUC, Calibration, and Lift',
    7,
    $M3L7$F1 SCORE

F1 score combines precision and recall into one number.

It is high only when both precision and recall are reasonably good.

Use F1 when:
  The dataset is imbalanced
  You care about both catching cases and avoiding false alarms
  You need one summary metric to compare models

But do not blindly optimize F1. Business cost still matters more.

Example:
  Model A — precision 90%, recall 30%: careful but misses many cases
  Model B — precision 70%, recall 75%: better balance, likely better F1


AUC: AREA UNDER THE ROC CURVE

AUC tells us how well the model ranks positive cases above negative cases across all possible thresholds.

Simple interpretation:
  AUC = 0.5 → random guessing. No better than a coin flip.
  AUC = 0.7 → acceptable in many business problems
  AUC = 0.8 → good
  AUC = 0.9 → very strong
  AUC = 1.0 → perfect (rare, often suspicious — may indicate leakage)

AUC answers: does the model generally give higher scores to actual positives than negatives?

In churn prediction: do actual churners tend to get higher churn scores than non-churners?

[!] For imbalanced problems (fraud, defects), the precision-recall curve can be more informative than the ROC curve. The ROC curve may look too optimistic when the positive class is very rare.


CALIBRATION

Calibration means: when the model says 70% probability, does the event actually happen about 70% of the time?

Example: take all customers with predicted churn probability around 70%.
  If ~70 out of 100 actually churn → well calibrated.
  If only 30 out of 100 churn → model overestimates risk.
  If 90 out of 100 churn → model underestimates risk.

Calibration matters when the probability itself drives a business decision:
  Risk pricing
  Credit default probability
  Churn probability for intervention triggers
  Fraud risk scoring
  Lead conversion probability

A model can rank users well (high AUC) but still have poorly calibrated probabilities. Check both.

PM question: "Are we using the score only for ranking, or do we need the probability to be accurate?"


LIFT AND TOP-DECILE PERFORMANCE

Lift answers: how much better is the model at finding positives in the top group compared with random?

Example:
  Overall churn rate = 5%
  In the top 10% highest-risk customers, churn rate = 25%
  Lift = 25% / 5% = 5x

The model's top-risk group is 5 times more likely to churn than the average customer.

Use lift when:
  Sales team can contact only the top leads
  Retention team can act on only the top-risk customers
  Fraud team has limited review capacity
  Marketing budget targets only high-probability converters

>> Lift is often more useful than accuracy or F1 for business decisions — because most teams can act on only a fraction of cases.$M3L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.8 — Churn Prediction: A Full PM Walkthrough
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Churn Prediction: A Full PM Walkthrough',
    8,
    $M3L8$Let's walk through churn prediction end to end — from business problem to monitoring.


BUSINESS PROBLEM

A company wants to identify customers likely to cancel in the next 30 days so the retention team can intervene before cancellation.


INPUT FEATURES

  Days since last login
  Product usage decline
  Number of support tickets
  Payment failures
  Plan type (monthly vs. annual)
  Tenure
  Customer satisfaction score
  Email engagement rate


TARGET

Churned within 30 days: yes or no.


OUTPUT

Churn probability = 76%.


POSSIBLE ACTIONS AT EACH PROBABILITY LEVEL

  Above 80%: proactive customer success outreach
  60–80%: send personalized retention offer
  40–60%: trigger automated educational content or check-in email
  Below 40%: no action (monitor only)

This is a tiered action system based on probability ranges — not a single binary flag.


TECHNICAL SUCCESS METRICS

  Precision and recall
  F1 score
  AUC
  Calibration
  Lift at top decile


BUSINESS SUCCESS METRICS

  Churn rate reduction
  Revenue saved from retained customers
  Offer cost per saved customer
  Net ROI from intervention
  Customer satisfaction after outreach
  Lift in retention for treated vs. untreated high-risk group


PM QUESTIONS TO ASK

  What is the prediction window? 7-day, 30-day, or 90-day churn?
  What intervention will happen after a high-risk prediction?
  What is the cost of giving an unnecessary discount to a non-churner?
  What is the value of saving one customer?
  How many customers will be flagged daily or weekly?
  Can the team operationally handle that volume?
  Is there a way to measure incremental lift (e.g., A/B test: treated vs. untreated)?
  Are some high-risk segments already planning to churn regardless of intervention?

[!] A common mistake: build the churn model, flag customers, but have no differentiated action. If everyone gets the same generic discount email, the model adds no value. The prediction must trigger a meaningfully different response based on the score.

>> The churn model is not the product. The intervention system that uses the model is the product.$M3L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.9 — Fraud and Marketing Conversion: Two More Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fraud and Marketing Conversion: Two More Examples',
    9,
    $M3L9$EXAMPLE 2: FRAUD DETECTION

Business problem: identify suspicious transactions before they are processed.

Input features:
  Transaction amount
  Device type
  Location mismatch flag
  Unusual purchase pattern
  Account age
  Number of failed login attempts
  Payment method
  Previous chargebacks
  Time of transaction

Target: fraud or not fraud.

Output: fraud probability = 93%.

Tiered action system:
  Above 95% → decline automatically
  70–95% → send to manual review
  Below 70% → approve

Business metrics:
  Fraud loss reduction
  False positive rate (good customers blocked)
  Manual review volume and capacity
  Approval rate for good customers
  Chargeback reduction
  Operational cost per case

PM questions:
  Which is more costly: missed fraud or wrongly blocked customers?
  What is the manual review team capacity?
  Does the model work equally well across regions and payment methods?
  Are fraud patterns changing over time (drift)?
  Are fraudsters adapting their behavior to avoid detection?


EXAMPLE 3: MARKETING CONVERSION PREDICTION

Business problem: predict which users are likely to respond to a campaign, to target spending efficiently.

Input features:
  Previous purchases
  Email open history
  Website visits and cart activity
  Discount usage history
  Product interest category
  Time since last purchase
  Customer segment

Target: converted or did not convert.

Output: conversion probability = 41%.

How it is used:
  Send campaign only to high-probability users
  Personalize the offer based on interest signals
  Reduce spend on low-probability users
  Prioritize high-intent leads for direct outreach

Business metrics:
  Campaign ROI
  Conversion rate uplift vs. baseline
  Revenue per message sent
  Unsubscribe rate (over-targeting cost)
  Marketing cost per acquisition

PM questions:
  Are we optimizing for conversion rate or profit? (Discounts may boost conversion but hurt margin.)
  Are we over-targeting the same users repeatedly?
  Does the model create customer fatigue?
  What is the incremental lift compared with random targeting?
  Are some "high probability" users going to convert anyway, with or without the campaign?

[!] The last PM question above is about incrementality. A model may predict high probability of conversion for users who would have converted without any intervention. Spending budget on them is waste. Use holdout experiments to measure true incremental lift.

>> The three examples — churn, fraud, conversion — follow the same pattern: probability → threshold → tiered action → business metric. Master that pattern and you can navigate any classification model.$M3L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.10 — What Can Go Wrong
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Can Go Wrong',
    10,
    $M3L10$PROBLEM 1: WRONG TARGET DEFINITION

Bad target: "Predict bad customers."
Better target: "Predict whether a customer will cancel subscription within 30 days."

A good target needs: clear event, clear time window, clear positive class, clear unit.


PROBLEM 2: DATA LEAKAGE

The model uses information unavailable at prediction time.

Example: predicting churn using "cancellation request submitted" — that is near simultaneous with the event.
Example: predicting fraud using "chargeback received" — chargebacks happen after the transaction.

Leakage makes the model look excellent in testing and fail in production.

PM question: "Would this feature be available at the moment we make the prediction?"


PROBLEM 3: IMBALANCED CLASSES WITHOUT CORRECT EVALUATION

If only 1% of transactions are fraud, a model predicting "not fraud" always achieves 99% accuracy.

Evaluate imbalanced problems with precision, recall, AUC, and PR curve — not accuracy alone.

PM question: "What is the positive class rate, and are we using the right metrics?"


PROBLEM 4: BAD THRESHOLD CHOICE

A good AUC does not mean the chosen threshold is good for the business.

Too low: too many users flagged, team is overwhelmed, customers frustrated.
Too high: too many real cases missed, business loss continues.

PM question: "How did we choose the threshold, and what business cost does it optimize?"


PROBLEM 5: NO ACTION AFTER PREDICTION

A churn model is useless if no one acts on high-risk customers.
A lead scoring model is useless if sales does not use it.
A fraud model is useless if the review process is not ready.

PM question: "What exactly happens after each prediction is made?"


PROBLEM 6: MODEL WORKS OVERALL BUT FAILS FOR KEY SEGMENTS

Overall AUC may look good, but the model may fail for:
  New customers (too little data)
  Specific regions or product categories
  High-value users (exactly the ones that matter most)
  Seasonal periods
  Small businesses vs. enterprise customers

PM question: "How does the model perform by segment?"


PROBLEM 7: MODEL DRIFT

User behavior changes. Fraudsters adapt. Products change. Markets shift.

A model trained on old data may slowly become weaker.

PM question: "How will we monitor model performance after launch, and how often will we retrain?"


PROBLEM 8: CONFUSING PREDICTION WITH CAUSATION

Support tickets are associated with churn. That does not prove they cause churn.

Maybe unhappy customers both open tickets and churn — due to an underlying product problem.

PM question: "Are we using this for prediction (fine) or claiming it proves what causes churn (not fine without an experiment)?"

[!] These eight failure modes appear in almost every classification project. Building a checklist review against them before each launch is one of the highest-value things a PM can do.

>> The most common ML failure is not a bad model. It is a well-performing model connected to no action, the wrong action, or the wrong metric.$M3L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 3.11 — PM Checklist and How to Explain to Leadership
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist and How to Explain to Leadership',
    11,
    $M3L11$LOGISTIC REGRESSION: THE SIMPLE MEMORY SHORTCUT

Logistic regression is: predicting the probability of a yes/no event.

  Input features → weighted score → sigmoid → probability → threshold → action

Use it when:
  The outcome is binary (yes/no)
  You need probabilities for ranking or scoring
  You need an explainable baseline model
  You want to understand which factors increase or decrease risk

Measure it with:
  Precision, recall, F1, AUC, calibration, lift, business impact.

Watch out for:
  Accuracy on imbalanced data
  Bad threshold choice
  Data leakage
  False positive vs. false negative cost imbalance
  Poor calibration when probabilities are used directly
  Segment-level failures
  Confusing association with causation


PM CHECKLIST FOR ANY LOGISTIC REGRESSION MODEL

Before building or reviewing:

  1.  What yes/no outcome are we predicting?
  2.  What is the positive class?
  3.  What is the prediction time window?
  4.  What action will be taken from the prediction?
  5.  What features are used?
  6.  Are all features available at prediction time? (leakage check)
  7.  What is the baseline?
  8.  What is the class balance?
  9.  What are precision, recall, F1, and AUC?
  10. Is accuracy misleading here?
  11. What threshold are we using?
  12. Why did we choose that threshold?
  13. What is the cost of false positives?
  14. What is the cost of false negatives?
  15. Is the probability calibrated?
  16. How does performance vary by segment?
  17. How many cases will be flagged daily or weekly?
  18. Can the business process handle that volume?
  19. How will we monitor drift?
  20. What business metric should improve?


HOW TO EXPLAIN TO LEADERSHIP

Simple version:
  "We built a model that predicts the probability of a yes/no event.
   For each customer, transaction, or lead, it looks at historical signals
   and estimates the likelihood of the target outcome. We then choose a
   threshold that turns the probability into an action. The model is useful
   only if that action improves a business metric."

Churn example:
  "The churn model predicts which customers are likely to cancel in the next
   30 days. In testing, the top 10% highest-risk customers churned at 5 times
   the average rate. We recommend piloting retention outreach for this group
   and measuring saved revenue against offer cost."

Fraud example:
  "The fraud model assigns each transaction a fraud probability. Transactions
   above 95% are declined, transactions between 70% and 95% go to manual review,
   and below 70% are approved. We chose these thresholds based on fraud loss,
   customer friction, and review team capacity."

[!] Leadership does not need to know what a sigmoid function is. They need to know: what decision does it improve, what evidence do we have, what does it cost to operate, and how will we know if it starts failing.


THE MOST IMPORTANT PM QUESTION

  What action will we take at each probability level,
  and does that action improve the business outcome?

If you cannot answer that clearly, the model is not ready to ship.

>> A logistic regression model becomes a product when its probability scores drive differentiated actions that create measurable business value.$M3L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 3.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'When should you use logistic regression instead of linear regression?',
    '["When the output is a yes/no category and you need a probability","When the output is a continuous number like revenue","When you have no historical data","When you need to cluster customers into groups"]',
    0
  );

  -- Q2 — Lesson 3.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What is a threshold in logistic regression?',
    '["A cutoff probability that converts a score into a business action","The number of features in the model","The size of the training dataset","The model training speed"]',
    0
  );

  -- Q3 — Lesson 3.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'In logistic regression, what does a positive coefficient mean?',
    '["That feature increases the probability of the predicted event","That feature has no effect on the prediction","That feature must be removed from the model","That the model is overfitting"]',
    0
  );

  -- Q4 — Lesson 3.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'What is a false negative in a churn prediction model?',
    '["The model predicts a customer will not churn, but they actually do churn","The model predicts a customer will churn, but they actually stay","The model correctly identifies a churner","The model correctly identifies a loyal customer"]',
    0
  );

  -- Q5 — Lesson 3.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'Why is accuracy a misleading metric for fraud detection?',
    '["Because fraud is rare, a model that always predicts not-fraud achieves high accuracy but catches nothing","Because fraud detection requires regression, not classification","Because accuracy cannot be measured on financial data","Because fraud models should only use precision"]',
    0
  );

  -- Q6 — Lesson 3.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A fraud team can manually review only 50 cases per day. Which metric should they prioritize?',
    '["Precision — so that most flagged cases are genuine fraud and review capacity is not wasted","Recall — so that every fraud case is caught regardless of volume","Accuracy — because it combines all outcomes","F1 score — because it balances both errors equally"]',
    0
  );

  -- Q7 — Lesson 3.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'What does AUC measure in a logistic regression model?',
    '["How well the model ranks actual positive cases above negatives across all thresholds","The average prediction error in business units","The percentage of positive cases in the dataset","The number of features used by the model"]',
    0
  );

  -- Q8 — Lesson 3.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'In a churn model, why should the intervention vary by probability level rather than treating all flagged customers the same?',
    '["Different risk levels warrant different actions — a tiered response improves ROI and avoids wasting offers on low-risk cases","All flagged customers have the same churn risk","The model cannot predict exact probability levels","Customer success teams prefer simpler instructions"]',
    0
  );

  -- Q9 — Lesson 3.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A marketing conversion model has high predicted probability for users who would convert anyway without a campaign. What is this problem called?',
    '["Lack of incrementality — the model scores likely-buyers but the campaign adds no causal lift","Data leakage from future purchase data","Class imbalance in the training set","Multicollinearity between engagement features"]',
    0
  );

  -- Q10 — Lesson 3.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A logistic regression model has AUC of 0.88 but the business metric did not improve after launch. What is the most likely root cause?',
    '["No differentiated action was connected to the predictions","The AUC was measured incorrectly","The model needs more training data","The threshold was set to 0.5 by default"]',
    0
  );

  -- Q11 — Lesson 3.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the most important question a PM should answer before shipping any logistic regression model?',
    '["What action will we take at each probability level, and does that action improve the business outcome?","What is the model''s F1 score on the test set?","How many layers does the model have?","Which programming language was used to train it?"]',
    0
  );

end $$;
