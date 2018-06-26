library(ggplot2)

bayes <- function(x) min(x,1-x)
nearest <- function(x) 2*x*(1-x)
matushita <- function(x) sqrt(x*(1-x))
entropy <- function(x) -x*log(x)-(1-x)*log(1-x)
negJeffrey <- function(x) -(2*x - 1) * log(x/(1-x))

x <- seq(0.001,0.999, 0.01)

bV <- Vectorize(bayes)
nV <- Vectorize(nearest)
mV <- Vectorize(matushita)
eV <- Vectorize(entropy)
jV <- Vectorize(negJeffrey)

lab <- c(rep("bayes",100),rep("nearest", 100),rep("matushita",100),rep("entropy",100))
val <- c(bV(x), nV(x), mV(x), eV(x))

df = data.frame(x, val, lab)

png("F-error.png", units="in", width=8, height=6, res=600)
ggplot(data=df, aes(x=x,y=val,group=lab, colour=lab)) + geom_line()
dev.off()
