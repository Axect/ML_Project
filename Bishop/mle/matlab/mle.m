df = readtable("../data/mle.csv");
hold on
plot(df.x, df.origin)
plot(df.x, df.n_10)
plot(df.x, df.n_100)
plot(df.x, df.n_1000)
plot(df.x, df.n_10000)
legend('Std', 'n=10', 'n=100', 'n=1000', 'n=10000')