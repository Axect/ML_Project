import std.stdio : writeln;

void main() {
  piMC(1_000_000).writeln;
  
}

struct PiGen {
  import std.random : Random, uniform01;

  auto rnd = Random(42);
  double x;

  enum empty = false;

  double front() const @property {
    return 4 / (1 + x ^^ 2);
  }

  void popFront() {
    x = uniform01(rnd);
  }
}

double piMC(long n) {
  import std.range : take;
  import std.parallelism : taskPool;
  import std.algorithm.iteration : sum;
  
  long t = 0;

  PiGen p;
  p.popFront;
  double result = take(p, n).sum;

  return result / n;
}
