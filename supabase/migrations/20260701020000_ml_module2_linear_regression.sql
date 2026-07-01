-- ML for Everyone — Module 2: Linear Regression
-- 11 lessons covering linear regression from a PM perspective

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
    'Module 2: Linear Regression',
    'Learn how to predict numbers using weighted inputs — and how to ask the right questions about regression models.',
    2
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.1 — What Is Linear Regression and When to Use It
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is Linear Regression and When to Use It',
    1,
    $M2L1$Linear regression is one of the simplest and most important machine learning models.

It is used when you want to predict a **number**.

Examples:
  Predict next month's sales
  Predict delivery time
  Predict customer lifetime value
  Predict house price
  Predict demand
  Predict cost
  Predict revenue
  Predict waiting time
  Predict product rating

**Linear regression tries to understand how different input factors affect a numeric outcome.**


THE SIMPLEST MENTAL MODEL

Imagine estimating the price of a used car.

You may think:
  Newer car → higher price
  More miles driven → lower price
  Better brand → higher price
  Accident history → lower price
  Good condition → higher price

Linear regression does the same thing mathematically.

It learns how much each factor increases or decreases the final number.

Car price may be estimated like this:
  Base price
  + value for brand
  + value for newer year
  - reduction for mileage
  - reduction for accident history
  + value for good condition

That is linear regression. It is like a **weighted scoring system**.


WHEN TO USE IT

Use linear regression when the output is a number.

Good use cases:
  How much revenue will we make next month? → Revenue amount
  How many units will customers buy? → Demand quantity
  What will this customer's lifetime value be? → Dollar value
  How many days will delivery take? → Number of days
  How many support tickets will we receive? → Ticket volume

Do not use linear regression when the output is yes/no.

Examples of the wrong problem type:
  Will the customer churn? Yes or no → classification
  Is this fraud? Yes or no → classification
  Will the user click? Yes or no → classification

[!] Simple rule: if the answer is a number, linear regression may be useful. If the answer is a category or yes/no, use a classification model instead.

>> Linear regression is not the fanciest model. It is often the most useful one for explaining business drivers.$M2L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.2 — Inputs, Outputs, and Coefficients
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Inputs, Outputs, and Coefficients',
    2,
    $M2L2$INPUTS: FEATURES

The inputs are called **features**. They are the information given to the model.

Example: predicting monthly sales. Features may include:
  Price
  Discount
  Marketing spend
  Season
  Website traffic
  Previous month sales
  Competitor price
  Product rating
  Inventory availability

The target (output) is: monthly sales.

The model studies historical data and learns:
  How price affects sales
  How discount affects sales
  How marketing affects sales
  How traffic affects sales
  How rating affects sales

Then for a new month, it predicts sales.


OUTPUTS: THE PREDICTED NUMBER

The output is a predicted number.

  Expected monthly sales = 9,400 units
  Expected revenue = $230,000
  Expected delivery time = 4.8 days
  Expected customer lifetime value = $720


COEFFICIENTS: THE REAL INSIGHT

Linear regression also gives a second useful output: **coefficients**.

Coefficients tell us how much each input factor affects the prediction.

Example for monthly sales:
  Marketing spend  +0.8   More marketing → higher sales
  Price            -120   Higher price → lower sales
  Product rating   +2000  Better rating → higher sales
  Discount         +300   More discount → higher sales

A positive coefficient means the feature increases the prediction.
A negative coefficient means the feature decreases the prediction.

[!] This is one reason linear regression is popular with businesses. It is easier to explain than many complex models. The coefficients give you a story about what drives the outcome.


THE FORMULA IN SIMPLE WORDS

  Prediction = base value
             + (weight for feature 1 × value of feature 1)
             + (weight for feature 2 × value of feature 2)
             + (weight for feature 3 × value of feature 3)
             + error

The model learns the best weights from past data.

Example:
  Predicted sales = base sales
                  + effect of price
                  + effect of discount
                  + effect of marketing
                  + effect of rating

>> Coefficients turn a black-box prediction into an explainable business story.$M2L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.3 — How the Model Learns: OLS and Error Reduction
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'How the Model Learns: OLS and Error Reduction',
    3,
    $M2L3$Linear regression learns by comparing its predictions with actual outcomes and adjusting to reduce mistakes.


SIMPLE VS. MULTIPLE REGRESSION

Simple linear regression uses only one input feature.

Example: predict sales using only marketing spend.
  Sales = base + marketing spend effect

This is simple but usually not enough for real business problems.

Multiple linear regression uses many input features.

Example: predict sales using marketing spend, price, discount, traffic, season, and rating.

Most practical regression models are multiple regression models. Business outcomes depend on many factors, not just one.


HOW LEARNING WORKS

Example:
  Actual sales = 10,000 units
  Predicted sales = 9,200 units
  Error = 800 units

The model does this for many rows of historical data.

Then it chooses coefficients that reduce the total error.

The most common method is called **ordinary least squares** (OLS).

OLS tries to minimize the squared errors.

Why squared errors?
  Mistake of 2 → becomes 4
  Mistake of 10 → becomes 100

[!] Squaring punishes large errors much more than small errors. So the model works hard to avoid big mistakes, not just average ones.


WHAT THE MODEL CANNOT EXPLAIN

Even the best regression model will not predict perfectly.

The part the model cannot explain is called the **residual** or error term.

Real factors that create unexplained variation:
  Random events
  Missing data
  Factors not included in the model
  Measurement error
  One-time events like a viral post or a supply crisis

A PM should expect some residual error. The goal is not perfection. The goal is to reduce error enough to make better decisions.


MINI EXERCISE

You are predicting revenue. The model says $230,000. Actual revenue was $245,000.

  Error = ______
  Is that a large or small error in context of $230,000? ______
  What might explain the remaining gap? ______$M2L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.4 — Understanding Coefficients and What They Mean
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Understanding Coefficients and What They Mean',
    4,
    $M2L4$A coefficient tells you the expected change in the output when one input increases by one unit, assuming all other inputs stay the same.

That phrase — "holding everything else constant" — is critical.


EXAMPLE: MONTHLY SALES MODEL

  Marketing spend  coefficient = +0.5
  Price            coefficient = -200
  Rating           coefficient = +1,500

Meaning:
  If marketing spend increases by $1, predicted sales increase by 0.5 units,
  assuming everything else stays the same.

  If price increases by $1, predicted sales decrease by 200 units,
  assuming everything else stays the same.

  If rating increases by 1 point, predicted sales increase by 1,500 units,
  assuming everything else stays the same.


WHY "HOLDING EVERYTHING ELSE CONSTANT" MATTERS

In real life, things change together.

Example: when you raise price, you may also cut marketing. So sales fall from both effects combined.

Coefficients try to isolate the individual effect of each factor.

This is useful for understanding drivers — but in practice, factors interact. Use coefficients for insight, not for exact predictions of combined changes.


POSITIVE AND NEGATIVE COEFFICIENTS

Positive coefficient → feature increases the prediction.
  More marketing → higher sales.

Negative coefficient → feature decreases the prediction.
  Higher price → lower sales.

[!] A coefficient shows a relationship in the data. It does not automatically prove cause and effect. More on this in the next lesson.


COEFFICIENT SIZE VS. SIGNIFICANCE

A large coefficient does not always mean the feature is important.

Example: price has a coefficient of -200, but price only varies from $18 to $22.

So the actual impact is small in practice.

Compare: rating has a coefficient of +1,500 and varies from 3.0 to 5.0.

That is a larger practical impact even though the coefficient number alone looks smaller.

PM lesson: always look at coefficient multiplied by typical range of the feature, not just the coefficient alone.


P-VALUES

P-values help answer: is this feature's effect likely real, or could it be random noise?

  p-value below 0.05 → statistically significant
  p-value above 0.05 → may not be significant

But statistical significance is not the same as business significance.

A feature can be statistically significant but only improve revenue by $50 per year.

PM question:
  Is this feature both statistically significant AND practically meaningful?$M2L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.5 — Correlation Is Not Causation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Correlation Is Not Causation',
    5,
    $M2L5$This is the most important concept in this module for any PM.

Linear regression can tell us: "These two things move together."

It cannot reliably tell us: "One thing caused the other."


CLASSIC EXAMPLE

Ice cream sales and sunglasses sales both increase in summer.

That does not mean ice cream sales cause sunglasses sales.

A third factor — hot weather — affects both.

This third factor is called a **confounding variable**.


BUSINESS EXAMPLE

Customers who receive discount offers may buy more.

But did the discount cause the purchase?

Maybe the company sent discounts to customers who were already likely to buy.

The model shows a relationship. But the relationship may be backwards — the company targeted likely-buyers, not that discounts created buyers.


TO PROVE CAUSATION YOU USUALLY NEED

  A/B test (randomized experiment)
  Natural experiment
  Causal inference methods (difference-in-differences, instrumental variables)

As a PM, the language matters.

Do not say:
  "The model proves higher marketing spend caused higher sales."

Say:
  "The model shows higher marketing spend is associated with higher sales."

That is safer and more accurate.

[!] This distinction protects you in leadership meetings. If someone challenges "how do you know marketing caused the lift?" — association is defensible. Causation from regression alone is not.


WHEN THIS GETS DANGEROUS

Business decisions based on causal misinterpretation can lead to:
  Wasted budget (scaling a channel that did not actually cause the result)
  Wrong product changes (removing a feature correlated with retention but not causing it)
  Flawed strategy (attributing success to a variable that just happened to move at the same time)

>> Regression shows patterns. Experiments show causes. Use both together to make confident decisions.$M2L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.6 — Measuring Model Performance: MAE, RMSE, and R²
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Measuring Model Performance: MAE, RMSE, and R²',
    6,
    $M2L6$For regression models, we measure how far the predicted number is from the actual number.

The three most important metrics are MAE, RMSE, and R-squared.


MAE: MEAN ABSOLUTE ERROR

MAE is the average absolute mistake.

Example for delivery time prediction:
  Actual 5 days, predicted 4 days → error 1
  Actual 7 days, predicted 8 days → error 1
  Actual 3 days, predicted 5 days → error 2

  Average error = (1 + 1 + 2) / 3 = 1.33 days

MAE = 1.33 days.

In simple words: "On average our delivery prediction is off by 1.33 days."

MAE is easy to explain to a business audience.

PM use: when you need a clear, business-friendly accuracy statement.


RMSE: ROOT MEAN SQUARED ERROR

RMSE is similar to MAE but punishes large errors more.

If most predictions are off by 1 day but some are off by 10 days, RMSE rises sharply.

Use RMSE when large errors are especially costly.

Example: being wrong by 1 delivery day may be fine. Being wrong by 10 days creates complaints, refunds, and trust loss. RMSE catches that.

  MAE → tells average error
  RMSE → punishes large errors

If RMSE is much larger than MAE, there are some big outlier errors worth investigating.


R²: HOW MUCH VARIATION THE MODEL EXPLAINS

R-squared tells us how much of the variation in the target is explained by the model.

  R² = 0.80 → model explains 80% of the variation in the target
  R² = 0 → model is no better than just predicting the average every time
  R² = 1 → perfect prediction

In real business data, R² = 1 is rare and should raise suspicion (possible data leakage).


ADJUSTED R²

Normal R² usually increases when you add more features, even useless ones.

Adjusted R² corrects for this. It penalizes unnecessary features.

Use adjusted R² when comparing models with different numbers of features.

Example:
  Model A: 5 features, R² = 0.75
  Model B: 50 features, R² = 0.77

Model B is much more complex. Adjusted R² helps reveal whether that complexity is actually worth it.

[!] High R² does not guarantee a useful model. A model can explain the past well but fail on future data. Always validate on held-out data, and always connect accuracy back to a real business decision.


PM QUESTION FOR METRICS

For MAE and RMSE: ask "is this error small enough to make a better decision than what we do today?"

For R²: ask "does explaining X% of variation actually help the business?"

The technical metric must translate to business value.$M2L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.7 — Business Metric Impact: Connecting Accuracy to Value
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Business Metric Impact: Connecting Accuracy to Value',
    7,
    $M2L7$Technical metrics are not enough.

A regression model should improve a business decision. The PM's job is to make that connection explicit.


EXAMPLE: DEMAND FORECASTING

Technical metric:
  MAE reduced from 2,000 units to 1,200 units

Business metrics:
  Fewer stockouts
  Lower excess inventory cost
  Better gross margin
  Higher product availability for customers
  Lower warehouse holding cost


EXAMPLE: DELIVERY TIME PREDICTION

Technical metric:
  MAE reduced from 2.4 days to 1.5 days

Business metrics:
  Fewer late deliveries
  Fewer customer contacts and complaints
  Higher customer satisfaction score
  Better conversion from delivery promise
  Lower refund and compensation cost


THE CONNECTION QUESTION

Do not stop at "our MAE improved from X to Y."

Always answer: "And that means..."

  MAE improved → more accurate inventory orders → fewer stockouts → better availability → higher revenue

Every step in that chain should be traceable.

[!] A model with excellent MAE but no connected business process is an expensive analysis project, not a product capability.


THE BASELINE QUESTION

Always compare to a simple baseline.

For demand forecasting:
  Baseline = use last week as next week's forecast

For delivery time:
  Baseline = use average historical delivery time

For customer lifetime value:
  Baseline = use average order value times expected order frequency

If the model does not beat the baseline meaningfully, it may not be worth building.

PM question:
  "How much better is this model than our current approach?
   And how much does that improvement translate to in dollars, units, or decisions?"

>> The most important sentence in any model review: "Because of this improvement, we can now make a better decision about X, which we estimate is worth Y."$M2L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.8 — Three Real Product Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Three Real Product Examples',
    8,
    $M2L8$LINEAR REGRESSION EXAMPLE 1: DEMAND FORECASTING

Business problem: predict weekly demand for each product.

Input features:
  Previous week sales
  Price
  Discount
  Marketing spend
  Season and holiday flag
  Product rating
  Inventory availability

Target: units sold next week.

Output: predicted demand = 12,500 units.

How it is used:
  Plan inventory
  Avoid stockouts and overstocking
  Plan marketing
  Manage supply chain

PM questions to ask:
  Are predictions made at product, category, or region level?
  How far ahead are we forecasting?
  Are holiday and promotion effects included?
  What happens for new products with little history?
  Is the model better than last week's sales as a baseline?


LINEAR REGRESSION EXAMPLE 2: CUSTOMER LIFETIME VALUE

Business problem: estimate how valuable a customer will be over the next 12 months.

Input features:
  Number of purchases
  Average order value
  Time since first purchase
  Time since last purchase
  Product categories purchased
  Discount usage
  Website visits and email engagement
  Support tickets

Target: revenue from the customer over the next 12 months.

Output: predicted CLV = $850.

How it is used:
  Set marketing budget per customer
  Prioritize high-value customers
  Personalize offers
  Improve retention strategy

PM questions to ask:
  Are we predicting revenue or profit?
  What time window are we using?
  Do we treat new and old customers separately?
  Are discounts reducing profit even if revenue looks high?
  How will the business act on high-CLV predictions?


LINEAR REGRESSION EXAMPLE 3: DELIVERY TIME PREDICTION

Business problem: estimate delivery time more accurately.

Input features:
  Distance
  Package weight
  Warehouse processing time
  Shipping method and carrier
  Destination region
  Historical route delay
  Holiday period
  Weather condition

Target: actual delivery time.

Output: predicted delivery time = 4.7 days.

How it is used:
  Show accurate delivery estimates at checkout
  Reduce customer complaints
  Identify risky shipments proactively
  Improve carrier and route decisions

PM questions to ask:
  Is the prediction made before checkout, after order, or after shipment?
  Are all features available at prediction time?
  Does the model perform well during holidays?
  Are large errors concentrated in specific carriers or regions?

[!] In all three examples, notice the pattern: define the numeric target → identify available features → connect the output to a decision → measure business impact. That is the PM's role in every regression project.$M2L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.9 — What Can Go Wrong: Data and Model Failures
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Can Go Wrong: Data and Model Failures',
    9,
    $M2L9$PROBLEM 1: THE RELATIONSHIP IS NOT LINEAR

Linear regression assumes a mostly straight-line relationship between inputs and output.

But many real business relationships are curved.

Example: reducing price from $100 to $90 may increase demand slightly. Reducing from $20 to $10 may increase demand massively.

The effect of price depends on where you are on the price scale.

Fixes: add non-linear features, use log transformation, try decision trees or random forests.


PROBLEM 2: OUTLIERS DISTORT THE MODEL

Most deliveries take 2–7 days. One delivery took 90 days because of rare customs issues.

That extreme case pulls the regression line and hurts predictions for everyone else.

PM question: "How are outliers handled in the training data?"

Fixes: remove invalid data, cap extreme values, analyze outliers separately.


PROBLEM 3: MULTICOLLINEARITY

**Multicollinearity** means two or more features are highly related to each other.

Examples:
  House size and number of bedrooms
  Marketing spend and website traffic
  Distance and shipping cost

When this happens, the model may struggle to assign credit to the right feature.

The prediction may still be okay, but coefficient interpretation becomes unreliable.

PM question: "Are any features highly correlated with each other?"

[!] If you are using coefficients to tell a business story about what drives the outcome, multicollinearity can make that story misleading. Two correlated features split the credit arbitrarily.


PROBLEM 4: DATA LEAKAGE

Data leakage happens when the model uses information unavailable at prediction time.

Example 1: predicting CLV using "number of purchases next month" — that reveals the answer.

Example 2: predicting delivery time using "actual customs clearance time" — you would not know that before the delivery.

Leakage can make a model look excellent during testing but useless in real life.

PM question: "Would this feature be known at the exact moment we need to make the prediction?"


PROBLEM 5: MISSING IMPORTANT VARIABLES

The model predicts sales using price and marketing spend, but seasonality was forgotten.

The model performs badly during holidays.

PM question: "What important business drivers might be missing from the data?"


PROBLEM 6: HISTORICAL DATA DOES NOT REPRESENT THE FUTURE

The model learns from the past. But the future may be different.

Examples:
  New competitor enters the market
  Economic conditions change
  Product changes significantly
  Customer behavior shifts

This is called **model drift**.

PM question: "How often will we monitor and retrain the model?"


PROBLEM 7: AVERAGE PERFORMANCE HIDES SEGMENT FAILURES

Overall delivery-time MAE = 1.2 days.
But for rural locations, MAE = 4.5 days.

The average looks fine. The important segment is broken.

PM question: "Can we see model performance broken down by region, customer type, product category, and time period?"

>> A model that looks good on average can still fail the customers who matter most.$M2L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.10 — Regression vs. Experimentation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Regression vs. Experimentation',
    10,
    $M2L10$Regression uses historical data to find associations.

Experimentation creates new evidence to establish cause and effect.

Understanding when to use each is a core PM skill.


WHAT REGRESSION IS GOOD FOR

  Prediction: estimating a future numeric value
  Understanding associations: which factors move with the outcome
  Forecasting: projecting trends forward
  Prioritization: ranking features by estimated impact

But regression alone cannot prove causation.

Example:
  Regression may show: users who receive discounts buy more.

  But this could mean:
  A. Discounts cause purchases (causal)
  B. The company targets likely-buyers with discounts (reverse causation)
  C. High-intent users open more emails and see more discount offers (confounding)

Regression cannot tell you which explanation is true.


WHAT EXPERIMENTS ARE BETTER FOR

  Proving causality: did this change cause the outcome?
  Measuring product impact: what lifted because of our feature?
  Testing interventions: does this retention offer actually reduce churn?

Example from above:
  An A/B test randomly assigns 50% of users to receive a discount.
  The other 50% receives no discount.
  If the discount group buys more, the discount caused the lift.
  The random assignment removes confounding.


USING BOTH TOGETHER

Best practice for PMs:

  Step 1: use regression to identify likely drivers and generate hypotheses.
  "Marketing spend appears associated with sales. Let's test this."

  Step 2: run an experiment to confirm causation.
  "A/B test: vary marketing spend across matched markets."

  Step 3: use regression on experimental data to estimate effect size.

[!] Regression is the scouting report. The experiment is the proof. Build products based on both, not just one.


WHEN YOU CANNOT EXPERIMENT

Sometimes running an experiment is impossible:
  Ethical constraints
  Time constraints
  No control group available
  Historical data only

In those cases, regression with good confounding controls is the best available tool.

But be explicit about the limitation. "This is our best estimate from observational data, not a controlled experiment."

>> The smartest PMs use regression to find where to look and experiments to prove what they found.$M2L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 2.11 — PM Checklist and How to Explain to Leadership
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist and How to Explain to Leadership',
    11,
    $M2L11$LINEAR REGRESSION: THE SIMPLE MEMORY SHORTCUT

Linear regression is: predicting a number using weighted inputs.

  Input features → weighted formula → predicted number

Use it when:
  The output is numeric
  You need a simple, explainable baseline
  You want to understand which factors are associated with the outcome

Measure it with: MAE, RMSE, R², adjusted R², business impact.

Watch out for: correlation vs. causation, outliers, data leakage, non-linear relationships, multicollinearity, segment-level failures.


PM CHECKLIST FOR ANY REGRESSION PROJECT

Before building or reviewing a linear regression model:

  1. What number are we trying to predict?
  2. What decision will this prediction improve?
  3. What is the prediction time window?
  4. What are the input features?
  5. Are all features available at prediction time? (leakage check)
  6. What is the baseline we are comparing against?
  7. What are MAE, RMSE, and R²?
  8. Which metric matters most for the business?
  9. Are there large errors in important segments?
  10. Are there outliers that distort the model?
  11. Are any features highly correlated with each other?
  12. Are coefficients being interpreted correctly?
  13. Are we accidentally claiming causation from an observational model?
  14. How will the model be monitored after launch?
  15. What business metric should improve, and by how much?


HOW TO EXPLAIN LINEAR REGRESSION TO LEADERSHIP

Simple version:
  "We built a model that predicts a numeric outcome based on historical patterns.
   It looks at key drivers like price, demand history, customer behavior, or
   operational factors, and estimates the expected value. We validated it on
   unseen data and compared it against a simple baseline."

Example for demand forecasting:
  "The model predicts weekly demand for each product. On average it is off by
   1,200 units, compared with 2,000 units from our current baseline. This should
   help reduce stockouts and excess inventory. We will monitor performance by
   product category and retrain if accuracy drops."

[!] Leadership does not need to know what ordinary least squares means. They need to know: what decision does it improve, by how much, and what is the monitoring plan.


THE MOST IMPORTANT PM QUESTION

In every regression review, there is one question that matters most:

What decision will this prediction improve?

If you cannot answer that clearly, the model is not ready to ship — no matter how good the R² looks.

>> A regression model is not a product. It becomes a product when its output changes a decision and that decision creates measurable business value.$M2L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 2.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'When should you use linear regression instead of a classification model?',
    '["When the output is a number, like revenue or delivery time","When the output is yes or no","When you want to group customers into segments","When you have no historical data"]',
    0
  );

  -- Q2 — Lesson 2.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What do coefficients in a linear regression model tell you?',
    '["How much each input feature is expected to affect the predicted number","The exact probability of each outcome","The number of rows in the training dataset","The model version number"]',
    0
  );

  -- Q3 — Lesson 2.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'Why does OLS (ordinary least squares) use squared errors rather than raw errors?',
    '["To punish large mistakes more heavily than small mistakes","To make the math easier to compute","To ensure R² equals exactly 1","To reduce the number of features needed"]',
    0
  );

  -- Q4 — Lesson 2.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'What does "holding everything else constant" mean when interpreting a coefficient?',
    '["We isolate the effect of one feature while assuming all other features do not change","We set all other features to zero","We remove all other features from the model","We average all other features together"]',
    0
  );

  -- Q5 — Lesson 2.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A regression model shows marketing spend is strongly associated with sales. What is the safest conclusion?',
    '["Marketing spend and sales move together, but we cannot conclude marketing caused the sales increase without an experiment","Marketing spend caused the sales increase","We should immediately double the marketing budget","The model proves marketing is the single most important driver"]',
    0
  );

  -- Q6 — Lesson 2.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'What is the key difference between MAE and RMSE?',
    '["MAE is the average absolute error; RMSE penalizes large errors more heavily","MAE is for classification; RMSE is for regression","MAE requires more training data; RMSE works on small datasets","MAE measures business impact; RMSE measures technical accuracy"]',
    0
  );

  -- Q7 — Lesson 2.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A demand model improves MAE from 2,000 to 1,200 units. What should a PM say next?',
    '["And that improvement translates to fewer stockouts and lower inventory cost, which we estimate is worth X","The model is now ready to ship","We should increase R² before proceeding","We need to add more features to reduce MAE further"]',
    0
  );

  -- Q8 — Lesson 2.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'In the delivery time prediction example, why must you check whether all features are available at prediction time?',
    '["Some features like actual customs clearance time are only known after delivery, which would be data leakage","Features are only available after the model is deployed","All features must be collected in real time for the model to work","More features always improve delivery time accuracy"]',
    0
  );

  -- Q9 — Lesson 2.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'What is multicollinearity and why does it matter for PMs?',
    '["When two or more features are highly related, making coefficient interpretation unreliable even if predictions are still reasonable","When the model has too many rows of training data","When MAE and RMSE give different results","When the model is retrained too frequently"]',
    0
  );

  -- Q10 — Lesson 2.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'What is the main limitation of using regression alone to guide a business decision?',
    '["Regression shows associations but cannot prove causation — only experiments can establish that a change caused an outcome","Regression cannot handle more than 10 input features","Regression only works on data collected in the last 12 months","Regression requires the target variable to be binary"]',
    0
  );

  -- Q11 — Lesson 2.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the most important PM question to ask before shipping any regression model?',
    '["What decision will this prediction improve?","What is the R² score?","How many features does the model use?","Which algorithm was used to train it?"]',
    0
  );

end $$;
