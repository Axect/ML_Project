import std.stdio : writeln;

void main() {
  // auto a = Vector(1,10_000_001);
  // a.mean.writeln;
  // a.var.writeln;
  // a.std.writeln;
  auto b = Vector([1,2,3,4]);
  b.add(1).writeln;
  b.sub(1).writeln;
  b.mul(2).writeln;
  b.div(2).writeln;
  b.pow(2).writeln;
  b.sqrt.writeln;
  b.fmap(x => x ^^ x).writeln;
}

/++
  Vector is default class for Statistics
+/
struct Vector {
  import std.algorithm.iteration : sum, map;
  import std.range : iota;
  import std.array : array;
  import std.math : sqrt;
  
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
  pure long length() const {
    return this.comp.length;
  }
  
  // ===========================================================================
  //    Void Functions
  // ===========================================================================
  void add_void(T)(T x) {
    auto X = cast(double)x;
    this.comp = this.comp.map!(t => t + X).array;
  }

  void sub_void(T)(T x) {
    auto X = cast(double)x;
    this.comp = this.comp.map!(t => t - X).array;
  }

  void mul_void(T)(T x) {
    auto X = cast(double)x;
    this.comp = this.comp.map!(t => t * X).array;
  }

  void div_void(T)(T x) {
    auto X = cast(double)x;
    this.comp = this.comp.map!(t => t / X).array;
  }

  void pow_void(T)(T x) {
    auto X = cast(double)x;
    this.comp = this.comp.map!(t => t ^^ X).array;
  }

  void sqrt_void() {
    this.comp = this.comp.map!(t => t.sqrt).array;
  }

  void fmap_void(double delegate(double) f) {
    this.comp = this.comp.map!(t => f(t)).array;
  }

  // ===========================================================================
  //    Vector Function
  // ===========================================================================
  Vector fmap(double delegate(double) f) {
    Vector that = Vector(comp);
    that.fmap_void(f);
    return that;
  }

  Vector sqrt() {
    return fmap(t => t.sqrt);
  }

  Vector pow(T)(T x) {
    auto X = cast(double) x;
    return fmap((double t) => t ^^ X);
  }

  Vector add(T)(T x) {
    auto X = cast(double) x;
    return fmap(t => t + X);
  }

  Vector sub(T)(T x) {
    auto X = cast(double) x;
    return this.fmap(t => t - X);
  }

  Vector mul(T)(T x) {
    auto X = cast(double) x;
    return this.fmap(t => t * X);
  }

  Vector div(T)(T x) {
    auto X = cast(double) x;
    return this.fmap(t => t / X);
  }
  // ===========================================================================
  // Operator Overloading
  // ===========================================================================
  /++
    Getter
  +/
  double opIndex(size_t i) {
    return this.comp[i];
  }

  /++
    Setter
  +/
  void opIndexAssign(double value, size_t i) {
    this.comp[i] = value;
  }

  /++
    Binary Operator with Scalar
  +/
  Vector opBinary(string op)(double rhs) {
    Vector temp = Vector(this.comp);
    switch(op) {
      case "+":
        temp.add_void(rhs);
        break;
      case "-":
        temp.sub_void(rhs);
        break;
      case "*":
        temp.mul_void(rhs);
        break;
      case "/":
        temp.div_void(rhs);
        break;
      case "^^":
        temp.pow_void(rhs);
        break;
      default:
        break;
    }
    return temp;
  }

  /++
    Binary Operator with Vector
  +/
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
  pure double sum() const {
    return comp.sum;
  }
  
  pure double mean() const {
    return sum() / (cast(double)length);
  }

  double var() {
    Vector temp = Vector(comp);
    immutable m = mean;
    immutable l = cast(double)length - 1;
    return temp.comp.map!(t => (t - m)^^2).sum / l;
  }

  double std() {
    return sqrt(var);
  }
}
