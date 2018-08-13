library("ggplot2")

df <- read.csv("data2.csv")
ggplot(df, aes(X, Y)) + geom_point(aes(colour=Z))
ggsave("data2.pdf")
