-- ML for Everyone — Module 11: RNNs, LSTMs, and Sequence Models
-- 11 lessons covering sequence models from a PM perspective

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
    'Module 11: RNNs, LSTMs, and Sequence Models',
    'Learn how recurrent neural networks and LSTMs learn from ordered data — and how to evaluate, apply, and communicate about them as a PM.',
    11
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.1 — What Is a Sequence Model and Why Order Matters
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is a Sequence Model and Why Order Matters',
    1,
    $M11L1$A sequence model is a model used when the order of data matters.

In many ML problems, order does not matter much. For predicting customer churn, a table of feature counts is enough: logins last 30 days, number of support tickets, plan type, payment failures.

But in sequence problems, the order itself carries meaning.

Example — same events, different meaning:

  Visit homepage → view product → add to cart → abandon cart

vs.

  Add to cart → view product → visit homepage → abandon cart

**Sequence models are used when the past order of events helps predict what happens next.**


WHAT IS SEQUENTIAL DATA?

Sequential data is data arranged in order. The order may be based on time, position, steps, words, events, frames, or sensor readings.

| Data type      | Sequence example                                |
| Text           | Word 1 → word 2 → word 3                        |
| Time series    | Sales today → tomorrow → next day               |
| User behavior  | Visit → click → cart → purchase                 |
| Financial data | Price at minute 1 → minute 2 → minute 3         |
| Sensor data    | Temperature reading every second                |
| Video          | Frame 1 → frame 2 → frame 3                     |
| Support journey| Ticket opened → reply → escalation → resolution |


WHY NORMAL MODELS STRUGGLE WITH SEQUENCES

Traditional models like logistic regression, decision trees, and random forests expect a fixed set of summary features. Sometimes those summaries lose important order information.

Example:

Customer A: Login → use feature → invite teammate → purchase
Customer B: Purchase → stop using → open ticket → cancel

Both customers may have similar summary counts, but the sequence tells a different story. A sequence model can learn from the order of events.

Do not automatically use a sequence model. If summary features solve the problem, use them — they are simpler, cheaper, and easier to explain. Sequence models add value when exact order patterns cannot be captured by aggregates.

PM question: "Do we really need the full sequence, or do summary features solve the problem?"

[!] This is the most important PM question for any sequence model project. Teams often reach for RNNs because they sound advanced, when a logistic regression with well-engineered features works just as well.

>> Use sequence models when the past order of events helps predict what happens next — and when simpler baselines have been tried and found insufficient.$M11L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.2 — What Is an RNN, Hidden State, and How It Processes Sequences
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is an RNN, Hidden State, and How It Processes Sequences',
    2,
    $M11L2$WHAT IS AN RNN?

RNN stands for Recurrent Neural Network. It is a neural network designed for sequential data.

A normal feedforward neural network processes inputs independently. An RNN processes one step at a time and carries memory from previous steps.

Example: reading a sentence.

"The customer cancelled because the product was too expensive."

An RNN reads: The → customer → cancelled → because → the → product → was → too → expensive

At each word, it keeps some memory of earlier words.

**An RNN reads data step by step and remembers some of what came before.**


THE SIMPLEST MENTAL MODEL

Imagine watching a movie. You understand the current scene because you remember earlier scenes. If a character says "I finally found it," you need context — what did they find, and why does it matter?

An RNN works similarly. It processes the current input while carrying a memory of earlier inputs.

Customer behavior example:

  Day 1: signed up
  Day 2: completed onboarding
  Day 5: invited teammate
  Day 20: stopped using
  Day 25: opened support ticket
  Day 30: payment failed

The RNN sees the journey, not just the counts.


WHAT IS HIDDEN STATE?

The hidden state is the RNN''s memory. At each timestep, the RNN updates the hidden state using the current input and the previous hidden state.

Example: sentence sentiment.

"The movie was not good."

When the RNN reads "good," it also remembers "not." The hidden state carries that earlier context.

**Hidden state is the model''s running memory of the sequence so far.**

For user behavior, the hidden state may capture: engagement level, recent frustration, purchase intent, risk pattern, or decline in usage. The model learns this representation — it is not manually defined.


WHAT DOES "RECURRENT" MEAN?

"Recurrent" means something repeats. In an RNN, the same neural-network logic is reused at each timestep. The model processes one step at a time — one word, one day, one event — and at each step uses the current input plus memory from the previous step.

[!] An RNN''s hidden state is not a human-readable summary. It is a learned numerical representation of everything the model considers important from the sequence so far. You cannot read it directly, but its effects show in the final prediction.

>> An RNN reads a sequence step by step, carrying a running memory (hidden state) that captures patterns from earlier steps.$M11L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.3 — Inputs, Outputs, and Task Types for Sequence Models
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Inputs, Outputs, and Task Types for Sequence Models',
    3,
    $M11L3$WHAT GOES IN?

RNN inputs are ordered sequences. The model receives ordered steps, not a single flat row.

Text: words or tokens in order.
  Example: "I want to cancel my subscription."

Time series: values over time.
  Example: Daily sales — 100 → 120 → 115 → 140 → 170

User behavior: events in order.
  Example: View product → search → add to cart → remove → leave

Sensor data: readings over time.
  Example: Temperature, vibration, pressure every second.

Speech: audio signals over time.


WHAT COMES OUT?

SEQUENCE-TO-ONE
Many input steps produce one output.
Examples:
  Customer behavior over 30 days → churn probability.
  Movie review text → positive or negative sentiment.

SEQUENCE-TO-SEQUENCE
Many input steps produce many output steps.
Examples:
  English sentence → Spanish sentence.
  Audio sequence → text transcript.

NEXT-STEP PREDICTION
Past sequence predicts next item or value.
Examples:
  Sales for last 30 days → sales tomorrow.
  Words so far → next word.

MANY-TO-MANY LABELING
Each input step gets a label.
Example: words in a sentence → part-of-speech tag for each word.

PM shortcut: "Are we predicting one final answer, the next step, or an output for every step?"


BIDIRECTIONAL RNNS

A normal RNN reads a sequence in one direction (start to end). A bidirectional RNN reads in both directions — forward and backward.

Why useful? Sometimes later context helps interpret earlier words.

Example: "The bank near the river was flooded." The word "river" helps clarify that "bank" means riverbank, not financial institution.

Bidirectional RNNs are useful when the full sequence is available before prediction — for tasks like sentiment analysis, text classification, and document understanding.

Not useful for real-time future prediction. If forecasting tomorrow''s demand, you cannot use future data.

PM question: "Is this a real-time prediction where future context is unavailable?"

[!] Defining the output type is a product decision. "Predict churn" could mean: a single probability at end of month, a probability updated after every event, or a sequence of risk scores. Each requires a different model design.

>> The task type (sequence-to-one, seq2seq, next-step) shapes everything — architecture, training data format, evaluation metrics, and latency requirements.$M11L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.4 — Four Real Product Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Four Real Product Examples',
    4,
    $M11L4$EXAMPLE 1: SENTIMENT ANALYSIS

Business problem: classify customer reviews as positive, neutral, or negative.
Model type: sequence-to-one (text → sentiment label).
Input: review text in order. Example: "The product arrived late, but the quality was excellent." Order matters — "but the quality was excellent" changes the meaning.
Output: Positive / neutral / negative.

Actions: route negative reviews to support, track sentiment trends, identify product issues.

Technical metrics: accuracy, precision/recall by sentiment class, F1, confusion matrix.
Business metrics: faster feedback detection, better support prioritization, improved product quality insights.


EXAMPLE 2: TIME-SERIES DEMAND FORECASTING

Business problem: forecast future demand.
Model type: sequence-to-one or sequence-to-sequence.
Input: past demand sequence — Day 1: 1,000 → Day 2: 1,200 → Day 3: 1,150 → Day 4: 1,400.
Output: predicted demand for future days.

Use cases: sales forecasting, inventory planning, staffing, capacity planning, energy demand prediction.

Technical metrics: MAE, RMSE, MAPE, forecast bias, prediction interval coverage.
Business metrics: stockout reduction, overstock reduction, planning cost.

PM question: "What baseline forecasting methods — moving average, exponential smoothing, ARIMA — did we compare against?"


EXAMPLE 3: USER JOURNEY PREDICTION

Business problem: predict whether a user will convert based on recent behavior.
Model type: sequence-to-one.
Input: ordered event sequence — Homepage visit → category browse → product view → review read → add to cart → checkout start.
Output: conversion probability.

Actions: trigger reminder, personalize recommendation, offer help, detect drop-off risk.

Technical metrics: AUC, precision, recall, lift, calibration, conversion lift from intervention.
Business metrics: higher conversion, lower abandonment, better personalization.


EXAMPLE 4: ANOMALY DETECTION IN SENSOR DATA

Business problem: detect unusual machine behavior before failure.
Model type: sequence-to-one or next-step prediction (detect when actual deviates from predicted).
Input: sensor readings over time — vibration, pressure, temperature, speed.
Output: anomaly risk or failure probability.

Actions: maintenance alert, stop equipment, schedule inspection.

Technical metrics: precision, recall, false alarm rate, detection delay, PR AUC.
Business metrics: downtime reduction, maintenance cost reduction, safety improvement, fewer unexpected failures.

[!] Each example connects sequence input → model output → threshold → tiered action → team capacity → business metric. That full chain is the PM deliverable — not just the model accuracy number.

>> Speech recognition follows the same pattern (audio sequence → text sequence) and serves voice assistants, call transcription, support automation, and compliance review — word error rate and latency are the primary technical metrics.$M11L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.5 — Why Basic RNNs Struggle: Vanishing Gradient and LSTMs
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Why Basic RNNs Struggle: Vanishing Gradient and LSTMs',
    5,
    $M11L5$THE LONG-TERM DEPENDENCY PROBLEM

Basic RNNs have a critical weakness: they struggle to remember information from far back in a long sequence.

Example:

"The product that I bought after reading many reviews and comparing multiple brands was excellent."

The important word "product" appears early. The final opinion "excellent" appears much later. A basic RNN may struggle to connect these distant parts of the sequence.

This is called the long-term dependency problem.


VANISHING GRADIENT

During training, the model sends error backward through time. For long sequences, the learning signal becomes smaller and smaller as it moves backward. This is called vanishing gradient.

Analogy: imagine shouting instructions down a long hallway. By the time the message reaches the far end, it is too faint to understand.

In practice: the model may not learn how early events affect later outcomes.

Example: a customer had a bad onboarding experience 60 days ago, and that still affects churn risk. A basic RNN may not remember that reliably.


EXPLODING GRADIENT

The opposite problem: the learning signal becomes too large and unstable, making training collapse.

Analogy: the message becomes extremely loud and distorted rather than fading.

PM-level takeaway: basic RNNs can be hard to train on long sequences. That is why LSTMs and GRUs were developed.


WHAT IS AN LSTM?

LSTM stands for Long Short-Term Memory. An LSTM is a special type of RNN designed to remember important information for longer.

**An LSTM is an RNN with a better memory system.**

It can decide: what to remember, what to forget, what new information to store, and what information to output right now.

Think of an LSTM like a smart notebook. As it reads a sequence, it decides:
  This is important — keep it.
  This is no longer useful — forget it.
  This new signal matters — add it.
  This part should influence the prediction now.

LSTM uses three gates to control this:
  Forget gate: decides what old information to drop. (A resolved payment issue may matter less now.)
  Input gate: decides what new information to store. (A new support escalation may be important.)
  Output gate: decides what information to use for the current prediction. (Focus on the recent usage drop.)

Simple memory: LSTM gates decide what to forget, what to remember, and what to use.


WHAT IS A GRU?

GRU stands for Gated Recurrent Unit. It is a simpler alternative to LSTM with fewer parameters, often achieving similar results.

PM-level summary: LSTM = more complex memory, GRU = simpler gated memory. Both are better than basic RNNs for long sequences. You do not choose between them — ask the team which architecture fits the data and latency requirements.

[!] As a PM, you do not tune gates or memory cells. But understanding that LSTMs solve the long-memory problem helps you ask the right question: "Is our sequence long enough that an LSTM is worth the added complexity over a simpler model?"

>> LSTMs solve the basic RNN''s memory problem by using gates to decide what to remember, forget, and output at each step.$M11L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.6 — Sequence-to-Sequence Models, Attention, and RNNs vs. Transformers
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Sequence-to-Sequence Models, Attention, and RNNs vs. Transformers',
    6,
    $M11L6$SEQUENCE-TO-SEQUENCE MODELS

Sequence-to-sequence models take one sequence and produce another sequence.

| Input sequence      | Output sequence      |
| English sentence    | French sentence      |
| Audio signal        | Text transcript      |
| Long document       | Short summary        |
| User action history | Next action sequence |
| Question            | Answer               |

Older seq2seq systems used RNNs or LSTMs with an encoder-decoder architecture: the encoder compressed the input sequence into a fixed hidden state, and the decoder expanded it into the output sequence. The bottleneck was that all input information had to pass through a single compressed vector.


WHAT IS ATTENTION?

Attention is a mechanism that lets a model focus on the most relevant parts of the input sequence when producing each output step.

Example: when translating a word, the model can focus on the specific source word that corresponds to it, rather than relying only on a single compressed hidden state that must carry everything.

**Attention lets the model look back at important parts of the input instead of compressing everything into one summary.**

This idea became the foundation of transformers.


RNNS/LSTMS VS. TRANSFORMERS

RNNs and LSTMs process sequences step by step. Transformers use attention to look across the entire sequence more directly.

| Topic            | RNN/LSTM                  | Transformer                             |
| Processing style | Step by step              | Looks across sequence via attention     |
| Long context     | Limited/moderate          | Usually stronger                        |
| Training speed   | Less parallelizable       | More parallelizable                     |
| Modern NLP       | Historical foundation     | Current dominant architecture (LLMs)   |
| Smaller systems  | Often practical and cheap | Can be heavier and more expensive       |

PM takeaway: learn RNNs/LSTMs to understand how models handle ordered data and memory. Learn transformers to understand modern AI and LLMs. In most new NLP projects today, the default starting point is a transformer-based model.

PM questions:
  Why RNN/LSTM vs. transformer for this problem?
  Which performs better on our data?
  Which is cheaper to serve at our scale?
  Which handles our latency requirements?


WHEN TO USE RNNS OR LSTMS TODAY

Use RNNs/LSTMs when:
  You have sequential/time-series data and order matters
  The dataset is not extremely large
  The model needs to be smaller or more efficient
  You need streaming or step-by-step processing
  Transformer complexity is not justified
  You are forecasting from historical sequences
  You are modeling event sequences or sensor anomalies

For modern large-scale NLP, code, and multimodal tasks, transformer-based models are now the standard starting point.

[!] RNNs and LSTMs are not obsolete — they remain practical for time-series forecasting, sensor anomaly detection, and smaller sequence classification tasks where transformer overhead is unjustified.

>> Transformers replaced RNNs for most NLP tasks, but RNNs and LSTMs are still the right choice for many operational forecasting and event-sequence problems.$M11L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.7 — Metrics for Sequence Models
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Metrics for Sequence Models',
    7,
    $M11L7$Metrics for sequence models depend on the task type. Always connect technical metrics to business outcomes.


CLASSIFICATION METRICS (Churn, sentiment, fraud, anomaly detection)

  Accuracy: fraction of correct predictions.
  Precision: when the model says positive, how often is it right?
  Recall: of all actual positives, how many did the model catch?
  F1: harmonic mean of precision and recall.
  AUC / PR AUC: overall performance across thresholds.
  Confusion matrix: which classes the model confuses.
  Calibration: do predicted probabilities match real-world frequencies?


FORECASTING METRICS (Demand, traffic, sales, sensor readings)

  MAE (Mean Absolute Error): average absolute error. Easy to explain.
    Example: forecast is off by 200 units on average.

  RMSE (Root Mean Squared Error): punishes large errors more. Useful when big forecast misses are costly.

  MAPE (Mean Absolute Percentage Error): error as a percentage of actual.
    Example: forecast is off by 8% on average.
    Caution: MAPE behaves badly when actual values are near zero.

  Forecast bias: checks whether the model consistently overpredicts or underpredicts.
    Example: a demand model that always overpredicts creates excess inventory.

  Prediction intervals: instead of one value, the model estimates a range.
    Example: Expected demand = 10,000 units, 80% range = 8,000–13,000 units.
    Useful for planning under uncertainty.

  Business impact: stockout rate, overstock cost, planning accuracy, operational efficiency.


SEQUENCE-TO-SEQUENCE METRICS (Translation, summarization, transcription)

  Word error rate (WER): for speech recognition — fraction of words wrong.
  BLEU / ROUGE: for text generation and summarization — measures overlap with reference output.
  Human evaluation: for quality, fluency, faithfulness.
  Task success: did the output accomplish the goal?
  Business metrics: support deflection, time saved, manual transcription cost.


RECOMMENDATION / NEXT-ITEM METRICS

  Precision@K: of the top K recommendations, how many are relevant?
  Recall@K: of all relevant items, how many appear in top K?
  NDCG: accounts for ranking position — a relevant item at rank 1 is worth more than at rank 5.
  Business: click-through rate, conversion, retention, satisfaction, long-term engagement.

PM question: "Which offline metric matters most for our task, and what online business metric proves value?"

[!] Sequence models are often evaluated on sophisticated offline metrics like BLEU, NDCG, or MAPE — but the business still needs to see improvement in stockout rate, customer complaints, conversion, or cost. Always define both.

>> Match the metric to the task. Precision/recall for classification, MAE/RMSE for forecasting, WER for speech, NDCG for ranking. Then prove value with a business metric.$M11L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.8 — Data Preparation: Sequence Length, Leakage, and Cold Start
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Data Preparation: Sequence Length, Leakage, and Cold Start',
    8,
    $M11L8$Sequence models need careful data preparation. Several issues are specific to ordered data and do not appear in tabular ML.


SEQUENCE LENGTH AND WINDOWING

How many past steps should the model look at?

Examples: last 7 days, 30 days, 90 days, 100 clicks, or 1,000 tokens.

Too short: the model misses important context.
Too long: training becomes harder, more expensive, and the model may learn noise.

For time series, the model often uses a window of past values to predict future values.
  Example: use last 30 days to predict next 7 days.

PM question: "How was the sequence length or time window chosen, and was it validated on held-out data?"


PADDING AND MASKING

Sequences often have different lengths. One user may have 5 events, another may have 200. Padding adds placeholder values so batches have the same length. Masking tells the model to ignore the padded positions so they do not affect learning.

These are engineering details — but if not handled correctly, the model may learn from artificial padding signals.

PM question: "How are variable-length sequences handled, and are padded positions masked?"


DATA LEAKAGE IN SEQUENCE MODELS

Leakage is especially dangerous in sequence models because time order makes it easy to accidentally include future information.

Examples of leakage:
  Predicting churn at day 30, but the sequence includes the cancellation event from day 31.
  Forecasting demand for next week using sales data that includes next week.
  Predicting whether a purchase will happen, but including the purchase event in the input sequence.

PM question: "Does the input sequence stop strictly before the prediction point?"

This is one of the most important questions for any sequence model project.


COLD START AND SPARSE SEQUENCES

Sequence models struggle when there is little history.

Examples:
  A new user has only one event.
  A new product has only a few days of sales.
  A new machine has limited sensor history.

This is called cold start.

Possible solutions:
  Use profile or metadata features for new users/items
  Use simpler fallback models (population averages, content-based rules)
  Use similar-user or similar-item data
  Use hybrid models that combine sequence signals with non-sequence features
  Wait for enough history before applying the sequence model

PM question: "What happens when there is not enough sequence history, and what is the fallback?"


REAL-TIME VS. BATCH PREDICTION

Batch prediction: predictions generated periodically.
  Example: every night, predict churn risk for all customers.
  Good when immediate response is not needed.

Real-time prediction: prediction happens as events occur.
  Example: as a user browses, update purchase intent.
  Good for personalization and fraud detection.
  Requires more infrastructure.

PM questions: does prediction need to happen instantly? What is the latency requirement? Can we use batch predictions and cache them?

[!] Leakage from the future is the most common hidden failure in sequence ML. A model that looks perfect in evaluation may be completely wrong in production because future events were included in training.

>> Sequence data preparation is more error-prone than tabular ML. Verify sequence length choices, masking, leakage boundaries, and cold-start handling before accepting any offline metric as meaningful.$M11L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.9 — Strengths, Weaknesses, and Comparisons
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Strengths, Weaknesses, and Comparisons',
    9,
    $M11L9$STRENGTHS OF RNNS AND LSTMS

1. Designed for ordered data — they use sequence order instead of ignoring it.
2. Can model temporal patterns — useful for time-series and behavior over time.
3. Can process variable-length sequences — useful for text, user journeys, and event histories.
4. LSTMs handle longer memory better than basic RNNs — gates decide what to remember and forget.
5. Useful for streaming data — they can process one step at a time.
6. Good foundation for understanding modern sequence AI — they help explain why transformers were a breakthrough.


WEAKNESSES OF RNNS AND LSTMS

1. Harder to train than simpler models — training can be slower and more sensitive to hyperparameters.
2. Basic RNNs struggle with long-term dependencies — LSTMs improve this but do not fully solve every long-context problem.
3. Less parallelizable than transformers — step-by-step processing slows training on long sequences.
4. Less interpretable — hidden states are not easy to explain to stakeholders.
5. Need careful sequence preparation — windowing, padding, masking, and leakage prevention all matter.
6. Not always better than simpler models — for many business forecasting problems, simpler baselines perform comparably.
7. Transformers often outperform them in modern NLP — especially for large-scale language tasks.


COMPARISON: RNN VS. SIMPLE FEATURE ENGINEERING

Sometimes you do not need an RNN at all.

Example: instead of feeding the full login history, create summary features:
  Logins last 7 days / last 30 days
  Usage drop percentage
  Days since last login
  Number of active weeks

Then use logistic regression, random forest, or gradient boosting. This may be simpler, more explainable, and cheaper.

Use RNN/LSTM only when the exact sequence pattern matters — when order, not just counts, drives the prediction.

PM question: "Does the sequence model beat a well-engineered summary-feature baseline?"


COMPARISON: RNN VS. STATISTICAL TIME-SERIES MODELS

For forecasting, RNNs are not the only option. Other approaches include:

  Moving average, exponential smoothing → very simple, interpretable.
  ARIMA → captures trends and seasonality.
  Prophet-style models → handles holidays, missing data.
  Gradient boosting with lag features → often competitive.
  Temporal convolutional networks → alternative deep learning approach.
  Transformers → strong for large forecasting problems.

RNNs and LSTMs add value when patterns are complex, data is sufficient, and simpler models have been tried and found insufficient.

PM question: "What forecasting baselines did we compare against before choosing an RNN?"

[!] The most common mistake with RNNs is choosing them first before establishing a simpler baseline. A well-tuned ARIMA or gradient boosting model often performs comparably at a fraction of the cost and complexity.

>> An RNN''s value must be proven against a simpler baseline. Never justify a sequence model with complexity alone — justify it with measurable performance improvement on the right metric.$M11L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.10 — Interpretability, Drift, and Ten Things That Can Go Wrong
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Interpretability, Drift, and Ten Things That Can Go Wrong',
    10,
    $M11L10$INTERPRETABILITY

RNNs and LSTMs are harder to explain than decision trees or logistic regression. Hidden states are not directly human-readable.

Possible explanation approaches:
  Attention weights (if attention is used): which steps the model focused on.
  Feature attribution: which input features contributed most.
  Important timestep analysis: which events in the sequence drove the prediction.
  Example-based explanations: "this prediction is similar to these historical cases."
  Human-readable patterns: surface the events the model appears to have weighted.

Example output to stakeholders:

"The model flagged this user as high churn risk because usage dropped after onboarding, support tickets increased, a payment issue occurred, and no recovery activity followed."

PM question: "Can we identify which events in the sequence drove the prediction, and is that level of explanation sufficient for this use case?"

For high-stakes decisions (credit, hiring, medical, legal), interpretability is a requirement, not a nice-to-have.


DRIFT IN SEQUENCE MODELS

Sequence patterns can change over time.

Examples:
  User behavior patterns shift after a product redesign.
  Demand patterns change due to economic shifts.
  Fraud patterns evolve after a rule change.
  Sensor behavior changes after equipment maintenance.
  Customer journey changes after a competitor enters the market.

A model trained on old sequences may degrade quietly.

PM questions:
  How will model performance be monitored after launch?
  How often will training data be refreshed?
  How will human review feedback flow back to improve the model?
  What triggers a retraining?


TEN THINGS THAT CAN GO WRONG

1. Sequence order is not actually useful — summary features work just as well. Use a simpler model.
2. Data leakage — the model sees future events. Predictions look great offline and fail in production.
3. Sequence length is wrong — too short misses context, too long adds noise and cost.
4. Poor handling of missing data — time-series gaps or missing events confuse the model.
5. Cold start — new users or items have too little history. No fallback exists.
6. Overfitting — the model memorizes training sequences and fails on new ones.
7. Hard to explain — stakeholders cannot understand why a prediction was made, creating trust issues.
8. Latency is too high — real-time sequence scoring is expensive and slow.
9. Drift — behavior patterns change over time and performance decays silently.
10. Wrong success metric — the model predicts well offline but does not improve the business outcome.

[!] Leakage and wrong success metric are the two most dangerous failures because they are the hardest to detect. A model with a great AUC that does not improve churn rate or stockouts has not delivered value — it has only delivered complexity.

>> Interpretability, drift, and the ten failure modes are PM responsibilities — own them alongside the data science team.$M11L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 11.11 — PM Checklist, How to Explain, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist, How to Explain, and the Memory Shortcut',
    11,
    $M11L11$PM CHECKLIST FOR RNN/LSTM PROJECTS

1.  What sequence are we modeling?
2.  Why does order matter — what pattern cannot be captured by summary features?
3.  What is the exact prediction target?
4.  Are we predicting one output, next step, or a full output sequence?
5.  What is the sequence length or time window?
6.  How was the time window chosen and validated?
7.  How are short sequences (cold start) handled?
8.  How are long sequences handled?
9.  How are missing timesteps or gaps handled?
10. Are we using RNN, LSTM, GRU, bidirectional RNN, or transformer?
11. Why this architecture for this data and latency requirement?
12. What simpler baseline did we compare against?
13. Does the sequence model meaningfully outperform summary features or simpler models?
14. Are all inputs available at prediction time — no future events in the sequence?
15. Is there data leakage from the future?
16. What are the offline metrics?
17. What business metric should improve?
18. How does performance vary by segment?
19. Is the model explainable enough for this use case?
20. Which events or timesteps drive predictions?
21. Is this batch or real-time?
22. What is the latency requirement?
23. What is the serving cost?
24. How will drift be monitored?
25. What is the retraining plan?
26. What happens when the model is uncertain?
27. What action does the prediction trigger, and does the team have capacity to act?


HOW TO EXPLAIN TO LEADERSHIP

Simple version:
  "We used a sequence model because the order of events matters for this problem. Instead of looking only at summary features, the model reads the history step by step and learns how earlier events influence later outcomes. An LSTM is a type of recurrent neural network with a stronger memory mechanism, allowing it to remember important signals over longer sequences."

Churn example:
  "The model predicts churn risk from the customer''s activity sequence, not just total usage counts. It can distinguish between a customer whose usage is steadily increasing and one whose usage dropped after support issues. We will compare it against simpler models and only use it if the sequence-based approach improves retention outcomes enough to justify the added complexity."

Forecasting example:
  "The model forecasts demand using historical demand sequences. It learns temporal patterns such as recent trends, seasonality, and momentum. Success will be measured by forecast error, stockout reduction, overstock reduction, and business planning improvements."


THE MEMORY SHORTCUT

An RNN is: **a neural network with memory for ordered data.**
An LSTM is: **an RNN with a smarter memory system that uses gates to decide what to remember, forget, and use.**

Remember: Sequence → step-by-step processing → hidden state memory → prediction

Use when:
  Order matters
  You have text, speech, time-series, clickstream, or event history
  Past context affects the current prediction
  Summary features are not enough
  You need sequence-to-one, next-step, or sequence-to-sequence output

Measure with:
  Classification: precision, recall, F1, AUC, PR AUC, calibration
  Forecasting: MAE, RMSE, MAPE, forecast bias, prediction intervals
  Seq2seq: word error rate, BLEU/ROUGE, human evaluation, task success

Watch for:
  Data leakage from the future
  Wrong sequence length
  Cold start with no fallback
  Overfitting
  Low interpretability for high-stakes decisions
  High latency or serving cost
  Drift
  Using RNNs when summary features are enough
  Using RNNs for large-scale NLP when a transformer is better

The most important PM question:
  **Does using the actual sequence order improve the decision enough compared with simpler summary features or baseline models?**$M11L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 11.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'When is a sequence model justified over a simpler tabular model?',
    '["When the order of events carries information that cannot be captured by summary features — and a simpler baseline has been tried and found insufficient","Whenever the input data has a time dimension, regardless of whether order actually matters","When the dataset has more than 100,000 rows, since sequence models scale better","When the team has experience with neural networks and wants to apply their skills"]',
    0
  );

  -- Q2 — Lesson 11.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What is the hidden state in an RNN?',
    '["The model''s running memory of the sequence so far — a learned representation updated at each step that carries forward information the model considers important","A fixed list of hand-engineered features extracted from the sequence before training","The final prediction output produced after reading the entire sequence","A visualization tool that shows which input steps the model focused on"]',
    0
  );

  -- Q3 — Lesson 11.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'A team wants to predict churn risk updated after every customer event, not just once a month. Which output type does this require?',
    '["Many-to-many — an output at each timestep — so the model produces a risk score after every event rather than one final answer at the end of the sequence","Sequence-to-one — since there is still only one churn outcome per customer","Sequence-to-sequence — since the input and output both involve customer data","Next-step prediction — since the model must predict what the customer will do next"]',
    0
  );

  -- Q4 — Lesson 11.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'A demand forecasting model has low MAPE but the operations team says inventory planning has not improved. What should the PM investigate?',
    '["Whether low average MAPE hides large errors on the high-value SKUs that drive inventory decisions, and whether the forecast is being used correctly in the planning process","Whether MAPE should be replaced with RMSE as the primary metric","Whether the model needs more training data to reduce MAPE further","Whether the model should be retrained with a longer sequence window"]',
    0
  );

  -- Q5 — Lesson 11.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'Why do LSTMs outperform basic RNNs on long sequences?',
    '["LSTMs use gates to control what to remember, forget, and output at each step — solving the vanishing gradient problem that causes basic RNNs to lose important signals from early in the sequence","LSTMs use more hidden layers, giving them greater capacity to model complex patterns","LSTMs process sequences in parallel rather than step by step, making them faster and more accurate","LSTMs use attention to look across the full sequence at once instead of one step at a time"]',
    0
  );

  -- Q6 — Lesson 11.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A team is building a new customer sentiment classifier on short support ticket text. Which architecture should the PM recommend exploring first?',
    '["A transformer-based model or fine-tuned language model, since transformers now outperform RNNs for most NLP classification tasks and pre-trained models can reduce data requirements","A basic RNN, since it is the simplest sequence architecture and requires the least compute","A bidirectional LSTM, since text classification always requires reading in both directions","A 3D CNN, since document images contain spatial patterns that CNNs are designed to capture"]',
    0
  );

  -- Q7 — Lesson 11.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A demand forecasting model has an 8% MAPE overall but consistently overpredicts for certain product categories. What metric reveals this problem?',
    '["Forecast bias — it measures whether the model systematically overpredicts or underpredicts, which MAPE alone does not surface since errors can average out across segments","RMSE — it penalizes large errors more than MAPE and would catch the systematic overprediction","Prediction interval coverage — it reveals whether the model''s uncertainty ranges are too wide","AUC — it measures overall classification performance across all confidence thresholds"]',
    0
  );

  -- Q8 — Lesson 11.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A churn prediction model uses a 90-day customer event sequence. The model achieves 91% AUC in offline evaluation but shows no churn reduction in a live pilot. What should the PM check first?',
    '["Whether future events — such as the cancellation request itself — were included in the 90-day sequence during training, causing data leakage that inflated offline metrics","Whether 90 days is too short a window and the model needs to see 180 days of history","Whether the model needs to be retrained with more customer data to close the gap","Whether AUC is the wrong metric and precision-recall should be used instead"]',
    0
  );

  -- Q9 — Lesson 11.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A team proposes an LSTM for churn prediction. The current logistic regression model uses features like logins last 30 days, usage drop, and days since last login. What should the PM ask?',
    '["Does the LSTM meaningfully outperform the logistic regression baseline using the same evaluation metric — if the sequence order adds no predictive value beyond the summary features, the added complexity is not justified","Should we replace logistic regression with gradient boosting before trying LSTM?","Is the LSTM using LSTM or GRU cells, since GRU has fewer parameters and may train faster?","Does the LSTM use a bidirectional architecture, since reading the sequence in both directions improves most classification tasks?"]',
    0
  );

  -- Q10 — Lesson 11.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'Six months after launch, a sensor anomaly detection model starts generating twice as many false alarms as it did initially. What is the most likely cause?',
    '["Model drift — equipment behavior or operating conditions changed, so the model''s learned patterns no longer match current sensor data","The model was overtrained and needs fewer epochs in its next training run","The sequence window is too long and should be shortened to focus on recent readings","The threshold was set too high at launch and needs to be lowered to reduce recall"]',
    0
  );

  -- Q11 — Lesson 11.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'The most important PM question for any sequence model project is: "Does using the actual sequence order improve the decision enough compared with simpler baseline models?" Which checklist item most directly tests this?',
    '["Does the sequence model meaningfully outperform summary features or a simpler baseline on the same evaluation metric?","What architecture is used — RNN, LSTM, GRU, or bidirectional RNN?","What sequence length was chosen?","Is the model trained batch or in real time?"]',
    0
  );

end $$;
