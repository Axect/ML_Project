import std.stdio : writeln;
import dnum.vector;
import dnum.stats;
import dnum.utils;

void main() {
  // ===========================================================================
  // XOR 3D
  // ===========================================================================
	auto w = weightInit(4, 1);
  auto x = Matrix([
      [0, 0, 1],
      [0, 1, 0],
      [1, 0, 0],
      [1, 1, 0],
  ]);
  auto t = Matrix([
    [0],
    [1],
    [1],
    [0],
  ]);

  auto y = train(w, x, t, 0.25, 20);
  y.writeln;
}

Matrix weightInit(int m, int n) {
	auto w = runif(m, -1, 1);
  switch(n) {
    case 1:
      break;
    default:
      foreach(i; 1 .. n) {
        w = cbind(w, runif(m, -1, 1));
      }
      break;
  }
  return w;
}

double activation(double x) {
  return x > 0 ? 1 : 0;
}

Matrix addBias(Matrix input, double bias = -1) {
  auto b = Matrix(bias, input.row, 1);
  auto x = cbind(b, input);
  return x;
}

Matrix forward(Matrix weight, Matrix inputb) {
  auto s = inputb % weight;
  auto g = VectorizeM(x => activation(x));
  return g(s);
}

Matrix train(Matrix weight, Matrix input, Matrix answer, double eta = 0.25, int times = 10) {
  auto x = input;
  auto xb = addBias(input, -1);
  auto w = weight;
  auto t = answer;
  foreach(i; 0 .. times) {
    auto y = forward(w, xb);
    w = w - xb.transpose % (y - t) * eta;
    w.writeln;
  }
  auto y = forward(w, xb);
  return y;
}