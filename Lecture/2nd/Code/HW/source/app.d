import std.stdio;
import std.random : uniform;
import dnum.vector;
import dnum.stats;

void main() {
  auto w = weightsInit(3,1);
  w.writeln;
  auto f = Vectorize(s => activation(s));
  f(w.val).writeln;
  auto g = VectorizeM(s => activation(s));
  g(w).writeln;
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
  s.val.fmap_void(x => activation(x));
  return s;
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