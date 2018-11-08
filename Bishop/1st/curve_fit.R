x <- seq(0, 1, 0.01)
y <- x^2 + runif(101) / 10

#fit first degree polynomial equation:
fit  <- lm(y~x)
#second degree
fit2 <- lm(y~poly(x,2,raw=TRUE))
#third degree
fit3 <- lm(y~poly(x,3,raw=TRUE))
#fourth degree
fit4 <- lm(y~poly(x,4,raw=TRUE))
#generate range of 50 numbers starting from 30 and ending at 160
xx <- seq(0, 1, 0.01)
plot(x,y)
lines(xx, predict(fit, data.frame(x=xx)), col="red")
lines(xx, predict(fit2, data.frame(x=xx)), col="blue")