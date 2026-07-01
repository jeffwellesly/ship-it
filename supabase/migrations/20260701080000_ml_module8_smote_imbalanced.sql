-- ML for Everyone — Module 8: SMOTE and Imbalanced Data
-- 11 lessons covering imbalanced data from a PM perspective

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
    'Module 8: SMOTE and Imbalanced Data',
    'Learn why rare events break standard ML models, how to detect and measure the problem, and how techniques like SMOTE help models learn to find the cases that matter most.',
    8
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.1 — What Is Imbalanced Data and Why Does It Matter?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is Imbalanced Data and Why Does It Matter?',
    1,
    $M8L1$Imbalanced data means one class appears much more often than another in a classification problem.

Example: fraud detection.

Out of 10,000 transactions:
  9,900 are not fraud (99%)
  100 are fraud (1%)

Other common examples:

  Use case                  | Majority class    | Minority class
  Fraud detection           | Not fraud         | Fraud
  Product defect detection  | Not defective     | Defective
  Loan default prediction   | No default        | Default
  Churn prediction          | Did not churn     | Churn
  Medical risk prediction   | No disease        | Disease
  System failure prediction | Normal operation  | Failure
  Spam detection            | Normal message    | Spam

**Imbalanced data means the important event is rare.**


WHY IT IS A PROBLEM

Machine learning models usually try to maximize overall accuracy.

When one class is very common, the model can look accurate without solving the business problem.

Example: fraud rate = 1%.

A model that predicts "not fraud" for every single transaction:
  Correct predictions = 9,900
  Accuracy = 99%
  Fraud recall = 0%

The model caught no fraud. It is completely useless.

This is the accuracy trap. The model learned to ignore the rare class because predicting the majority class gives high accuracy.


WHY THIS MATTERS FOR PMs

Many high-value business problems involve rare events:
  Fraud is rare but expensive.
  Product defects may be rare but damage trust and safety.
  Loan defaults may be rare but costly.
  System outages may be rare but high-impact.

A model with high accuracy can still be bad for the business.

As a PM, do not ask only: "What is the accuracy?"

Ask: "Are we catching the rare cases that matter?"

[!] The accuracy trap is the most common way imbalanced classification models fail silently. A 99% accurate model can have zero business value if it never catches the event it was built to find.

>> When the event you care about is rare, accuracy is the wrong metric. Start with precision and recall.$M8L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.2 — Precision, Recall, and the Confusion Matrix
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Precision, Recall, and the Confusion Matrix',
    2,
    $M8L2$THE CONFUSION MATRIX

For imbalanced data, the confusion matrix reveals what accuracy hides.

Example: fraud detection.

  ─────────────────────────────────────────────────────────
                     | Predicted not fraud | Predicted fraud
  Actual not fraud   | True Negative  (TN) | False Positive (FP)
  Actual fraud       | False Negative (FN) | True Positive  (TP)
  ─────────────────────────────────────────────────────────

True positive (TP): model predicted fraud, and it was fraud. Good.
True negative (TN): model predicted not fraud, and it was not fraud. Good.
False positive (FP): model predicted fraud, but it was not fraud. Annoyed a good customer.
False negative (FN): model predicted not fraud, but it was actually fraud. Fraud loss occurred.

For imbalanced problems, false negatives are often the most costly outcome because they represent the rare cases we are trying to catch.


PRECISION

Precision answers: of all the cases the model flagged as positive, how many were actually positive?

  Precision = TP / (TP + FP)

Example: the model flags 100 transactions as fraud. 80 are actually fraud.
  Precision = 80%

High precision = fewer false alarms.

Use precision when false positives are costly:
  Blocking good customers, overloading manual review teams, wasting sales team time, unnecessary retention offers.


RECALL

Recall answers: of all actual positive cases, how many did the model catch?

  Recall = TP / (TP + FN)

Example: 100 actual fraud cases exist. The model catches 75.
  Recall = 75%

High recall = fewer missed cases.

Use recall when false negatives are costly:
  Missing fraud, missing product defects, missing safety issues, missing loan defaults, missing abuse.


THE PRECISION-RECALL TRADE-OFF

Usually, precision and recall move against each other.

  Lower threshold → more cases flagged → recall usually rises → precision may fall.
  Higher threshold → fewer cases flagged → precision usually rises → recall may fall.

Example: fraud threshold.
  Low threshold → catch more fraud, but also block more good customers.
  High threshold → block fewer good customers, but miss more fraud.

The right balance depends on business cost. PM question: "Which mistake is more expensive — false positive or false negative?"

[!] Never evaluate an imbalanced classification model using accuracy alone. Always review the confusion matrix and ask for precision and recall on the minority (positive) class.

>> Precision protects your team from false alarms. Recall protects you from missed cases. Knowing which matters more drives every threshold decision.$M8L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.3 — F1 Score, PR AUC, and Business Metrics
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'F1 Score, PR AUC, and Business Metrics',
    3,
    $M8L3$F1 SCORE

F1 score combines precision and recall into one number.

It is high only when both precision and recall are reasonably good.

Example:
  Model A: precision 90%, recall 20% — careful but misses most cases.
  Model B: precision 70%, recall 70% — more balanced, likely better F1.

F1 is useful for summary comparison, but it is still a technical metric. Business cost of errors matters more.


PRECISION-RECALL CURVE

A precision-recall (PR) curve shows the trade-off between precision and recall at every possible threshold.

It is especially useful when the positive class is rare, because it focuses entirely on the minority class — unlike the ROC curve, which can look optimistic on imbalanced data.

Use the PR curve for:
  Fraud, defects, defaults, abuse detection, rare churn, medical risk, safety events.

PM question: "Can we review the precision-recall curve, not just accuracy or ROC AUC?"


PR AUC / AVERAGE PRECISION

Average precision (AP) or PR AUC summarizes the precision-recall curve into one number.

It captures how well the model finds rare positive cases while managing false alarms across all thresholds.

For imbalanced problems, average precision is often more informative than accuracy or ROC AUC.


BUSINESS METRICS MATTER MORE THAN TECHNICAL METRICS

For imbalanced data, the final measure should be business impact.

  Fraud detection:
    Technical: recall, precision, PR AUC.
    Business: fraud loss reduced, good-customer approval rate, manual review cost, chargeback reduction.

  Churn prediction:
    Technical: recall, precision, lift at top decile.
    Business: customers saved, retained revenue, offer cost, net ROI.

  Defect detection:
    Technical: defect recall, false negative rate, precision.
    Business: defects caught, customer complaints reduced, warranty cost, rework cost.

  Loan default:
    Technical: AUC, PR AUC, recall, calibration.
    Business: default loss reduction, approval quality, fairness, regulatory compliance.

A model is successful only if it improves the real-world outcome.

[!] PR AUC is the right first metric for most imbalanced problems. Always follow it with the business metric — how much did fraud loss, churn, or defect cost actually change?

>> Technical metrics tell you the model works. Business metrics tell you it matters.$M8L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.4 — Handling Imbalanced Data: A Menu of Options
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Handling Imbalanced Data: A Menu of Options',
    4,
    $M8L4$When the positive class is rare, there are several strategies to help the model learn it better. SMOTE is one of them — not the only one.

Here is the full menu.


1. USE BETTER METRICS

The simplest fix. Stop using accuracy; start using precision, recall, F1, PR AUC, and business cost.

This does not change the model — it changes how you evaluate it.


2. TUNE THE DECISION THRESHOLD

Instead of using the default 50% threshold, choose a cut-off based on business cost.

Example: if a missed fraud case costs $500 and a blocked good customer costs $20, a lower threshold (flagging more cases) may be worthwhile.

This is often the highest-leverage and easiest change.


3. USE CLASS WEIGHTS

Tell the model that mistakes on the minority class are more costly.

Example: weight fraud errors 20 times higher than non-fraud errors.

Most ML libraries support class weights directly. This is usually simpler than oversampling.


4. UNDERSAMPLE THE MAJORITY CLASS

Use fewer examples from the majority class.

Original: 990,000 normal / 5,000 fraud.
After undersampling: 50,000 normal / 5,000 fraud.

Benefit: forces the model to pay more attention to the minority class.
Risk: you may discard useful majority-class information.


5. OVERSAMPLE THE MINORITY CLASS (RANDOM)

Duplicate existing minority-class examples.

Original: 990,000 normal / 5,000 fraud.
After oversampling: 990,000 normal / 100,000 fraud (duplicated).

Benefit: the model sees the minority class more often.
Risk: duplicating the same examples repeatedly can cause overfitting.


6. SMOTE (SYNTHETIC OVERSAMPLING)

Create new synthetic minority-class examples rather than duplicating old ones.

Smarter than random oversampling because it generates new realistic examples.


7. COLLECT MORE MINORITY EXAMPLES

Often the best long-term fix. Better labeling and more real minority data beats any sampling technique.


8. ANOMALY DETECTION

When positive-case labels are very limited or unreliable, anomaly detection may help. The model learns what "normal" looks like and flags deviations.

[!] Start with class weights and threshold tuning before SMOTE. They are simpler, more interpretable, and often achieve similar results. SMOTE adds complexity — justify it.

PM question: "Why was SMOTE chosen over class weights or threshold tuning? What did we compare?"$M8L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.5 — What Is SMOTE and How Does It Work?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is SMOTE and How Does It Work?',
    5,
    $M8L5$WHAT IS SMOTE?

SMOTE stands for **Synthetic Minority Over-sampling Technique**.

It creates new synthetic examples of the minority class rather than simply duplicating existing ones.

**SMOTE creates realistic artificial examples of the rare class so the model can learn that class better.**


A SIMPLE EXAMPLE

Suppose we have two fraud cases.

Fraud case A:
  Transaction amount = $900
  Account age = 2 days
  Failed logins = 4

Fraud case B:
  Transaction amount = $1,100
  Account age = 4 days
  Failed logins = 6

SMOTE creates a synthetic fraud case somewhere between them:

Synthetic fraud case:
  Transaction amount = $1,000
  Account age = 3 days
  Failed logins = 5

This new case was not copied from the data — it was created between two similar real fraud cases. This helps the model learn the general "fraud region" rather than memorizing specific fraud examples.


HOW SMOTE WORKS (STEP BY STEP)

Step 1: Take one minority-class example (e.g., a fraud transaction).
Step 2: Find its nearest minority-class neighbors (other fraud transactions that look similar).
Step 3: Choose one neighbor.
Step 4: Create a new synthetic point somewhere between the original example and the neighbor.
Step 5: Repeat until the minority class has enough examples.

**SMOTE fills in the space between similar rare cases.**

The number of neighbors considered (commonly 5) controls how closely the synthetic examples cluster around existing minority-class points.


WHAT SMOTE IS NOT

SMOTE is not magic. It does not create truly new real-world information. It creates synthetic examples based on the existing minority examples.

If the original minority examples are poor quality, biased, noisy, or unrepresentative, SMOTE amplifies those problems.

SMOTE can help the model learn from rare examples — it cannot replace good data.

[!] SMOTE is a data augmentation technique, not a data collection replacement. The quality of synthetic examples depends entirely on the quality of the real minority-class examples they are based on.

>> SMOTE draws a line between two real rare examples and puts a new fake example somewhere on that line. Simple idea, powerful effect — when the underlying data is clean.$M8L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.6 — When to Use SMOTE and a Critical Warning
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'When to Use SMOTE and a Critical Warning',
    6,
    $M8L6$WHEN SHOULD YOU USE SMOTE?

SMOTE is appropriate when:
  You have a classification problem with a rare positive class.
  You have enough real minority-class examples to create meaningful synthetic points.
  The minority-class examples have useful, clean patterns.
  Accuracy is misleading and you want to improve recall or minority-class detection.
  You are working with structured / tabular numeric data.

Good use cases: fraud detection, defect detection, churn prediction, loan default, abuse detection, medical risk classification, system failure prediction.


THE CRITICAL WARNING: NEVER APPLY SMOTE BEFORE THE TRAIN/TEST SPLIT

This is one of the biggest and most common mistakes in imbalanced classification.

Wrong process:
  1. Apply SMOTE to the full dataset.
  2. Split into train and test.
  3. Train model and evaluate.

The problem: synthetic examples are created from real examples. If synthetic examples land in the test set, they contain information derived from the training data — this is data leakage. Test performance will look better than it really is.

Correct process:
  1. Split data into train and test. Keep the test set untouched.
  2. Apply SMOTE only to the training data.
  3. Train the model on the augmented training data.
  4. Evaluate on the original, untouched test set.

PM question: "Was SMOTE applied only to the training data, after the train/test split?"

This is one of the most important data quality questions for any SMOTE project.


THE TEST SET SHOULD REFLECT THE REAL WORLD

The test data should match real-world class distribution.

If real-world fraud rate is 1%, the test data should reflect 1% fraud — not an artificially balanced 50/50 split.

Why? Because you need to know how the model will actually perform in production.

Metrics from an artificially balanced test set overestimate real-world performance.

PM question: "Does the test set match the real-world class distribution?"

[!] These two rules — SMOTE only on training data, test set matches real world — are non-negotiable. Violating either means the evaluation cannot be trusted, and a bad model may be shipped with confidence.

>> A great SMOTE implementation with a contaminated test set is worse than no SMOTE at all — it looks trustworthy but is not.$M8L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.7 — SMOTE Complications: Calibration, Categoricals, Noise
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'SMOTE Complications: Calibration, Categoricals, Noise',
    7,
    $M8L7$SMOTE AND PROBABILITY CALIBRATION

Oversampling changes the class distribution in training data.

Example:
  Real world: 1% fraud
  Training data after SMOTE: 30% fraud

This can affect predicted probabilities. The model may output probabilities that are too high because it saw far more fraud-like examples during training.

If the probability itself drives a business decision (e.g., risk pricing, loan probability, intervention priority), calibration may be needed to realign probabilities with real-world rates.

PM question: "Are we using the model score for ranking only, or do we need calibrated probabilities? If the latter, was calibration checked after SMOTE?"


SMOTE WITH CATEGORICAL DATA

Basic SMOTE works by interpolating between numeric feature values. This is meaningful when features are numbers.

But many business datasets have categorical features: country, device type, payment method, subscription plan, product category.

Creating a synthetic value halfway between "iOS" and "Android" is meaningless.

For categorical or mixed data, use SMOTE variants designed for the purpose:
  SMOTE-NC — handles datasets with both numeric and categorical features.
  SMOTE-N — for purely nominal/categorical data.
  ADASYN — adaptive synthetic sampling, focuses on harder-to-learn examples.

PM question: "Do we have categorical features? Are we using the right SMOTE variant?"


SMOTE WITH HIGH-DIMENSIONAL DATA

SMOTE relies on finding "similar" minority-class examples using nearest-neighbor search.

In high-dimensional spaces (many features, text embeddings, sparse one-hot encoding), nearest neighbors may become less meaningful. Points that look numerically close may not actually be similar in the business sense.

This is the curse of dimensionality.

PM question: "Are nearest neighbors meaningful in this feature space? Does the team have evidence the synthetic examples are realistic?"


SMOTE AND NOISY LABELS

If minority-class labels are unreliable (e.g., transactions mislabeled as fraud, or inconsistent labeling across time), SMOTE may generate more synthetic examples around the bad labels — amplifying the noise.

PM question: "How reliable are the minority-class labels? What is the estimated label error rate?"

Label quality is especially important for rare events where even a few mislabeled examples have an outsized effect.


SMOTE CAN BLUR CLASS BOUNDARIES

Sometimes minority-class examples sit close to the majority boundary. SMOTE may create synthetic points near or across that boundary — generating examples that look like the majority class and confusing the model.

This can increase false positives.

PM question: "Did SMOTE improve recall at the cost of an unacceptable increase in false positives?"

[!] SMOTE is not a single button to press. It requires careful decisions about calibration, data types, feature space dimensionality, and label quality. Treat each of these as a risk to check.

>> Each complication is a PM question. Ask all of them before signing off on a SMOTE-based model.$M8L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.8 — Fraud Detection and Defect Detection Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Fraud Detection and Defect Detection Examples',
    8,
    $M8L8$EXAMPLE 1: FRAUD DETECTION

Business problem: identify fraudulent transactions before they are processed.

Data: 1,000,000 transactions. 995,000 normal. 5,000 fraud (0.5%).

The accuracy trap: a model predicting "not fraud" every time achieves 99.5% accuracy while catching zero fraud cases.

Correct approach:
  1. Split data into train and test (test set retains real 0.5% fraud rate).
  2. Apply SMOTE (or class weights) only to the training set.
  3. Train the classifier.
  4. Evaluate on the untouched test set.
  5. Tune threshold based on fraud loss vs. customer friction.

Tiered action system:
  Above 95% → decline automatically
  70–95% → manual review queue
  Below 70% → approve

Technical metrics: precision, recall, PR AUC, false positive rate, false negative rate.

Business metrics: fraud loss reduction, good-customer approval rate, manual review cost, chargeback reduction.

Key PM questions:
  What is the cost of a missed fraud case? What is the cost of blocking a good customer?
  Is manual review capacity limited? How many cases will be flagged daily?
  Was SMOTE applied only to training data?
  Did recall improve without unacceptable false positives?
  Are probabilities calibrated for risk scoring?


EXAMPLE 2: PRODUCT DEFECT DETECTION

Business problem: identify defective products before they reach customers.

Data: 98% normal products, 2% defective.

The accuracy trap: predicting "not defective" for everything achieves 98% accuracy but misses all defects.

Key considerations:
  Missing a defect (false negative) may lead to customer complaints, returns, safety issues, or warranty cost.
  Too many false alarms (false positives) can overload the inspection team and slow operations.
  Defect labels must be reliable — mislabeled examples cause SMOTE to amplify noise.

Technical metrics: defect recall, precision, PR AUC, false negative rate, confusion matrix.

Business metrics: defects caught, customer complaints reduced, warranty cost reduction, rework cost, inspection workload, customer satisfaction.

Key PM questions:
  Is missing a defect more costly than unnecessary inspection?
  What false positive rate can the operations team handle?
  Are defect labels reliable? Were they collected consistently?
  Does the model catch the most severe defect types specifically?
  Is there a segment of products where defect detection is especially critical?

[!] In safety-critical defect detection (food, medical devices, vehicles), recall is paramount. A 5% miss rate on defects may be unacceptable regardless of overall model accuracy.

>> Both examples share the same PM structure: identify the rare event → cost the two types of mistakes → choose the metric and threshold that optimizes the trade-off.$M8L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.9 — Churn Prediction and Loan Default Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Churn Prediction and Loan Default Examples',
    9,
    $M8L9$EXAMPLE 3: CHURN PREDICTION

Business problem: identify customers likely to cancel in the next 30 days.

Data: 95% did not churn, 5% churned.

The accuracy trap: predicting "no churn" always achieves 95% accuracy but finds no churners.

Correct approach:
  Use imbalance handling (SMOTE, class weights, or threshold tuning).
  Rank customers by churn risk.
  Target the top-risk customers with differentiated intervention.
  Evaluate by retention impact, not just model metric.

Tiered actions based on churn probability:
  Above 80% → proactive customer success outreach
  60–80% → personalized retention offer
  40–60% → automated re-engagement content
  Below 40% → no action

Technical metrics: recall, precision, lift at top decile, PR AUC, calibration.

Business metrics: customers saved, retained revenue, offer cost, net ROI, churn rate reduction.

Key PM questions:
  What is the prediction window (7-day, 30-day, 90-day churn)?
  What action will happen after each prediction?
  How many customers can the retention team handle?
  Are we optimizing for recall, precision, or lift at the top decile?
  Did SMOTE improve the quality of the highest-risk list?
  Does the intervention actually reduce churn — or just flag users who would have stayed anyway?


EXAMPLE 4: LOAN DEFAULT PREDICTION

Business problem: predict whether a borrower may default.

Data: most borrowers repay; defaults are relatively rare but expensive.

Key considerations:
  Defaults are rare but high-cost false negatives.
  False positives (rejecting a creditworthy applicant) also have real costs — lost revenue and potential fairness concerns.
  Probabilities may drive pricing decisions, so calibration is critical.
  Fairness and regulatory compliance requirements apply.

Technical metrics: AUC, PR AUC, recall, precision, calibration, segment-level performance.

Business metrics: default loss reduction, approval quality, profitability, fairness metrics, regulatory compliance.

Key PM questions:
  Are predicted probabilities calibrated — is a 70% default probability accurate?
  Are protected attributes handled correctly? Does the model perform fairly across demographic groups?
  What is the business cost of a false approval vs. a false rejection?
  Is there human review for high-impact decisions?
  Has the model been audited for disparate impact?

[!] Loan default models require extra rigor on fairness and calibration. A model that achieves high recall by over-flagging certain demographic groups may be accurate but legally and ethically unacceptable.

>> All four examples — fraud, defects, churn, loans — are imbalanced. The PM framework is the same: rare class, two types of costly mistakes, choose metrics that match the cost structure.$M8L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.10 — Measuring SMOTE's Impact, Lift, and Operational Capacity
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Measuring SMOTE''s Impact, Lift, and Operational Capacity',
    10,
    $M8L10$HOW TO MEASURE WHETHER SMOTE HELPED

Do not assume SMOTE helped just because it was applied. Compare models on the same untouched test set.

Example comparison:
  Model A: no imbalance handling
  Model B: class weights only
  Model C: SMOTE
  Model D: SMOTE + threshold tuning

For each, check:
  Recall on the positive class
  Precision on the positive class
  PR AUC
  Business cost (false positive volume × FP cost + false negative volume × FN cost)
  Calibration (if probability matters)
  Segment-level performance (does it work for all customer groups?)
  Operational volume (how many cases will be flagged per day?)

The best model is not always the one with the highest recall. A model with very high recall but terrible precision may overload the business team with false alarms.

PM question: "Compared with no SMOTE, what specifically did SMOTE improve and what did it worsen?"


LIFT: ESPECIALLY USEFUL FOR IMBALANCED PROBLEMS

Lift answers: how much more concentrated is the positive class in the model's top-ranked group vs. the overall population?

Example:
  Overall churn rate = 5%
  Top 10% highest-risk customers from the model churn at 25%
  Lift = 25% / 5% = 5x

The model's top-risk group is 5 times more concentrated with churners than the average population.

Lift is valuable when the team can only act on a small group:
  Churn campaigns, fraud review queues, lead scoring, collections, defect inspections.

PM question: "How much better is the top-ranked group vs. random selection?"


OPERATIONAL CAPACITY MATTERS

In imbalanced problems, the model threshold directly affects workload.

Example: a fraud review team can review 1,000 cases per day.
  Threshold A flags 5,000 cases/day → not feasible.
  Threshold B flags 900 cases/day → feasible.

Even if threshold A catches more fraud, it may not be operationally usable.

PMs must connect model output to workflow capacity.

Key questions:
  How many cases will be flagged per day or week?
  Who reviews them?
  What is the SLA for review?
  What is the cost per review?
  What happens if flagged volume spikes?
  What is the customer experience impact of being flagged?


COST-SENSITIVE THINKING

All mistakes in imbalanced problems are not equal.

Example: fraud.
  False negative: fraud goes through → cost = $500 average fraud loss.
  False positive: good customer blocked → cost = ~$20 in friction and support.

In this case, false negatives are far more expensive per incident. But if false positives affect thousands of customers, total cost may still be large.

Simple expected cost formula:
  Expected cost = (FP count × FP cost) + (FN count × FN cost)

PMs do not need to calculate every detail, but should push the team to think in these terms when choosing a threshold.

[!] Lift and expected cost are the two most business-relevant metrics for imbalanced classification. Use them to bridge the gap between "model performance" and "business decision."

>> A model that flags the right people and the team can actually act on is better than a perfect model that generates more cases than anyone can process.$M8L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 8.11 — PM Checklist, What Can Go Wrong, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist, What Can Go Wrong, and the Memory Shortcut',
    11,
    $M8L11$WHAT CAN GO WRONG

1. High accuracy hides failure
   The model looks good but misses rare cases.
   PM question: "What is recall for the minority class?"

2. SMOTE applied before the train/test split
   Synthetic examples contaminate the test set — data leakage.
   PM question: "Was SMOTE applied only after splitting, and only to the training data?"

3. Test set is artificially balanced
   Gives unrealistic performance estimates.
   PM question: "Does the test set match the real-world class distribution?"

4. Precision collapses after SMOTE
   The model catches more positives but creates too many false alarms.
   PM question: "What happened to precision and daily flagged volume?"

5. Probabilities become poorly calibrated
   Oversampling changes training class balance, distorting raw probabilities.
   PM question: "Do we need calibrated probabilities? Was calibration checked?"

6. Minority-class labels are noisy
   SMOTE creates synthetic examples around mislabeled data.
   PM question: "How reliable are the positive-class labels?"

7. Wrong SMOTE variant for the data type
   Basic SMOTE interpolates numerics — meaningless for categorical features.
   PM question: "Are we using the right imbalance technique for this data?"

8. No action follows the prediction
   The model flags rare cases, but no team is set up to act on them.
   PM question: "What happens after a case is flagged?"

9. Fairness issues across groups
   The model may detect the positive class at different rates across demographic segments.
   PM question: "Does minority-class detection work fairly across important user groups?"

10. Simpler alternatives were not compared
    SMOTE adds complexity — class weights or threshold tuning may achieve the same result.
    PM question: "Why SMOTE specifically? What did we compare it against?"


PM CHECKLIST FOR IMBALANCED DATA AND SMOTE

1.  What is the positive class?
2.  What is the class distribution?
3.  Is the positive class rare?
4.  Why does the rare class matter?
5.  What is the cost of a false positive?
6.  What is the cost of a false negative?
7.  Is accuracy misleading here?
8.  What are precision and recall for the minority class?
9.  What is the PR AUC or average precision?
10. What does the confusion matrix show?
11. What threshold are we using and why?
12. Did we compare class weights, threshold tuning, undersampling, oversampling, and SMOTE?
13. Was SMOTE applied only to the training data?
14. Was the test set left untouched and does it reflect real-world class balance?
15. Did recall improve? What happened to precision?
16. How many cases will be flagged in production per day?
17. Can the team handle that volume?
18. Are probabilities calibrated?
19. Are minority-class labels reliable?
20. Are synthetic examples realistic for this data type?
21. Does performance vary by segment or demographic group?
22. What business metric should improve?


HOW TO EXPLAIN TO LEADERSHIP

Simple version:
  "In this problem, the event we care about is rare. That means normal accuracy is misleading — a model can look accurate by mostly predicting the common class. We evaluated the model using precision, recall, and business cost. To help the model learn the rare class better, we tested imbalance-handling methods including SMOTE, which creates synthetic examples of the rare class in training data. We evaluated performance on original, real-world test data."

Fraud example:
  "Fraud is 1% of transactions, so a model with 99% accuracy could still catch no fraud. After imbalance handling and threshold tuning, the model catches 72% of fraud cases while keeping false positives within review team capacity. The next step is to pilot this workflow and measure fraud loss reduction, customer friction, and review cost."

Churn example:
  "Churners are 5% of customers, so accuracy is the wrong metric. We care whether the model ranks likely churners at the top. The top 10% highest-risk customers have a churn rate 4x higher than average. We recommend testing retention actions on that group and measuring net saved revenue against offer cost."


THE MEMORY SHORTCUT

Imbalanced data = the important event is rare.
SMOTE = creating synthetic rare-class examples so the model learns rare patterns better.

  Rare class → accuracy trap → use precision/recall → handle imbalance → tune threshold → measure business impact

Use SMOTE when: the positive class is rare, you have classification data, you have enough real minority examples, you evaluate on untouched real-world test data.

Measure with: precision, recall, F1, PR AUC, average precision, confusion matrix, lift, calibration, business cost, operational volume.

Watch for: accuracy trap, SMOTE before split (data leakage), artificial test balance, calibration problems, false positive explosion, noisy labels, categorical data issues, no action after flagging.

The most important PM question:
  **Are we actually catching more of the rare important cases without creating too many costly false alarms?**$M8L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 8.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'A fraud detection model achieves 99% accuracy. Why might this model be completely useless?',
    '["Fraud is 1% of transactions — a model predicting not-fraud every time also achieves 99% accuracy while catching zero fraud cases","99% accuracy is the theoretical maximum and confirms the model is working correctly","Fraud detection requires regression, not classification, so accuracy is the wrong algorithm","The model needs more training data to reach 99.5% accuracy before it can be deployed"]',
    0
  );

  -- Q2 — Lesson 8.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'A fraud model flags 200 transactions. 160 are actually fraud. 40 actual fraud cases were not flagged. What are precision and recall?',
    '["Precision = 80% (160/200 flagged were real fraud); Recall = 80% (160 of 200 total fraud cases were caught)","Precision = 40% (40 missed out of 200 flagged); Recall = 80%","Precision = 80%; Recall = 40% (40 of total cases flagged)","Both precision and recall = 99% because the overall accuracy is near-perfect"]',
    0
  );

  -- Q3 — Lesson 8.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'Why is PR AUC often more informative than ROC AUC for imbalanced classification problems?',
    '["PR AUC focuses on the positive class performance across thresholds — ROC AUC can look optimistic when the negative class dominates","ROC AUC requires balanced data to compute correctly","PR AUC is always higher than ROC AUC, making it easier to use in reports","PR AUC measures calibration; ROC AUC measures ranking"]',
    0
  );

  -- Q4 — Lesson 8.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'Before using SMOTE, which simpler alternatives should a PM ask the team to compare?',
    '["Class weights and threshold tuning — they are simpler, more interpretable, and often achieve similar results without adding SMOTE complexity","Random undersampling and feature engineering — these always outperform SMOTE","Neural networks and gradient boosting — imbalance requires more powerful models","Collect 10x more data and retrain — data volume always solves imbalance"]',
    0
  );

  -- Q5 — Lesson 8.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'How does SMOTE create new minority-class examples?',
    '["It creates synthetic points between existing minority-class examples by interpolating between a real example and one of its nearest minority-class neighbors","It duplicates existing minority-class examples multiple times until the classes are balanced","It randomly generates new examples uniformly across the entire feature space","It copies minority-class examples from similar datasets found online"]',
    0
  );

  -- Q6 — Lesson 8.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A team applies SMOTE to the full dataset and then splits into train and test. What is the problem?',
    '["Data leakage — synthetic examples derived from real data may appear in the test set, making test performance look better than production reality","The test set will have too few positive examples to evaluate recall","SMOTE changes the feature distributions in a way that breaks the train/test split","The model will underfit because SMOTE reduces the effective training size"]',
    0
  );

  -- Q7 — Lesson 8.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A churn model trained with SMOTE outputs a 45% churn probability. Why might this number be misleading?',
    '["SMOTE increases the minority-class proportion in training (e.g., from 5% to 30%), causing the model to output inflated probabilities that do not match the real-world base rate","SMOTE always makes predictions more conservative, so 45% should be interpreted as 22.5%","The 45% is correct because SMOTE ensures perfectly calibrated probabilities","Probability outputs from SMOTE models must always be multiplied by the actual class imbalance ratio"]',
    0
  );

  -- Q8 — Lesson 8.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A defect detection model has 98% accuracy. The team is satisfied. What should the PM ask first?',
    '["What is recall for the defective class? 98% accuracy could mean the model predicts not-defective every time and catches zero defects","Can we increase accuracy to 99% with more training data?","Is the model trained on a balanced dataset with equal defective and normal examples?","Should we switch to a regression model since accuracy is near its maximum?"]',
    0
  );

  -- Q9 — Lesson 8.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A churn model with high recall is used to send retention offers. A pilot shows offers are sent to many users who would not have churned anyway. What does this indicate?',
    '["The model may have low precision and insufficient lift — it catches churners but also flags many non-churners, wasting offer budget on people who would stay without intervention","The model needs to be retrained with SMOTE to improve recall further","The retention offer is the wrong action — the model prediction is still correct","Churn models should never be used to trigger offers because of this inherent problem"]',
    0
  );

  -- Q10 — Lesson 8.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A fraud model has excellent PR AUC, but the fraud review team can only process 500 cases per day and the model flags 3,000. What should the PM do?',
    '["Raise the threshold to reduce flagged volume to a level the team can handle — a model that generates unprocessable volume has no operational value","Deploy the model anyway since PR AUC is the most important metric","Hire more reviewers to match the model output volume","Lower the threshold further to catch even more fraud"]',
    0
  );

  -- Q11 — Lesson 8.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the most important PM question for any imbalanced classification project?',
    '["Are we actually catching more of the rare important cases without creating too many costly false alarms?","What is the model accuracy on the full dataset?","How many synthetic examples did SMOTE generate?","Which neighbor count parameter was used in the SMOTE implementation?"]',
    0
  );

end $$;
