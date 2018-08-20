x <- seq(1, 10, 0.1);
y <- x^2 + rnorm(91,0,5);

df = data.frame(X=x, Y=y)

library("ggplot2");

ggplot(df, aes(X, Y)) + geom_point()
ggsave("reg_data.png")
