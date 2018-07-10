# input : N x m
# output : N x n
# weight : m x n
# answer : N x n

weights_init <- function(m, n) {
    w <- runif(m, -1, 1)
    if(n==1) {
        return(w) # 1 * m matrix
    } else {
        for (i in 2:n) {
            w <- cbind(w, runif(m, -1, 1))
        }
        return(w)
    }
}

# Only Binary Activation
activation <- function(s) {
    ans <- if(s > 0) 1 else 0
    return(ans)
}

output <- function(weights, input) {
    s <- input %*% weights
    g <- Vectorize(activation)
    y <- g(s)
    return(y)
}

update <- function(weights, input, answer, eta = 0.25) {
    y <- output(weights, input)
    w <- weights - eta * (t(x) %*% (y - answer))
    return(w)
}

train <- function(weights, input, answer, eta = 0.25, times) {
    w <- weights
    for (i in 1:(times - 1)) {
       w <- update(w, input, answer, eta = 0.25)
       print(w)
    }
    return(output(w, input))
}

# ==============================================================================
# Example - OR
# ==============================================================================
w <- weights_init(3,1)

x <- matrix(0, 4, 3)
x[,1] = -1
x[,2] = c(0,1,0,1)
x[,3] = c(0,0,1,1)

t <- c(0,1,1,1)

y <- train(w, x, t, 0.25, 10)

print(y)