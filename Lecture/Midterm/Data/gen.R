x <- seq(0,1,0.01)
y <- sqrt(abs(1 - x^2 + runif(101, -0.1, 0.1)))

z <- function(x,y) {
  if (x^2 + y^2 < 1) {
    return(0)
  } else {
    return(1)
  }
}

zv <- Vectorize(z)

f <- zv(x,y)

df <- data.frame(X=x, Y=y, Z=f)

write.table(df, file="data.csv", sep = ",")
