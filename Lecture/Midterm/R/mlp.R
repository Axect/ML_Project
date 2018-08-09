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

tanhact <- function(x) {
  return(0.5 * (tanh(x) + 1))
}

forwards <- function(weights, inputb) {
  s <- inputb %*% weights
  g <- sigmoid
  y <- g(s) # Numeric functions are automatically vectorized
  return(y)
}

forwardt <- function(weights, inputb) {
  s <- inputb %*% weights
  g <- tanhact
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
  xb <- addBias(x, -2) # xb = n x (L+1)
  err <- c(0)
  for (i in 1:times) {
    a <- forwardt(v, xb) # a = n x M
    ab <- addBias(a, -1) # ab = n x (M+1)
    y <- forwards(w, ab) # y = n x N
    err <- rbind(err, t(y - t) %*% (y - t)) # err = n x n
    # print(err)
    wb <- hideBias(w) # Remove bias : wb = M x N
    do <- (y - t) * y * (1 - y) # do = n x N, sigmoid
    dh <- (do %*% t(wb)) * 0.5 * (1 + a) * (1 - a) # dh = n x M, tanh
    w <- w - eta * (t(ab) %*% do)
    v <- v - eta * (t(xb) %*% dh)
  }
  # Recall
  a <- forwardt(v, xb)
  ab <- addBias(a,-1)
  y <- forwards(w, ab)

  #print(v)
  #print(w)
  return(err)
}

# ==============================================================================
# Test - Quad Circle
# ==============================================================================
v <- weights_init(2,1) # 3 x 2
w <- weights_init(2,1) # 3 x 1

df <- read.csv("../data.csv")

x <- data.matrix(cbind(df['X'], df['Y']))
r <- data.matrix(df['X']^2 + df['Y']^2)
t <- data.matrix(df['Z'])

y <- train(v, w, r, t, 0.2, 5000)

# Result :
#       [,1]
#   54.06966
#X 110.03508
#            Z
#[1,] 3.722186
#[2,] 6.801995

# 3 Predict Z, when X=sqrt(0.5), Y=0.5
v1 <- matrix(c(54.06966, 110.03508), 2, 1)
w1 <- matrix(c(3.722186, 6.801995), 2, 1)

x1 <- matrix(sqrt(0.5)^2 + 0.5^2, 1, 1)
xb1 <- addBias(x1, -2)

a1 <- forwardt(v1, xb1)
ab1 <- addBias(a1, -1)
y1 <- forwards(w1, ab1)
print(y1)

# 4 Predict Z, when X=sqrt(0.5), Y=sqrt(0.5)
x2 <- matrix(sqrt(0.5)^2 + sqrt(0.5)^2, 1, 1)
xb2 <- addBias(x2, -2)

a2 <- forwardt(v1, xb2)
ab2 <- addBias(a2, -1)
y2 <- forwards(w1, ab2)
print(y2)
