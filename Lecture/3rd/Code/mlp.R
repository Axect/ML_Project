# x : n x (L + 1) (input + bias)
# v : (L + 1) x M
# a : n x (M + 1) (Add Bias)
# w : (M + 1) x N
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

forward <- function(weights, input) {
    s <- input %*% weights
    g <- sigmoid
    y <- g(s)
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
    xp <- addBias(x, -1) # xp = n x (L+1)
    for (i in 1:times) {
        a <- forward(v, xp) # a = n x M
        ap <- addBias(a, -1) # ap = n x (M+1)
        y <- forward(w, ap) # y = n x N
        err <- t(y - t) %*% (y - t) # err = n x n
        # print(err)
        wp <- hideBias(w) # Remove bias : wp = M x N
        do <- (y - t) * y * (1 - y) # do = n x N
        dh <- (do %*% t(wp)) * a * (1 - a) # dh = n x M
        w <- w - eta * (t(ap) %*% do)
        v <- v - eta * (t(xp) %*% dh)
    }
    # Recall
    a <- forward(v, xp)
    ap <- addBias(a,-1)
    y <- forward(w, ap)
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

y <- train(v, w, x, t, 0.25, 5000)

print(y)