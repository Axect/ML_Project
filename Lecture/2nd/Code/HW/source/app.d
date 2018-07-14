import std.stdio;
import std.random : uniform;
import dnum.vector;
import dnum.stats;

void main() {
  auto a = Vector(1,10,2);
  a.writeln;
  auto b = runif(5, -1, 1);
  b.writeln;
  cbind(a,b).writeln;
  rbind(a,b).writeln;
  b.mean.writeln;
}

// Matrix weightsInit(int m, int n) {
  
// }

Vector runif(int n, double a, double b) {
  import std.random : Random, unpredictableSeed;

  auto rnd = Random(unpredictableSeed);

  double[] w;
  w.length = n;

  foreach(i; 0 .. n) {
    w[i] = uniform!"()"(a, b, rnd);
  }

  return Vector(w);
}