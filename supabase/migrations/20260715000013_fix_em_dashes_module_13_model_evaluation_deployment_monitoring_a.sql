-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 13: Model Evaluation, Deployment, Monitoring, and MLOps
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update modules set description = $M$Learn how to take a model from notebook to production, evaluating it properly, deploying it safely, monitoring it reliably, and retiring it responsibly.$M$ where id = 'cfbeb1c2-5acc-42ef-8fde-4949d82d4cdb';

update lessons set content = $Da298f295_90be_45bb_ad64_791f91c0e06b$Building a model is only one part of an ML product. A model can look good in a notebook and still fail in the real world.

Real-world ML systems involve: data pipelines, product integration, user behavior, business workflows, model latency, cost, monitoring, retraining, human review, edge cases, fairness, drift, and feedback loops.

**A model is not useful until it works reliably inside a real product or business process.**

As a PM, your job is not to code the model. Your job is to make sure the model solves a real problem, is evaluated properly, can be used safely, and improves a business outcome.


THE FULL ML LIFECYCLE

A practical ML project follows this lifecycle:

  1. Define the business problem
  2. Define the prediction target
  3. Collect and validate data
  4. Create features
  5. Train model
  6. Evaluate offline
  7. Compare with baseline
  8. Decide threshold or action rule
  9. Pilot or A/B test
  10. Deploy
  11. Monitor
  12. Retrain or retire

MLOps is the system around this lifecycle, the tools and practices that help teams move from one-time model building to reliable, repeatable ML operations.


THE SIMPLEST MENTAL MODEL

Think of ML like launching a product feature. You would not launch a feature just because engineering says it works locally. You would ask:

  What user problem does it solve?
  How do we measure success?
  Does it work for real users?
  What happens if it fails?
  Can we monitor it and roll it back?
  Who owns it after launch?

A model is not "done" when training is complete. It is done only when this chain is working:

**Prediction → Action → Measured impact → Monitoring loop**

[!] The most common PM mistake in ML is declaring victory when offline metrics look good. Offline performance is a prerequisite, not proof of product value. The product test is whether the model changes a real decision and improves a real outcome.

>> A model is a product feature. Apply the same launch discipline: validate, pilot, measure, monitor, and own.$Da298f295_90be_45bb_ad64_791f91c0e06b$ where id = 'a298f295-90be-45bb-ad64-791f91c0e06b';

update lessons set content = $D544da9cc_ce5a_418f_8df7_97b054423db6$OFFLINE EVALUATION

Offline evaluation happens before launch. The model is tested on historical data with known outcomes.

Common offline metrics by problem type:
  Regression: MAE, RMSE, MAPE, R², forecast bias.
  Classification: accuracy, precision, recall, F1, AUC, PR AUC, confusion matrix, calibration.
  Ranking/recommendation: NDCG, Precision@K, Recall@K, MAP, MRR.
  Generative AI: factuality, relevance, safety, human eval scores, hallucination rate.

Offline evaluation answers: "Can the model predict historical outcomes?"


ONLINE EVALUATION

Online evaluation happens after the model is used in the real product or workflow.

Examples:
  Did churn actually go down?
  Did fraud loss decrease?
  Did conversion improve?
  Did support resolution time improve?
  Did manual review workload stay manageable?

Online evaluation answers: "Does the model improve the real product or business?"

Both are needed. A model with great offline metrics can fail online, for example, a churn model where the retention offer doesn''t actually save customers, or a recommendation model where better offline ranking leads to repetitive content that reduces satisfaction.

**A good model metric does not automatically mean a good product outcome.**


BASELINE MODEL

A model should beat a reasonable baseline. The baseline is the simple comparison point, what exists today.

| Problem             | Simple baseline               |
| Demand forecast     | Last week''s demand            |
| Churn prediction    | Predict no churn for everyone |
| Fraud detection     | Existing rule-based system    |
| Recommendation      | Most popular items            |
| Ticket routing      | Current manual triage process |

PM question: "How much better is this model than the current baseline, and is the improvement worth the added cost and complexity?"


BUSINESS METRICS

| Model use case     | Business metric                          |
| Churn prediction   | Retention, saved revenue, offer ROI      |
| Fraud detection    | Fraud loss, false declines, review cost  |
| Demand forecasting | Stockouts, overstock, inventory cost     |
| Recommendation     | Conversion, engagement, satisfaction     |
| Ticket routing     | Resolution time, CSAT, cost per ticket   |
| Defect detection   | Defect escape rate, returns, complaints  |

Simple memory:
  Model metric tells if prediction is good.
  Business metric tells if the product is better.

[!] If the team cannot name a business metric that should improve because of this model, the project is not ready to move forward. No business metric = no definition of success.

>> Offline metrics prove the model works. Online and business metrics prove the product works.$D544da9cc_ce5a_418f_8df7_97b054423db6$ where id = '544da9cc-ce5a-418f-8df7-97b054423db6';

update lessons set content = $Dafd3af95_3458_4780_b08d_642d76e648f3$THE CONFUSION MATRIX AS BUSINESS LANGUAGE

For classification models, the confusion matrix translates model errors into business costs.

Example: churn prediction.

  True positive: correctly identify a churner → enables retention outreach.
  False positive: predict churn for someone who would have stayed → wastes discount/outreach.
  False negative: miss a churner → lost customer.
  True negative: correctly do nothing → no cost.

PM question: "Which error is more expensive, a false positive or a false negative?"

The threshold and success metric should follow that answer.


THRESHOLD SELECTION

Many models output a probability. Product decisions need rules.

Example: fraud scoring.
  Below 50%: approve.
  50% to 90%: manual review.
  Above 90%: block.

The default threshold of 50% is often not right. Threshold should depend on:
  False positive cost vs. false negative cost
  Manual review team capacity
  User experience
  Risk tolerance
  Business priority

For fraud: you may accept a lower threshold (flag more) when fraud loss is very high.
For blocking users: you may require a higher threshold to avoid false positives.

PM question: "How was this threshold chosen, and what business cost does it optimize?"


CALIBRATION

Calibration means the predicted probability matches real-world frequency.

Example: among users with predicted churn probability of 80%, about 80 out of 100 should actually churn.

A model can rank cases well (high AUC) but still be poorly calibrated, the scores may all be too high or too low.

Calibration matters when:
  You use probability thresholds for automated decisions
  You price risk or expected value
  You communicate probability to teams or users
  You compare risk across customer segments

PM question: "Are we using the model score for ranking only, or as a true probability? If the latter, was calibration validated?"


SEGMENT-LEVEL EVALUATION

Overall performance can hide failures.

Example: overall AUC = 0.85 looks fine, but performance may be poor for new users, specific countries, mobile users, or high-value customers.

A model that works well on average can hurt important groups or create fairness issues.

PM questions:
  How does performance vary by segment?
  Are errors concentrated in certain groups?
  Are high-value segments protected?
  Does this create fairness or trust issues?

[!] Teams often share only overall metrics. PMs should require segment-level breakdowns before approving deployment. A model that performs well on average can have unacceptable failure rates for the most important customer segment.

>> Error type matters more than error rate. Threshold and calibration are product decisions. Overall metrics hide segment problems.$Dafd3af95_3458_4780_b08d_642d76e648f3$ where id = 'afd3af95-3458-4780-b08d-642d76e648f3';

update lessons set content = $Db0b54595_e58d_4ce2_acff_014386f735d9$ERROR ANALYSIS

Error analysis means reviewing actual model mistakes, not just metrics.

Do not only look at aggregate performance numbers. Look at representative wrong examples.

For a churn model:
  Which churners did we miss? Why?
  Which non-churners did we falsely flag?

For a fraud model:
  Which fraud cases slipped through?
  Which good transactions were blocked?

For a document model:
  Which fields were extracted incorrectly?
  Which document types were confused?

Error analysis often reveals: bad labels, missing features, data leakage, segment failures, edge cases, product workflow problems, or need for human review.

PM question: "Can we review representative false positives and false negatives before launch?"


DATA LEAKAGE

Data leakage happens when a model uses information that would not be available at prediction time.

Examples:
  Predicting churn using "cancellation request submitted." (That reveals the answer.)
  Predicting fraud using "chargeback received." (That comes days later.)
  Predicting delivery delay using actual customs clearance time. (Known only after shipment.)

Leakage makes a model look excellent offline and fail completely in production.

PM question: "Would every feature be available at the exact moment the prediction is made?"

This is one of the most important PM questions in ML.


TRAIN/VALIDATION/TEST SPLIT

ML teams split data into three sets:
  Training set: used to train the model.
  Validation set: used to tune settings and choose hyperparameters.
  Test set: used for final evaluation on truly unseen data.

The test set should not be used repeatedly, teams may indirectly overfit to it through iterative decisions.

PM question: "Was the final model evaluated on truly unseen data?"


TIME-BASED VALIDATION

For many business problems, random splitting is wrong.

Example: predicting future demand. Train on January–September. Validate on October. Test on November–December.

Random mixing would allow "future" data to inform the model, leakage by another name.

Use time-based validation for: forecasting, churn prediction, fraud detection, user behavior prediction, any problem where patterns change over time.

PM question: "Does the validation setup match how the model will be used in real life?"

[!] Time-based validation is non-negotiable for any time-series or behavioral model. A random split that mixes past and future data gives a false sense of quality and will produce a model that underperforms after launch.

>> Error analysis shows why mistakes happen. Leakage checks prevent fake accuracy. Time-based validation ensures the test matches production reality.$Db0b54595_e58d_4ce2_acff_014386f735d9$ where id = 'b0b54595-e58d-4ce2-acff-014386f735d9';

update lessons set content = $D654184fa_99a7_42fb_8ee8_325f7b7b9df1$A/B TESTING FOR ML PRODUCTS

A/B testing compares two product experiences in production.

Example:
  Control group: current recommendation system.
  Treatment group: new ML recommendation system.

Measure: conversion, engagement, revenue, satisfaction, long-term retention, complaints.

A/B testing is critical because offline model improvement does not guarantee product improvement. A recommendation model may improve offline NDCG but reduce satisfaction by recommending repetitive content.

PM question: "What online experiment proves this model improves user or business outcomes?"


SHADOW MODE

Shadow mode means running a model in production without affecting users.

Example: a fraud model scores live transactions, but decisions are still made by the old system. The team compares what the new model would have done vs. what actually happened.

Use shadow mode when:
  Risk is high and you need production data without user impact
  You need to estimate operational volume (how many cases will be flagged?)
  You want to compare with current process before committing

PM question: "Can we run the model in shadow mode before full launch?"


CANARY LAUNCH / PHASED ROLLOUT

A canary launch rolls out to a small percentage first, 1% of traffic, one region, one product category, or a low-risk user group. Expand only if metrics look good.

Use phased rollout when:
  Model affects users directly
  Errors can be costly
  Operations teams need time to adapt
  You need monitoring data before scaling

PM question: "What is our safe rollout plan, and at what signal do we expand or roll back?"


DEPLOYMENT TYPES

Batch prediction: predictions generated periodically.
  Example: every night, score all customers for churn risk.
  Good for: churn campaigns, lead scoring, demand planning, inventory.

Real-time prediction: prediction happens immediately.
  Example: score a transaction for fraud during checkout.
  Good for: fraud detection, search ranking, recommendations, routing.

On-device/edge prediction: model runs on the device.
  Good for: privacy-sensitive tasks, low-latency needs, offline use, mobile.

PM question: "Does this use case need batch, real-time, or on-device prediction, and what does that imply for latency, cost, and infrastructure?"

[!] Many teams skip shadow mode and canary launch because they add time. This is a PM risk: without a shadow run, you cannot estimate operational volume or compare model behavior against production data. A fraud model that flags 10× more transactions than expected will overload the review team.

>> Shadow mode gives production insight before any user impact. Canary launch limits blast radius. Match the deployment type to the latency and cost requirements.$D654184fa_99a7_42fb_8ee8_325f7b7b9df1$ where id = '654184fa-99a7-42fb-8ee8-325f7b7b9df1';

update lessons set content = $Dbe45edb5_0139_4fd7_ad5f_85c5d608d4dd$LATENCY

Latency is how long the model takes to return a prediction.

A recommendation model may need to respond in under 100 milliseconds. A nightly churn model can take hours. Latency matters most when the model is inside the user experience.

High latency can hurt: conversion, search experience, checkout, user trust, and operational speed.

PM questions:
  What is the latency requirement?
  What is current model latency?
  What happens when the model service is slow?
  Is the accuracy gain worth the latency cost?
  Is there a fallback if latency spikes?


COST

ML systems have costs beyond training: inference, storage, feature pipelines, data labeling, human review, monitoring, retraining, engineering maintenance, and third-party APIs.

A very accurate model may not be worth it if cost per prediction is too high.

Example: if a model saves $0.02 per prediction but costs $0.05 per prediction, it does not make business sense unless there are other benefits.

PM question: "What are the unit economics of this model at our expected volume?"


FALLBACK BEHAVIOR

Every production model should have fallback behavior for when things go wrong.

What happens if:
  Model service is down?
  Feature pipeline fails?
  Input data is missing?
  Model confidence is too low?
  Latency spikes above threshold?

Fallback examples:
  Use the previous model version
  Use a rule-based system
  Use a historical average
  Send to manual review
  Ask the user for more information
  Hide the ML-powered feature temporarily
  Use a safe default

PM question: "What happens when the model cannot produce a reliable prediction?"


HUMAN-IN-THE-LOOP

Human-in-the-loop means a person reviews or approves model output before action is taken.

Use it when:
  Decision is high-stakes (legal, medical, credit, account suspension)
  Model confidence is low
  Errors are expensive
  Training data is limited
  Model is newly launched and trust is still being established
  Customer trust in automation is fragile

Human-in-the-loop can mean:
  Model drafts, human approves
  Model flags, human investigates
  Model handles low-risk cases, humans handle high-risk cases
  Human reviews all low-confidence predictions

PM question: "Which predictions can be automated, and which require human approval, and what is the threshold between them?"

[!] Fallback and human-in-the-loop are not edge cases, they are product requirements. A model without a defined fallback will create operational surprises when it fails. A high-stakes model without human review is a governance risk.

>> Latency and cost are product constraints. Fallback protects operations. Human-in-the-loop protects users.$Dbe45edb5_0139_4fd7_ad5f_85c5d608d4dd$ where id = 'be45edb5-0139-4fd7-ad5f-85c5d608d4dd';

update lessons set content = $Daa1ae49f_c6c5_4426_8c40_de4513bc3a55$WHY MONITORING MATTERS

A model that worked at launch may degrade quietly over time. Monitoring is how you catch it.

Monitor after launch:
  Model inputs and outputs
  Data quality
  Prediction distribution
  Business metrics
  Latency and cost
  Error rate
  Segment performance
  Drift
  Human override rate
  Customer complaints


DATA QUALITY MONITORING

Data quality issues can break models without obvious errors.

Examples:
  Missing values where there should be none
  A feature that always returns zero because a tracking system broke
  Out-of-range values from a pipeline bug
  Schema changes in an upstream data source
  Timezone errors causing mismatched timestamps
  Label delays creating stale ground truth

Example: "number of logins last 7 days" suddenly becomes zero for all users because tracking broke. The model may start predicting high churn risk for many users, affecting operations before anyone notices.

PM question: "What data quality checks exist before predictions are made?"


TRAINING-SERVING SKEW

Training-serving skew means the model sees different data during training and production.

Example: in training, "average spend last 30 days" is calculated one way. In production, it is calculated differently. The model performs worse because the feature it learned on does not match what it receives.

This is a common production failure that does not show up in offline evaluation.

PM question: "Are features calculated the same way in training and serving?"


DATA DRIFT

Data drift means input data changes over time, the distribution of features shifts.

Examples:
  Fraud model trained on old transaction patterns; fraudsters change behavior.
  Demand model trained before a market shift no longer matches customer behavior.
  Seasonality, product changes, competitor entry, new user demographics.

PM question: "How will we detect when production data no longer looks like training data?"


CONCEPT DRIFT

Concept drift means the relationship between inputs and outcomes changes, not just the inputs themselves.

Example: before, heavy discount usage predicted low loyalty. Later, loyal customers also heavily use discounts after a strategy change. Same feature, different meaning.

Data drift asks: "Did the inputs change?"
Concept drift asks: "Did the meaning of the inputs change?"

PM question: "Are the patterns the model learned still valid given how the business or market has changed?"


PREDICTION DRIFT

Prediction drift means the model''s output distribution changes unexpectedly.

Example: a churn model used to flag 5% of customers as high risk. Now it flags 25%. This may mean customer behavior changed, a feature pipeline broke, the user mix changed, or the model is outdated.

PM question: "Are model outputs changing in ways we did not expect?"

[!] Monitoring gaps are silent killers. A model with no monitoring may degrade for weeks before anyone notices. Define monitoring alerts and owners before launch, not after the first incident.

>> Monitor inputs, outputs, quality, drift, and business impact. Catch problems before users or operations teams report them.$Daa1ae49f_c6c5_4426_8c40_de4513bc3a55$ where id = 'aa1ae49f-c6c5-4426-8c40-de4513bc3a55';

update lessons set content = $Da1d3b03e_b5e7_4603_bf22_84e7b04cd666$RETRAINING

Retraining means updating the model using newer data.

Retraining types:
  Scheduled: retrain every week, month, or quarter on a fixed cadence.
  Triggered: retrain when performance drops below a threshold or drift exceeds a limit.
  Continuous: automated pipeline retrains frequently as new data arrives.

PM questions:
  How often should we retrain?
  What triggers retraining?
  Who approves a new model version for production?
  How do we compare the old model vs. the new model before switching?
  Can we roll back if the new version performs worse?


MODEL VERSIONING

Model versioning tracks each model version with enough metadata to understand what changed and why.

For each version, track: training data used, feature set, algorithm, evaluation metrics, approval status, deployment date, owner, known limitations, rollback plan.

PM question: "Can we trace which model version made a specific prediction, and can we roll back if needed?"


FEATURE STORE

A feature store is a system that manages ML features consistently across models and teams.

It ensures features are: defined consistently, reusable across models, available for both training and serving, versioned, monitored, and governed.

PM-level explanation: **A feature store prevents different teams from calculating the same feature in different ways.**

Example: "customer active days last 30 days" should mean exactly the same thing in the training pipeline and in the production serving system.

PM question: "Are key features standardized and reusable, or are they calculated differently in training vs. serving?"


MODEL REGISTRY

A model registry is a system for storing, tracking, reviewing, and approving trained models.

It manages: model versions, evaluation results, deployment status, approval workflows, metadata, and rollbacks.

**A model registry is like a release management system for ML models.**

PM question: "Is there an approval workflow before a model goes to production?"


CI/CD/CT IN ML

Traditional software has CI (continuous integration, auto-test code) and CD (continuous deployment, auto-ship releases). ML adds CT: continuous training, automatically retrain models when new data arrives or when performance triggers are met.

PM-level meaning: ML products need automation not just for code, but also for data, features, training, evaluation, deployment, and monitoring.

[!] Without model versioning and a registry, production ML operates without a safety net. Teams cannot roll back, cannot audit what changed, and cannot prove which model version produced a decision, a serious governance risk for any regulated use case.

>> Retraining keeps models fresh. Versioning enables rollback. Feature stores prevent skew. Model registries enforce approval. CT closes the loop.$Da1d3b03e_b5e7_4603_bf22_84e7b04cd666$ where id = 'a1d3b03e-b5e7-4603-bf22-84e7b04cd666';

update lessons set content = $Dbeb0f937_9b40_4368_b076_a3f7fdf6d381$MODEL GOVERNANCE

Model governance means the rules and accountability structure around ML systems.

It covers:
  Who approves the model before launch?
  Who owns the data it uses?
  Who monitors performance after launch?
  Who handles incidents?
  Who approves retraining?
  Who reviews fairness and segment performance?
  Who manages risk?
  Who communicates limitations to affected users?
  Who can override the model?

Governance is especially critical for high-impact decisions: credit, employment, healthcare, insurance, account suspension, safety, legal/compliance.

PM question: "Who is accountable for this model after launch, not just at launch?"


MODEL CARDS

A model card is structured documentation for a model. It includes: model purpose, intended use, out-of-scope uses, training data summary, evaluation metrics, segment performance, ethical considerations, limitations, monitoring plan, owner, and update history.

**A model card helps future teams understand what the model can and cannot do.**

PM question: "Do we have clear documentation that a new team member could use to understand this model''s scope and limitations?"


RISK LEVELS

Not all models need the same level of control.

Low-risk: recommend blog articles. Mistake impact is low. Standard monitoring is enough.

Medium-risk: prioritize sales leads. Mistake may waste time or miss revenue. Monitoring, segment evaluation, and periodic review are needed.

High-risk: fraud blocking, credit approval, medical triage, account suspension. Mistake may harm users or create legal/compliance risk. High-risk models need more: explainability, monitoring, human review, audit logs, fairness checks, rollback plan, and governance.

PM question: "What is the worst-case impact if this model is wrong, and does our control level match that risk?"


EXPLAINABILITY AFTER DEPLOYMENT

Some models need to explain individual predictions, not just work well in aggregate.

Examples where explanation is needed:
  Why was this transaction blocked?
  Why was this loan application declined?
  Why was this document rejected?
  Why was this user flagged?

Explanations help: build trust, support appeals, help operations teams debug, meet compliance requirements.

Common explanation methods:
  Feature importance: which features contributed most.
  SHAP: precise attribution of each feature''s contribution to one prediction.
  LIME: local approximation around one prediction.
  Attention/attribution: for text and image models.
  Decision path: for tree-based models.

PM question: "Who needs explanations, users, operations, regulators, and how will they use them?"


USER EXPERIENCE AROUND ML

ML output affects user experience in ways that go beyond the model itself.

PMs must design around uncertainty:
  Should we show confidence to the user?
  Should users be able to correct or appeal decisions?
  Should the model be visible or invisible?
  Should low-confidence cases go to human review?
  How do we avoid users over-trusting the model?

A model prediction is not the UX. The product flow around it matters as much as accuracy.

[!] Explainability is a business requirement for any model that makes decisions users can appeal. Design for explanation before launch, not after the first complaint.

>> Governance defines accountability. Documentation enables future maintenance. Risk level determines control requirements. Explainability protects affected users.$Dbeb0f937_9b40_4368_b076_a3f7fdf6d381$ where id = 'beb0f937-9b40-4368-b076-a3f7fdf6d381';

update lessons set content = $D65579585_0105_4061_bc95_8dfd35c1b295$FEEDBACK LOOPS

Feedback loops happen when model output changes future training data.

Example: a recommendation model shows certain products more often → those products get more clicks because they are shown more → the model learns they are popular → it shows them even more → diversity drops.

Other examples:
  Lead scoring changes which leads sales contacts → changes the quality of future sales outcome data.
  Fraud model changes fraudster behavior → old patterns are no longer representative.
  Credit model changes who gets approved → changes who appears in future repayment data.

PM question: "Does the model influence the data it later learns from? If yes, how are we monitoring for degradation and preserving exploration?"


FAIRNESS AND BIAS MONITORING

Models can perform differently across groups. Bias comes from: historical decisions, labeling, missing data, unequal representation, proxy variables.

Fairness checks include: performance by group, false positive rate by group, false negative rate by group, calibration by group, outcome disparity.

PM question: "Are some users more likely to be harmed by model errors, and are we monitoring segment performance after launch?"


SECURITY AND ABUSE

ML systems can be attacked or abused.

Examples: fraudsters adapt to detection patterns; bad actors game recommendation algorithms; prompt injection attacks AI agents; adversarial inputs fool vision systems.

PM questions: Could users game the model? Could bad actors infer decision boundaries? What is the incident response plan?


INCIDENT RESPONSE

Production ML systems need incident plans.

Examples of incidents: model flags too many users, fraud model misses a new attack, feature pipeline breaks, AI assistant gives unsafe answers, latency spikes.

Incident plan includes: alert thresholds, on-call owner, rollback process, manual override, customer support guidance, root cause analysis, post-incident model improvement.

PM question: "What is our rollback or kill-switch plan if the model misbehaves?"


FIVE DEPLOYMENT EXAMPLES

Churn model (batch nightly): monitor flagged volume, save rate, offer ROI, segment performance, feature drift. Key concern: are interventions effective?

Fraud model (real-time): monitor false declines, chargeback reduction, review queue volume, latency. Key concern: are we blocking good customers?

Demand forecasting (batch daily/weekly): monitor forecast error over time, bias by category, seasonal performance, planner adoption. Key concern: are forecasts actually being used in planning decisions?

Recommendation (real-time ranking): monitor CTR, conversion, diversity, repetition, feedback loops, cold-start. Key concern: are we optimizing clicks at the expense of long-term satisfaction?

AI assistant (real-time generation): monitor factuality reports, safety incidents, hallucination rate, escalation rate, retrieval quality, cost. Key concern: are users over-trusting the output?

[!] For each of these examples, the monitoring plan and the business metric are PM deliverables, not data science deliverables. If the PM does not define what to monitor and what success looks like, no one will own it.

>> Feedback loops, fairness, security, and incident response are post-launch PM responsibilities. Define them before launch so there is no scramble when something goes wrong.$D65579585_0105_4061_bc95_8dfd35c1b295$ where id = '65579585-0105-4061-bc95-8dfd35c1b295';

update questions set choices = $D745dc3bb_bef6_4c09_b6d1_971e1ecfb3acQ$["The model ranks churners correctly but the retention action, the offer or outreach triggered by the prediction, is not actually convincing customers to stay","The AUC threshold of 0.91 is too low; the model needs to reach 0.95 before it can improve churn","The model was not compared against a baseline before launch","The business metric chosen is wrong; churn rate is not the right outcome to measure"]$D745dc3bb_bef6_4c09_b6d1_971e1ecfb3acQ$::jsonb where id = '745dc3bb-bef6-4c09-b6d1-971e1ecfb3ac';

update questions set choices = $D6961ea75_9f5a_4310_a389_57c54cbc5e82Q$["Segment-level performance, overall accuracy hides the false positive rate for international customers, which may create unacceptable user harm and churn in that segment","Raising the overall accuracy target to 98% to reduce all error types simultaneously","Whether the threshold is set too high and needs to be lowered across all customer segments","Whether the confusion matrix is the right evaluation tool for fraud detection"]$D6961ea75_9f5a_4310_a389_57c54cbc5e82Q$::jsonb where id = '6961ea75-9f5a-4310-a389-57c54cbc5e82';

update questions set choices = $D38dbe519_7fe9_435a_82cb_6f77ffc189b3Q$["Random splitting allows future data to inform training, the model may learn from sales in December when predicting November, which is impossible in production; time-based validation is required","80/20 is an incorrect split ratio; demand forecasting requires at least 90/10","The model should use cross-validation instead of a single split for better accuracy estimates","Random splitting is only a problem if the dataset has fewer than 10,000 rows"]$D38dbe519_7fe9_435a_82cb_6f77ffc189b3Q$::jsonb where id = '38dbe519-7fe9-435a-82cb-6f77ffc189b3';

update questions set choices = $Dc67460a5_195a_4e61_85ec_6f851cc4c01bQ$["Shadow mode, run the model on live transactions without affecting decisions, compare model outputs to actual outcomes, and measure the volume of flags the review team would need to process","A/B test, split traffic and let the model make real decisions for 50% of transactions immediately","Canary launch, deploy to 1% of traffic and let the model make live decisions while monitoring","Offline evaluation, use historical data to estimate flagging volume based on test-set performance"]$Dc67460a5_195a_4e61_85ec_6f851cc4c01bQ$::jsonb where id = 'c67460a5-195a-4e61-85ec-6f851cc4c01b';

update questions set choices = $D7badc31e_4d27_48d2_8c4b_af6027c8f962Q$["Whether a smaller or cached model can meet the latency requirement at acceptable accuracy, the accuracy gain may not justify 800ms added latency if it hurts conversion more than better recommendations help it","Whether the latency is a server infrastructure problem that engineering should fix independently","Whether the model should switch from real-time to batch scoring to eliminate the latency issue","Whether users will notice 800ms of latency, since research shows users tolerate up to 2 seconds of load time"]$D7badc31e_4d27_48d2_8c4b_af6027c8f962Q$::jsonb where id = '7badc31e-4d27-48d2-8c4b-af6027c8f962';

update questions set choices = $Da866d880_945c_4fc2_80f6_0e5f772f5d73Q$["Data quality and prediction drift, a pipeline issue, schema change, or broken feature may be producing invalid input values that skew the model's output distribution","Whether the model needs to be retrained with more recent data to adjust to higher actual churn rates","Whether the threshold should be raised to bring flagging back to the expected 5% rate","Whether the business has actually experienced a surge in churn risk that the model is correctly detecting"]$Da866d880_945c_4fc2_80f6_0e5f772f5d73Q$::jsonb where id = 'a866d880-945c-4fc2-80f6-0e5f772f5d73';

update questions set choices = $Dcca12ba0_b6a9_44c1_9bce_ecc0affbb66fQ$["A feature store, it standardizes feature definitions so the same feature is calculated consistently across models and matches between training and production serving","A model registry, it tracks model versions and ensures consistent deployment practices","A data warehouse, it centralizes raw data so both teams pull from the same source tables","A CI/CD pipeline, it automatically tests feature definitions before they are used in training"]$Dcca12ba0_b6a9_44c1_9bce_ecc0affbb66fQ$::jsonb where id = 'cca12ba0-b6a9-44c1-9bce-ecc0affbb66f';

update questions set choices = $Da0319470_4ce6_420a_9770_b1ac5611f890Q$["Explainability and an appeals process, high-risk automated decisions that affect users must provide explanations and an appeal path, both for user fairness and for regulatory compliance in many jurisdictions","A model card, written documentation about the model's training data would resolve the transparency issue","A feature store, consistent feature definitions would make the model more accurate and reduce unjust suspensions","Continuous training, more frequent retraining would reduce the false positive rate causing unjust suspensions"]$Da0319470_4ce6_420a_9770_b1ac5611f890Q$::jsonb where id = 'a0319470-4ce6-420a-9770-b1ac5611f890';

update questions set choices = $D1463c241_a046_47ae_9a72_90c999433316Q$["A feedback loop, the model shows popular content more, those items get more watch time, the model learns they are more engaging, and recommends them even more, progressively reducing diversity","The model is overfitting to training data and needs to be retrained on more recent viewing data","The watch-time metric is being measured incorrectly and should be replaced with session length","The model architecture needs to be upgraded to a transformer to handle user preference sequences better"]$D1463c241_a046_47ae_9a72_90c999433316Q$::jsonb where id = '1463c241-a046-47ae-9a72-90c999433316';

update questions set choices = $De1fa368f_0cb8_40e4_9e5a_2430acbaebedQ$["What exact decision will the model improve, and what action happens after each prediction, if no action is defined, the prediction has no business impact regardless of its accuracy","Is there monitoring for data quality and model drift after launch?","Is the model calibrated if probabilities are used for threshold decisions?","What is the rollout plan, shadow mode, canary launch, or A/B test?"]$De1fa368f_0cb8_40e4_9e5a_2430acbaebedQ$::jsonb where id = 'e1fa368f-0cb8-40e4-9e5a-2430acbaebed';
