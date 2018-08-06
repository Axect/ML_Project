---
title: "2018 PL Midterm"
author: [Tae Geun Kim]
date: 2018-08-07
subject: "Markdown"
keywords: [Markdown, Example]
subtitle: "Statistics, Machine Learning"
titlepage: true
...


\newpage\null\thispagestyle{empty}\newpage

# Statistics

## 1. Hand-Writing

1. Prove that
$$ V[x] = E[x^2] - E[x]^2 ~~~ \text{where pdf of x is continuous}$$

\vspace{1cm}

2. Prove that
$$ Cov(x,y) = E[xy] - E[x]E[y] ~~~ \text{where pdf of x,y are continuous}$$

\vspace{1cm}

3. Find $ACC, ~ TPR, ~ TNR, ~ PPV$ of next table :

Actual \\ Predicted | Cat | Dog | Rabbit
:--: | :--: | :--: | :--:
Cat | 5 | 3 | 0
Dog | 2 | 3 | 1
Rabbit | 0 | 2 | 11

\vspace{1cm}

4. Denote $F$-measure, and explain meaning of $F$-measure.

\vspace{1cm}

5. Write full name of each objects :

    * $ROC$
    * $AUC$
    * $MCC$
    * $MAP$

\vspace{1cm}

6. Denote Mahalanobis distance and pdf of higher dimension Gaussian distribution.

\pagebreak

## 2. Programming

You have data for five people about weight, score and age.

Weight | Score | Age
:-----:|:-----:|:---:
64.0 | 580.0 | 29.0
66.0 | 570.0 | 33.0
68.0 | 590.0 | 37.0
69.0 | 660.0 | 46.0
73.0 | 600.0 | 55.0

1. Find covariance matrix

\vspace{1cm}

2. Find correlation coefficient between weight and score.
$$ \rho(x,y) = \frac{\displaystyle\sum_i (x_i - \bar{x})(y_i - \bar{y})}{\sqrt{\displaystyle\sum_i(x_i - \bar{x})^2} \sqrt{\displaystyle\sum_i (y_i - \bar{y})^2}} $$

\vspace{1cm}

3. Now you have another person data:

    Weight | Score | Age
    :-----:|:-----:|:---:
    66.0 | 640.0 | 44.0

    Calculate Mahalnobis distance of this person from above data set.

\pagebreak

# Machine Learning

## 1. Hand-Writing

1. Prove that $\beta$ minimize $RSS$. ($X$ is input, $t$ is answer)
$$\bf \beta = (X^T X)^{-1} X^T t $$

\vspace{1cm}

2. Why we use sigmoid or $\tanh$ as activation function?

\vspace{1cm}

3. Denote forward process of Multi Layer Perceptron.

\vspace{1cm}

4. Denote whole Error Back-Propagation process of Multi Layer Perceptron.

\vspace{1cm}

5. Find derivatives of below functions (represent derivative as original function).

    * $\sigma_{\beta}(x) = \displaystyle \frac{1}{1 + e^{-\beta x}}$

    * $\tanh(x) = \displaystyle \frac{e^x - e^{-x}}{e^x + e^{-x}}$

    * $softmax(x_k) = \displaystyle \frac{e^{x_k}}{\displaystyle\sum_k e^{x_k}}$

\vspace{1cm}

6. Rewrite Error Back-Propagation as vectorized form.

\pagebreak

## 2. Programming

First, type below code.

```sh
wget https://github.com/Axect/ML_Project/raw/master/Lecture/Midterm/data.csv
```

And let's see  `data.csv`

1. Can we use SLP or linear regression to this data? If not, explain why.

\vspace{1cm}

2. Implement MLP code using $\tanh$ as activation function from input to hidden and sigmoid as activation function from hidden to output.

\vspace{1cm}

3. Predict $Z$ when $X = \sqrt{0.5}$, $Y = 0.5$.

\vspace{1cm}

4. Predict $Z$ when $X = \sqrt{0.5}$, $Y = \sqrt{0.5}$.