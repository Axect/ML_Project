df <- read.csv("data.csv")

n <- 10

xsum <- sum(df["X"])
ysum <- sum(df["Y"])

b1 <- (n * sum(df["X"] * df["Y"]) - xsum * ysum) / (n * sum(df["X"]^2) - xsum^2)
b0 <- (ysum - b1 * xsum) / n

yhat <- function(x) {
  return(b0 + b1*x)
}

dg <- data.frame(A=df["X"], B=df["Y"], C=yhat(df["X"]))

library("ggplot2")

ggplot(dg) + geom_point(aes(X, Y)) + geom_line(aes(X,X.1))

ggsave("slr.png")
