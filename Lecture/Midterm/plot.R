library("ggplot2")

a <- read.csv("data.csv")
ggplot(a, aes(X,Y)) + geom_point(aes(colour = Z))
ggsave("midplot.pdf")
