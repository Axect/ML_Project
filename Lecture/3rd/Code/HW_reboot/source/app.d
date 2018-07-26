import std.stdio : writeln;
import dnum.tensor;
import dnum.linalg;
import dnum.stats;
import dnum.utils;

void main() {
  auto v = weightInit(3, 2);
	auto w = weightInit(3, 1);

  auto x = Tensor([
    [0, 0],
    [0, 1],
    [1, 0],
    [1, 1],
  ]);

  auto q = Tensor([1,2,3,4]);
  q.writeln;
  (1-q).writeln;
  (q * (1 - q)).writeln;
  q.writeln;

  auto t = Tensor([0, 1, 1, 0], false);
  auto y = train(v, w, x, t, 0.25, 10);

  y.writeln;
}

Tensor weightInit(int m, int n) {
	auto w = runif(m, -1, 1, false);
	switch(n) {
		case 1:
			break;
		default:
			foreach(i; 1 .. n) {
				w = cbind(w, runif(m, -1, 1, false));
			}
			break;
	}
	return w;
}

pure double sigmoid(double x) {
	import std.math : exp;
	return 1 / (1 + exp(-x));
}

Tensor forward(Tensor weight, Tensor inputb) {
	auto s = inputb % weight;
	auto g = vectorize(x => sigmoid(x));
  return g(s);
}

Tensor addBias(Tensor input, double bias = -1) {
  auto b = Tensor(bias, input.nrow, 1);
  auto x = cbind(b, input);
  return x;
}

Tensor hideBias(Tensor weight) {
  auto w = Tensor(weight.data[1 .. weight.nrow][]);
  return w;
}

Tensor train(Tensor weight1, Tensor weight2, Tensor input, Tensor answer, double eta, int times) {
  auto x = input;
  auto v = weight1;
  auto w = weight2;
  auto t = answer;
  auto xb = x.addBias;
  foreach (i; 0 .. times) {
    auto a = forward(v, xb);
    auto ab = a.addBias;
    auto y = forward(w, ab);
    auto wb = hideBias(w);
    auto delo = (y - t) * y * (1 - y);
    auto delh = (delo % wb.transpose) * a * (1 - a);
    w = w - (ab.transpose % delo) * eta;
    v = v - (xb.transpose % delh) * eta;
  }
  auto a = forward(v, xb);
  auto ab = addBias(a, -1);
  auto y = forward(w, ab);
  return y;
}
