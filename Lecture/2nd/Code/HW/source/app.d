import std.stdio;
import std.random : uniform;
import dnum.vector;
import dnum.stats;

void main() {
  auto w = weightsInit(3,1);
  w.writeln;
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