import std.stdio;
import std.random : uniform;
import dnum.vector;

void main() {
  auto a = Vector(1,10,2);
  a.writeln;
  auto b = runif(5, -1, 1);
  b.writeln;
  cbind(a,b).writeln;
  rbind(a,b).writeln;
}

// Matrix weightsInit(int m, int n) {
  
// }

Vector runif(int n, double a, double b) {
  import std.random : Random, unpredictableSeed;
  import std.array : array;
  import std.range : generate, takeExactly;

  auto rnd = Random(unpredictableSeed);

  double[] w = generate!(() => uniform(a, b)).takeExactly(n).array;

  return Vector(w);
}