x <- seq(0,1,0.01)
y <- x + runif(101, -2, 2)

z <- function(x,y) {
  if (y < x) {
    return(0)
  } else {
    return(1)
  }
}

zv <- Vectorize(z)

f <- zv(x,y)

df <- data.frame(X=x, Y=y, Z=f)

write.table(df, file="data2.csv", sep = ",", row.names=FALSE)
