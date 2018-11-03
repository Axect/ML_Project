library("ggpubr")

dat <- read.csv("bench.csv")

Library <- c("DNumeric1(D)", "DNumeric2(D)", "DNumeric3(D)", "R", "Peroxide(Rust)", "Tensorflow(Python)")

df <- cbind(dat, Library)

g <- ggline(df, "Library", "mean", type='l', ylab="time(s)", title="Benchmark for XOR MLP")
g + yscale("log10", .format=TRUE)
