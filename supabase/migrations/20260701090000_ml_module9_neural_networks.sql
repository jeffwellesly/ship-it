-- ML for Everyone — Module 9: Neural Networks
-- 11 lessons covering neural networks from a PM perspective

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
    'Module 9: Neural Networks',
    'Learn how neural networks learn complex patterns through layers of connected units — and how to evaluate, apply, and communicate about them as a PM.',
    9
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.1 — What Is a Neural Network, When to Use It, and What Goes In and Out
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is a Neural Network, When to Use It, and What Goes In and Out',
    1,
    $M9L1$A neural network is a machine learning model designed to learn complex patterns from data.

**A neural network takes inputs, passes them through layers of calculations, and produces a prediction.**

Examples: predict churn, detect image defects, recommend products, classify support tickets, detect fraud, understand text, recognize speech, predict demand, generate content.


WHY DO WE NEED NEURAL NETWORKS?

Simpler models like linear regression and decision trees are useful — but they can struggle when patterns are very complex.

Example: a linear model may learn "more usage = lower churn risk." But real behavior may be more complicated:

  A customer may churn only when usage drops sharply AND support tickets increase AND payment fails AND key features have not been adopted.

A neural network can learn these complex combinations.

It is especially useful when:
  There are many input features
  The relationship is non-linear
  Features interact in complicated ways
  Data is unstructured (image, text, audio, video)
  Simpler models are not performing well enough

Do not automatically use neural networks. For many tabular business problems, logistic regression, random forests, or gradient boosting may be simpler, cheaper, and easier to explain.


WHAT GOES IN?

  Structured/tabular data: customer features, transaction table, product signals.
  Image data: pixels from photos, manufacturing images, medical scans.
  Text data: words, tokens, embeddings from support tickets or reviews.
  Audio: sound waves from calls or recordings.
  Sequence data: ordered events — user activity, purchase history, sensor readings.

Each input type usually needs the right neural network architecture.


WHAT COMES OUT?

  Binary classification: churn probability = 78%.
  Multi-class classification: support ticket → billing 70%, technical 20%, cancellation 10%.
  Regression: predicted demand = 12,500 units.
  Ranking/recommendation: product scores for ordering a feed.
  Generation: new text, image, code, summary.

For PMs, the key question is: **What decision or product behavior will use this output?**

[!] Never use a neural network just because it is available. Always compare against simpler models. The question is not "can we use a neural network?" but "does this problem require one?"

>> The simplest model that solves the problem is usually the best model. Neural networks are for when the simpler models have been tried and found insufficient.$M9L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.2 — Neurons, Weights, Activation Functions, and Layers
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Neurons, Weights, Activation Functions, and Layers',
    2,
    $M9L2$WHAT IS A NEURON?

A neuron is the basic unit of a neural network. It:
  1. Takes input values.
  2. Multiplies each input by a weight (how important that signal is).
  3. Applies an activation function (transforms the result).
  4. Passes the output forward to the next layer.

**A neuron is a small calculator that combines signals and passes forward a transformed result.**


WHAT ARE WEIGHTS?

Weights decide how important each input is. During training, the model learns the weights.

Churn prediction example:
  Usage drop → high weight (strong churn signal)
  Payment failure → high weight (strong churn signal)
  Annual plan → negative weight (reduces churn risk)
  High engagement → negative weight (reduces churn risk)

If a feature helps prediction, the network increases its weight. If it is not useful, the weight becomes small.


WHAT IS AN ACTIVATION FUNCTION?

Without activation functions, even a deep neural network would behave like a simple linear model. Activation functions allow the network to learn non-linear patterns — curves, bends, and complex relationships.

Common activation functions:

  Sigmoid: outputs a value between 0 and 1. Used at the output layer for binary classification (churn probability = 0.78). Can cause training problems in deep networks.

  ReLU (Rectified Linear Unit): outputs 0 if input is negative, the input itself if positive. Simple and efficient. Most commonly used in hidden layers.

  Tanh: outputs values between -1 and 1. Similar to sigmoid but centered at zero.

  Softmax: used for multi-class output. Makes all class probabilities add up to 100%.
    Example: billing 70%, technical 20%, cancellation 10%.


WHAT ARE LAYERS?

  Input layer: receives raw features (customer data, pixels, words).
  Hidden layers: where the network learns patterns. Can learn intermediate representations — e.g., for churn: low engagement, frustration, price sensitivity.
  Output layer: gives the final prediction (probability, number, scores).

Deep learning = neural networks with many hidden layers. Each layer learns a different level of abstraction.

For images: edges → shapes → object parts → full objects.
For text: words → phrases → context → meaning.

[!] As a PM, you do not tune weights or activation functions. But understanding these concepts helps you ask sharp questions when reviewing model design and training decisions.

>> The network learns weights by seeing examples of what good predictions look like. Layers let it build complex understanding from simple signals.$M9L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.3 — How Training Works: Loss, Backpropagation, Gradient Descent
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'How Training Works: Loss, Backpropagation, Gradient Descent',
    3,
    $M9L3$WHAT IS LOSS?

Loss measures how wrong the model is on a given prediction.

Example:
  Actual: customer churned = yes.
  Model predicted: churn probability = 20%. Model was very wrong. Loss is high.

  Actual: customer churned = yes.
  Model predicted: churn probability = 90%. Model was mostly right. Loss is low.

Training tries to reduce loss. Common loss functions:
  Mean squared error → for regression (predicting numbers).
  Binary cross-entropy → for binary classification (churn/not churn).
  Categorical cross-entropy → for multi-class classification (ticket categories).

**Loss is the model's internal error score during training.**


WHAT IS BACKPROPAGATION?

After making a prediction, the model calculates the error. Then it sends the error backward through the network to update each weight.

The process:
  1. Model makes prediction.
  2. Model calculates how wrong it was (loss).
  3. Error is sent backward through layers.
  4. Each weight is adjusted to reduce the error.
  5. Model tries again on the next batch.
  6. Repeat many times.

**Backpropagation tells each part of the network how much it contributed to the mistake.**


WHAT IS GRADIENT DESCENT?

Gradient descent is how weights are updated.

Analogy: you are standing on a hill in fog. You want to reach the valley (lowest loss). You cannot see the whole mountain, but you can feel which direction slopes downward. So you take small steps downhill until you reach a lower point.

  The hill = the loss function.
  Downhill direction = direction that reduces loss.
  Step size = learning rate.


WHAT IS LEARNING RATE?

Learning rate controls how big each update step is.

Too high: the model jumps around and fails to converge.
Too low: the model learns too slowly or gets stuck.

An epoch is one full pass through the training data. More epochs can help learning — but too many cause overfitting.

A batch is the number of examples processed before each weight update. Smaller batches give noisier but faster updates.

[!] Training instability — where loss oscillates or does not decrease — is often a learning rate problem. A PM does not tune this, but should ask whether training converged smoothly.

>> Training is the model repeatedly seeing examples, being told how wrong it was, and adjusting every weight slightly to do better next time. Millions of tiny adjustments add up to learned patterns.$M9L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.4 — Overfitting, Regularization, Data Requirements, Label Quality
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Overfitting, Regularization, Data Requirements, Label Quality',
    4,
    $M9L4$WHAT IS OVERFITTING IN NEURAL NETWORKS?

Neural networks can have millions or billions of parameters (weights). This makes them extremely flexible — and prone to memorizing training data instead of learning general patterns.

Signs of overfitting:
  Training accuracy keeps improving.
  Validation/test accuracy stops improving or gets worse.
  Model works well on old data but poorly on new data.
  Model learns noise rather than true patterns.

Analogy: a student memorizes 1,000 practice questions but fails on a new exam because they memorized answers, not concepts.

PM question: "How does training performance compare with validation and test performance? Is the gap large?"


HOW TO REDUCE OVERFITTING

1. More data — the most reliable fix.
2. Regularization — penalizes complexity, discourages the model from memorizing.
3. Dropout — randomly disables some neurons during training, forcing the network not to depend too much on any one path.
4. Early stopping — halt training when validation performance stops improving.
5. Data augmentation — create variations of training examples (rotate/crop images, add noise to text).
6. Simpler model — fewer layers or neurons. Smaller models often generalize better when data is limited.


WHY NEURAL NETWORKS NEED A LOT OF DATA

Neural networks have many parameters to learn. Too little data → the model memorizes instead of generalizes.

Rule of thumb: if you have only a few thousand labeled examples, a random forest or logistic regression is often better. If you have millions of examples, a neural network may outperform simpler models significantly.

PM question: "Do we have enough labeled data for this model complexity?"


LABELED DATA QUALITY

For supervised neural networks, labels are critical. A network cannot learn the right patterns if labels are wrong.

Bad labels come from: human mistakes, inconsistent definitions, delayed outcomes, biased review processes, old policy definitions, ambiguous cases.

Examples:
  Defect labels from inconsistent human inspectors → model learns inconsistency.
  Churn labels with a wrong time window → model learns the wrong prediction target.

A neural network cannot fix bad labels. Powerful learning from bad data produces confident wrong predictions.

PM question: "How were labels created, and how reliable are they? What is the estimated label error rate?"

[!] Overfitting and label quality are the two most common hidden failure modes in neural network projects. A model that looks great in training may be completely wrong for the business.

>> Large models need large, clean data. If you do not have it, use a smaller model or collect better data first.$M9L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.5 — Key Architectures: MLP, CNN, RNN, Transformer
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Key Architectures: MLP, CNN, RNN, Transformer',
    5,
    $M9L5$Different problems need different neural network architectures. As a PM, you should know the four main families and when each applies.


FEEDFORWARD NEURAL NETWORK / MLP (MULTILAYER PERCEPTRON)

The simplest and most general architecture.

Information flows from input → hidden layers → output. No special structure for sequences or grids.

Best for: structured/tabular data (customer tables, transaction data, feature sets).

Example: churn prediction from customer usage features.

When it falls short: when the data has strong spatial structure (images) or temporal structure (sequences), specialized architectures do better.


CNN: CONVOLUTIONAL NEURAL NETWORK

Designed for grid-like data — primarily images.

CNNs learn local patterns (edges, textures, shapes) and combine them into higher-level features across layers.

Best for: image classification, defect detection, medical imaging, document scanning, video analysis.

Example: detecting defects in product photos.

PM use cases: visual quality control, content moderation, image tagging, optical character recognition.


RNN / LSTM: RECURRENT NEURAL NETWORK / LONG SHORT-TERM MEMORY

Designed for sequential data where order and timing matter.

RNNs process inputs one step at a time and maintain a memory of previous steps. LSTMs are a variant that handles longer dependencies better.

Best for: time series, older NLP tasks, sensor sequences, user activity streams.

Note: for most NLP tasks today, Transformers have largely replaced RNNs.


TRANSFORMER

The most important modern architecture — powers large language models, search, recommendations, and generative AI.

Transformers process the entire sequence at once (not step by step) and use attention mechanisms to learn which parts of the input matter most for each output.

Best for: language understanding and generation, code, search ranking, recommendations, multimodal applications (text + image).

Examples: GPT-style models, BERT, recommendation transformers, search ranking at scale.

[!] In 2024–2026, most state-of-the-art natural language, code, and multimodal systems are transformer-based. When your team mentions "LLMs," "foundation models," or "embedding models," they are using transformers.

PM question: "Which architecture is being used and why is it appropriate for this data type and problem?"

>> Architecture choice is a technical decision, but the PM should verify it matches the data modality. You would not use a CNN for tabular churn data or a simple MLP for image defect detection.$M9L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.6 — Neural Networks for Specific Problems: Classification, Regression, Ranking, Generation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Neural Networks for Specific Problems: Classification, Regression, Ranking, Generation',
    6,
    $M9L6$CLASSIFICATION

Output: class label or probability per class.

Examples: fraud/not fraud, churn/not churn, support ticket category, sentiment, defect type.

Metrics: accuracy, precision, recall, F1, AUC, PR AUC, confusion matrix, calibration.

Metric choice depends on cost of errors. For rare events, use PR AUC not accuracy.


REGRESSION

Output: a number.

Examples: demand forecast, customer lifetime value, delivery time, price estimate, wait time.

Metrics: MAE, RMSE, R², segment-level error, business metric impact.

Always compare against simpler regression baselines. Neural networks add value only when the relationship is complex enough to justify the extra cost.


RECOMMENDATION AND RANKING

Output: a ranked score for each item.

Examples: product recommendations, search results, content feed ranking, lead prioritization, candidate matching.

Technical metrics: NDCG, Precision@K, Recall@K, MAP, click prediction loss.
Business metrics: click-through rate, conversion, revenue, retention, user satisfaction, long-term engagement, diversity.

PM warning: recommendation models can optimize short-term clicks while hurting long-term trust or creating filter bubbles. Always define what "good recommendation" means before optimizing for a metric.


GENERATION

Output: new text, image, code, summary, translation.

Examples: customer-facing chatbots, email drafting, summarization, product description generation, code assistant.

Technical evaluation: human evaluation, factuality, relevance, safety, toxicity.
Business evaluation: user satisfaction, time saved, task completion rate, support deflection, cost, latency.

Generative models need special attention to hallucination, safety, privacy, copyright, and trust.


COMPARISON WITH SIMPLER MODELS

  Topic          | Logistic regression   | Random forest         | Neural network
  Pattern type   | Simpler, linear       | Non-linear, tabular   | Complex, any data type
  Explainability | High                  | Medium                | Low
  Data need      | Low                  | Medium                | Often high
  Training cost  | Low                  | Medium                | High
  Best use       | Explainable baseline  | Structured prediction | Images, text, deep personalization

[!] For structured tabular problems, random forests and gradient boosting often match or beat neural networks and are far cheaper to build, explain, and maintain. Justify the neural network.

>> The right model is the simplest one that solves the problem. If a random forest gets the job done, use it.$M9L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.7 — Metrics, Calibration, Latency, and Cost
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Metrics, Calibration, Latency, and Cost',
    7,
    $M9L7$OFFLINE VS. ONLINE METRICS

Offline metrics: measured before launch using validation/test data.
  Examples: AUC, RMSE, recall, NDCG.
  These tell you whether the model works on historical data.

Online metrics: measured after launch in the real product.
  Examples: conversion, revenue, retention, customer satisfaction, support contacts, manual review volume.

A neural network can perform well offline and still fail online because:
  User behavior changes.
  Model output changes the product experience in unexpected ways.
  Latency is too high.
  Recommendations feel repetitive.
  False positives erode trust.
  The model optimizes the wrong goal (clicks vs. satisfaction).

PM question: "What online experiment or pilot will prove this model actually improves the product?"


CALIBRATION

Calibration means predicted probabilities match real-world frequencies.

Example: the model outputs 80% churn risk. Do approximately 80 out of 100 customers at that score actually churn? If yes, the model is calibrated.

Calibration matters when:
  You use probability thresholds for decisions.
  You price risk.
  You communicate probability to users or teams.
  You compare scores across different segments.

A neural network may rank cases correctly (high AUC) but still produce poorly calibrated probabilities.

PM question: "Are we using the output as a ranking score or as a true probability? If the latter, was calibration validated?"


LATENCY AND COST

Neural networks can be expensive to train and serve.

  Training cost: the compute cost of teaching the model.
  Inference cost: the cost of running the model per prediction.

If a model powers real-time recommendations, it must respond in milliseconds. A large model may be accurate but too slow or expensive for the product.

PM questions:
  What is the latency requirement (real-time vs. batch)?
  How much does each prediction cost?
  Can we cache predictions?
  Can we use a smaller model with acceptable accuracy?
  Does the accuracy gain justify the infrastructure cost?

[!] A model that is 2% more accurate but 10× more expensive to serve may not be the right choice. Cost and latency are product requirements, not just engineering concerns.

>> Accuracy on a test set is free. Accuracy in production has a cost. Understand the cost before choosing the model.$M9L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.8 — Interpretability, Bias, Leakage, Drift, and Feedback Loops
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Interpretability, Bias, Leakage, Drift, and Feedback Loops',
    8,
    $M9L8$INTERPRETABILITY PROBLEM

A logistic regression model can say: "Payment failure increases churn odds."
A decision tree can say: "If usage is low and support tickets are high, churn risk is high."

A neural network may have millions of learned weights. Direct explanation is harder.

For high-stakes decisions — credit, hiring, medical, insurance, legal — this matters a great deal.

PM questions:
  Does this use case require individual prediction explanations?
  Is a simpler model acceptable for the required accuracy level?
  Can we use SHAP, LIME, or feature attribution methods?
  Should a human review high-impact decisions?


BIAS AND FAIRNESS

Neural networks learn from data. If the data contains bias, the model learns bias.

Examples of bias sources:
  Historical decisions were made unfairly.
  Labels reflect biased human judgment.
  Some groups are underrepresented in training data.
  Data quality differs by group.
  Feedback loops reinforce old behavior.

A model may perform well overall but poorly for certain groups.

PM questions:
  Does the model perform equally well across important segments?
  Are some users harmed more by false positives or false negatives?
  Are protected attributes used directly or indirectly via proxies?
  Are we monitoring fairness after launch?


DATA LEAKAGE

Data leakage happens when the model uses information not available at prediction time.

Example: predicting churn using "cancellation request submitted" — a feature that directly reveals the answer.

Neural networks are powerful and will exploit leakage very effectively, making test performance look amazing but failing completely in production.

PM question: "Would every feature be available at the exact moment the prediction is made?"


DRIFT

Model drift means performance degrades over time because the world changes.

Examples: user behavior changes, new competitors enter, product UI changes, fraud patterns evolve, economic conditions shift.

Track after launch: prediction distribution, input feature distribution, accuracy on fresh labels, business metrics, segment performance, latency and cost, user complaints.

PM question: "When will we retrain, update, or retire this model?"


FEEDBACK LOOPS

Neural network systems can create feedback loops.

Example: a recommendation model shows certain products more. Those products get more clicks. The model learns they are popular and shows them even more — reducing diversity and reinforcing early choices.

Other examples: search rankings reinforce top results; content feeds over-optimize for engagement; fraud models change attacker behavior; lead scoring biases future labels by changing which leads receive sales attention.

PM questions:
  Does the model influence the data it later learns from?
  Are we measuring long-term effects vs. short-term metrics?
  Are we preserving exploration and diversity?

[!] Feedback loops are the long-term risk that offline metrics cannot measure. A model with excellent AUC can still slowly degrade the product experience through self-reinforcing patterns.

>> Interpretability, fairness, leakage, drift, and feedback loops are all PM responsibilities — not just data science concerns. Own them.$M9L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.9 — Four Real Product Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Four Real Product Examples',
    9,
    $M9L9$EXAMPLE 1: CHURN PREDICTION

Model: feedforward neural network (MLP) on tabular data.
Inputs: usage frequency, usage decline, days since last login, support tickets, payment failures, plan type, feature adoption, tenure, email engagement.
Output: churn probability = 82%.

Actions: retention offer, customer success outreach, product education, plan recommendation.

Technical metrics: AUC, precision, recall, F1, PR AUC, calibration, lift at top decile.
Business metrics: churn reduction, retained revenue, offer ROI, save rate.

Key PM questions:
  Is this better than logistic regression or random forest? Does the extra complexity improve business impact?
  Are probabilities calibrated for threshold decisions?
  How many customers are flagged? Can the team act on that volume?


EXAMPLE 2: PRODUCT RECOMMENDATION

Model: neural recommendation model (often transformer or two-tower architecture).
Inputs: user past behavior, item metadata, click history, purchase history, search signals, similar users/items, context.
Output: ranked list of items.

Technical metrics: Precision@K, Recall@K, NDCG, click prediction loss.
Business metrics: click-through rate, conversion, revenue, retention, long-term engagement, diversity.

Key PM questions:
  Are we optimizing clicks, purchases, satisfaction, or long-term retention — and are those the same?
  Are recommendations too repetitive? Are we creating filter bubbles?
  Are new items getting exposure, or does the model only surface already-popular content?


EXAMPLE 3: SUPPORT TICKET CLASSIFICATION

Model: neural text classifier (MLP on embeddings, or fine-tuned transformer).
Inputs: ticket subject, ticket body, customer history, language, sentiment.
Output: billing 75%, technical 15%, cancellation 10%.

Actions: route to correct team, suggest help article, prioritize urgent tickets, auto-tag issue type.

Technical metrics: accuracy, precision/recall per class, F1, confusion matrix.
Business metrics: faster routing, lower resolution time, lower support cost, fewer escalations.

Key PM questions:
  Which misclassification type is most costly?
  Does it work for rare ticket types and across languages?
  How will agent feedback be used to improve labels over time?


EXAMPLE 4: DEFECT DETECTION FROM IMAGES

Model: CNN (convolutional neural network).
Inputs: product images.
Output: defect probability = 94%.

Actions: send to manual inspection, reject item, trigger supplier review, route to quality team.

Technical metrics: precision, recall, F1, PR AUC, false negative rate.
Business metrics: defects caught, customer complaints reduced, inspection cost, return reduction.

Key PM questions:
  Is missing a defect worse than a false alarm? What are the safety implications?
  How were image labels created? Are they consistent across inspectors?
  Does it work across different lighting, angles, and product variants?
  What confidence level requires mandatory human review?

[!] Each example connects model output → threshold → tiered action → team capacity → business metric. That chain is the PM deliverable — not just the model accuracy number.

>> Build the action system, not just the model. A neural network that produces predictions no one acts on is a science experiment, not a product.$M9L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.10 — Common Failure Modes
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Common Failure Modes',
    10,
    $M9L10$Understanding how neural networks fail helps PMs catch problems before they reach production.


1. NOT ENOUGH DATA
The model overfits on training data and fails to generalize.
PM question: "Do we have enough labeled examples for this model complexity?"


2. POOR LABEL QUALITY
The model learns inconsistent or wrong patterns because labels are noisy.
PM question: "How were labels created? What is the estimated error rate in the labels?"


3. WRONG METRIC
The model optimizes a technical metric that does not improve the product or business.
PM question: "Does improving this metric actually improve the business outcome we care about?"


4. OVERFITTING
Great training performance, weak test or production performance.
PM question: "What is the gap between training and validation performance?"


5. DATA LEAKAGE
The model uses future or unavailable information, inflating test results.
PM question: "Would every feature be available at prediction time in production?"


6. POOR CALIBRATION
Scores are useful for ranking but not trustworthy as true probabilities.
PM question: "Do we need calibrated probabilities, or are we using scores for ranking only?"


7. HIGH LATENCY
The model is too slow for the required product experience.
PM question: "What is the latency requirement, and does the model meet it?"


8. HIGH SERVING COST
The model is too expensive to run at the required scale.
PM question: "What is the cost per inference, and does the accuracy gain justify it?"


9. WEAK INTERPRETABILITY
Stakeholders cannot understand or trust predictions for high-stakes decisions.
PM question: "Do we need to explain individual predictions, and what explanation method is available?"


10. BIAS AND FAIRNESS ISSUES
The model performs better for some groups than others, causing unfair outcomes.
PM question: "Does the model perform equally well across important user segments?"


11. DRIFT
Performance decays after launch as the world changes.
PM question: "How will we monitor model performance over time, and when will we retrain?"


12. FEEDBACK LOOPS
The model influences the data it later learns from, creating self-reinforcing patterns.
PM question: "Are we measuring long-term effects, and are we preserving exploration and diversity?"

[!] These twelve failure modes are not rare edge cases — they are the normal risks in any neural network project. Review this list before every model launch.

>> A model that avoids these twelve pitfalls is worth shipping. A model that falls into even one of them may cause more harm than no model at all.$M9L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 9.11 — PM Checklist, How to Explain, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist, How to Explain, and the Memory Shortcut',
    11,
    $M9L11$PM CHECKLIST FOR NEURAL NETWORKS

1.  What exact problem are we solving?
2.  Is it classification, regression, ranking, generation, or detection?
3.  What is the target and the positive class?
4.  What are the inputs? Structured, image, text, audio, or sequence?
5.  How much labeled data do we have?
6.  How reliable are the labels?
7.  What simpler models did we compare against?
8.  Does the neural network meaningfully outperform the baseline?
9.  Which offline metrics matter?
10. Which business metrics should improve?
11. How does training performance compare with validation/test performance? (overfitting check)
12. Is the model calibrated?
13. What threshold or ranking rule converts output into action?
14. What is the cost of false positives?
15. What is the cost of false negatives?
16. How does performance vary by segment?
17. Is the model explainable enough for this use case?
18. Are there bias or fairness concerns?
19. Are all features available at prediction time? (leakage check)
20. What is inference latency?
21. What is serving cost?
22. How will the model be monitored after launch?
23. How often will it be retrained?
24. What happens when the model is uncertain?
25. Is there human review for high-impact decisions?
26. Could feedback loops affect the model over time?
27. What is the online experiment or pilot plan?
28. What product decision improves because of this model?


HOW TO EXPLAIN TO LEADERSHIP

Simple version:
  "We used a neural network because the problem involves complex patterns that simpler models do not capture well. The model processes input signals through multiple layers and learns hidden relationships that help predict the target outcome. We compared it with simpler baselines, validated it on unseen data, and will measure success using both model metrics and business outcomes."

Churn example:
  "The neural network predicts churn risk using usage, support, payment, and engagement signals. It outperforms our logistic regression baseline, especially for identifying the highest-risk customers. Because the model is less interpretable, we will monitor segment-level performance, calibration, and intervention ROI during the pilot."

Recommendation example:
  "The recommendation model ranks items based on user behavior and item features. Offline ranking metrics improved. We will make the launch decision based on online results — conversion, retention, satisfaction, and long-term engagement — because offline metrics alone cannot confirm the model improves the product experience."


THE MEMORY SHORTCUT

A neural network is: **a layered model that learns complex patterns from data.**

  Inputs → neurons → hidden layers → activation functions → output prediction

Use it when: patterns are complex, you have a lot of data, simpler models are not enough, you work with images/text/audio/video/recommendations, or you need learned representations.

Measure it with: classification metrics, regression metrics, ranking metrics, calibration, segment performance, latency, cost, and business impact.

Watch for: too little data, bad labels, overfitting, data leakage, poor calibration, high cost, high latency, low interpretability, bias and fairness issues, drift, and feedback loops.

The most important PM question:
  **Does the neural network create enough extra business value to justify its complexity, cost, and reduced interpretability?**$M9L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 9.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'When should a PM push back on using a neural network?',
    '["When a simpler model like logistic regression or random forest achieves comparable performance at lower cost and complexity","When the dataset has more than 1 million rows — neural networks only work on smaller datasets","When the problem involves binary classification rather than multi-class","When the team does not have a GPU available for training"]',
    0
  );

  -- Q2 — Lesson 9.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'What is the purpose of an activation function in a neural network?',
    '["It allows the network to learn non-linear patterns — without it, even many layers would behave like a single linear model","It reduces the number of parameters the model needs to learn","It measures how wrong the model''s prediction is during training","It selects which features to include in the input layer"]',
    0
  );

  -- Q3 — Lesson 9.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'What does backpropagation do during neural network training?',
    '["It sends the prediction error backward through the network to adjust each weight, reducing the mistake on the next iteration","It randomly restarts training when the model gets stuck in a bad state","It reduces the learning rate automatically as training progresses","It splits the training data into batches before each epoch"]',
    0
  );

  -- Q4 — Lesson 9.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'A neural network achieves 99% accuracy on training data and 71% on the test set. What does this indicate?',
    '["Overfitting — the model memorized the training data rather than learning general patterns","Underfitting — the model is too small to capture the complexity of the data","The learning rate is too high and needs to be reduced","The test set is too small to give a reliable accuracy estimate"]',
    0
  );

  -- Q5 — Lesson 9.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A team wants to automatically detect defects in product photos. Which neural network architecture is most appropriate?',
    '["CNN — convolutional neural networks are designed for grid-like image data and learn visual patterns like edges, textures, and shapes","MLP — feedforward networks are best for all visual tasks because they are the simplest architecture","RNN — recurrent networks process images as sequential pixel streams","Transformer — all modern ML problems should use transformers regardless of data type"]',
    0
  );

  -- Q6 — Lesson 9.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A recommendation model is optimized for click-through rate and achieves excellent results. Users start complaining about repetitive and boring recommendations. What is the likely cause?',
    '["The model optimized clicks but created a filter bubble — maximizing one short-term metric degraded long-term satisfaction and diversity","The model is overfitting to the training data","The model needs more user history features to improve diversity","Click-through rate is the correct metric and complaints do not reflect model quality"]',
    0
  );

  -- Q7 — Lesson 9.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'A churn model has excellent offline AUC but in production it does not reduce actual churn. What should the PM investigate first?',
    '["The gap between offline and online metrics — the model may optimize historical patterns without translating to real behavior change, or the intervention triggered by the score may be ineffective","The model needs more training data to improve offline AUC further","The latency is too high and predictions arrive too late to be useful","The batch size used during training was too large"]',
    0
  );

  -- Q8 — Lesson 9.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A credit scoring neural network performs well overall but has 30% higher false rejection rate for one demographic group. What should happen before launch?',
    '["Pause launch and investigate whether the model has a fairness problem — disparate impact on a protected group may be legally and ethically unacceptable","Launch with the current model and monitor after deployment","Retrain with a higher learning rate to improve overall accuracy","Remove demographic features from the input and retrain without investigating further"]',
    0
  );

  -- Q9 — Lesson 9.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A ticket classification neural network has 91% overall accuracy. Support agents report that escalation tickets are misrouted 45% of the time. What should the PM do?',
    '["Evaluate per-class precision and recall — overall accuracy hides the failure on the rarest and most important ticket type","Retrain the model with more epochs to improve overall accuracy","Switch to a simpler logistic regression model since the neural network is clearly broken","Accept the result since 91% overall accuracy meets the initial success threshold"]',
    0
  );

  -- Q10 — Lesson 9.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A fraud detection neural network uses a feature called "dispute resolution status" which is only known after a chargeback is filed. The model achieves 99.8% precision on the test set. What is the problem?',
    '["Data leakage — dispute resolution status is not available at prediction time (before the transaction is processed), so the model is exploiting future information and will fail in production","The model is overfitting because precision is too high","The feature is fine since it correlates strongly with fraud","The team should increase the threshold to reduce precision and improve recall"]',
    0
  );

  -- Q11 — Lesson 9.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'What is the most important PM question for any neural network project?',
    '["Does the neural network create enough extra business value to justify its complexity, cost, and reduced interpretability?","How many hidden layers does the architecture use?","What activation function was applied in the output layer?","Was the model trained using gradient descent or a different optimizer?"]',
    0
  );

end $$;
