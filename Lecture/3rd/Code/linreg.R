linreg <- function(input, target) {
    x <- input
    xt <- t(x)
    beta <- solve(xt %*% x) %*% (xt %*% target)
    return(input %*% beta)
}

x <- matrix(0, 4, 3)
x[,1] = -1 # Bias
x[,2] = c(0,1,0,1)
x[,3] = c(0,0,1,1)

t <- c(0,1,1,1)

y <- linreg(x, t)

print(y)

activation <- function(s) {
    ans <- if(s > 0.5) 1 else 0
    return(ans)
}

g <- Vectorize(activation)

print(g(y))