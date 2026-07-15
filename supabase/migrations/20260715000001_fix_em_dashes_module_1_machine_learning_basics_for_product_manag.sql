-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 1: Machine Learning Basics for Product Managers
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update courses set description = $C$Understand AI and machine learning from a product and business perspective, no math degree required.$C$ where id = '43a49940-387c-43ed-a9d6-52e9752c963c';

update lessons set content = $Dcd9316b6_3b96_4f8a_b308_f92b1212f649$As a PM, you usually do not need to build models yourself.

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

[!] Think of a thermometer. A doctor does not need to understand how the thermometer is built. But the doctor must understand what the reading means and what to do with it. A PM's relationship to ML models is similar, understand the output, understand the limits, decide what to do.


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
  Business metric: repeat purchase rate$Dcd9316b6_3b96_4f8a_b308_f92b1212f649$ where id = 'cd9316b6-3b96-4f8a-b308-f92b1212f649';

update lessons set content = $D17d24aa1_0646_4c0c_9f5f_68b55500592a$Machine learning is a way for computers to learn patterns from past data and use those patterns to make predictions or decisions on new data.

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

[!] Think of spam filters. Early spam filters relied on rules: if the email says "click here to win" block it. ML spam filters learn from millions of past emails marked as spam by humans. They discover patterns you could never manually write, subtle combinations of words, sender behavior, and timing. Then they classify new emails you have never seen before.


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

Understanding limits is as important as understanding capabilities.$D17d24aa1_0646_4c0c_9f5f_68b55500592a$ where id = '17d24aa1-0646-4c0c-9f5f-68b55500592a';

update lessons set content = $Daaa842d2_a5ec_44b2_a58a_4f41f46ba1e4$There are two broad types of machine learning that PMs encounter most often.


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

The word "supervised" comes from the fact that the model gets the right answer during training. It is supervised, given labeled examples.


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

>> Supervised learning predicts a known outcome. Unsupervised learning discovers unknown structure.$Daaa842d2_a5ec_44b2_a58a_4f41f46ba1e4$ where id = 'aaa842d2-a5ec-44b2-a58a-4f41f46ba1e4';

update lessons set content = $Dee6b3e8b_c9b1_4418_8647_c36c7f627239$Every ML project follows a similar flow. This lesson covers the first four steps, which are where PMs have the most influence.


STEP 1, DEFINE THE BUSINESS PROBLEM

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


STEP 2, DEFINE THE TARGET

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


STEP 3, COLLECT DATA

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


STEP 4, CREATE FEATURES

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
  Would this feature be available at the moment we need to make the prediction?$Dee6b3e8b_c9b1_4418_8647_c36c7f627239$ where id = 'ee6b3e8b-c9b1-4418-8647-c36c7f627239';

update lessons set content = $De513117c_7743_4861_8410_7da359c5f835$This lesson covers the final four steps of the ML workflow, where models often succeed or fail in practice.


STEP 5, TRAIN THE MODEL

Training means the model learns patterns from historical data.

The model compares its predictions with the true answers and adjusts itself to reduce errors over many iterations.

Different models learn differently:
  Linear regression learns weights for each input
  Logistic regression learns probability of a yes/no outcome
  Decision trees learn rules (if X then Y)
  Random forests combine many trees
  Neural networks learn complex patterns through many layers

As a PM, you do not need to understand the math. You do need to ask: does this model type make sense for our problem and our data?


STEP 6, VALIDATE THE MODEL

Validation means testing whether the model works on data it has never seen.

This helps answer:
  Is the model useful?
  Does it generalize to new cases?
  Is it better than a simple baseline?
  Does it work across important segments?

A model can look good in training and fail in real life. Validation catches that.

[!] Validation on overall data can hide problems. A model may perform well on average but fail on important sub-groups, specific regions, demographics, product types. Always ask about segment-level performance.


STEP 7, DEPLOY THE MODEL

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


STEP 8, MONITOR THE MODEL

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
  How quickly can we retrain?$De513117c_7743_4861_8410_7da359c5f835$ where id = 'e513117c-7743-4861-8410-7da359c5f835';

update questions set choices = $Dcafde263_5f01_4ce1_9ef4_9b71d150146bQ$["No action was connected to the model output, predictions existed but no process used them","The model needs more training data","The threshold was set too high","The model used regression instead of classification"]$Dcafde263_5f01_4ce1_9ef4_9b71d150146bQ$::jsonb where id = 'cafde263-5f01-4ce1-9ef4-9b71d150146b';
