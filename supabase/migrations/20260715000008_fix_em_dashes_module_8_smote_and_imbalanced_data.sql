-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 8: SMOTE and Imbalanced Data
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update lessons set content = $D15a8a8fe_2e5b_4278_8b68_5543795d2d8c$When the positive class is rare, there are several strategies to help the model learn it better. SMOTE is one of them, not the only one.

Here is the full menu.


1. USE BETTER METRICS

The simplest fix. Stop using accuracy; start using precision, recall, F1, PR AUC, and business cost.

This does not change the model, it changes how you evaluate it.


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

[!] Start with class weights and threshold tuning before SMOTE. They are simpler, more interpretable, and often achieve similar results. SMOTE adds complexity, justify it.

PM question: "Why was SMOTE chosen over class weights or threshold tuning? What did we compare?"$D15a8a8fe_2e5b_4278_8b68_5543795d2d8c$ where id = '15a8a8fe-2e5b-4278-8b68-5543795d2d8c';

update lessons set content = $D2d2f5979_8207_4e0a_885c_3037193c72de$THE CONFUSION MATRIX

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

The right balance depends on business cost. PM question: "Which mistake is more expensive, false positive or false negative?"

[!] Never evaluate an imbalanced classification model using accuracy alone. Always review the confusion matrix and ask for precision and recall on the minority (positive) class.

>> Precision protects your team from false alarms. Recall protects you from missed cases. Knowing which matters more drives every threshold decision.$D2d2f5979_8207_4e0a_885c_3037193c72de$ where id = '2d2f5979-8207-4e0a-885c-3037193c72de';

update lessons set content = $D9feec40b_5c21_4b61_902d_00210e2c9205$F1 SCORE

F1 score combines precision and recall into one number.

It is high only when both precision and recall are reasonably good.

Example:
  Model A: precision 90%, recall 20%, careful but misses most cases.
  Model B: precision 70%, recall 70%, more balanced, likely better F1.

F1 is useful for summary comparison, but it is still a technical metric. Business cost of errors matters more.


PRECISION-RECALL CURVE

A precision-recall (PR) curve shows the trade-off between precision and recall at every possible threshold.

It is especially useful when the positive class is rare, because it focuses entirely on the minority class, unlike the ROC curve, which can look optimistic on imbalanced data.

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

[!] PR AUC is the right first metric for most imbalanced problems. Always follow it with the business metric, how much did fraud loss, churn, or defect cost actually change?

>> Technical metrics tell you the model works. Business metrics tell you it matters.$D9feec40b_5c21_4b61_902d_00210e2c9205$ where id = '9feec40b-5c21-4b61-902d-00210e2c9205';

update lessons set content = $D5696a510_208f_4e8e_8fac_bfe9ec782ec3$WHAT IS SMOTE?

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

This new case was not copied from the data, it was created between two similar real fraud cases. This helps the model learn the general "fraud region" rather than memorizing specific fraud examples.


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

SMOTE can help the model learn from rare examples, it cannot replace good data.

[!] SMOTE is a data augmentation technique, not a data collection replacement. The quality of synthetic examples depends entirely on the quality of the real minority-class examples they are based on.

>> SMOTE draws a line between two real rare examples and puts a new fake example somewhere on that line. Simple idea, powerful effect, when the underlying data is clean.$D5696a510_208f_4e8e_8fac_bfe9ec782ec3$ where id = '5696a510-208f-4e8e-8fac-bfe9ec782ec3';

update lessons set content = $De20880fa_ab7e_4bb2_bb6a_b43cce2db81b$WHEN SHOULD YOU USE SMOTE?

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

The problem: synthetic examples are created from real examples. If synthetic examples land in the test set, they contain information derived from the training data, this is data leakage. Test performance will look better than it really is.

Correct process:
  1. Split data into train and test. Keep the test set untouched.
  2. Apply SMOTE only to the training data.
  3. Train the model on the augmented training data.
  4. Evaluate on the original, untouched test set.

PM question: "Was SMOTE applied only to the training data, after the train/test split?"

This is one of the most important data quality questions for any SMOTE project.


THE TEST SET SHOULD REFLECT THE REAL WORLD

The test data should match real-world class distribution.

If real-world fraud rate is 1%, the test data should reflect 1% fraud, not an artificially balanced 50/50 split.

Why? Because you need to know how the model will actually perform in production.

Metrics from an artificially balanced test set overestimate real-world performance.

PM question: "Does the test set match the real-world class distribution?"

[!] These two rules, SMOTE only on training data, test set matches real world, are non-negotiable. Violating either means the evaluation cannot be trusted, and a bad model may be shipped with confidence.

>> A great SMOTE implementation with a contaminated test set is worse than no SMOTE at all, it looks trustworthy but is not.$De20880fa_ab7e_4bb2_bb6a_b43cce2db81b$ where id = 'e20880fa-ab7e-4bb2-bb6a-b43cce2db81b';

update lessons set content = $Db3593b1f_5475_47eb_829b_e5eca4ad58e9$SMOTE AND PROBABILITY CALIBRATION

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
  SMOTE-NC, handles datasets with both numeric and categorical features.
  SMOTE-N, for purely nominal/categorical data.
  ADASYN, adaptive synthetic sampling, focuses on harder-to-learn examples.

PM question: "Do we have categorical features? Are we using the right SMOTE variant?"


SMOTE WITH HIGH-DIMENSIONAL DATA

SMOTE relies on finding "similar" minority-class examples using nearest-neighbor search.

In high-dimensional spaces (many features, text embeddings, sparse one-hot encoding), nearest neighbors may become less meaningful. Points that look numerically close may not actually be similar in the business sense.

This is the curse of dimensionality.

PM question: "Are nearest neighbors meaningful in this feature space? Does the team have evidence the synthetic examples are realistic?"


SMOTE AND NOISY LABELS

If minority-class labels are unreliable (e.g., transactions mislabeled as fraud, or inconsistent labeling across time), SMOTE may generate more synthetic examples around the bad labels, amplifying the noise.

PM question: "How reliable are the minority-class labels? What is the estimated label error rate?"

Label quality is especially important for rare events where even a few mislabeled examples have an outsized effect.


SMOTE CAN BLUR CLASS BOUNDARIES

Sometimes minority-class examples sit close to the majority boundary. SMOTE may create synthetic points near or across that boundary, generating examples that look like the majority class and confusing the model.

This can increase false positives.

PM question: "Did SMOTE improve recall at the cost of an unacceptable increase in false positives?"

[!] SMOTE is not a single button to press. It requires careful decisions about calibration, data types, feature space dimensionality, and label quality. Treat each of these as a risk to check.

>> Each complication is a PM question. Ask all of them before signing off on a SMOTE-based model.$Db3593b1f_5475_47eb_829b_e5eca4ad58e9$ where id = 'b3593b1f-5475-47eb-829b-e5eca4ad58e9';

update lessons set content = $D7689e641_6938_4d1b_ad39_56abf4e9d7cc$EXAMPLE 1: FRAUD DETECTION

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
  Defect labels must be reliable, mislabeled examples cause SMOTE to amplify noise.

Technical metrics: defect recall, precision, PR AUC, false negative rate, confusion matrix.

Business metrics: defects caught, customer complaints reduced, warranty cost reduction, rework cost, inspection workload, customer satisfaction.

Key PM questions:
  Is missing a defect more costly than unnecessary inspection?
  What false positive rate can the operations team handle?
  Are defect labels reliable? Were they collected consistently?
  Does the model catch the most severe defect types specifically?
  Is there a segment of products where defect detection is especially critical?

[!] In safety-critical defect detection (food, medical devices, vehicles), recall is paramount. A 5% miss rate on defects may be unacceptable regardless of overall model accuracy.

>> Both examples share the same PM structure: identify the rare event → cost the two types of mistakes → choose the metric and threshold that optimizes the trade-off.$D7689e641_6938_4d1b_ad39_56abf4e9d7cc$ where id = '7689e641-6938-4d1b-ad39-56abf4e9d7cc';

update lessons set content = $D14d4bc54_427f_40b0_a88e_a478422c335f$EXAMPLE 3: CHURN PREDICTION

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
  Does the intervention actually reduce churn, or just flag users who would have stayed anyway?


EXAMPLE 4: LOAN DEFAULT PREDICTION

Business problem: predict whether a borrower may default.

Data: most borrowers repay; defaults are relatively rare but expensive.

Key considerations:
  Defaults are rare but high-cost false negatives.
  False positives (rejecting a creditworthy applicant) also have real costs, lost revenue and potential fairness concerns.
  Probabilities may drive pricing decisions, so calibration is critical.
  Fairness and regulatory compliance requirements apply.

Technical metrics: AUC, PR AUC, recall, precision, calibration, segment-level performance.

Business metrics: default loss reduction, approval quality, profitability, fairness metrics, regulatory compliance.

Key PM questions:
  Are predicted probabilities calibrated, is a 70% default probability accurate?
  Are protected attributes handled correctly? Does the model perform fairly across demographic groups?
  What is the business cost of a false approval vs. a false rejection?
  Is there human review for high-impact decisions?
  Has the model been audited for disparate impact?

[!] Loan default models require extra rigor on fairness and calibration. A model that achieves high recall by over-flagging certain demographic groups may be accurate but legally and ethically unacceptable.

>> All four examples, fraud, defects, churn, loans, are imbalanced. The PM framework is the same: rare class, two types of costly mistakes, choose metrics that match the cost structure.$D14d4bc54_427f_40b0_a88e_a478422c335f$ where id = '14d4bc54-427f-40b0-a88e-a478422c335f';

update lessons set content = $D20c1532c_844b_4ba3_8dd3_c39c08753cfd$WHAT CAN GO WRONG

1. High accuracy hides failure
   The model looks good but misses rare cases.
   PM question: "What is recall for the minority class?"

2. SMOTE applied before the train/test split
   Synthetic examples contaminate the test set, data leakage.
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
   Basic SMOTE interpolates numerics, meaningless for categorical features.
   PM question: "Are we using the right imbalance technique for this data?"

8. No action follows the prediction
   The model flags rare cases, but no team is set up to act on them.
   PM question: "What happens after a case is flagged?"

9. Fairness issues across groups
   The model may detect the positive class at different rates across demographic segments.
   PM question: "Does minority-class detection work fairly across important user groups?"

10. Simpler alternatives were not compared
    SMOTE adds complexity, class weights or threshold tuning may achieve the same result.
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
  "In this problem, the event we care about is rare. That means normal accuracy is misleading, a model can look accurate by mostly predicting the common class. We evaluated the model using precision, recall, and business cost. To help the model learn the rare class better, we tested imbalance-handling methods including SMOTE, which creates synthetic examples of the rare class in training data. We evaluated performance on original, real-world test data."

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
  **Are we actually catching more of the rare important cases without creating too many costly false alarms?**$D20c1532c_844b_4ba3_8dd3_c39c08753cfd$ where id = '20c1532c-844b-4ba3-8dd3-c39c08753cfd';

update questions set choices = $D07e11b98_2535_4a79_a313_151d9ff730dcQ$["Fraud is 1% of transactions, a model predicting not-fraud every time also achieves 99% accuracy while catching zero fraud cases","99% accuracy is the theoretical maximum and confirms the model is working correctly","Fraud detection requires regression, not classification, so accuracy is the wrong algorithm","The model needs more training data to reach 99.5% accuracy before it can be deployed"]$D07e11b98_2535_4a79_a313_151d9ff730dcQ$::jsonb where id = '07e11b98-2535-4a79-a313-151d9ff730dc';

update questions set choices = $D89419d97_587a_4fe8_80b7_2186aec4c443Q$["PR AUC focuses on the positive class performance across thresholds, ROC AUC can look optimistic when the negative class dominates","ROC AUC requires balanced data to compute correctly","PR AUC is always higher than ROC AUC, making it easier to use in reports","PR AUC measures calibration; ROC AUC measures ranking"]$D89419d97_587a_4fe8_80b7_2186aec4c443Q$::jsonb where id = '89419d97-587a-4fe8-80b7-2186aec4c443';

update questions set choices = $D957d7574_c30a_40fe_9173_a569adb931aeQ$["Class weights and threshold tuning, they are simpler, more interpretable, and often achieve similar results without adding SMOTE complexity","Random undersampling and feature engineering, these always outperform SMOTE","Neural networks and gradient boosting, imbalance requires more powerful models","Collect 10x more data and retrain, data volume always solves imbalance"]$D957d7574_c30a_40fe_9173_a569adb931aeQ$::jsonb where id = '957d7574-c30a-40fe-9173-a569adb931ae';

update questions set choices = $D4101091e_1a57_4a77_9dd4_a494738e1903Q$["Data leakage, synthetic examples derived from real data may appear in the test set, making test performance look better than production reality","The test set will have too few positive examples to evaluate recall","SMOTE changes the feature distributions in a way that breaks the train/test split","The model will underfit because SMOTE reduces the effective training size"]$D4101091e_1a57_4a77_9dd4_a494738e1903Q$::jsonb where id = '4101091e-1a57-4a77-9dd4-a494738e1903';

update questions set choices = $Dd568f05c_5bec_4c3d_956b_089de16dece1Q$["The model may have low precision and insufficient lift, it catches churners but also flags many non-churners, wasting offer budget on people who would stay without intervention","The model needs to be retrained with SMOTE to improve recall further","The retention offer is the wrong action, the model prediction is still correct","Churn models should never be used to trigger offers because of this inherent problem"]$Dd568f05c_5bec_4c3d_956b_089de16dece1Q$::jsonb where id = 'd568f05c-5bec-4c3d-956b-089de16dece1';

update questions set choices = $D86050f95_1a47_4979_98a4_de7d678b19b8Q$["Raise the threshold to reduce flagged volume to a level the team can handle, a model that generates unprocessable volume has no operational value","Deploy the model anyway since PR AUC is the most important metric","Hire more reviewers to match the model output volume","Lower the threshold further to catch even more fraud"]$D86050f95_1a47_4979_98a4_de7d678b19b8Q$::jsonb where id = '86050f95-1a47-4979-98a4-de7d678b19b8';
