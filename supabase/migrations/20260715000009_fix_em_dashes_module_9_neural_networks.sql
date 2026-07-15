-- Fix em dashes introduced by earlier typography-styling migrations.
-- AI/ML for Builders / Module 9: Neural Networks
-- Replaces markdown glossary "**Term** — Definition" with "**Term**: Definition",
-- and general prose " — " with ", ". Titles use " - " (spaced hyphen).

update modules set description = $M$Learn how neural networks learn complex patterns through layers of connected units, and how to evaluate, apply, and communicate about them as a PM.$M$ where id = '72d67f7c-8048-43f7-8e1a-95973c63ea97';

update lessons set content = $Da2f8d2fb_7397_4c70_8a97_be9810aed49c$A neural network is a machine learning model designed to learn complex patterns from data.

**A neural network takes inputs, passes them through layers of calculations, and produces a prediction.**

Examples: predict churn, detect image defects, recommend products, classify support tickets, detect fraud, understand text, recognize speech, predict demand, generate content.


WHY DO WE NEED NEURAL NETWORKS?

Simpler models like linear regression and decision trees are useful, but they can struggle when patterns are very complex.

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
  Sequence data: ordered events, user activity, purchase history, sensor readings.

Each input type usually needs the right neural network architecture.


WHAT COMES OUT?

  Binary classification: churn probability = 78%.
  Multi-class classification: support ticket → billing 70%, technical 20%, cancellation 10%.
  Regression: predicted demand = 12,500 units.
  Ranking/recommendation: product scores for ordering a feed.
  Generation: new text, image, code, summary.

For PMs, the key question is: **What decision or product behavior will use this output?**

[!] Never use a neural network just because it is available. Always compare against simpler models. The question is not "can we use a neural network?" but "does this problem require one?"

>> The simplest model that solves the problem is usually the best model. Neural networks are for when the simpler models have been tried and found insufficient.$Da2f8d2fb_7397_4c70_8a97_be9810aed49c$ where id = 'a2f8d2fb-7397-4c70-8a97-be9810aed49c';

update lessons set content = $Dc94b83e3_2a77_4ac9_a945_4d33724e7ed3$WHAT IS A NEURON?

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

Without activation functions, even a deep neural network would behave like a simple linear model. Activation functions allow the network to learn non-linear patterns, curves, bends, and complex relationships.

Common activation functions:

  Sigmoid: outputs a value between 0 and 1. Used at the output layer for binary classification (churn probability = 0.78). Can cause training problems in deep networks.

  ReLU (Rectified Linear Unit): outputs 0 if input is negative, the input itself if positive. Simple and efficient. Most commonly used in hidden layers.

  Tanh: outputs values between -1 and 1. Similar to sigmoid but centered at zero.

  Softmax: used for multi-class output. Makes all class probabilities add up to 100%.
    Example: billing 70%, technical 20%, cancellation 10%.


WHAT ARE LAYERS?

  Input layer: receives raw features (customer data, pixels, words).
  Hidden layers: where the network learns patterns. Can learn intermediate representations, e.g., for churn: low engagement, frustration, price sensitivity.
  Output layer: gives the final prediction (probability, number, scores).

Deep learning = neural networks with many hidden layers. Each layer learns a different level of abstraction.

For images: edges → shapes → object parts → full objects.
For text: words → phrases → context → meaning.

[!] As a PM, you do not tune weights or activation functions. But understanding these concepts helps you ask sharp questions when reviewing model design and training decisions.

>> The network learns weights by seeing examples of what good predictions look like. Layers let it build complex understanding from simple signals.$Dc94b83e3_2a77_4ac9_a945_4d33724e7ed3$ where id = 'c94b83e3-2a77-4ac9-a945-4d33724e7ed3';

update lessons set content = $D3962bfcc_0996_42a4_a338_2d5e0f374871$WHAT IS LOSS?

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

An epoch is one full pass through the training data. More epochs can help learning, but too many cause overfitting.

A batch is the number of examples processed before each weight update. Smaller batches give noisier but faster updates.

[!] Training instability, where loss oscillates or does not decrease, is often a learning rate problem. A PM does not tune this, but should ask whether training converged smoothly.

>> Training is the model repeatedly seeing examples, being told how wrong it was, and adjusting every weight slightly to do better next time. Millions of tiny adjustments add up to learned patterns.$D3962bfcc_0996_42a4_a338_2d5e0f374871$ where id = '3962bfcc-0996-42a4-a338-2d5e0f374871';

update lessons set content = $D6e2b567c_b075_4afe_8112_7cfacb4d6edc$WHAT IS OVERFITTING IN NEURAL NETWORKS?

Neural networks can have millions or billions of parameters (weights). This makes them extremely flexible, and prone to memorizing training data instead of learning general patterns.

Signs of overfitting:
  Training accuracy keeps improving.
  Validation/test accuracy stops improving or gets worse.
  Model works well on old data but poorly on new data.
  Model learns noise rather than true patterns.

Analogy: a student memorizes 1,000 practice questions but fails on a new exam because they memorized answers, not concepts.

PM question: "How does training performance compare with validation and test performance? Is the gap large?"


HOW TO REDUCE OVERFITTING

1. More data, the most reliable fix.
2. Regularization, penalizes complexity, discourages the model from memorizing.
3. Dropout, randomly disables some neurons during training, forcing the network not to depend too much on any one path.
4. Early stopping, halt training when validation performance stops improving.
5. Data augmentation, create variations of training examples (rotate/crop images, add noise to text).
6. Simpler model, fewer layers or neurons. Smaller models often generalize better when data is limited.


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

>> Large models need large, clean data. If you do not have it, use a smaller model or collect better data first.$D6e2b567c_b075_4afe_8112_7cfacb4d6edc$ where id = '6e2b567c-b075-4afe-8112-7cfacb4d6edc';

update lessons set content = $D18bddb46_7d24_4ceb_a805_216874829420$Different problems need different neural network architectures. As a PM, you should know the four main families and when each applies.


FEEDFORWARD NEURAL NETWORK / MLP (MULTILAYER PERCEPTRON)

The simplest and most general architecture.

Information flows from input → hidden layers → output. No special structure for sequences or grids.

Best for: structured/tabular data (customer tables, transaction data, feature sets).

Example: churn prediction from customer usage features.

When it falls short: when the data has strong spatial structure (images) or temporal structure (sequences), specialized architectures do better.


CNN: CONVOLUTIONAL NEURAL NETWORK

Designed for grid-like data, primarily images.

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

The most important modern architecture, powers large language models, search, recommendations, and generative AI.

Transformers process the entire sequence at once (not step by step) and use attention mechanisms to learn which parts of the input matter most for each output.

Best for: language understanding and generation, code, search ranking, recommendations, multimodal applications (text + image).

Examples: GPT-style models, BERT, recommendation transformers, search ranking at scale.

[!] In 2024–2026, most state-of-the-art natural language, code, and multimodal systems are transformer-based. When your team mentions "LLMs," "foundation models," or "embedding models," they are using transformers.

PM question: "Which architecture is being used and why is it appropriate for this data type and problem?"

>> Architecture choice is a technical decision, but the PM should verify it matches the data modality. You would not use a CNN for tabular churn data or a simple MLP for image defect detection.$D18bddb46_7d24_4ceb_a805_216874829420$ where id = '18bddb46-7d24-4ceb-a805-216874829420';

update lessons set content = $D0a6846e0_1b0f_4cdd_909e_92dc578ace7c$INTERPRETABILITY PROBLEM

A logistic regression model can say: "Payment failure increases churn odds."
A decision tree can say: "If usage is low and support tickets are high, churn risk is high."

A neural network may have millions of learned weights. Direct explanation is harder.

For high-stakes decisions, credit, hiring, medical, insurance, legal, this matters a great deal.

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

Example: predicting churn using "cancellation request submitted", a feature that directly reveals the answer.

Neural networks are powerful and will exploit leakage very effectively, making test performance look amazing but failing completely in production.

PM question: "Would every feature be available at the exact moment the prediction is made?"


DRIFT

Model drift means performance degrades over time because the world changes.

Examples: user behavior changes, new competitors enter, product UI changes, fraud patterns evolve, economic conditions shift.

Track after launch: prediction distribution, input feature distribution, accuracy on fresh labels, business metrics, segment performance, latency and cost, user complaints.

PM question: "When will we retrain, update, or retire this model?"


FEEDBACK LOOPS

Neural network systems can create feedback loops.

Example: a recommendation model shows certain products more. Those products get more clicks. The model learns they are popular and shows them even more, reducing diversity and reinforcing early choices.

Other examples: search rankings reinforce top results; content feeds over-optimize for engagement; fraud models change attacker behavior; lead scoring biases future labels by changing which leads receive sales attention.

PM questions:
  Does the model influence the data it later learns from?
  Are we measuring long-term effects vs. short-term metrics?
  Are we preserving exploration and diversity?

[!] Feedback loops are the long-term risk that offline metrics cannot measure. A model with excellent AUC can still slowly degrade the product experience through self-reinforcing patterns.

>> Interpretability, fairness, leakage, drift, and feedback loops are all PM responsibilities, not just data science concerns. Own them.$D0a6846e0_1b0f_4cdd_909e_92dc578ace7c$ where id = '0a6846e0-1b0f-4cdd-909e-92dc578ace7c';

update lessons set content = $D2696e9b3_b900_4197_9245_f14e1cd41923$EXAMPLE 1: CHURN PREDICTION

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
  Are we optimizing clicks, purchases, satisfaction, or long-term retention, and are those the same?
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

[!] Each example connects model output → threshold → tiered action → team capacity → business metric. That chain is the PM deliverable, not just the model accuracy number.

>> Build the action system, not just the model. A neural network that produces predictions no one acts on is a science experiment, not a product.$D2696e9b3_b900_4197_9245_f14e1cd41923$ where id = '2696e9b3-b900-4197-9245-f14e1cd41923';

update lessons set content = $D65dbde9f_b062_41ee_946c_e78b2459714c$Understanding how neural networks fail helps PMs catch problems before they reach production.


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

[!] These twelve failure modes are not rare edge cases, they are the normal risks in any neural network project. Review this list before every model launch.

>> A model that avoids these twelve pitfalls is worth shipping. A model that falls into even one of them may cause more harm than no model at all.$D65dbde9f_b062_41ee_946c_e78b2459714c$ where id = '65dbde9f-b062-41ee-946c-e78b2459714c';

update lessons set content = $D3ce5f0dd_d46d_4a64_ad4a_afb06a3d20e9$PM CHECKLIST FOR NEURAL NETWORKS

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
  "The recommendation model ranks items based on user behavior and item features. Offline ranking metrics improved. We will make the launch decision based on online results, conversion, retention, satisfaction, and long-term engagement, because offline metrics alone cannot confirm the model improves the product experience."


THE MEMORY SHORTCUT

A neural network is: **a layered model that learns complex patterns from data.**

  Inputs → neurons → hidden layers → activation functions → output prediction

Use it when: patterns are complex, you have a lot of data, simpler models are not enough, you work with images/text/audio/video/recommendations, or you need learned representations.

Measure it with: classification metrics, regression metrics, ranking metrics, calibration, segment performance, latency, cost, and business impact.

Watch for: too little data, bad labels, overfitting, data leakage, poor calibration, high cost, high latency, low interpretability, bias and fairness issues, drift, and feedback loops.

The most important PM question:
  **Does the neural network create enough extra business value to justify its complexity, cost, and reduced interpretability?**$D3ce5f0dd_d46d_4a64_ad4a_afb06a3d20e9$ where id = '3ce5f0dd-d46d-4a64-ad4a-afb06a3d20e9';

update questions set choices = $D5b1ddf02_8663_4869_b125_2133777b0160Q$["When a simpler model like logistic regression or random forest achieves comparable performance at lower cost and complexity","When the dataset has more than 1 million rows, neural networks only work on smaller datasets","When the problem involves binary classification rather than multi-class","When the team does not have a GPU available for training"]$D5b1ddf02_8663_4869_b125_2133777b0160Q$::jsonb where id = '5b1ddf02-8663-4869-b125-2133777b0160';

update questions set choices = $D9cd46cc5_531c_42f7_806d_f01a7261a52fQ$["It allows the network to learn non-linear patterns, without it, even many layers would behave like a single linear model","It reduces the number of parameters the model needs to learn","It measures how wrong the model's prediction is during training","It selects which features to include in the input layer"]$D9cd46cc5_531c_42f7_806d_f01a7261a52fQ$::jsonb where id = '9cd46cc5-531c-42f7-806d-f01a7261a52f';

update questions set choices = $D1550c6e3_4703_4af0_8dbe_bb40e52502ecQ$["Overfitting, the model memorized the training data rather than learning general patterns","Underfitting, the model is too small to capture the complexity of the data","The learning rate is too high and needs to be reduced","The test set is too small to give a reliable accuracy estimate"]$D1550c6e3_4703_4af0_8dbe_bb40e52502ecQ$::jsonb where id = '1550c6e3-4703-4af0-8dbe-bb40e52502ec';

update questions set choices = $D6a5bd2c7_7572_4fc8_9699_012091ccfd95Q$["CNN, convolutional neural networks are designed for grid-like image data and learn visual patterns like edges, textures, and shapes","MLP, feedforward networks are best for all visual tasks because they are the simplest architecture","RNN, recurrent networks process images as sequential pixel streams","Transformer, all modern ML problems should use transformers regardless of data type"]$D6a5bd2c7_7572_4fc8_9699_012091ccfd95Q$::jsonb where id = '6a5bd2c7-7572-4fc8-9699-012091ccfd95';

update questions set choices = $D0a6aad3f_30a4_4dd3_99a2_4c43e7280a6bQ$["The model optimized clicks but created a filter bubble, maximizing one short-term metric degraded long-term satisfaction and diversity","The model is overfitting to the training data","The model needs more user history features to improve diversity","Click-through rate is the correct metric and complaints do not reflect model quality"]$D0a6aad3f_30a4_4dd3_99a2_4c43e7280a6bQ$::jsonb where id = '0a6aad3f-30a4-4dd3-99a2-4c43e7280a6b';

update questions set choices = $D0f07f722_317e_4ae0_8935_d95d990241e3Q$["The gap between offline and online metrics, the model may optimize historical patterns without translating to real behavior change, or the intervention triggered by the score may be ineffective","The model needs more training data to improve offline AUC further","The latency is too high and predictions arrive too late to be useful","The batch size used during training was too large"]$D0f07f722_317e_4ae0_8935_d95d990241e3Q$::jsonb where id = '0f07f722-317e-4ae0-8935-d95d990241e3';

update questions set choices = $D6d209230_2f3e_404b_b51e_726ef38761cfQ$["Pause launch and investigate whether the model has a fairness problem, disparate impact on a protected group may be legally and ethically unacceptable","Launch with the current model and monitor after deployment","Retrain with a higher learning rate to improve overall accuracy","Remove demographic features from the input and retrain without investigating further"]$D6d209230_2f3e_404b_b51e_726ef38761cfQ$::jsonb where id = '6d209230-2f3e-404b-b51e-726ef38761cf';

update questions set choices = $Daca7f73f_6acd_44c8_a3e9_e8ac905659bcQ$["Evaluate per-class precision and recall, overall accuracy hides the failure on the rarest and most important ticket type","Retrain the model with more epochs to improve overall accuracy","Switch to a simpler logistic regression model since the neural network is clearly broken","Accept the result since 91% overall accuracy meets the initial success threshold"]$Daca7f73f_6acd_44c8_a3e9_e8ac905659bcQ$::jsonb where id = 'aca7f73f-6acd-44c8-a3e9-e8ac905659bc';

update questions set choices = $D7dbca801_eff5_4683_a5cb_eee982bdd314Q$["Data leakage, dispute resolution status is not available at prediction time (before the transaction is processed), so the model is exploiting future information and will fail in production","The model is overfitting because precision is too high","The feature is fine since it correlates strongly with fraud","The team should increase the threshold to reduce precision and improve recall"]$D7dbca801_eff5_4683_a5cb_eee982bdd314Q$::jsonb where id = '7dbca801-eff5-4683-a5cb-eee982bdd314';
