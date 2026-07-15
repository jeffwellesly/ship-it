-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 7: Monte Carlo Simulation
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update lessons set content = $Dd3ca2228_6b0e_409b_986f_a148c40d46c6$Monte Carlo simulation is a method used to understand uncertainty.

Most business decisions are not certain. You usually do not know exactly how many customers will buy, how long a project will take, how much revenue a launch will generate, or how much risk exists.

A normal forecast may say: "We expect $1 million revenue."

Monte Carlo simulation says: "There is a 70% chance revenue will be between $850,000 and $1.2 million, a 15% chance it will be below $850,000, and a 15% chance it will be above $1.2 million."

**Monte Carlo simulation does not give one answer. It gives a range of possible answers and the probability of each outcome.**


HOW IT DIFFERS FROM ML MODELS

Monte Carlo simulation is not the same as logistic regression, decision trees, or random forests.

Those models learn patterns from historical data and make predictions.

Monte Carlo simulation is a decision-planning tool. It asks: "Given uncertainty in the inputs, what range of outcomes could happen?"

  Topic        | ML prediction model              | Monte Carlo simulation
  Main purpose | Predict outcome from data        | Explore uncertainty and risk
  Input        | Historical data / features       | Assumptions and distributions
  Output       | Prediction or probability        | Distribution of possible outcomes
  Best for     | Churn, fraud, demand, classification | Planning, risk, scenarios
  Key question | What is likely to happen?        | What could happen, and how likely is each?

Simple memory: **ML predicts. Monte Carlo simulates.**


WHEN SHOULD YOU USE IT?

Use Monte Carlo when you have multiple uncertain inputs and need to understand risk.

  Business question                                 | Monte Carlo use
  What is the chance our launch hits revenue target?| Simulate demand, conversion, price, cost
  How much inventory should we hold?                | Simulate demand and supply uncertainty
  When will this project finish?                    | Simulate task duration uncertainty
  What is the range of possible profit?             | Simulate revenue and cost drivers
  What is the probability of stockout?              | Simulate demand and lead time
  How much budget buffer do we need?                | Simulate cost variation

Monte Carlo is especially useful when a single average estimate hides risk.

Example: average demand = 10,000 units. But the real question may be: "What is the probability demand exceeds 15,000 and we run out of stock?" Monte Carlo answers that better than a point forecast.

[!] Monte Carlo is not about finding the "correct" answer. It is about replacing false certainty with honest uncertainty, and making better decisions as a result.

>> A plan that looks fine on average can have catastrophic downside. Monte Carlo shows you the full picture.$Dd3ca2228_6b0e_409b_986f_a148c40d46c6$ where id = 'd3ca2228-6b0e-409b-986f-a148c40d46c6';

update lessons set content = $D05799619_d14a_4068_8101_bbd28882c948$Monte Carlo simulation follows a simple repeatable process.


STEP 1: DEFINE THE BUSINESS QUESTION

Be specific.

Example: "What is the probability that this product launch generates at least $1 million in revenue?"

A vague question produces a vague simulation. Nail the decision first.


STEP 2: BUILD THE FORMULA

Example: Revenue = website visitors × conversion rate × average order value


STEP 3: IDENTIFY UNCERTAIN INPUTS

Which variables in the formula do you not know exactly?

Example: website visitors, conversion rate, average order value.


STEP 4: ASSIGN PROBABILITY DISTRIBUTIONS

For each uncertain input, describe its range.

Example:
  Visitors: likely between 80,000 and 150,000.
  Conversion rate: likely between 2% and 6%.
  Average order value: likely between $40 and $70.


STEP 5: RANDOMLY SAMPLE VALUES

The simulation randomly picks one possible value for each input, consistent with its distribution.

One sample:
  Visitors = 110,000
  Conversion rate = 4.2%
  Average order value = $58
  Revenue = 110,000 × 4.2% × $58 = $267,960

That is one scenario.


STEP 6: REPEAT THOUSANDS OF TIMES

Run 10,000 or more scenarios. Each uses different random values drawn from the assigned distributions.


STEP 7: ANALYZE THE OUTPUT DISTRIBUTION

Now answer:
  What is the average revenue?
  What is the median revenue?
  What is the worst-case range?
  What is the probability of hitting the target?
  Which input causes the most uncertainty?

This is the complete algorithm. The idea is simple, the power comes from running enough scenarios to see the full shape of possible outcomes.

[!] A simulation is only as good as its inputs. The most important work happens in steps 1–4, before the algorithm runs: defining the formula, identifying uncertain variables, and assigning realistic distributions.

>> The algorithm runs in seconds. The thinking, formula, variables, distributions, takes hours. That is where the value is.$D05799619_d14a_4068_8101_bbd28882c948$ where id = '05799619-d14a-4068-8101-bbd28882c948';

update lessons set content = $Dce7f626e_5da2_477f_bdb7_7082cd2b142b$THE MOST IMPORTANT OUTPUT: PERCENTILES

Monte Carlo simulation uses percentiles to describe the range of outcomes.

P50, the median. 50% of outcomes fall below, 50% above.
  Example: P50 revenue = $250,000

P10, only 10% of outcomes are below this value.
  For revenue: P10 = $100,000 → downside case.

P90, 90% of outcomes fall below this value.
  For revenue: P90 = $600,000 → upside case.

PM-friendly shorthand:
  P50 = realistic middle case
  P10 = downside case
  P90 = upside case


PROBABILITY OF HITTING A TARGET

Monte Carlo answers probability questions better than forecasts.

Examples:
  What is the probability revenue exceeds $1 million?
  What is the probability the project finishes before June 30?
  What is the probability inventory runs out?
  What is the probability profit turns negative?

Example insight: average profit = $300,000. But Monte Carlo shows: there is a 25% chance of losing money.

That changes the decision. High average profit with large downside risk is different from high average profit with low downside risk.


WORKED EXAMPLE: PRODUCT LAUNCH REVENUE

Formula: Revenue = visitors × conversion rate × average order value

  Input              | Low    | Most likely | High
  Visitors           | 80,000 | 100,000     | 140,000
  Conversion rate    | 2%     | 4%          | 7%
  Average order value| $35    | $50         | $75

Three example scenarios the simulation might generate:

  Scenario 1: 90,000 visitors × 3% × $45 = $121,500
  Scenario 2: 130,000 visitors × 6% × $65 = $507,000
  Scenario 3: 100,000 visitors × 4% × $50 = $200,000

After 10,000 scenarios, possible output:
  Median revenue = $230,000
  80% range: $130,000 to $420,000
  Probability of revenue above $500,000 = 12%
  Probability of revenue below $150,000 = 18%

This is far more useful for decision-making than saying "expected revenue is $250,000."

[!] Do not just look at the mean when reviewing simulation results. Ask for P10, P50, P90, and probability of the key risk events. The tails are where the important decisions live.

>> Percentiles turn a simulation into a business conversation. P50 is the plan. P10 is why you need contingencies. P90 is the upside you are hoping for.$Dce7f626e_5da2_477f_bdb7_7082cd2b142b$ where id = 'ce7f626e-5da2-477f-bdb7-7082cd2b142b';

update lessons set content = $D1a1f1555_557a_46e8_932c_65f137ab7dd1$A probability distribution describes how uncertain values behave. You do not need to know the math deeply, but you should understand the business meaning of each.


NORMAL DISTRIBUTION

A bell-shaped curve. Values cluster around an average; extreme values are less common.

Use when: errors, quality measurements, some demand patterns, some operational times.

Caution: normal distribution can produce negative values, which may not make sense for demand or price. Use alternatives when values cannot go below zero.


UNIFORM DISTRIBUTION

Every value in a range is equally likely.

Use when: you know only a minimum and maximum and have no reason to prefer one value within that range.

Example: supplier cost could be anywhere from $10 to $15 with no information suggesting one value is more likely.


TRIANGULAR DISTRIBUTION

Uses three inputs: minimum, most likely, and maximum.

Use when: experts can estimate a best case, most likely case, and worst case, which is common in project and business planning.

Example: task duration, minimum 5 days, most likely 8 days, maximum 15 days.

This is the most practical distribution for most PM use cases.


LOGNORMAL DISTRIBUTION

Values cannot go below zero and may have rare large outliers.

Use when: revenue, demand, delivery delays, financial returns, insurance claims.

Example: customer lifetime value cannot be negative, but some customers spend 10× the average.


POISSON DISTRIBUTION

For counts of events occurring in a time period.

Use when: support tickets per hour, defects per batch, transactions per minute, arrivals at a service counter.


BERNOULLI DISTRIBUTION

For yes/no events with a given probability.

Use when: customer converts or does not convert (conversion rate), payment failure happens or does not happen, supplier delay occurs or does not occur.


HOW TO CHOOSE

Match the distribution to the business behavior of the variable.

  Variable type                       | Try this distribution
  Measurement with natural center     | Normal
  Bounded range, no preferred value   | Uniform
  Expert can give low/likely/high     | Triangular
  Cannot be negative, can spike high  | Lognormal
  Count of events in a period         | Poisson
  Yes/no outcome                      | Bernoulli

[!] Bad distribution assumptions produce misleading simulation results. If you are unsure, triangular is the safest default for business planning, it is easy to explain and grounded in expert judgment.

>> The distribution is a claim about how the world works. Challenge it the same way you challenge any other assumption.$D1a1f1555_557a_46e8_932c_65f137ab7dd1$ where id = '1a1f1555-557a-46e8-932c-65f137ab7dd1';

update lessons set content = $D9b01a8dc_b4ee_4a75_b25a_a58e897e3453$EXAMPLE 1: INVENTORY PLANNING

Business problem: how many units should we stock?

Uncertain variables:
  Customer demand
  Supplier lead time
  Return rate
  Replenishment delay
  Promotion impact

The trade-off:
  Too little stock → stockouts, lost sales, poor customer experience.
  Too much stock → excess inventory, storage cost, markdown risk, waste.

Monte Carlo output (example):

  Inventory level | Stockout probability | Avg leftover units
  10,000 units    | 35%                  | 400
  12,000 units    | 18%                  | 1,800
  15,000 units    | 5%                   | 4,200

PM decision: choose the level that balances stockout cost against overstock cost.

If a stockout costs $20 per lost unit in gross margin, and excess inventory costs $3 per unit to hold and mark down, the math may favor stocking 12,000 rather than 15,000, but knowing the stockout probability at each level is essential to making that call confidently.


EXAMPLE 2: PROJECT TIMELINE PLANNING

Business problem: when will this project actually finish?

Traditional plan (point estimates):
  Design = 2 weeks
  Engineering = 6 weeks
  QA = 2 weeks
  Launch prep = 1 week
  Total = 11 weeks

Realistic uncertain ranges:
  Design = 1–4 weeks
  Engineering = 5–10 weeks
  QA = 1–5 weeks
  Launch prep = 1–3 weeks

Monte Carlo output:
  Median finish = 12 weeks
  80% confidence range = 10 to 16 weeks
  Probability of finishing within 11 weeks = 38%
  Probability of delay beyond 15 weeks = 18%

Better PM statement: "Based on uncertainty in task durations, there is only a 38% chance we finish within 11 weeks. For 80% confidence, we should plan for 16 weeks, or reduce risk in engineering and QA first."

This prevents false confidence in a plan that looks clean on paper but has a majority-odds chance of slipping.

[!] Project timeline simulations often reveal that the "expected" finish date is not the 50th percentile, it is often closer to the 35th percentile because planners anchor to best-case estimates. Monte Carlo forces the team to confront this.

>> Stocking decisions and timeline commitments are the two most common PM scenarios where point estimates cause avoidable surprises. Simulate both.$D9b01a8dc_b4ee_4a75_b25a_a58e897e3453$ where id = '9b01a8dc-b4ee-4a75-b25a-a58e897e3453';

update lessons set content = $D58dc657e_1f49_412c_ab6f_79239a9acaf8$EXAMPLE 3: PRICING AND PROFIT PLANNING

Business problem: which price point should we choose?

Profit depends on: price, demand, conversion rate, unit cost, return rate, marketing spend.

Monte Carlo can simulate the profit distribution for each price option.

Example output:

  Price | Median profit | Probability of loss | P90 upside
  $40   | $300,000      | 5%                  | $480,000
  $50   | $380,000      | 12%                 | $620,000
  $60   | $350,000      | 25%                 | $700,000

PM decision: Price B ($50) may be attractive if the business can tolerate 12% loss probability for a higher median and upside. Price C ($60) has more upside but also much higher risk.

Monte Carlo enables risk-adjusted comparison, not just average-to-average comparison.


EXAMPLE 4: CAPACITY PLANNING FOR SUPPORT OPERATIONS

Business problem: how many support agents do we need?

Uncertain variables:
  Incoming ticket volume, average handle time, agent availability, escalation rate, repeat contact rate.

Monte Carlo output:

  Agents | SLA miss probability | Avg wait time | Overtime cost/week
  20     | 32%                  | High          | Low
  25     | 12%                  | Moderate      | Moderate
  30     | 4%                   | Low            | High

PM decision: choose staffing based on the customer experience target and cost trade-off.

If SLA breach costs the company in customer satisfaction and contract penalties, paying for 25 agents instead of 20 may be clearly worth it.


EXAMPLE 5: MARKETING CAMPAIGN PLANNING

Business problem: estimate ROI before committing the campaign budget.

Uncertain inputs:
  Audience size, open rate, click rate, conversion rate, average order value, discount cost, unsubscribe rate.

Monte Carlo output:
  Expected ROI = positive
  Probability of negative ROI = 30% if conversion is below 2%
  Probability of exceeding revenue target = 45%
  Customer acquisition cost range: P10 = $18, P50 = $30, P90 = $65

PM decision: the 30% downside risk may justify running a pilot with a smaller budget before committing to a full campaign. The simulation justifies the test, not the full spend.

[!] Monte Carlo is especially valuable before large, hard-to-reverse investments, a new price, a big inventory order, a full campaign launch. Run the simulation to decide how much to pilot before committing.

>> The goal is not to avoid risk. It is to take the right risks with open eyes.$D58dc657e_1f49_412c_ab6f_79239a9acaf8$ where id = '58dc657e-1f49-412c-ab6f-79239a9acaf8';

update lessons set content = $D47227528_f4bc_44fa_b565_e88c6199bd58$SENSITIVITY ANALYSIS

Sensitivity analysis asks: which input variable affects the outcome the most?

Example, in a revenue simulation, uncertainty may come from:
  Visitors, conversion rate, average order value, return rate, marketing cost.

Sensitivity output might show:
  Conversion rate → 60% of revenue uncertainty
  Visitors → 25% of revenue uncertainty
  Average order value → 10% of revenue uncertainty
  Other factors → 5% of revenue uncertainty

PM interpretation: conversion rate is the most important thing to improve or validate.

Possible actions:
  Run a landing page A/B test before full launch
  Improve funnel measurement to narrow the conversion rate range
  Use historical conversion data from similar launches
  Launch a small pilot to measure real conversion before full spend commitment

Monte Carlo is not just about predicting outcomes. Sensitivity analysis identifies which assumptions matter most, and where reducing uncertainty is worth the investment.


SCENARIO PLANNING VS. MONTE CARLO

Scenario planning uses a few manually defined cases.

Example: best case, base case, worst case.

Monte Carlo uses thousands of randomly sampled cases.

  Topic           | Scenario planning          | Monte Carlo simulation
  Number of cases | 3–5                        | Thousands
  Inputs          | Manually chosen            | Randomly sampled from distributions
  Output          | A few outcomes             | Full probability distribution
  Best for        | Simple communication       | Quantifying uncertainty
  Weakness        | Misses many possibilities  | Requires well-defined distributions

Scenario planning is easier to explain to stakeholders.
Monte Carlo is more complete and statistically rigorous.

A good PM often uses both:
  Monte Carlo for rigorous internal analysis.
  Simple scenarios (P10/P50/P90) for leadership communication.


MONTE CARLO VS. FORECASTING

Forecasting gives the center estimate: "Expected demand next month = 20,000 units."

Monte Carlo gives the full range: P10 = 14,000, P50 = 20,000, P90 = 31,000, probability demand exceeds inventory = 22%.

They work together. A forecast model provides the average; Monte Carlo simulates the uncertainty around it.

[!] A great forecast and a Monte Carlo simulation answer different questions. The forecast tells you what is most likely. The simulation tells you what could go wrong, and how likely that is.

>> Sensitivity analysis is where Monte Carlo earns its keep. The average tells you what to plan for. Sensitivity tells you what to worry about.$D47227528_f4bc_44fa_b565_e88c6199bd58$ where id = '47227528-f4bc-44fa-b565-e88c6199bd58';

update lessons set content = $Dcfc930a9_061d_49a7_a89e_f88fc0791c60$CORRELATION BETWEEN INPUTS

One common mistake is assuming uncertain variables are independent when they actually move together.

Examples of correlated inputs:
  Marketing spend and website visitors, if spend is high, visitors tend to be high.
  Price and demand, if price increases, demand often decreases.
  Weather and foot traffic, if weather is bad, foot traffic falls.
  Economic conditions and customer churn, in a recession, churn tends to rise.

If the simulation treats these as independent, it may produce unrealistic scenarios.

Example of an unrealistic scenario that uncorrelated simulation could generate:
  Very high price and very high demand, even though demand historically falls when price rises.

Modeling positive or negative correlation between inputs prevents the simulation from exploring impossible combinations.

PM question: "Which uncertain inputs are correlated, and did we model that relationship?"


NUMBER OF SIMULATIONS

Common choices: 1,000 / 10,000 / 100,000 iterations.

More simulations produce a more stable output distribution, but require more compute time.

For most business spreadsheet models, 10,000 iterations is sufficient to get a reliable picture of the distribution.

For complex financial or scientific models, more may be needed.

PM question: "Did we run enough simulations for the output to stabilize?" (Run it twice with the same settings, if the P10 and P90 change significantly between runs, more iterations are needed.)


READING THE OUTPUT DISTRIBUTION

When reviewing a Monte Carlo result, do not focus only on the mean.

Check:
  Mean, average outcome, but can be skewed by extreme values.
  Median, middle outcome; more robust when distribution is skewed.
  P10 and P90, the downside and upside range.
  Probability of a bad outcome, loss, stockout, delay, missed target.
  Tail risk, rare but severe outcomes. A 3% chance of a $5M loss may matter a great deal.
  Sensitivity drivers, which assumptions have the biggest impact on the output?

Full review checklist for a Monte Carlo output:
  1. Is the median (P50) close to our plan? If not, why?
  2. What is the downside (P10)?
  3. What is the upside (P90)?
  4. What is the probability of the worst outcome we are trying to avoid?
  5. Which input drives the most uncertainty?
  6. What can we do to reduce that uncertainty before committing?

[!] Tail risk deserves separate attention. A low-probability catastrophic outcome may dominate the decision even if the average looks fine.

>> The mean is where you hope to land. P10 is where you need to be able to survive.$Dcfc930a9_061d_49a7_a89e_f88fc0791c60$ where id = 'cfc930a9-061d-49a7-a89e-f88fc0791c60';

update lessons set content = $D4a921f33_61b6_4ca9_b0a0_4b2cf952a723$STRENGTHS OF MONTE CARLO SIMULATION

1. Shows uncertainty clearly, gives a range instead of one number.
2. Helps quantify risk, you can estimate the probability of bad outcomes.
3. Supports better decisions, compare options by risk and reward, not just average.
4. Handles multiple uncertain inputs, real-world decisions often have several uncertain drivers.
5. Useful for leadership communication, present best case, base case, downside, and probability of hitting target.
6. Identifies key risk drivers, sensitivity analysis shows which assumptions matter most.
7. Useful before large commitments, simulate outcomes before spending large budget or making irreversible decisions.


WEAKNESSES OF MONTE CARLO SIMULATION

1. Depends heavily on assumptions
   If the input distributions are wrong, the output will be wrong. Garbage in, garbage out, even with 100,000 simulations.

2. Can create false confidence
   A simulation with thousands of runs looks scientific. But if assumptions are weak, the result is still weak. The number of iterations does not validate the quality of the assumptions.

3. Hard to choose distributions
   Teams may not know whether to use normal, triangular, lognormal, or another distribution, and the choice matters.

4. May ignore rare extreme events
   If distributions do not include tail events (black swans), the simulation will underestimate risk.

5. Correlation can be missed
   Treating correlated inputs as independent produces unrealistic scenarios.

6. Can be hard to explain
   Some stakeholders do not understand percentiles and probability ranges. Communication requires extra care.

7. Not a replacement for real measurement
   Monte Carlo helps plan, but actual outcomes must still be measured after launch. Adjust assumptions when reality diverges from simulation.


WHAT CAN GO WRONG

1. Assumptions come from one person's guess
   PM question: "What data supports this range?"

2. Wrong distribution choice
   PM question: "Why is this the right distribution for this variable?"

3. Correlation ignored
   PM question: "Which assumptions move together, did we model that?"

4. Only the average is reviewed
   PM question: "What is the probability of missing our target?"

5. Tail risk is dismissed as unlikely
   PM question: "What happens in the worst 5% of scenarios, can we survive it?"

6. Model is too complex to trust
   PM question: "Can we simplify this without losing the important risk drivers?"

7. No decision changes from the result
   PM question: "What decision will we make differently because of this simulation?"

[!] A Monte Carlo simulation that does not change a decision was a waste of time. Always start with the question: what would we do differently if the downside probability is X% vs. Y%?

>> A simulation is a thinking tool, not a prediction machine. Its value is in sharpening decisions, not replacing judgment.$D4a921f33_61b6_4ca9_b0a0_4b2cf952a723$ where id = '4a921f33-61b6-4ca9-b0a0-4b2cf952a723';

update lessons set content = $D35bc055d_8163_42f6_965d_bcc1849c270d$PM CHECKLIST FOR MONTE CARLO SIMULATION

1.  What decision are we trying to improve?
2.  What is the outcome we are simulating?
3.  What is the formula or business logic?
4.  Which inputs are uncertain?
5.  What distribution is used for each uncertain input?
6.  Are distributions based on historical data, experiments, or expert judgment?
7.  Are any inputs correlated?
8.  Did we include downside and tail-risk scenarios?
9.  How many simulations were run?
10. Did the output stabilize?
11. What is the median outcome (P50)?
12. What are P10 and P90?
13. What is the probability of missing the target?
14. What is the probability of a bad outcome (loss, stockout, delay)?
15. Which variables drive the most uncertainty?
16. What decision changes based on this result?
17. Which assumptions should we validate first?
18. Can we run a pilot or experiment to reduce uncertainty before committing?
19. How will we compare simulated results with actual outcomes later?
20. How should we communicate this clearly to stakeholders?


HOW TO EXPLAIN TO LEADERSHIP

Simple version:
  "We used Monte Carlo simulation to model uncertainty in the plan. Instead of relying on one forecast, we identified the major uncertain inputs, assigned realistic ranges to them, and simulated thousands of possible outcomes. This gives a probability distribution showing the likely range, downside risk, upside potential, and chance of hitting our target."

Revenue launch example:
  "The base forecast shows expected revenue of $1 million, but the simulation shows only a 55% chance of reaching that target. The biggest driver of uncertainty is conversion rate. If we improve conversion to the higher end of our expected range, the probability of hitting target increases to 75%. I recommend validating conversion through a smaller pilot before committing full launch spend."

Project timeline example:
  "The project plan says 12 weeks, but after simulating uncertainty in engineering, QA, and launch tasks, we estimate only a 40% chance of finishing within 12 weeks. For 80% confidence, we should plan for 16 weeks, or reduce risk in the engineering workstream by resolving the open technical unknowns first."


THE MEMORY SHORTCUT

Monte Carlo simulation is: **running thousands of possible futures to understand risk.**

  Uncertain inputs → probability distributions → many scenarios → outcome distribution → better decision

Use it when: you have uncertainty, you need a range not a single number, you need downside and upside scenarios, you need the probability of hitting a target, or you are planning a launch, inventory order, project, or budget.

Measure it by: quality of assumptions, realism of distributions, backtesting where possible, usefulness of sensitivity analysis, and whether the simulation actually improved a decision or business outcome.

Watch for: weak assumptions, wrong distributions, ignored correlations, false confidence from many simulations, underweighted tail risks, focusing only on the average, and simulations that change no decision.

The most important PM question:
  **What decision becomes better because we understand the range of possible outcomes, not just the average?**$D35bc055d_8163_42f6_965d_bcc1849c270d$ where id = '35bc055d-8163-42f6-965d-bcc1849c270d';

update questions set choices = $Da831910e_6ec1_4b21_aebd_8112a0ef0383Q$["The average hides the distribution, Monte Carlo reveals the probability of serious downside (e.g., 25% chance of revenue below $800K) that should change the decision","Monte Carlo can increase the expected revenue by choosing better input values","The forecast model is always wrong and Monte Carlo replaces it","Monte Carlo tells you which product features will drive the most revenue"]$Da831910e_6ec1_4b21_aebd_8112a0ef0383Q$::jsonb where id = 'a831910e-6ec1-4b21-aebd-8112a0ef0383';

update questions set choices = $D85927702_dc6c_4ba2_a2dd_08751e89c50fQ$["Steps 1–4: defining the formula, identifying uncertain variables, and assigning realistic distributions, these assumptions drive everything","Step 6: choosing how many simulations to run","Step 7: reading the percentile output table","Step 5: the random sampling algorithm the software uses"]$D85927702_dc6c_4ba2_a2dd_08751e89c50fQ$::jsonb where id = '85927702-dc6c-4ba2-a2dd-08751e89c50f';

update questions set choices = $D84ebbfd1_db68_48d0_b409_30d1f68a79b4Q$["There is real downside risk, 22% chance of loss and a wide range of outcomes. The P50 is the plan; the P10 is the contingency to survive","The model is wrong because P10 is much lower than P50","The simulation should be rerun with fewer scenarios to tighten the range","P90 is the most likely outcome because it represents the best-prepared scenario"]$D84ebbfd1_db68_48d0_b409_30d1f68a79b4Q$::jsonb where id = '84ebbfd1-db68-48d0-b409-30d1f68a79b4';

update questions set choices = $D8bafd1af_6639_4140_b967_5bce7d170a6bQ$["Poisson, it models counts of events occurring in a fixed time period","Normal, ticket volume clusters around a mean with symmetric variation","Bernoulli, tickets either arrive or do not arrive","Uniform, any number of tickets is equally likely"]$D8bafd1af_6639_4140_b967_5bce7d170a6bQ$::jsonb where id = '8bafd1af-6639-4140-b967-5bce7d170a6b';

update questions set choices = $D614b3c07_cbf7_414b_b8ce_6e36d464f83cQ$["Communicate that 11 weeks is unlikely and plan for 16 weeks, or invest in reducing uncertainty in the longest-risk workstream before committing","Ignore the simulation since the plan already has a buffer week built in","Rerun the simulation with more iterations to get a tighter range","Accept the 38% probability since it is better than 0%"]$D614b3c07_cbf7_414b_b8ce_6e36d464f83cQ$::jsonb where id = '614b3c07-cbf7-414b-b8ce-6e36d464f83c';

update questions set choices = $Dc97db738_b8e3_4853_a1d8_f852508c59cbQ$["Run a smaller pilot to measure real conversion before committing full campaign spend, the simulation justified the test","Cancel the campaign since 30% probability of loss is too high","Increase the campaign budget to improve the outcome distribution","Rerun the simulation with more optimistic conversion rate assumptions"]$Dc97db738_b8e3_4853_a1d8_f852508c59cbQ$::jsonb where id = 'c97db738-b8e3-4853-a1d8-f852508c59cb';

update questions set choices = $Da87d1771_6e6d_4e83_b6b4_b5e87683936fQ$["Validate or improve the conversion rate estimate, run a landing page test or use historical data from similar launches before full commitment","Improve the website traffic estimate since it affects 25% of uncertainty","Switch to scenario planning since sensitivity results are hard to act on","Increase the number of simulation runs to reduce the uncertainty"]$Da87d1771_6e6d_4e83_b6b4_b5e87683936fQ$::jsonb where id = 'a87d1771-6e6d-4e83-b6b4-b5e87683936f';

update questions set choices = $De50b080c_abb5_4fb9_9afe_f2e93566a3d4Q$["These variables are likely positively correlated, when spend is high, visitors tend to be high. Treating them as independent allows the simulation to generate unrealistic combinations like low spend and very high visitors","Independence is the standard assumption in all Monte Carlo models","The simulation should instead model marketing spend as a fixed cost, not an uncertain variable","Independent variables cannot both be uncertain in the same simulation"]$De50b080c_abb5_4fb9_9afe_f2e93566a3d4Q$::jsonb where id = 'e50b080c-abb5-4fb9-9afe-f2e93566a3d4';

update questions set choices = $Da2e2eac4_2980_4e1f_8773_90864e82c234Q$["More iterations stabilize the output distribution but do not validate the assumptions. If the input distributions are wrong, 100,000 runs of a bad model produces 100,000 bad results","The stakeholder is correct, more iterations always increase accuracy","100,000 simulations is too many; 10,000 is the maximum useful number","The number of simulations does not affect the output in Monte Carlo models"]$Da2e2eac4_2980_4e1f_8773_90864e82c234Q$::jsonb where id = 'a2e2eac4-2980-4e1f-8773-90864e82c234';
