-- ML for Everyone — Module 15: Experimentation, Causal Thinking, and When ML Is Not Enough
-- 11 lessons covering experimentation from a PM perspective

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
    'Module 15: Experimentation, Causal Thinking, and When ML Is Not Enough',
    'Learn how to prove that a product action caused an outcome — not just that a model predicted it.',
    15
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.1 — Prediction vs. Causation and Why PMs Need Causal Thinking
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Prediction vs. Causation and Why PMs Need Causal Thinking',
    1,
    $M15L1$Machine learning can predict what is likely to happen. But prediction is not the same as proof.

A model may predict: "This customer is likely to churn." But that does not mean: "This discount will save the customer."

A model may predict: "This user is likely to click this recommendation." But that does not mean: "Showing this recommendation improves long-term satisfaction."

**ML helps predict. Experimentation helps prove impact.**


THE SIMPLEST MENTAL MODEL

Imagine a doctor. A prediction model says: "This patient has a high risk of illness." That is useful. But the doctor still needs to know: "Which treatment actually improves the patient''s health?"

Prediction identifies risk. Experimentation tests treatment.

Same in product: ML may say "this customer is high churn risk," but experimentation answers "does our retention action reduce churn for this type of customer?"


PREDICTION VS. CAUSATION

Prediction answers: what is likely to happen?
Causation answers: what caused something to happen?

Example: a model finds that customers who use discounts churn less.

Prediction interpretation: discount usage is associated with lower churn.
Causal interpretation may be wrong: maybe loyal customers receive more discounts; maybe active customers see more promotions. Discounts may not be the cause of lower churn. To prove discounts reduce churn, we need an experiment.


CORRELATION VS. CAUSATION

Correlation means two things move together. Causation means one thing causes the other.

Classic example: ice cream sales and swimming accidents both increase in summer. They are correlated. But ice cream does not cause accidents — the real cause is hot weather and more people swimming.

Product example: users who complete onboarding may have higher retention. But this could mean motivated users are more likely to complete onboarding and more likely to stay anyway. Correlation is useful for prediction. Causation is needed for confident decision-making.


WHY PMS MUST UNDERSTAND CAUSAL THINKING

PMs make action decisions: should we launch this feature? Send this notification? Offer this discount? Change this ranking? These are action questions that require causal thinking. You need to know: **if we do X, will Y improve?** That is different from: **can we predict Y?**

[!] The most common PM mistake after seeing a model is saying "the model predicts churn well, so our retention program will work." Not necessarily. The model identifies risk. The retention program must be tested separately. These are different questions.

>> ML predicts outcomes. Experiments prove that actions cause those outcomes. You need both.$M15L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.2 — A/B Tests: Control, Treatment, Randomization, and Before-After Pitfalls
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'A/B Tests: Control, Treatment, Randomization, and Before-After Pitfalls',
    2,
    $M15L2$WHAT IS AN A/B TEST?

An A/B test compares two versions of an experience.

Version A: the current experience (control).
Version B: the new experience (treatment).

Example: old onboarding vs. new onboarding. Measure which version improves activation, retention, or satisfaction.

A/B tests help PMs avoid launching based on opinion. Instead of "I think this design is better," you can say "we tested it and it improved activation by 6% without hurting retention."

The model output is usually just a signal. "Churn risk = 80%" does not answer: which offer, what message, which channel, at what time, for which segment, and will it actually reduce churn? The model predicts who may need action. Experimentation proves which action works.


CONTROL AND TREATMENT GROUPS

Control group: users who get the current experience — the comparison baseline.
Treatment group: users who get the new experience — the change being tested.

Example:
  Control: no retention offer.
  Treatment: retention offer sent to high-risk customers.

If churn is lower in treatment after random assignment, the offer may have caused the reduction.


RANDOMIZATION

Randomization means users are assigned to control or treatment by chance. This makes the groups similar before the experiment starts. When groups are similar before the test, differences after are more likely caused by the treatment.

**Randomization creates a fair comparison.**

Without randomization, comparison can be biased. Example: giving discounts only to angry customers and comparing them to normal customers — any outcome difference may be due to customer type, not the discount.


WHY BEFORE-AFTER COMPARISONS CAN MISLEAD

Before launch: conversion = 10%. After launch: conversion = 12%. Conclusion: feature improved conversion.

But conversion may have improved because: seasonality changed, a marketing campaign launched, a competitor had an outage, pricing changed, or traffic quality shifted. Without a control group, you cannot attribute the change to the feature.

**A/B testing separates product impact from outside changes.**

[!] Before-after comparisons are tempting because they are easy to run. But they are unreliable because the world does not hold still during the test. Teams often declare victory on before-after improvements that later reverse — or were never real.

>> A/B tests create a fair comparison through randomization. Before-after comparisons confound the feature change with everything else that changed at the same time.$M15L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.3 — Primary Metrics, Secondary Metrics, Guardrail Metrics, Leading vs. Lagging
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Primary Metrics, Secondary Metrics, Guardrail Metrics, Leading vs. Lagging',
    3,
    $M15L3$PRIMARY METRIC

The primary metric is the main metric used to decide success. It must be chosen before the experiment starts — not after looking at results.

Examples:
  Checkout redesign → purchase conversion rate.
  Onboarding improvement → activation rate.
  Recommendation change → long-term engagement or conversion.
  Support automation → resolution time or customer satisfaction.

PM question: "What is the one main metric that decides whether this test wins?"


SECONDARY METRICS

Secondary metrics provide additional understanding about why the primary metric moved.

Example for checkout redesign:
  Primary metric: purchase conversion.
  Secondary metrics: cart abandonment, time to checkout, payment failure, average order value, customer support contacts.

Secondary metrics help explain the mechanism — but the primary metric still drives the launch decision.


GUARDRAIL METRICS

Guardrail metrics make sure the experiment does not harm other important outcomes.

Example: a recommendation model increases clicks, but guardrails show user complaints increased, hide/report rate went up, diversity dropped, and long-term retention decreased. This may not be a good launch despite the click improvement.

Common guardrails: latency, error rate, customer complaints, refunds, return rate, churn, unsubscribe rate, support contacts, fairness metrics, safety incidents, cost.

**Primary metric tells us if we won. Guardrails tell us if the win is safe.**


LEADING VS. LAGGING METRICS

Leading metrics: move quickly and predict future success.
  Examples: click-through rate, signup completion, activation, add-to-cart, trial start, feature usage.

Lagging metrics: take longer but are closer to business value.
  Examples: revenue, retention, customer lifetime value, churn, profit, renewal, long-term satisfaction.

A common mistake is optimizing only leading metrics. Example: a notification increases clicks today but increases unsubscribes next month.

PM question: "Are we measuring the short-term metric and its long-term consequence?"

[!] Teams often pick easy-to-measure leading metrics as the primary metric because lagging metrics take too long. This is a PM risk: winning on CTR or activation while losing on retention or revenue is not a real win. Define the lagging metric you ultimately care about, then use leading metrics as proxies — but verify the proxy is valid.

>> Primary metric drives the decision. Secondary metrics explain it. Guardrails prevent harm. Leading metrics predict quickly. Lagging metrics confirm real value.$M15L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.4 — Statistical Significance, Practical Significance, Sample Size, and P-Values
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Statistical Significance, Practical Significance, Sample Size, and P-Values',
    4,
    $M15L4$STATISTICAL SIGNIFICANCE

Statistical significance asks: is the observed difference likely real, or could it be random noise?

Example: Control conversion = 10.0%, Treatment = 10.1%. This tiny difference may be noise. But Control = 10.0%, Treatment = 12.0% — with enough users, this may be a real effect.

**Statistical significance helps avoid overreacting to random fluctuation.**

P-value: helps estimate whether the result could happen by random chance if there were actually no real effect. A low p-value suggests the result is less likely to be noise. But p-value does not tell you whether the effect is big enough, whether the metric is right, or whether to launch. P-value is one input, not the whole decision.


PRACTICAL SIGNIFICANCE

A result can be statistically significant but too small to matter.

Example: treatment improves conversion by 0.01%. If the business impact is negligible, it may not justify engineering cost and maintenance.

**Practical significance asks: is the improvement big enough to matter?**

PM question: "Even if this is statistically significant, is it worth launching?"


MINIMUM DETECTABLE EFFECT (MDE)

MDE is the smallest effect your experiment is designed to detect.

Example: you want to detect at least a 2% lift in conversion. If your experiment has too few users, it may not reliably detect small changes.

**MDE helps decide how large the experiment needs to be.**

Questions: what lift do we care about? How many users do we need? How long should the test run?


SAMPLE SIZE AND POWER

Small sample size produces noisy results — one extra purchase can flip the outcome.
Large sample size gives more reliable results — but takes more time and traffic.

Power: the experiment''s ability to detect a real effect if one exists.

Low power: there may be a real improvement, but the test fails to detect it. This means a negative result is inconclusive, not proof of no effect.

High power: if the effect exists, the test is likely to find it.

**Power is about not missing a real effect due to insufficient traffic.**


CONFIDENCE INTERVAL

A confidence interval gives a range of likely effect sizes.

Example: Estimated lift = 5%, Confidence interval = 2% to 8%. The true effect may reasonably be in that range.

Example: Estimated lift = 5%, Confidence interval = -1% to 11%. This is less clear because the range includes possible harm.

**Do not only ask "did it win?" Ask "how big could the real effect reasonably be?"**

[!] Teams sometimes launch on a statistically significant result that is practically tiny. A 0.1% conversion improvement may be statistically real but take years to recover the engineering investment. Always ask both questions: is it real, and does it matter?

>> Statistical significance checks if the result is real. Practical significance checks if it matters. MDE and sample size determine whether you can detect what you care about.$M15L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.5 — Peeking, Multiple Testing, Sample Ratio Mismatch, Novelty, and Learning Effects
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Peeking, Multiple Testing, Sample Ratio Mismatch, Novelty, and Learning Effects',
    5,
    $M15L5$THE PEEKING PROBLEM

Peeking means checking experiment results repeatedly and stopping as soon as results look good. This creates false winners.

Example: Day 1 — treatment looks bad. Day 2 — neutral. Day 3 — treatment looks great. Team stops and declares victory. But Day 3 may have been random noise.

PM question: "Did we decide the test duration and stopping rule before the test started?"


THE MULTIPLE TESTING PROBLEM

If you test many metrics, one may look significant by chance.

Example: you check 50 metrics. Even if the feature has no real effect, one or two metrics may show a random significant change simply due to chance.

This is why primary metrics must be defined before the experiment starts — not selected from among all observed results afterward.

PM question: "Are we over-interpreting one positive metric out of many?"


SAMPLE RATIO MISMATCH

Sample ratio mismatch means the actual traffic split differs from the planned split.

Example: planned 50/50, actual 70/30. This may indicate a bug in assignment, logging, eligibility filtering, or experiment configuration.

PM question: "Did the actual experiment split match the design? If not, the result may be invalid."


NOVELTY EFFECT

Novelty effect happens when users react positively just because something is new.

Example: a redesigned homepage gets more clicks in the first week because users are curious. Two weeks later, behavior returns to normal.

PM question: "Did we run the experiment long enough to rule out novelty bias?"


LEARNING EFFECT

Learning effect is the opposite: users need time to adapt before they can benefit.

Example: a new dashboard may reduce productivity initially because users are learning it. After a few weeks, productivity improves. Stopping too early may cause you to wrongly reject a genuinely good feature.

PM question: "Does this change require users to learn a new behavior before benefits appear?"

[!] Peeking is extremely common and extremely damaging. If teams check results daily and can stop early, they will find false winners more often than real ones. This is not a hypothetical risk — it is a well-documented problem in industry experimentation platforms. Define the stopping rule before the test starts.

>> Peeking creates false winners. Multiple testing creates false positives. Sample ratio mismatch invalidates results. Novelty inflates early results. Learning effects suppress early results. All five are PM responsibilities to check.$M15L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.6 — Network Effects, Unit of Randomization, A/A Tests, Feature Flags, Phased Rollout
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Network Effects, Unit of Randomization, A/A Tests, Feature Flags, Phased Rollout',
    6,
    $M15L6$NETWORK EFFECTS AND INTERFERENCE

Some experiments are hard because users affect each other.

Examples:
  In a marketplace, changing seller ranking affects both buyer and seller behavior.
  In a social app, one user''s experience affects another user''s behavior.
  In messaging, treatment users interact with control users.

This is called interference. Standard A/B tests assume one user''s treatment does not affect another user''s outcome. When that assumption breaks, experiment results are unreliable.

PM question: "Can one user''s treatment affect another user''s experience?"


UNIT OF RANDOMIZATION

The unit of randomization is what gets assigned to control or treatment.

Examples: user-level, session-level, account-level, household-level, store-level, region-level, company-level.

Choosing the wrong unit creates contamination. Example: if a company account has many users and some get treatment while others do not, their behavior may influence each other, violating the independence assumption.

For B2B products, account-level randomization is often better than user-level.

PM question: "What is the right unit to randomize for this experiment?"


A/A TESTS

An A/A test compares two identical experiences — both control. Why? To check whether the experimentation system is working correctly.

If an A/A test shows a large difference, something is wrong: bad randomization, logging errors, sample ratio mismatch, or metric calculation bugs.

**A/A tests test the testing system itself.**


FEATURE FLAGS

Feature flags allow teams to turn features on or off for specific users or groups. They enable A/B testing, gradual rollouts, quick rollbacks, targeted releases, and internal testing.

PM question: "Can we turn this feature off quickly if something goes wrong?"

Feature flags are especially important for ML-driven features because model behavior can be unpredictable at scale.


PHASED ROLLOUT

A phased rollout launches gradually: internal users → 1% → 5% → 25% → 50% → 100%.

Useful when: the feature is risky, an ML model may behave unpredictably, operational teams need time, infrastructure load is uncertain, or customer impact could be high.

PM question: "What is the safest rollout plan, and what signal triggers moving to the next phase?"

[!] Network effects are often overlooked until experiment results are puzzling. When treatment and control users interact — in marketplaces, social platforms, shared tools — standard A/B tests give biased results. Cluster randomization (by store, region, company) is one solution, but requires larger sample sizes. Know the risk before choosing the unit.

>> Network effects break A/B test assumptions. Unit choice prevents contamination. A/A tests validate the system. Feature flags enable safe rollback. Phased rollout limits blast radius.$M15L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.7 — Uplift Modeling, Four Customer Types, and Causal Inference Methods
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Uplift Modeling, Four Customer Types, and Causal Inference Methods',
    7,
    $M15L7$ML AND EXPERIMENTATION ANSWER DIFFERENT QUESTIONS

| Question                                              | Best tool          |
| Who is likely to churn?                               | ML                 |
| Does this offer reduce churn?                         | Experiment         |
| Which transaction is risky?                           | ML                 |
| Does blocking this threshold reduce fraud?            | Experiment         |
| Which recommendation is likely to be clicked?         | ML                 |
| Does this ranking improve satisfaction?               | Experiment         |
| What demand is likely next week?                      | Forecasting model  |
| Does using this forecast reduce stockouts?            | Business eval      |

**ML predicts the target. Experiments prove the action works.**


UPLIFT MODELING

Uplift modeling predicts who will change behavior because of an intervention — not just who is at high risk.

Churn prediction asks: who is likely to churn?
Uplift modeling asks: who is likely to stay because we send this offer?

This distinction is critical. A high-risk customer may not be saveable. A medium-risk customer may respond well to outreach.

**Uplift modeling predicts treatment impact, not just outcome risk.**


FOUR CUSTOMER TYPES IN UPLIFT THINKING

For a retention campaign:

1. Sure things: they would stay without the offer. Giving them an offer wastes money.
2. Lost causes: they will churn even with the offer. The offer does not help.
3. Persuadables: they will stay only if they receive the offer. The best targets.
4. Do-not-disturbs: the offer may make them more likely to churn or reduce trust.

PM goal: target persuadables, not just high-risk customers.

Why churn risk alone is not enough: a customer with 95% churn risk may be impossible to save. A customer with 40% churn risk may be very responsive to a helpful intervention. Targeting by risk alone wastes effort on lost causes.


CAUSAL INFERENCE METHODS

Sometimes you cannot run a clean A/B test due to ethical, legal, operational, or sample-size constraints. Causal inference methods estimate impact from observational data.

Difference-in-differences: compare changes over time between a treated group and a comparison group — useful when a feature launched in one region first.

Matching: compare similar treated and untreated users matched on observed characteristics like tenure, usage, and spend. Controls for observable differences but not hidden ones.

Regression discontinuity: useful when treatment is assigned by a cutoff — compare users just above and just below the threshold to estimate treatment impact.

Synthetic control: create a comparison group by combining other similar groups — useful for market-level launches where randomization is impossible.

PM question: "If we cannot run a clean experiment, what is the most credible alternative method for estimating causal impact?"

[!] Uplift modeling is one of the most powerful and underused tools for PM decision-making. Instead of sending retention offers to the 1,000 highest-risk customers, send them to the 1,000 most persuadable customers. The business impact can be dramatically different even with the same budget.

>> Uplift models find who responds to treatment. Causal inference handles cases where experiments are impossible. Counterfactual thinking is the foundation of both.$M15L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.8 — Bandits, Personalization Experiments, and When ML Is Not Enough
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Bandits, Personalization Experiments, and When ML Is Not Enough',
    8,
    $M15L8$MULTI-ARMED BANDITS

In a normal A/B test, traffic is split evenly until the test ends. In a bandit, the system gradually sends more traffic to better-performing options while still exploring.

Use bandits when:
  There are many options to compare simultaneously
  You want to reduce regret (exposure to worse options during the test)
  User response is quick to observe
  The environment changes over time

Examples: choosing notification copy, ranking content modules, selecting offers, optimizing ads, testing recommendation variants.

PM warning: bandits are useful, but they make measurement and interpretation harder than standard A/B tests. When results are needed for a clear go/no-go decision, a standard A/B test is usually better.


PERSONALIZATION EXPERIMENTS

Testing personalized experiences is harder than testing one static feature. The treatment is not one version — it is an algorithm that gives different users different experiences.

Questions to answer:
  Is personalization better than a generic experience on average?
  Which user segments benefit, and which are harmed?
  Does it improve long-term outcomes, or just short-term engagement?
  Does it create filter bubbles or reduce content diversity?
  Does it increase cost or latency?

PM question: "Are we testing the algorithm''s total product impact, not just model accuracy?"


SHADOW TESTING VS. A/B TESTING

Shadow testing: model runs in the background but does not affect users. Good for measuring prediction volume, checking latency, comparing decisions, estimating operational load, and debugging. Cannot prove user impact because users never experience the model.

A/B testing: model affects treatment users. Measures causal product impact and compares business outcomes.

**Shadow mode checks readiness. A/B test checks impact.**


WHEN ML IS NOT ENOUGH

ML is not enough when the core question is causal.

Examples:
  ML predicts who may churn → cannot alone prove which offer saves them.
  ML predicts likely clicks → cannot alone prove the recommendation improves satisfaction.
  ML predicts demand → cannot alone prove that planners using the forecast reduce stockouts.
  ML scores lead quality → cannot alone prove sales productivity improves.

You always need product/process/workflow validation alongside model validation.


WHEN ML MAY NOT BE NEEDED

Sometimes ML is overkill. Use simpler approaches when:
  A rule solves the problem well
  Data is limited
  Explanation matters more than accuracy
  The problem is actually UX, not prediction
  The root cause is pricing, staffing, or process — not signal quality

Examples: if users cannot find a button, fix the UX. If support tickets are delayed because staffing is low, prediction may not solve the root cause. If churn is driven by pricing, a churn model will not fix it.

PM question: "Is this really an ML problem, or is it a product/process problem?"

[!] The single most expensive PM mistake in ML is building a prediction model when the root cause is a product or process problem. An ML model that predicts which customers are frustrated does not fix a slow support team, a confusing UI, or a pricing problem. Diagnose before prescribing.

>> Bandits reduce regret but complicate measurement. Personalization experiments need long-term and segment-level views. Shadow mode ≠ A/B test. ML proves prediction. Experiments prove action impact.$M15L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.9 — Common Experiment Failures and Good Experiment Design
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Common Experiment Failures and Good Experiment Design',
    9,
    $M15L9$TEN COMMON EXPERIMENT FAILURE MODES

1. No clear hypothesis. Bad: "Let''s test this new feature." Good: "We believe simplifying checkout will increase conversion by reducing form abandonment."

2. Wrong primary metric. The test improves clicks but the metric that matters is retention.

3. Too small sample. Results are noisy and conclusions are unreliable.

4. Stopping too early (peeking). The team sees a positive Day 3 result and declares victory.

5. No guardrail metrics. The primary metric improves but customer complaints increase undetected.

6. Bad randomization. Treatment and control groups are not comparable before the test starts.

7. Novelty effect. Early lift disappears within weeks as users adjust.

8. Network interference. Users affect each other, violating A/B test assumptions.

9. Not measuring long-term impact. A short-term win becomes a long-term harm.

10. Launching without operational readiness. The ML model flags more cases than the team can handle.


GOOD EXPERIMENT DESIGN TEMPLATE

A well-designed experiment plan should include all of these:

HYPOTHESIS
What do we believe and why?
Example: "We believe showing estimated delivery dates earlier in checkout will increase conversion because users currently abandon when delivery timing is uncertain."

TREATMENT
What exactly changes?
Example: show estimated delivery date on the product page and in the cart, before reaching checkout.

CONTROL
What is the comparison?
Example: current checkout page with delivery date shown only at confirmation.

ELIGIBILITY
Who is included?
Example: logged-in users in selected regions who have at least one item in cart.

RANDOMIZATION UNIT
User, session, account, or region.

PRIMARY METRIC
One metric that determines win/lose.
Example: checkout conversion rate.

SECONDARY METRICS
Supporting metrics that explain the mechanism.
Example: cart abandonment rate, delivery date interaction rate.

GUARDRAIL METRICS
Safety metrics.
Example: refunds, support contacts, latency.

DURATION AND SAMPLE SIZE
How long and how many users are needed to detect the MDE.

DECISION RULE
What result means launch, iterate, or stop — defined before the test starts.

[!] The hypothesis is the most skipped step in experiment design. Without a clear hypothesis about mechanism — "X improves Y because users currently experience Z" — the team cannot design the right test, cannot choose the right metrics, and cannot interpret ambiguous results. Invest 30 minutes writing the hypothesis. It will save weeks of confusion after results come in.

>> Design before you test. Define hypothesis, metrics, guardrails, sample size, duration, and decision rules upfront — not after results come in.$M15L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.10 — Five Product Examples: ML Plus Experimentation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Five Product Examples: ML Plus Experimentation',
    10,
    $M15L10$EXAMPLE 1: CHURN MODEL + RETENTION OFFER

ML model: predicts churn risk.
Prediction: Customer A has 80% churn risk.
Action: send retention offer.

Experiment:
  Control: no offer (or current outreach).
  Treatment: new retention offer.
  Primary metric: churn reduction.
  Secondary: offer acceptance, re-engagement.
  Guardrails: discount cost, customer complaints, margin impact.

Possible result: offer reduces churn by 3 percentage points but costs more than the retained revenue justifies for certain segments.

Decision: run uplift model to find persuadable segments where ROI is positive. Target only those.

PM lesson: a churn model identifies risk. The experiment proves whether the retention action works and for which customers.


EXAMPLE 2: RECOMMENDATION MODEL

ML model: ranks products for each user.
Offline result: NDCG improves 8%.

Experiment:
  Control: current ranking system.
  Treatment: new ML ranking model.
  Primary metric: conversion or long-term engagement.
  Secondary: CTR, add-to-cart, revenue per session.
  Guardrails: return rate, latency, diversity, complaints, hide/report rate.

Possible result: CTR improves but returns increase — users click recommendations they do not actually want.

Decision: do not launch. Adjust ranking objective to penalize categories with high return rates.

PM lesson: better ranking metrics offline do not guarantee better product outcomes online.


EXAMPLE 3: NEW ONBOARDING FLOW

ML involvement: none required.

Experiment:
  Control: old onboarding.
  Treatment: new onboarding.
  Primary metric: activation rate.
  Secondary: time to complete, first feature used.
  Guardrails: support contacts, feature misuse, 30-day retention.

Possible result: activation improves by 8%, but 30-day retention drops by 3%.

Decision: the new onboarding is too shallow — users activate faster but are less prepared. Iterate.

PM lesson: not every product improvement requires ML. Simple experimentation may be the right tool.


EXAMPLE 4: FRAUD MODEL THRESHOLD CHANGE

ML model: predicts fraud risk.
Change: lower the blocking threshold to catch more fraud.

Experiment:
  Control: current threshold.
  Treatment: lower threshold.
  Primary metric: fraud loss reduction.
  Secondary: chargebacks, manual review volume.
  Guardrails: false declines, good customer complaints, checkout conversion, latency.

Possible result: fraud loss decreases 12%, but good customer false declines increase 4%.

Decision: introduce a three-tier policy — approve, review, block — rather than a single threshold. Test each tier separately.

PM lesson: the model score is not the decision policy. The policy must be tested and calibrated to real operational constraints.


EXAMPLE 5: AI SUPPORT ASSISTANT

AI system: generates answers for support agents or customers.

Experiment:
  Control: current support workflow.
  Treatment: AI-assisted workflow.
  Primary metric: resolution time or successful self-service rate.
  Secondary: agent productivity, answer acceptance rate.
  Guardrails: incorrect answers, escalations, CSAT, safety incidents.

Possible result: resolution time improves 18% overall, but incorrect answers increase for billing and refund topics.

Decision: launch for low-risk topics (order status, shipping, FAQ). Keep human review for billing and account decisions.

PM lesson: AI quality must be tested in real workflows, not just judged from sample outputs. Topic-level performance often differs dramatically from overall performance.

[!] In all five examples, the ML model is necessary but not sufficient. The experiment is what proves product value. Without the experiment, the team is guessing that the model produces the right outcome — not proving it.

>> Each example shows the same pattern: ML predicts → action designed → experiment tests → result informs decision. The experiment is never optional.$M15L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 15.11 — PM Checklists, How to Explain, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklists, How to Explain, and the Memory Shortcut',
    11,
    $M15L11$PM CHECKLIST FOR EXPERIMENTS

1.  What is the hypothesis — what do we believe will happen and why?
2.  What exactly changes in treatment vs. control?
3.  Who is eligible, and what is the unit of randomization?
4.  Can users in treatment affect users in control (network effects)?
5.  What is the primary metric — defined before the test starts?
6.  What are the secondary metrics?
7.  What are the guardrail metrics?
8.  What sample size and test duration are needed to detect the MDE?
9.  Are we avoiding peeking and pre-defining the stopping rule?
10. Are we checking sample ratio mismatch?
11. Are there novelty or learning effects to account for?
12. What result means launch? Iterate? Stop?
13. Are we measuring long-term impact, not just immediate response?
14. What operational readiness is needed to act on results?
15. Is there a rollback plan?

PM CHECKLIST FOR ML + EXPERIMENTATION

1.  What does the model predict?
2.  What action uses the prediction?
3.  What is the current baseline system?
4.  Are we testing the model, the action, or both?
5.  What threshold or policy turns the score into an action?
6.  What is the cost of false positives? False negatives?
7.  Can operations handle the model''s output volume?
8.  What online metric proves product value?
9.  What guardrails protect users and the business?
10. Does the model perform differently by segment?
11. Is there enough time to observe delayed outcomes?
12. Are feedback loops possible?
13. Is there human review for risky decisions?
14. Can the model be rolled back?
15. Does the ML-driven action create measurable causal lift?


HOW TO EXPLAIN TO LEADERSHIP

Simple version:
  "The model tells us what is likely to happen, but it does not prove that our action will improve the outcome. To make a confident launch decision, we need an experiment that compares users who receive the new experience against a control group. We will measure the primary business metric, monitor guardrails, and decide based on both statistical and practical significance."

Churn example:
  "The churn model identifies high-risk customers, but the key business question is whether our retention offer actually saves them profitably. We recommend an A/B test among high-risk customers, with churn reduction as the primary metric and offer cost, margin, and customer complaints as guardrails."

Recommendation example:
  "The new ranking model improves offline metrics, but the launch decision depends on online product impact. We will A/B test against the current system and measure conversion, retention, diversity, latency, and negative feedback."


THE MEMORY SHORTCUT

Experimentation is: **testing whether a product action causes an outcome.**
Causal thinking is: **asking what would have happened without the action.**

Remember: Prediction → action → experiment → causal impact → launch decision

Use ML when: predicting risk, relevance, demand, ranking, or probability from complex signals.
Use experiments when: proving a feature works, testing an intervention, validating business value.
Use causal inference when: experiments are impossible and you need to estimate impact from observational data.

Watch out for:
  Confusing correlation with causation
  Treating prediction as proof of action impact
  No control group
  Wrong primary metric
  No guardrail metrics
  Small sample size
  Peeking and early stopping
  Novelty and learning effects
  Network interference
  Ignoring long-term outcomes
  Launching ML without testing the real workflow

The most important PM question:
  **Are we proving that our action caused a meaningful improvement — or are we only showing that a model can predict something?**$M15L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 15.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'A churn model achieves 0.92 AUC. The PM says the retention program will work because the model is accurate. What is wrong with this reasoning?',
    '["The model proves the model predicts churn well — it does not prove the retention action causes customers to stay. The offer, message, channel, timing, and target segment all need to be tested separately","The AUC threshold of 0.92 is insufficient; most retention programs require AUC above 0.95 to be effective","The model needs to be calibrated before it can support a retention program","The PM should run the model on the control group first to validate prediction accuracy before launching the retention program"]',
    0
  );

  -- Q2 — Lesson 15.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'A team launches a new checkout page and sees conversion increase from 10% to 12% in the following two weeks. They declare success. What is the problem with this conclusion?',
    '["Without a concurrent control group, the 2% increase could be due to seasonality, a marketing campaign, competitor outage, or other external factors — the before-after comparison cannot isolate the impact of the checkout change","The 2% improvement is too small to be statistically significant without knowing the sample size","They should have waited four weeks instead of two before measuring conversion","The primary metric should be revenue, not conversion rate, for checkout experiments"]',
    0
  );

  -- Q3 — Lesson 15.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'A recommendation experiment shows CTR increased by 12%. The team wants to ship. Guardrail metrics show the hide/report rate increased 40% and 30-day retention dropped 2%. What should the PM decide?',
    '["Do not launch — the primary metric win is outweighed by guardrail failures that indicate the model is optimizing for clicks at the expense of user trust and long-term retention","Launch because CTR improvement is statistically significant and outweighs the secondary metric changes","Investigate the hide/report rate increase before deciding, since it may be a logging error rather than a real effect","Launch with a plan to fix the guardrail metrics in the following sprint"]',
    0
  );

  -- Q4 — Lesson 15.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'An experiment shows a statistically significant 0.05% improvement in conversion with a p-value of 0.03. The team wants to launch. What should the PM ask?',
    '["Is this practically significant — does a 0.05% conversion improvement generate enough business value to justify the engineering cost, maintenance overhead, and risk of the change?","Whether to use a stricter significance threshold of p < 0.01 rather than p < 0.05","Whether to run the test for another two weeks to get a larger sample","Whether the confidence interval crosses zero, since p < 0.05 already confirms the effect is real"]',
    0
  );

  -- Q5 — Lesson 15.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A team checks their experiment results every day. On Day 4, conversion looks 3% higher in treatment. They stop the test and declare a winner. Why is this a problem?',
    '["Peeking — checking results repeatedly and stopping early inflates the false positive rate; the Day 4 result may be random noise that would have disappeared by Day 14 if the pre-defined stopping rule had been followed","The test should have run for at least 30 days to account for weekly seasonality patterns","They should have used a bandit algorithm instead of a fixed A/B split if they wanted to stop early","The 3% improvement is too small to declare a winner after only 4 days of data"]',
    0
  );

  -- Q6 — Lesson 15.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A marketplace experiment randomly assigns individual users to control or treatment for a new seller ranking algorithm. Results are confusing — control and treatment show similar behavior. What is likely wrong?',
    '["Network interference — buyers and sellers on a marketplace interact with each other, so treatment users'' experiences affect control users; the unit of randomization should be something that isolates the two groups, such as region or seller cohort","The sample size is too small and the test needs more traffic before results are interpretable","The metric is wrong — seller ranking experiments should measure seller revenue, not buyer behavior","The test needed a longer warm-up period before measurement began"]',
    0
  );

  -- Q7 — Lesson 15.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A team runs a retention campaign targeting the 1,000 customers with the highest churn risk scores. Results show minimal improvement. What alternative approach might have worked better?',
    '["Uplift modeling — the highest-risk customers may be ''lost causes'' who will churn regardless of the offer; targeting ''persuadable'' customers with moderate risk who respond to intervention would have produced more retained customers per offer sent","Using a lower churn risk threshold to target more customers with the same campaign","Running a deeper ML model to improve churn risk score accuracy before targeting","Using a difference-in-differences analysis instead of a direct experiment"]',
    0
  );

  -- Q8 — Lesson 15.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A fraud model runs in shadow mode for two weeks and correctly identifies 87% of past fraud cases. The team says it is ready to launch. What is missing?',
    '["Shadow mode only proves readiness — it cannot prove that deploying the model will reduce fraud losses, improve good customer approval rates, or create acceptable operational volume for the review team; an A/B test or phased rollout with live decisions is needed to prove product impact","The shadow mode precision needs to be above 90% before proceeding to any live testing","Shadow mode should run for at least 30 days to capture monthly fraud pattern cycles","The team should validate the model against a golden dataset before moving past shadow mode"]',
    0
  );

  -- Q9 — Lesson 15.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A PM wants to test a new notification strategy. They write: "Test the new notification." What is missing from this experiment design?',
    '["A hypothesis stating what will happen and why, a primary metric defined before launch, secondary and guardrail metrics, a randomization unit, a sample size and duration calculation, and a pre-defined decision rule — without these, the experiment cannot be interpreted reliably","A statistical significance threshold, since the team needs to agree in advance on p < 0.05 or p < 0.01","A novelty effect mitigation strategy to prevent false positives in the first week","An A/A test to validate the experimentation platform before running the real test"]',
    0
  );

  -- Q10 — Lesson 15.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'An AI support assistant reduces overall resolution time by 20% in an A/B test. However, the billing topic shows a 35% increase in escalations and a 20% drop in CSAT. What is the right launch decision?',
    '["Partial launch — deploy the assistant for topics where quality is validated (order status, shipping, FAQ) and maintain human review for billing; topic-level performance should drive topic-level deployment decisions","Full launch — the 20% overall improvement outweighs the billing topic issues, which can be addressed in a post-launch iteration","Do not launch — any topic with quality problems means the system is not ready for production","Launch with a higher confidence threshold for billing questions to reduce the escalation rate"]',
    0
  );

  -- Q11 — Lesson 15.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'The most important PM question for experimentation is: "Are we proving our action caused a meaningful improvement?" Which experiment design element most directly ensures this?',
    '["A randomized control group — without random assignment, any observed difference between groups may be caused by pre-existing differences rather than the treatment","A large enough sample size to detect the minimum detectable effect","A pre-defined primary metric to prevent post-hoc metric selection","A long enough test duration to rule out novelty effects"]',
    0
  );

end $$;
