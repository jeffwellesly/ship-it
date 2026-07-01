-- ML for Everyone — Module 10: CNNs / Convolutional Neural Networks
-- 11 lessons covering CNNs from a PM perspective

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
    'Module 10: CNNs / Convolutional Neural Networks',
    'Learn how convolutional neural networks learn visual patterns from images — and how to evaluate, apply, and communicate about them as a PM.',
    10
  ) returning id into v_module_id;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.1 — What Is a CNN, Why Images Are Different, and When to Use One
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'What Is a CNN, Why Images Are Different, and When to Use One',
    1,
    $M10L1$A CNN — Convolutional Neural Network — is a type of neural network designed for image and video problems.

**A CNN looks at an image and learns visual patterns.**

Examples:
  Is this product image good or defective?
  Does this medical scan show a tumor?
  Is this document a passport, invoice, or receipt?
  Is there a car, person, or traffic sign in this image?
  Does this manufacturing photo show a crack?


WHY IMAGES ARE DIFFERENT FROM TABLE DATA

In normal tabular data, each row has columns: age, purchases, churned.

An image is made of pixels. A small image may have thousands of pixels. A large image may have millions.

Each pixel has values for color and brightness. A color image usually has red, green, and blue channels.

So instead of simple columns, the input is a grid: 224 × 224 × 3.

A CNN is useful because it understands this grid-like structure.

A normal neural network treats every input as a flat list of numbers. If we flatten an image, we lose spatial structure — the model no longer knows that nearby pixels are related.

A CNN keeps the image structure. It understands:
  Nearby pixels matter together
  Patterns can appear anywhere in the image
  Small patterns combine into larger patterns

This makes CNNs much more efficient for images.


THE SIMPLEST MENTAL MODEL

Imagine looking at a picture of a cat. You do not recognize the cat all at once. Your brain notices small visual clues: edges, curves, fur texture, eyes, ears, whiskers, face shape, body shape.

A CNN works similarly:
  Early layers learn simple patterns like edges and corners.
  Middle layers learn shapes and textures.
  Later layers learn object parts.
  Final layers learn the full object.


WHEN TO USE A CNN

Use CNNs when the input is visual or grid-like.

| Use case                | Input               | Output                 |
| Image classification    | Image               | Category               |
| Defect detection        | Product photo       | Defect / no defect     |
| Medical imaging         | X-ray, MRI, CT scan | Risk category          |
| Document classification | Scanned document    | Invoice / receipt / ID |
| Object detection        | Image               | Object locations       |
| Quality inspection      | Manufacturing image | Pass / fail            |

CNNs are especially useful when the visual location of a pattern matters — a scratch on a product may appear anywhere in the image, and a CNN learns to detect it wherever it is.

[!] Do not automatically use a CNN. For structured tabular business problems, logistic regression, random forests, or gradient boosting are often simpler, cheaper, and easier to explain. CNNs are for visual data.

>> Use a CNN when your input is an image or video and you need to detect, classify, or locate visual patterns.$M10L1$
  ) returning id into v_l1;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.2 — Inputs, Outputs, and CNN Outputs by Task Type
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Inputs, Outputs, and CNN Outputs by Task Type',
    2,
    $M10L2$WHAT GOES IN?

The input is usually an image represented as numbers.

A 224 × 224 color image has:
  Width = 224 pixels
  Height = 224 pixels
  Channels = 3 (red, green, blue)
  Input shape: 224 × 224 × 3

For grayscale images: 224 × 224 × 1
For video: 30 frames × height × width × channels

Image models require preprocessing before training: resizing, normalizing pixel values, and handling channel order.


WHAT COMES OUT?

The output depends on the problem.

IMAGE CLASSIFICATION
Output: one category.
Example: Dog 90%, Cat 7%, Horse 3% → final prediction: Dog.

BINARY CLASSIFICATION
Output: yes/no probability.
Example: Defect probability = 94%

OBJECT DETECTION
Output: object type + location.
Example: Person detected at this box. Car detected at this box. Traffic sign detected at this box.

IMAGE SEGMENTATION
Output: pixel-level classification.
Example: Every pixel classified as road, car, person, sky, or background.

REGRESSION FROM IMAGES
Output: a number.
Example: Estimated damage cost from a car image = $2,500.


THREE DIFFERENT VISION TASKS

Classification: "What is in this image?" → One or more labels.
Detection: "What objects are in this image, and where are they?" → Labels plus bounding boxes.
Segmentation: "Which pixels belong to each object or region?" → Pixel-level map.

PM shortcut:
  Classification = what.
  Detection = what and where.
  Segmentation = exact pixel area.

[!] Knowing which task type you need shapes the entire model design. Asking for "defect detection" could mean classification (is there a defect?), detection (where is the defect?), or segmentation (show me exactly which pixels are defective). Define this precisely before the team starts building.

>> The output type is a product decision. Define it before designing the model.$M10L2$
  ) returning id into v_l2;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.3 — Convolution, Filters, Kernels, and Feature Maps
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Convolution, Filters, Kernels, and Feature Maps',
    3,
    $M10L3$WHAT IS CONVOLUTION?

Convolution is the core idea in CNNs.

A convolution is a small filter sliding across an image to detect a pattern.

Imagine a small window — like 3 × 3 pixels. This window moves across the image. At each location, it checks: "Does this small area contain the pattern I am looking for?"

A filter may learn to detect:
  Vertical edges
  Horizontal edges
  Corners and curves
  Textures
  Color changes
  Small shapes


WHAT IS A FILTER / KERNEL?

A filter (also called a kernel) is a small matrix of numbers. It scans the image, and each filter learns one kind of visual pattern.

Example:
  Filter 1 detects vertical edges.
  Filter 2 detects horizontal edges.
  Filter 3 detects bright spots.
  Filter 4 detects curves.

In early CNN layers, filters detect simple features.
In later layers, filters detect more complex patterns.


WHAT IS A FEATURE MAP?

When a filter scans an image, it produces a new grid showing where that pattern appears.

This output is called a feature map.

Example:
  If a filter detects vertical edges, the feature map highlights areas where vertical edges exist.
  If a filter detects round shapes, the feature map highlights round areas.

Simple memory:
  Filter = pattern detector.
  Feature map = where the pattern appears.


WHY CONVOLUTION IS POWERFUL

1. It looks at local areas. Images have local structure — a pixel is related to nearby pixels. CNNs use small filters to look at nearby regions.

2. It reuses the same filter everywhere. The same edge detector works in the top-left, center, or bottom-right. This is called parameter sharing, and it makes CNNs more efficient.

3. It keeps spatial information. The model knows where patterns appear — eyes above mouth may indicate a face; wheels below body may indicate a car.

[!] You never design filters manually. The CNN learns the filters automatically during training by seeing many labeled examples. Filters are the learned weights of the convolutional layers.

>> Convolution is how a CNN "reads" an image — by sliding pattern detectors across every region and recording where each pattern appears.$M10L3$
  ) returning id into v_l3;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.4 — CNN Architecture: ReLU, Pooling, Flattening, Fully Connected Layers
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'CNN Architecture: ReLU, Pooling, Flattening, Fully Connected Layers',
    4,
    $M10L4$A TYPICAL CNN ARCHITECTURE

A standard CNN flows like this:

  Image input
  → Convolution layer (detects patterns with filters)
  → ReLU activation (adds non-linearity)
  → Pooling layer (reduces size, keeps important features)
  → More convolution + ReLU + pooling (detects higher-level patterns)
  → Flattening (converts feature maps to a flat list)
  → Fully connected layers (combines all signals)
  → Output layer (final prediction)

Simple memory: Image → detect small patterns → combine patterns → classify image


RELU IN CNNS

After convolution, CNNs apply ReLU (Rectified Linear Unit).

ReLU keeps positive values and turns negative values into zero.

Why this matters: without activation functions, even a deep CNN would behave like a simple linear model. ReLU allows the network to learn non-linear patterns — curves, bends, complex visual shapes.


WHAT IS POOLING?

Pooling reduces the size of feature maps.

The most common type is max pooling. In a 2 × 2 area, max pooling keeps only the largest value.

Why? Because if a feature exists somewhere in a small area, the exact pixel location may not matter — the strongest signal is often enough.

Pooling helps:
  Reduce computation
  Reduce image size inside the model
  Make the model less sensitive to small shifts in where a pattern appears


WHAT IS FLATTENING?

After convolution and pooling, the image has been transformed into many feature maps. Before final classification, these are flattened into a long list of numbers for the final layers to process.

Example: feature maps may contain signals for edges, corners, textures, shapes, and object parts. Flattening lets the final layer combine everything.


WHAT ARE FULLY CONNECTED LAYERS?

Fully connected layers are normal neural-network layers near the end of a CNN. They take the learned visual features and make the final decision.

Example: earlier CNN layers detect fur, ears, eyes, and face shape. Fully connected layers combine those signals and output: Cat 94%.

For multi-class classification, the final layer uses softmax — giving probabilities across all classes that sum to 100%.

[!] As a PM, you never design this architecture yourself. But understanding the layers helps you ask the right questions: "What resolution images does this expect? How deep is the network? Are we using transfer learning?"

>> A CNN is a pipeline from raw pixels → simple patterns → complex patterns → final prediction. Each stage builds on the last.$M10L4$
  ) returning id into v_l4;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.5 — Four Real Product Examples
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Four Real Product Examples',
    5,
    $M10L5$EXAMPLE 1: IMAGE CLASSIFICATION (PRODUCT CATEGORIZATION)

Business problem: classify product images into categories for search and recommendations.
Input: product image.
Output: Shoes 80%, Bag 10%, Shirt 7%, Watch 3% → prediction: Shoes.

Technical metrics: accuracy, precision, recall, F1, confusion matrix, top-1 accuracy, top-5 accuracy.
Business metrics: fewer miscategorized products, better search results, better recommendations, less manual tagging.


EXAMPLE 2: DEFECT DETECTION

Business problem: detect whether a product image shows a defect.
Input: product image.
Output: Defect probability = 92%.

Actions: send to manual review, reject item, ask supplier for replacement, route to quality team.

Technical metrics: precision, recall, F1, PR AUC, false positive rate, false negative rate.
Business metrics: defects caught, customer complaints reduced, returns reduced, manual inspection cost.

Key PM question: which is worse — missing a real defect, or falsely flagging a good product? That determines the threshold and the primary success metric.


EXAMPLE 3: DOCUMENT IMAGE CLASSIFICATION

Business problem: classify uploaded documents.
Input: scanned image or photo of a document.
Output: Passport, Driver''s license, Invoice, Receipt, Bank statement, Utility bill.

Actions: route document to correct workflow, extract fields, trigger verification, ask user to re-upload if quality is poor.

Technical metrics: accuracy by document type, precision/recall by class, confusion matrix.
Business metrics: faster processing, lower manual review, fewer user upload errors, lower operations cost.

Key PM questions: which document types are most often confused? Does it work across languages and countries? What happens when confidence is low?


EXAMPLE 4: MEDICAL IMAGING

Business problem: detect disease signs in medical images.
Input: X-ray, MRI, CT scan, or pathology image.
Output: disease probability or abnormality location.

Actions: flag for specialist review, prioritize urgent cases, support diagnosis, reduce missed findings.

Technical metrics: sensitivity/recall, specificity, AUC, false negative rate, calibration.
Business/clinical metrics: earlier detection, fewer missed cases, faster diagnosis, better patient outcomes.

PM warning: medical use cases are high-stakes. A model should usually support humans, not replace them, unless it has strong validation, governance, and regulatory approval.

[!] Each example connects model output → threshold → tiered action → team capacity → business metric. That chain is the PM deliverable — not just the model accuracy number.

>> The PM''s job is to design what happens after the prediction, not just to get a prediction.$M10L5$
  ) returning id into v_l5;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.6 — Transfer Learning, Data Augmentation, and Image Labeling
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Transfer Learning, Data Augmentation, and Image Labeling',
    6,
    $M10L6$TRANSFER LEARNING

Training a CNN from scratch usually needs a lot of labeled images.

Transfer learning helps. The idea: start with a CNN already trained on a large image dataset, then adapt it to your specific task.

A pre-trained model already knows general visual patterns: edges, colors, textures, shapes, object parts. You fine-tune it for your task: defect detection, document classification, medical scan classification, product category recognition.

Why transfer learning is useful:
  It needs less labeled data
  It trains faster
  It often improves accuracy
  It reduces cost

Example: if you have only 2,000 labeled defect images, training from scratch may be weak. Fine-tuning a pre-trained image model may work much better.

PM shortcut: do not train from scratch if a good pre-trained model can be adapted.

PM question: "Are we training from scratch, or using transfer learning?"


DATA AUGMENTATION

Data augmentation creates realistic variations of training images to help the model generalize.

Examples of augmentations:
  Rotate image
  Crop image
  Flip image
  Change brightness
  Zoom
  Add noise
  Shift image slightly

PM question: "Do our augmentations match realistic real-world variation?"

Bad augmentation can hurt. Example: flipping medical images or text documents may create unrealistic examples that confuse the model.


IMAGE LABELING

CNNs need labeled images. Label quality is critical — bad labels create bad models.

Example labels: defective/not defective, cat/dog/horse, passport/invoice/receipt, tumor/no tumor.

Common labeling problems:
  Human annotators disagree on edge cases
  Labels are inconsistent across reviewers
  Some defects are subtle
  Images have multiple objects
  The definition of "defect" is unclear
  Different teams use different standards

PM question: "Do we have a clear, written labeling guideline that all annotators follow?"


TRAIN, VALIDATION, AND TEST SPLIT

Image models must be evaluated carefully. Use training, validation, and test sets.

Critical rule: do not let near-duplicate images leak between train and test. If the same product image appears in both training and test sets with only small changes, the model may look better than it really is.

PM question: "Are train and test images truly independent, with no near-duplicates across splits?"

[!] Train/test leakage is one of the most common and damaging problems in image ML. A model showing 99% accuracy may be memorizing training images rather than learning to generalize.

>> Transfer learning reduces data needs. Clean labels and clean splits protect against measuring the wrong thing.$M10L6$
  ) returning id into v_l6;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.7 — Metrics for Classification, Detection, and Segmentation
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Metrics for Classification, Detection, and Segmentation',
    7,
    $M10L7$METRICS FOR IMAGE CLASSIFICATION

Common metrics:
  Accuracy: fraction of correct predictions overall.
  Precision: when the model predicts positive, how often is it right?
  Recall: of all actual positives, how many did the model catch?
  F1: harmonic mean of precision and recall.
  AUC / PR AUC: overall performance across all thresholds.
  Confusion matrix: shows which classes the model confuses.
  Top-1 accuracy: model''s top prediction is correct.
  Top-5 accuracy: correct answer appears in model''s top 5 predictions (useful with many classes).

Precision vs. recall in defect detection:
  High precision = when the model says defective, it is usually right.
  High recall = the model catches most actual defects.
  If missing a defect is very costly → prioritize recall.
  If false alarms create too much manual review → prioritize precision.

PM question: "What is the cost of false positives vs. false negatives for this use case?"


CONFUSION MATRIX INSIGHT

A confusion matrix shows which classes the model confuses.

Example: the model may confuse passport and driver''s license, or receipt and invoice, or small scratch and normal texture.

Ask:
  Which mistakes are most common?
  Which mistakes are most costly?
  Are some classes underrepresented?
  Do we need more training data for confused classes?
  Should some classes be merged?


METRICS FOR OBJECT DETECTION

IoU (Intersection over Union): measures how much the predicted bounding box overlaps the true box. High IoU = accurate location.

mAP (Mean Average Precision): summarizes detection quality across classes and confidence thresholds.

PM-friendly meaning: mAP tells whether the model finds the right objects in the right places.


METRICS FOR SEGMENTATION

IoU: measures overlap between predicted region and true region.
Dice score: also measures overlap, commonly used in medical imaging.
Pixel accuracy: fraction of pixels correctly classified.

PM-friendly meaning: these tell whether the model outlines the right area, not just whether it found the object.


BUSINESS METRICS

Always connect model metrics to business outcomes:
  Manual review reduction
  Defect escape reduction
  Customer complaint reduction
  Processing time reduction
  Quality improvement
  Cost reduction
  User success rate
  Revenue or conversion impact

[!] A model that improves AUC but does not reduce manual review or customer complaints has not yet proven business value.

>> Match the metric to the decision. Precision matters for costly false alarms. Recall matters for costly misses. mAP matters when location is part of the answer.$M10L7$
  ) returning id into v_l7;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.8 — Confidence, Human-in-the-Loop, and Error Analysis
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Confidence, Human-in-the-Loop, and Error Analysis',
    8,
    $M10L8$MODEL CONFIDENCE AND CALIBRATION

CNNs often output confidence scores.

Example: Defect probability = 92%.

But confidence does not always mean the model is truly correct. A model can be overconfident — outputting 99% while being wrong.

PM question: "Is the model calibrated?"

Calibration means predicted probabilities match real-world frequencies. If the model says 80% defective, approximately 80 out of 100 images at that score should actually be defective.

Calibration matters when:
  You use probability thresholds for automatic decisions
  You set routing rules (auto-approve vs. manual review)
  You communicate confidence to users or operations teams
  You compare scores across product lines or categories

If scores are used only for ranking, calibration matters less — but well-calibrated scores still give better threshold decisions.


HUMAN-IN-THE-LOOP

Many image models should not make final decisions alone, especially early in deployment or for high-stakes cases.

Example tiered design:
  Confidence above 95%: auto-approve or auto-reject
  Confidence 60–95%: route to human review
  Confidence below 60%: reject or request a new image

Human review is especially important when:
  Mistakes are costly (medical, safety, compliance)
  Labels are ambiguous
  The model is newly deployed
  Image distribution changes frequently
  Regulations require human sign-off

PM question: "What confidence levels should trigger human review, and does the team have capacity to handle that volume?"


ERROR ANALYSIS

After training, do not only look at the overall metric. Look at actual wrong predictions.

Ask:
  Are errors due to blurry images?
  Bad lighting?
  Unusual angles?
  Rare product types?
  Background clutter?
  New categories not in training data?
  Labeling mistakes?
  Low-resolution images?
  Two classes that look similar?

Error analysis tells you what to improve.

Possible fixes:
  Collect more images of the failing category
  Improve labeling guidelines
  Add data augmentation for the failing condition
  Change image capture guidelines
  Use transfer learning
  Improve preprocessing
  Add human review for low-confidence cases
  Combine CNN output with metadata signals

[!] Teams often stop at the overall metric number. PMs should push for error breakdowns by category, confidence tier, and image quality condition. That is where the actionable insights live.

>> Error analysis tells you not just how often the model is wrong, but why — and that drives the right improvement decisions.$M10L8$
  ) returning id into v_l8;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.9 — Bias, Fairness, Robustness, Drift, and Privacy
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'Bias, Fairness, Robustness, Drift, and Privacy',
    9,
    $M10L9$BIAS AND FAIRNESS IN CNNS

CNNs learn from training images. If the training images are not representative, the model may fail for some groups or contexts.

Examples of bias:
  Face models trained mostly on one demographic fail on others.
  Product models trained on clean studio images fail on messy real-world photos.
  Medical models trained on one hospital''s equipment fail on different machines.
  Document models trained on one country''s formats fail on international documents.

PM questions:
  Is the image dataset representative of real-world variation?
  Does performance vary across groups, regions, devices, lighting, or categories?
  Are some users more likely to receive false positives or false negatives?
  Are we monitoring fairness and segment performance after launch?


ROBUSTNESS

Robustness means the model works under real-world variation.

A CNN should handle: different lighting, different angles, different devices, different backgrounds, different resolutions, small shifts, minor occlusions, and normal image noise.

CNNs can be fooled by adversarial examples — carefully crafted inputs that cause wrong predictions, invisible to humans but exploitable in some systems.

PM question: "What real-world variations did we test, and which ones did the model fail on?"


DRIFT

Image data can change over time.

Examples of drift:
  New product types
  New camera devices or resolutions
  New document formats
  New lighting conditions in manufacturing
  New packaging designs
  New fraud or abuse patterns
  New user behavior in image capture

A model trained on old image data may become less accurate.

PM questions:
  How will we monitor model performance after launch?
  How often will we refresh training data?
  How will we detect new failure patterns?
  How will human review feedback flow back into model improvement?


PRIVACY

Image data can contain sensitive information: faces, IDs, addresses, medical information, children, personal documents, homes, license plates.

PMs must consider:
  Consent and data collection agreements
  Data retention limits
  Access control
  Masking sensitive areas before storage
  Encryption
  Regulatory compliance
  Human reviewer privacy
  Whether the image is needed at all vs. extracting only required features

PM question: "Are we collecting and storing only the image data we truly need, and have we handled privacy requirements for our jurisdiction?"

[!] Privacy is easier to get right at the design stage than after launch. Define data retention, masking, and access policies before the system is built, not after a compliance review.

>> Bias, drift, and privacy are PM responsibilities — not just engineering concerns. Build monitoring and governance into the project plan from the start.$M10L9$
  ) returning id into v_l9;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.10 — CNN vs. Other Approaches and Common Failure Modes
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'CNN vs. Other Approaches and Common Failure Modes',
    10,
    $M10L10$CNN VS. REGULAR NEURAL NETWORK

| Topic                    | Regular neural network      | CNN                           |
| Best for                 | Tabular, simple structured  | Images, video, grid-like data |
| Input handling           | Flattens input              | Preserves spatial structure   |
| Learns local patterns    | Not naturally               | Yes                           |
| Reuses pattern detectors | No (no parameter sharing)   | Yes                           |
| Common use               | Churn, risk, regression     | Vision tasks                  |

Simple rule: use CNNs when the position and shape of visual patterns matter.


CNN VS. TRADITIONAL COMPUTER VISION

Before deep learning, image systems used hand-crafted rules: detect edges, detect corners, detect color thresholds, detect specific shapes.

Traditional computer vision may still be useful when:
  Rules are simple and stable
  Data is very limited
  Interpretability is required
  The environment is tightly controlled
  The task is very narrow

CNNs are better when:
  Visual variation is high across the real world
  You have many labeled examples
  Hand-written rules are too brittle to maintain
  Accuracy requirements are demanding

PM question: "Do we need ML, or can a simpler computer vision rule solve this more cheaply?"


CNN VS. VISION TRANSFORMERS

Modern image systems may use CNNs, vision transformers, or hybrid models. CNNs are foundational and remain widely used, especially for lower-resource settings. Vision transformers can perform very well with large datasets and pretraining.

PM-level takeaway: you do not pick the architecture yourself. Ask:
  Why CNN vs. transformer?
  Which performs better on our data and task?
  Which is cheaper to serve at our scale?
  Which is easier to maintain and explain?
  Which handles our edge cases better?


TEN COMMON CNN FAILURE MODES

1. Not enough labeled images → overfitting or poor generalization.
2. Poor label quality → model learns inconsistent definitions.
3. Train/test leakage → similar images across splits inflate test results.
4. Dataset not representative → works in lab, fails on real-world images.
5. Poor image quality → blurry, dark, cropped, or low-resolution images hurt performance.
6. Class imbalance → rare defects or rare document types are missed.
7. Overfitting → great training performance, weak validation/test performance.
8. Weak threshold choice → too many false positives or false negatives for the downstream workflow.
9. No human review for uncertain cases → mistakes go directly to users or operations.
10. Drift → new image types or conditions reduce performance over time.

[!] Train/test leakage and class imbalance are especially common and easy to miss. Always ask how the splits were created and how many examples exist for each class.

>> Knowing the ten failure modes lets you ask the right questions in design reviews — before the problems ship.$M10L10$
  ) returning id into v_l10;

  -- ─────────────────────────────────────────────────────────────────
  -- LESSON 10.11 — PM Checklist, How to Explain, and the Memory Shortcut
  -- ─────────────────────────────────────────────────────────────────
  insert into lessons (module_id, title, sort_order, content) values (
    v_module_id,
    'PM Checklist, How to Explain, and the Memory Shortcut',
    11,
    $M10L11$PM CHECKLIST FOR CNN PROJECTS

1.  What visual problem are we solving?
2.  Is it classification, detection, segmentation, or regression?
3.  What is the input image source?
4.  What is the output, and what decision will use it?
5.  Do we have enough labeled images?
6.  Are labels consistent and high quality?
7.  Do we have written labeling guidelines?
8.  Is the dataset representative of real-world images?
9.  Are train, validation, and test sets properly separated?
10. Are there duplicate or near-duplicate images across splits?
11. Are classes imbalanced?
12. Are rare classes important to the business?
13. Are images good quality?
14. Do we need image capture guidelines or product UI changes?
15. Are we training from scratch or using transfer learning?
16. Are we using data augmentation?
17. Do augmentations reflect real-world variation?
18. What technical metrics are we using?
19. Which errors are most costly — false positives or false negatives?
20. What threshold triggers action?
21. Do we need human review for uncertain cases?
22. How does performance vary by segment, category, or condition?
23. What happens with low-confidence predictions?
24. What is inference latency?
25. What is serving cost?
26. Are there privacy concerns with the images?
27. How will model drift be monitored?
28. How will human feedback improve the model over time?
29. What business metric should improve?


HOW TO EXPLAIN CNNS TO LEADERSHIP

Simple version:
  "We used a convolutional neural network because the problem involves images. CNNs are designed to learn visual patterns such as edges, textures, shapes, and object parts. The model processes each image through layers that detect increasingly complex visual features and then outputs a classification, detection, or risk score."

Defect detection example:
  "The model reviews product images and predicts whether there is a visible defect. We use high-confidence predictions for automatic routing and send uncertain cases to human review. Success is measured not only by model recall and precision, but also by reduction in customer complaints, manual review workload, and defect escape rate."

Document classification example:
  "The document classifier identifies whether an uploaded image is an invoice, receipt, passport, or bank statement. This helps route documents faster and reduce manual processing. We will monitor misclassification by document type and improve the model with human-review feedback."


THE MEMORY SHORTCUT

A CNN is: **a neural network specialized for images.**

Remember: Image → filters detect patterns → feature maps → pooling → final prediction

Use it when: input is image or video, visual patterns matter, you need classification/detection/segmentation, rule-based vision is too brittle, you have enough labeled visual data, or transfer learning can compensate for limited data.

Measure it with:
  Classification: accuracy, precision, recall, F1, confusion matrix, AUC/PR AUC
  Detection: IoU, mAP, precision, recall
  Segmentation: IoU, Dice score, pixel accuracy
  Business: fewer defects, lower manual review, faster processing, lower cost

Watch for: poor image quality, bad labels, not enough data, train/test leakage, class imbalance, overfitting, weak thresholds, no human review, privacy risk, drift.

The most important PM question:
  **Is the model learning real visual patterns that generalize to real-world images, and does its output improve a real product or business decision?**$M10L11$
  ) returning id into v_l11;

  -- ─────────────────────────────────────────────────────────────────
  -- QUIZ QUESTIONS (11 total, one per lesson)
  -- ─────────────────────────────────────────────────────────────────

  -- Q1 — Lesson 10.1
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l1,
    'Why is a CNN better suited for image problems than a regular neural network?',
    '["A CNN preserves spatial structure and uses filters that detect patterns at any location, while a regular neural network flattens the image and loses position information","A CNN requires less training data than a regular neural network for the same problem","A CNN is faster to train than a regular neural network on any type of data","A CNN can only process images, while a regular neural network can handle any data type including images"]',
    0
  );

  -- Q2 — Lesson 10.2
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l2,
    'A team says they need "defect detection." What clarifying question should the PM ask first?',
    '["Do we need classification (is there a defect?), object detection (where is the defect?), or segmentation (which exact pixels are defective?), since each requires a different model design","Do we have enough GPU compute to train a CNN?","Should we use transfer learning or train from scratch?","What precision score is acceptable for this use case?"]',
    0
  );

  -- Q3 — Lesson 10.3
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l3,
    'What is a feature map in a CNN?',
    '["A grid that shows where a specific visual pattern appears in the image after a filter scans across it","A chart that shows which features were most important for the final prediction","A list of the filters the model learned during training","A visualization of the model''s confidence score across different image regions"]',
    0
  );

  -- Q4 — Lesson 10.4
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l4,
    'What does max pooling do in a CNN architecture?',
    '["It reduces the size of feature maps by keeping only the strongest signal in each local area, making the model more efficient and less sensitive to small pattern shifts","It applies the ReLU activation function to remove negative values from the feature maps","It connects every neuron in one layer to every neuron in the next layer for final classification","It randomly removes filters during training to prevent overfitting"]',
    0
  );

  -- Q5 — Lesson 10.5
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l5,
    'A CNN for defect detection achieves 97% recall but only 41% precision. What does this mean for the operations team?',
    '["The model catches almost all real defects but raises many false alarms — 59% of flagged items are actually fine, which could overwhelm the manual review team","The model is well-balanced and ready for production deployment","The model is missing 59% of real defects, which is a critical quality failure","The confusion matrix is the wrong metric to use for this type of defect detection problem"]',
    0
  );

  -- Q6 — Lesson 10.6
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l6,
    'A team has 2,000 labeled product images and needs to build a defect classifier. What approach should they use?',
    '["Fine-tune a pre-trained CNN using transfer learning — training from scratch with 2,000 images is likely to overfit, while a pre-trained model already has general visual knowledge that can be adapted","Train a CNN from scratch since 2,000 labeled images is sufficient for most image classification tasks","Use a regular neural network instead since CNNs require at least 100,000 labeled images","Skip the model and use hand-crafted computer vision rules since the dataset is too small for any neural network"]',
    0
  );

  -- Q7 — Lesson 10.7
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l7,
    'For an object detection model that must find cracks in infrastructure photos, which metric is most important?',
    '["mAP (mean average precision) — it summarizes whether the model finds the right objects in the right locations across all confidence thresholds and object classes","Top-5 accuracy — it measures whether the correct class appears in the top 5 predictions","Pixel accuracy — it measures what fraction of all pixels are correctly labeled","IoU alone — comparing the predicted box to the true box is sufficient without aggregating across thresholds"]',
    0
  );

  -- Q8 — Lesson 10.8
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l8,
    'A CNN for medical scan review outputs confidence 99% on most cases. The team proposes full automation with no human review. What should the PM ask?',
    '["Is the model calibrated — does a 99% confidence score actually mean the model is correct 99% of the time? And what is the cost of the rare cases where a highly confident model is wrong?","Whether the model achieves 99% recall as well as 99% confidence, since both are needed for full automation","Whether the GPU serving cost justifies removing human reviewers from the workflow","Whether a simpler model like logistic regression could achieve the same 99% confidence at lower cost"]',
    0
  );

  -- Q9 — Lesson 10.9
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l9,
    'A product photo classifier trained on studio images is deployed in a mobile app where users take their own photos. Performance drops significantly. What is the most likely cause?',
    '["Dataset shift — the model was trained on clean studio images but is now receiving real-world photos with variable lighting, angles, and backgrounds that were not represented in training","The model is overfitting to validation data instead of training data","The mobile app is compressing images too aggressively before sending them to the model","The model needs more hidden layers to handle the increased complexity of mobile photos"]',
    0
  );

  -- Q10 — Lesson 10.10
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l10,
    'A CNN for document classification shows 98% accuracy on the test set. In production it misclassifies 35% of rare document types. What likely went wrong?',
    '["Class imbalance — rare document types had few training examples, so the model learned to ignore them; overall accuracy looked great because common classes dominated the test set","The model is overfitting on the training data but has sufficient validation performance","Transfer learning was used when training from scratch would have been more appropriate","The test set was too large, causing the model to memorize it rather than generalize"]',
    0
  );

  -- Q11 — Lesson 10.11
  insert into questions (lesson_id, question_text, choices, correct_choice_index) values (
    v_l11,
    'The most important PM question for a CNN project is: "Is the model learning real visual patterns that generalize to real-world images?" Which checklist item most directly tests this?',
    '["Are train, validation, and test sets truly independent with no near-duplicate images across splits?","What activation function was used in the convolutional layers?","How many filters does the first convolutional layer have?","Was the model trained with SGD or Adam optimizer?"]',
    0
  );

end $$;
