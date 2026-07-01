-- ML for Everyone — Module 7: Monte Carlo Simulation
-- 11 lessons covering Monte Carlo simulation from a PM perspective

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
    'Module 7: Monte Carlo Simulation',
    'Learn how to model uncertainty, quantify risk, and make better decisions by simulating thousands of possible futures instead of relying on a single forecast.',
    7
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.1 — What Is Monte Carlo Simulation and When to Use It?
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is Monte Carlo Simulation and When to Use It?',
    1,
    $M7L1$Monte Carlo simulation is a method used to understand uncertainty.

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

[!] Monte Carlo is not about finding the "correct" answer. It is about replacing false certainty with honest uncertainty — and making better decisions as a result.

>> A plan that looks fine on average can have catastrophic downside. Monte Carlo shows you the full picture.$M7L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.2 — Inputs, Outputs, and Why Single-Point Estimates Are Dangerous
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Inputs, Outputs, and Why Single-Point Estimates Are Dangerous',
    2,
    $M7L2$WHAT ARE THE INPUTS?

Monte Carlo simulation needs three things.

1. A business formula or model
   The logic that calculates the outcome.
   Example: Profit = Revenue − Cost
   Revenue = number of customers × conversion rate × average order value
   Cost = fixed cost + variable cost

2. Uncertain variables
   The things you do not know exactly.
   Examples: number of visitors, conversion rate, average order value, marketing cost, return rate, supplier cost, project duration.

3. Probability distributions
   Instead of entering one fixed value, you describe a range.
   Example: conversion rate is not exactly 5%.
   Low case: 3%. Most likely: 5%. High case: 8%.
   The simulation samples different possible values from this range.


WHAT IS THE OUTPUT?

The output is a distribution of possible outcomes.

Instead of: "Expected profit = $500,000"

You get:
  Average profit = $500,000
  Median profit = $470,000
  P10 (downside) = $100,000
  P90 (upside) = $900,000
  Probability of loss = 8%
  Probability of profit above $750,000 = 22%

The output can be shown as a histogram, percentile table, confidence range, risk chart, or sensitivity chart.


WHY SINGLE-POINT ESTIMATES ARE DANGEROUS

Business teams often use single-point estimates: "Expected demand = 10,000 units."

But actual demand could be 6,000, 8,000, 10,000, 13,000, or 18,000.

If you plan for exactly 10,000:
  Demand is lower → overstock and waste money.
  Demand is higher → stockout and lose sales.

Monte Carlo replaces the point estimate with a range.

Better statement: "There is a 20% chance demand exceeds 14,000 units. If we stock only 10,000, stockout risk is meaningful."

This is far more useful for decision-making than a single number.

[!] Single-point estimates create false confidence. They make uncertain outcomes feel precise. A plan built on one forecast is a plan built on an assumption.

>> The most dangerous number in business is the "expected" value when the real distribution is wide and the downside is severe.$M7L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.3 — How Monte Carlo Works: Step by Step
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'How Monte Carlo Works: Step by Step',
    3,
    $M7L3$Monte Carlo simulation follows a simple repeatable process.


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

The simulation randomly picks one possible value for each input — consistent with its distribution.

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

This is the complete algorithm. The idea is simple — the power comes from running enough scenarios to see the full shape of possible outcomes.

[!] A simulation is only as good as its inputs. The most important work happens in steps 1–4, before the algorithm runs: defining the formula, identifying uncertain variables, and assigning realistic distributions.

>> The algorithm runs in seconds. The thinking — formula, variables, distributions — takes hours. That is where the value is.$M7L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.4 — Percentiles, Probability of Hitting Targets, and a Worked Example
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Percentiles, Probability of Hitting Targets, and a Worked Example',
    4,
    $M7L4$THE MOST IMPORTANT OUTPUT: PERCENTILES

Monte Carlo simulation uses percentiles to describe the range of outcomes.

P50 — the median. 50% of outcomes fall below, 50% above.
  Example: P50 revenue = $250,000

P10 — only 10% of outcomes are below this value.
  For revenue: P10 = $100,000 → downside case.

P90 — 90% of outcomes fall below this value.
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

>> Percentiles turn a simulation into a business conversation. P50 is the plan. P10 is why you need contingencies. P90 is the upside you are hoping for.$M7L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.5 — Common Probability Distributions
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Common Probability Distributions',
    5,
    $M7L5$A probability distribution describes how uncertain values behave. You do not need to know the math deeply — but you should understand the business meaning of each.


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

Use when: experts can estimate a best case, most likely case, and worst case — which is common in project and business planning.

Example: task duration — minimum 5 days, most likely 8 days, maximum 15 days.

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

[!] Bad distribution assumptions produce misleading simulation results. If you are unsure, triangular is the safest default for business planning — it is easy to explain and grounded in expert judgment.

>> The distribution is a claim about how the world works. Challenge it the same way you challenge any other assumption.$M7L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.6 — Inventory Planning and Project Timeline Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Inventory Planning and Project Timeline Examples',
    6,
    $M7L6$EXAMPLE 1: INVENTORY PLANNING

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

If a stockout costs $20 per lost unit in gross margin, and excess inventory costs $3 per unit to hold and mark down, the math may favor stocking 12,000 rather than 15,000 — but knowing the stockout probability at each level is essential to making that call confidently.


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

Better PM statement: "Based on uncertainty in task durations, there is only a 38% chance we finish within 11 weeks. For 80% confidence, we should plan for 16 weeks — or reduce risk in engineering and QA first."

This prevents false confidence in a plan that looks clean on paper but has a majority-odds chance of slipping.

[!] Project timeline simulations often reveal that the "expected" finish date is not the 50th percentile — it is often closer to the 35th percentile because planners anchor to best-case estimates. Monte Carlo forces the team to confront this.

>> Stocking decisions and timeline commitments are the two most common PM scenarios where point estimates cause avoidable surprises. Simulate both.$M7L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.7 — Pricing, Capacity, and Marketing Campaign Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Pricing, Capacity, and Marketing Campaign Examples',
    7,
    $M7L7$EXAMPLE 3: PRICING AND PROFIT PLANNING

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

PM decision: the 30% downside risk may justify running a pilot with a smaller budget before committing to a full campaign. The simulation justifies the test — not the full spend.

[!] Monte Carlo is especially valuable before large, hard-to-reverse investments — a new price, a big inventory order, a full campaign launch. Run the simulation to decide how much to pilot before committing.

>> The goal is not to avoid risk. It is to take the right risks with open eyes.$M7L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.8 — Sensitivity Analysis and Scenario Comparisons
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Sensitivity Analysis and Scenario Comparisons',
    8,
    $M7L8$SENSITIVITY ANALYSIS

Sensitivity analysis asks: which input variable affects the outcome the most?

Example — in a revenue simulation, uncertainty may come from:
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

Monte Carlo is not just about predicting outcomes. Sensitivity analysis identifies which assumptions matter most — and where reducing uncertainty is worth the investment.


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

[!] A great forecast and a Monte Carlo simulation answer different questions. The forecast tells you what is most likely. The simulation tells you what could go wrong — and how likely that is.

>> Sensitivity analysis is where Monte Carlo earns its keep. The average tells you what to plan for. Sensitivity tells you what to worry about.$M7L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.9 — Correlation, Number of Simulations, and Reading Output
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Correlation, Number of Simulations, and Reading Output',
    9,
    $M7L9$CORRELATION BETWEEN INPUTS

One common mistake is assuming uncertain variables are independent when they actually move together.

Examples of correlated inputs:
  Marketing spend and website visitors — if spend is high, visitors tend to be high.
  Price and demand — if price increases, demand often decreases.
  Weather and foot traffic — if weather is bad, foot traffic falls.
  Economic conditions and customer churn — in a recession, churn tends to rise.

If the simulation treats these as independent, it may produce unrealistic scenarios.

Example of an unrealistic scenario that uncorrelated simulation could generate:
  Very high price and very high demand — even though demand historically falls when price rises.

Modeling positive or negative correlation between inputs prevents the simulation from exploring impossible combinations.

PM question: "Which uncertain inputs are correlated, and did we model that relationship?"


NUMBER OF SIMULATIONS

Common choices: 1,000 / 10,000 / 100,000 iterations.

More simulations produce a more stable output distribution, but require more compute time.

For most business spreadsheet models, 10,000 iterations is sufficient to get a reliable picture of the distribution.

For complex financial or scientific models, more may be needed.

PM question: "Did we run enough simulations for the output to stabilize?" (Run it twice with the same settings — if the P10 and P90 change significantly between runs, more iterations are needed.)


READING THE OUTPUT DISTRIBUTION

When reviewing a Monte Carlo result, do not focus only on the mean.

Check:
  Mean — average outcome, but can be skewed by extreme values.
  Median — middle outcome; more robust when distribution is skewed.
  P10 and P90 — the downside and upside range.
  Probability of a bad outcome — loss, stockout, delay, missed target.
  Tail risk — rare but severe outcomes. A 3% chance of a $5M loss may matter a great deal.
  Sensitivity drivers — which assumptions have the biggest impact on the output?

Full review checklist for a Monte Carlo output:
  1. Is the median (P50) close to our plan? If not, why?
  2. What is the downside (P10)?
  3. What is the upside (P90)?
  4. What is the probability of the worst outcome we are trying to avoid?
  5. Which input drives the most uncertainty?
  6. What can we do to reduce that uncertainty before committing?

[!] Tail risk deserves separate attention. A low-probability catastrophic outcome may dominate the decision even if the average looks fine.

>> The mean is where you hope to land. P10 is where you need to be able to survive.$M7L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.10 — Strengths, Weaknesses, and What Can Go Wrong
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Strengths, Weaknesses, and What Can Go Wrong',
    10,
    $M7L10$STRENGTHS OF MONTE CARLO SIMULATION

1. Shows uncertainty clearly — gives a range instead of one number.
2. Helps quantify risk — you can estimate the probability of bad outcomes.
3. Supports better decisions — compare options by risk and reward, not just average.
4. Handles multiple uncertain inputs — real-world decisions often have several uncertain drivers.
5. Useful for leadership communication — present best case, base case, downside, and probability of hitting target.
6. Identifies key risk drivers — sensitivity analysis shows which assumptions matter most.
7. Useful before large commitments — simulate outcomes before spending large budget or making irreversible decisions.


WEAKNESSES OF MONTE CARLO SIMULATION

1. Depends heavily on assumptions
   If the input distributions are wrong, the output will be wrong. Garbage in, garbage out — even with 100,000 simulations.

2. Can create false confidence
   A simulation with thousands of runs looks scientific. But if assumptions are weak, the result is still weak. The number of iterations does not validate the quality of the assumptions.

3. Hard to choose distributions
   Teams may not know whether to use normal, triangular, lognormal, or another distribution — and the choice matters.

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
   PM question: "Which assumptions move together — did we model that?"

4. Only the average is reviewed
   PM question: "What is the probability of missing our target?"

5. Tail risk is dismissed as unlikely
   PM question: "What happens in the worst 5% of scenarios — can we survive it?"

6. Model is too complex to trust
   PM question: "Can we simplify this without losing the important risk drivers?"

7. No decision changes from the result
   PM question: "What decision will we make differently because of this simulation?"

[!] A Monte Carlo simulation that does not change a decision was a waste of time. Always start with the question: what would we do differently if the downside probability is X% vs. Y%?

>> A simulation is a thinking tool, not a prediction machine. Its value is in sharpening decisions, not replacing judgment.$M7L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 7.11 — PM Checklist and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist and the Memory Shortcut',
    11,
    $M7L11$PM CHECKLIST FOR MONTE CARLO SIMULATION

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
  "The project plan says 12 weeks, but after simulating uncertainty in engineering, QA, and launch tasks, we estimate only a 40% chance of finishing within 12 weeks. For 80% confidence, we should plan for 16 weeks — or reduce risk in the engineering workstream by resolving the open technical unknowns first."


THE MEMORY SHORTCUT

Monte Carlo simulation is: **running thousands of possible futures to understand risk.**

  Uncertain inputs → probability distributions → many scenarios → outcome distribution → better decision

Use it when: you have uncertainty, you need a range not a single number, you need downside and upside scenarios, you need the probability of hitting a target, or you are planning a launch, inventory order, project, or budget.

Measure it by: quality of assumptions, realism of distributions, backtesting where possible, usefulness of sensitivity analysis, and whether the simulation actually improved a decision or business outcome.

Watch for: weak assumptions, wrong distributions, ignored correlations, false confidence from many simulations, underweighted tail risks, focusing only on the average, and simulations that change no decision.

The most important PM question:
  **What decision becomes better because we understand the range of possible outcomes, not just the average?**$M7L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 7.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'What is the fundamental difference between a machine learning prediction model and a Monte Carlo simulation?',
    '["ML learns patterns from historical data to predict outcomes; Monte Carlo samples from uncertain input distributions to explore the full range of possible outcomes","ML is used only for classification; Monte Carlo is used only for regression","ML requires more data; Monte Carlo works without any historical data","ML gives a point prediction; Monte Carlo gives a probability only for binary outcomes"]',
    0
  );

  -- Q2 — Lesson 7.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'A product launch forecast says expected revenue is $2 million. Why might Monte Carlo simulation still be essential?',
    '["The average hides the distribution — Monte Carlo reveals the probability of serious downside (e.g., 25% chance of revenue below $800K) that should change the decision","Monte Carlo can increase the expected revenue by choosing better input values","The forecast model is always wrong and Monte Carlo replaces it","Monte Carlo tells you which product features will drive the most revenue"]',
    0
  );

  -- Q3 — Lesson 7.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'In a Monte Carlo simulation, which step requires the most PM judgment and has the biggest impact on result quality?',
    '["Steps 1–4: defining the formula, identifying uncertain variables, and assigning realistic distributions — these assumptions drive everything","Step 6: choosing how many simulations to run","Step 7: reading the percentile output table","Step 5: the random sampling algorithm the software uses"]',
    0
  );

  -- Q4 — Lesson 7.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'A Monte Carlo simulation shows P10 revenue = $80K, P50 = $250K, P90 = $550K, and probability of loss = 22%. What does this tell the PM?',
    '["There is real downside risk — 22% chance of loss and a wide range of outcomes. The P50 is the plan; the P10 is the contingency to survive","The model is wrong because P10 is much lower than P50","The simulation should be rerun with fewer scenarios to tighten the range","P90 is the most likely outcome because it represents the best-prepared scenario"]',
    0
  );

  -- Q5 — Lesson 7.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A PM is simulating daily support ticket volume to plan staffing. Which probability distribution is most appropriate?',
    '["Poisson — it models counts of events occurring in a fixed time period","Normal — ticket volume clusters around a mean with symmetric variation","Bernoulli — tickets either arrive or do not arrive","Uniform — any number of tickets is equally likely"]',
    0
  );

  -- Q6 — Lesson 7.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A project plan shows 11 weeks. Monte Carlo simulation shows only 38% probability of finishing within 11 weeks and 80% confidence requires 16 weeks. What should the PM do?',
    '["Communicate that 11 weeks is unlikely and plan for 16 weeks — or invest in reducing uncertainty in the longest-risk workstream before committing","Ignore the simulation since the plan already has a buffer week built in","Rerun the simulation with more iterations to get a tighter range","Accept the 38% probability since it is better than 0%"]',
    0
  );

  -- Q7 — Lesson 7.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A Monte Carlo simulation shows a marketing campaign has 30% probability of negative ROI. What is the most appropriate PM response?',
    '["Run a smaller pilot to measure real conversion before committing full campaign spend — the simulation justified the test","Cancel the campaign since 30% probability of loss is too high","Increase the campaign budget to improve the outcome distribution","Rerun the simulation with more optimistic conversion rate assumptions"]',
    0
  );

  -- Q8 — Lesson 7.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'Sensitivity analysis on a revenue simulation shows conversion rate drives 60% of uncertainty. What should the PM prioritize?',
    '["Validate or improve the conversion rate estimate — run a landing page test or use historical data from similar launches before full commitment","Improve the website traffic estimate since it affects 25% of uncertainty","Switch to scenario planning since sensitivity results are hard to act on","Increase the number of simulation runs to reduce the uncertainty"]',
    0
  );

  -- Q9 — Lesson 7.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A simulation treats marketing spend and website visitors as independent uncertain variables. Why could this be a problem?',
    '["These variables are likely positively correlated — when spend is high, visitors tend to be high. Treating them as independent allows the simulation to generate unrealistic combinations like low spend and very high visitors","Independence is the standard assumption in all Monte Carlo models","The simulation should instead model marketing spend as a fixed cost, not an uncertain variable","Independent variables cannot both be uncertain in the same simulation"]',
    0
  );

  -- Q10 — Lesson 7.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A team runs 100,000 Monte Carlo simulations. A stakeholder says the result must be accurate because so many scenarios were tested. What is wrong with this reasoning?',
    '["More iterations stabilize the output distribution but do not validate the assumptions. If the input distributions are wrong, 100,000 runs of a bad model produces 100,000 bad results","The stakeholder is correct — more iterations always increase accuracy","100,000 simulations is too many; 10,000 is the maximum useful number","The number of simulations does not affect the output in Monte Carlo models"]',
    0
  );

  -- Q11 — Lesson 7.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the most important PM question for any Monte Carlo simulation project?',
    '["What decision becomes better because we understand the range of possible outcomes, not just the average?","How many simulations did we run?","Which probability distribution was used for the most important variable?","Is the simulation built in Python or a spreadsheet tool?"]',
    0
  );

end $$;
