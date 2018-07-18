# x : n x L (input)
# v : L x M
# a : n x M
# w : M x N
# y : n x N
# t : n x N
# dh : n x M
# do : n x N

weights_init <- function(m, n) {
    w <- runif(m, -1, 1)
    if(n==1) {
        return(w) # m x 1 matrix
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

forward <- function(weights, input) {
    s <- input %*% weights
    g <- Vectorize(activation)
    y <- g(s)
    return(y)
}

sigmoid <- 

update <- function(weights1, weights2, input, answer, eta = 0.25) {
    x <- input
    v <- weights1
    w <- weights2
    t <- answer
    a <- forward(v, x) # a = g(x %*% v)
    y <- forward(a, w)
    do <- (y - t) * a * (1 - a)
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
x[,1] = -1 # Bias
x[,2] = c(0,1,0,1)
x[,3] = c(0,0,1,1)

t <- c(0,1,1,1)

y <- train(w, x, t, 0.25, 100)

print(y)


# Sample Plot
f <- function(x) {
    w0 <- 0.2356196
    w1 <- 0.2797721
    w2 <- 0.2823095
    return(- w1 / w2 * x + w0 / w2)
}

plot(f, type='l', xlim=c(0,1), ylim=c(0,1), xlab="In1", ylab="In2")
points(0,0)
points(1,0)
points(0,1)
points(1,1)
