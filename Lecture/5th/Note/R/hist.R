x <- 1:100

# Model 1
y1 <- 0.5 * x + rnorm(100) * 5
m1 <- lm(y1 ~ x)
e1 <- y1 - m1$fitted.values

# Model 2
y2 <- 0.5 * x^2 + rnorm(100) * 5
m2 <- lm(y2 ~ x)
e2 <- y2 - m2$fitted.values

par(mfrow=c(1,2))
hist(e1)
hist(e2)
