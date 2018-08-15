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

  auto t = Tensor([0, 1, 1, 0], Shape.Col);
  auto y = train(v, w, x, t, 0.25, 10000);

  y.writeln;
}

Tensor weightInit(int m, int n) {
  return rand(m, n).fmap(x => 2*x - 1);
}

pure double sigmoid(double x) {
  import std.math : exp;
  return 1 / (1 + exp(-x));
}

Tensor forward(Tensor weight, Tensor inputb) {
  auto s = inputb % weight;
  return s.fmap(x => sigmoid(x));
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
  Tensor a, ab, y, wb, delo, delh;
  foreach (i; 0 .. times) {
    a = forward(v, xb);
    ab = a.addBias;
    y = forward(w, ab);
    wb = hideBias(w);
    delo = (y - t) * y * (1 - y);
    delh = (delo % wb.t) * a * (1 - a);
    w = w - (ab.t % delo) * eta;
    v = v - (xb.t % delh) * eta;
  }
  a = forward(v, xb);
  ab = addBias(a, -1);
  y = forward(w, ab);
  return y;
}
