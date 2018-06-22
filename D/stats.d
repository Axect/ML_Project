import std.stdio : writeln;

void main() {
  auto a = Vector(1, 100_001);
  a.mean.writeln;
  auto b = Vector([1,2,3,4]);
  b.writeln;
  auto c = b + 1;
  c.writeln;
  (b + c).writeln;
}

/++
  Vector is default class for Statistics
+/
struct Vector {
  import std.algorithm.iteration : sum, map;
  import std.range : iota;
  import std.array : array;
  
  double[] comp;

  // ===========================================================================
  // Constructor
  // ===========================================================================
  this(double start, double end, double step = 1) {
    this.comp = iota(start, end, step).map!(x => cast(double)x).array;
  }

  this(double[] vec) {
    this.comp = vec;
  }
  // ===========================================================================
  // Basic Operator
  // ===========================================================================
  long length() {
    return this.comp.length;
  }
  
  void add(T)(T x) {
    auto X = cast(double)x;
    this.comp = this.comp.map!(t => t + X).array;
  }

  void sub(T)(T x) {
    auto X = cast(double)x;
    this.comp = this.comp.map!(t => t - X).array;
  }

  void mul(T)(T x) {
    auto X = cast(double)x;
    this.comp = this.comp.map!(t => t * X).array;
  }

  void div(T)(T x) {
    auto X = cast(double)x;
    this.comp = this.comp.map!(t => t / X).array;
  }
  // ===========================================================================
  // Operator Overloading
  // ===========================================================================
  Vector opBinary(string op)(double rhs) {
    Vector temp = Vector(this.comp);
    switch(op) {
      case "+":
        temp.add(rhs);
        break;
      case "-":
        temp.sub(rhs);
        break;
      case "*":
        temp.mul(rhs);
        break;
      case "/":
        temp.div(rhs);
        break;
      default:
        break;
    }
    return temp;
  }

  Vector opBinary(string op)(Vector rhs) {
    Vector temp = Vector(this.comp);
    switch(op) {
      case "+":
        foreach(i; 0 .. temp.length) {
          temp.comp[i] += rhs.comp[i];
        }
        break;
      case "-":
        foreach(i; 0 .. temp.length) {
          temp.comp[i] -= rhs.comp[i];
        }
        break;
      case "*":
        foreach(i; 0 .. temp.length) {
          temp.comp[i] *= rhs.comp[i];
        }
        break;
      case "/":
        foreach(i; 0 .. temp.length) {
          temp.comp[i] /= rhs.comp[i];
        }
        break;
      default:
        break;
    }
    return temp;
  }
  // ===========================================================================
  // Statistics Operator
  // ===========================================================================
  pure double mean() const {
    immutable s = this.comp.sum;
    immutable l = cast(double)this.comp.length;
    return s / l;
  }
}
