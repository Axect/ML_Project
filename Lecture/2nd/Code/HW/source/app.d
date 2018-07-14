import std.stdio;
import std.random : uniform;
import dnum.vector;
import dnum.stats;

void main() {
  auto w = weightsInit(3,1);
  w.writeln;

  auto x = Matrix([
    [-1, 0, 0],
    [-1, 1, 0],
    [-1, 0, 1],
    [-1, 1, 1],
  ]);

  auto t = Matrix([
    [0],
    [1],
    [1],
    [1],
  ]);

  auto y = train(w, x, t, 0.25, 10);
  y.writeln;
  // auto f = Vectorize(s => activation(s));
  // f(w.val).writeln;
  // auto g = VectorizeM(s => activation(s));
  // g(w).writeln;
}

Matrix weightsInit(int m, int n) {
  auto w = runif(m, -1, 1);
  if (n == 1) {
    return w;
  } else {
    foreach(i; 1 .. n) {
      w = cbind(w, runif(m, -1, 1));
    }
    return w;
  }
}

double activation(double s) {
  return s > 0 ? 1 : 0;
}

Matrix output(Matrix weights, Matrix input) {
  auto s = input % weights;
  auto g = VectorizeM(x => activation(x));
  return g(s);
}

Matrix update(Matrix weights, Matrix input, Matrix answer, double eta = 0.25) {
  auto y = output(weights, input);
  auto w = weights - (input.transpose % (y - answer)) * eta;
  return w;
}

Matrix train(Matrix weights, Matrix input, Matrix answer, double eta = 0.25, int times = 10) {
  auto w = weights;
  foreach(i; 0 .. times - 1) {
    w = update(w, input, answer, eta);
    w.writeln;
  }
  return output(w, input);
}

// =============================================================================
// Should be implemented in DNumeric
// =============================================================================
Matrix runif(int n, double a, double b) {
  import std.random : Random, unpredictableSeed;

  auto rnd = Random(unpredictableSeed);

  double[] w;
  w.length = n;

  foreach(i; 0 .. n) {
    w[i] = uniform!"()"(a, b, rnd);
  }

  return Matrix(w, n, 1);
}

Vector delegate(Vector) Vectorize(double delegate(double) f) {
  return (v => v.fmap(f));
}

Matrix delegate(Matrix) VectorizeM(double delegate(double) f) {
  return (v => Matrix(v.val.fmap(f), v.row, v.col, v.byRow));
}