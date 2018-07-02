<!-- page_number: true -->
<!-- prerender: true -->

Introduce Machine Learning
===

###### Presented by Tae Geun Kim

---

## - Table of Contents

* Types of Machine Learning
* Scoring Machine Learning Algorithm

---

Types of Machine Learning
===

---
## Types of Machine Learning

* Supervised Learning
* Unsupervised Learning
* Reinforcement Learning
* Evolutionary Learning

---

![ML_Algorithm](MachineLearningAlgorithms.png)

---

We will divide ML by two ways

* Statistical Learning (Based on Statistics)
* Deep Learning (Based on Induction)

For Statistical Learning,

* Statistics
* R (or Scipy or Julia)
* DIY (Do It Yourself with your own languages)

For Deep Learning,

* Tensorflow
* Torch / PyTorch
* MXNet or Other frameworks

---

Scoring Machine Learning Algorithm
===

---

## 1. Overfitting
![Overfitting](overfitting.png)

We need third data sets - **validation set**. This procedure called **Cross Validation**.

---

But in some cases, we can't get enough labeled data. So, we need **semi-supervised learning**.

There are some ways :

* Leave Some Out (Leave one out)
* Multifold cross validation

---
### Example : Multifold cross validation


![K-Fold 200%](Kfold.jpg)

---
## 2. Confusion Matrix


Actual \ Predicted | Cat | Dog | Rabbit
:--: | :--: | :--: | :--:
Cat | 5 | 3 | 0 
Dog | 2 | 3 | 1
Rabbit | 0 | 2 | 11

---

![Confusion](confusion.png)

---

Predicted \ Actual | Cat | Non-cat
:--: | :--: | :--:
Cat | 5 TP | 3 FN
Non-cat | 2 FP | 17 TN

---

* Notations
$$ P = TP + FN, ~ N = FP + TN $$

* Accuracy
$$ ACC = \frac{TP+TN}{P + N} $$

* Sensitivity, Recall, True positive rate
$$ TPR = \frac{TP}{P} $$

---

* Specificity, True negative rate
$$ TNR = \frac{TN}{N} $$

* Precision, Positive predictive value
$$ PPV = \frac{TP}{TP + FP} $$

---

* High Recall $\rightarrow$ the class is correctly recognized (small FN)
* High Precision $\rightarrow$ an example labeled as positive is indeed positive (small FP)
* High Recall, Low Precision $\rightarrow$ Miss a lot of positive examples, but those we predict as positive are indeed positive (low FP)

---

* F-measure

$$ F = \frac{1}{\alpha\frac{1}{PPV} + (1-\alpha)\frac{1}{TPR}} = \frac{(\beta^2 + 1)PPV \times TPR}{\beta^2 PPV + TPR}$$


* $F_1$-measure ($\beta = 1$)

$$F_1 = 2 \times \frac{TPR \times PPV}{TPR + PPV}$$

* $F_1 \, \rightarrow \, 1$ : Best!
* $F_1 \, \rightarrow \, 0$ : Worst!

---

