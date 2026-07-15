-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 2: Linear Regression
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update modules set description = $M$Learn how to predict numbers using weighted inputs, and how to ask the right questions about regression models.$M$ where id = '01c0280b-2d7f-42d9-9b8e-19355b5310f0';

update lessons set content = $D95f3a0ed_5806_4392_b7e3_2d67c209a8e4$A coefficient tells you the expected change in the output when one input increases by one unit, assuming all other inputs stay the same.

That phrase, "holding everything else constant", is critical.


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

This is useful for understanding drivers, but in practice, factors interact. Use coefficients for insight, not for exact predictions of combined changes.


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
  Is this feature both statistically significant AND practically meaningful?$D95f3a0ed_5806_4392_b7e3_2d67c209a8e4$ where id = '95f3a0ed-5806-4392-b7e3-2d67c209a8e4';

update lessons set content = $Dc86927f7_55fb_4b94_98c6_b4bc95fbf934$This is the most important concept in this module for any PM.

Linear regression can tell us: "These two things move together."

It cannot reliably tell us: "One thing caused the other."


CLASSIC EXAMPLE

Ice cream sales and sunglasses sales both increase in summer.

That does not mean ice cream sales cause sunglasses sales.

A third factor, hot weather, affects both.

This third factor is called a **confounding variable**.


BUSINESS EXAMPLE

Customers who receive discount offers may buy more.

But did the discount cause the purchase?

Maybe the company sent discounts to customers who were already likely to buy.

The model shows a relationship. But the relationship may be backwards, the company targeted likely-buyers, not that discounts created buyers.


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

[!] This distinction protects you in leadership meetings. If someone challenges "how do you know marketing caused the lift?", association is defensible. Causation from regression alone is not.


WHEN THIS GETS DANGEROUS

Business decisions based on causal misinterpretation can lead to:
  Wasted budget (scaling a channel that did not actually cause the result)
  Wrong product changes (removing a feature correlated with retention but not causing it)
  Flawed strategy (attributing success to a variable that just happened to move at the same time)

>> Regression shows patterns. Experiments show causes. Use both together to make confident decisions.$Dc86927f7_55fb_4b94_98c6_b4bc95fbf934$ where id = 'c86927f7-55fb-4b94-98c6-b4bc95fbf934';

update lessons set content = $D74ad822e_9101_4715_afa5_d0801f09e4f1$PROBLEM 1: THE RELATIONSHIP IS NOT LINEAR

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

Example 1: predicting CLV using "number of purchases next month", that reveals the answer.

Example 2: predicting delivery time using "actual customs clearance time", you would not know that before the delivery.

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

>> A model that looks good on average can still fail the customers who matter most.$D74ad822e_9101_4715_afa5_d0801f09e4f1$ where id = '74ad822e-9101-4715-afa5-d0801f09e4f1';

update lessons set content = $D6aa8b383_2ceb_4ee8_b0c2_6f4d61f0bb58$LINEAR REGRESSION: THE SIMPLE MEMORY SHORTCUT

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

If you cannot answer that clearly, the model is not ready to ship, no matter how good the R² looks.

>> A regression model is not a product. It becomes a product when its output changes a decision and that decision creates measurable business value.$D6aa8b383_2ceb_4ee8_b0c2_6f4d61f0bb58$ where id = '6aa8b383-2ceb-4ee8-b0c2-6f4d61f0bb58';

update questions set choices = $Daed6c7d2_59ba_4bc7_8888_f74f5ad4d799Q$["Regression shows associations but cannot prove causation, only experiments can establish that a change caused an outcome","Regression cannot handle more than 10 input features","Regression only works on data collected in the last 12 months","Regression requires the target variable to be binary"]$Daed6c7d2_59ba_4bc7_8888_f74f5ad4d799Q$::jsonb where id = 'aed6c7d2-59ba-4bc7-8888-f74f5ad4d799';
