weight <- c(64,66,68,69,73)
score <- c(580,570,590,660,600)
age <- c(29,33,37,46,55)

m <- cbind(weight, score, age)

covmat <- function(cols) {
  mat = matrix(0, ncol(cols), ncol(cols))
  for (i in 1:ncol(cols)) {
    for (j in 1:ncol(cols)) {
      mat[i,j] = cov(cols[,i], cols[,j])
    }
  }
  return(mat)
}

mahal <- function(p, dat) {
  ms <- colMeans(dat)
  cs <- covmat(dat)
  return(sqrt(t(p - ms) %*% solve(cs) %*% (p - ms)))
}

# 1. Find covariance matrix
covm <- covmat(m)
print(covm)

# 2. Correlation
rho <- cor(weight, score)
print(rho)

# 3. Person
dat <- c(66, 640, 44)
md <- mahal(dat, m)
print(md)
