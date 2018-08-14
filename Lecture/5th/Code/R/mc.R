xs <- runif(1000000, 0, 1)
pis <- sum(4 / (1 + xs ^ 2))
pis <- pis / 1000000
print(pis)
