x <- mtcars$mpg
svg(filename="hist.svg", 
    width=8, 
    height=6)
h <- hist(x, breaks=10)
xfit <- seq(min(x),max(x),length=40)
yfit <- dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit * diff(h$mids[1:2]) * length(x)
lines(xfit, yfit, lwd=2)
dev.off()