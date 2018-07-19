# x : n x L
# xb : n x (L+1) : add bias
# v : (L + 1) x M
# a : n x M
# ab : n x (M+1) : add bias
# w : (M + 1) x N
# wb : M x N : remove bias
# y : n x N
# t : n x N
# dh : n x M
# do : n x N

weights_init <- function(m, n) {
    w <- matrix(runif(m, -1, 1), m, 1)
    if(n==1) {
        return(w) # m x 1 matrix
    } else {
        for (i in 2:n) {
            w <- cbind(w, runif(m, -1, 1))
        }
        return(w) # m x n matrix
    }
}

sigmoid <- function(x) {
    return(1/(1 + exp(-x)))
}

forward <- function(weights, inputb) {
    s <- inputb %*% weights
    g <- sigmoid
    y <- g(s) # Numeric functions are automatically vectorized
    return(y)
}

addBias <- function(input, bias) {
    b <- matrix(bias, nrow(input), 1)
    return(cbind(b, input))
}

hideBias <- function(weight) {
    w <- weight[2:nrow(weight),]
    return(w)
}

train <- function(weights1, weights2, input, answer, eta = 0.25, times) {
    x <- input # x = n x L
    v <- weights1 # v = (L+1) x M
    w <- weights2 # w = (M+1) x N
    t <- answer # t = n x N
    xb <- addBias(x, -1) # xb = n x (L+1)
    for (i in 1:times) {
        a <- forward(v, xb) # a = n x M
        ab <- addBias(a, -1) # ab = n x (M+1)
        y <- forward(w, ab) # y = n x N
        err <- t(y - t) %*% (y - t) # err = n x n
        # print(err)
        wb <- hideBias(w) # Remove bias : wb = M x N
        do <- (y - t) * y * (1 - y) # do = n x N
        dh <- (do %*% t(wb)) * a * (1 - a) # dh = n x M
        w <- w - eta * (t(ab) %*% do)
        v <- v - eta * (t(xb) %*% dh)
    }
    # Recall
    a <- forward(v, xb)
    ab <- addBias(a,-1)
    y <- forward(w, ab)
    return(y)
}

# ==============================================================================
# Example - XOR
# ==============================================================================
v <- weights_init(3,2) # 3 x 2
w <- weights_init(3,1) # 3 x 1

x <- matrix(0, 4, 2) # 4 x 2
x[,1] = c(0, 0, 1, 1)
x[,2] = c(0, 1, 0, 1)

t <- c(0,1,1,0)

y <- train(v, w, x, t, 0.25, 10000)

print(y)
