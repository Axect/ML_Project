x = (0:0.01:1)';
y = x.^2 + rand(101,1) ./ 10;
f = fit(x, y, 'poly2');
plot(f, x, y)