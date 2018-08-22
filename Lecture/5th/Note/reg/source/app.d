import std.stdio : writeln;

import dnum.tensor;
import dnum.utils;
import dnum.stats;
import dnum.csv;

void main() {
  auto df = readcsv("data.csv", true);
  auto line = Linear(df.data.col(1), df.data.col(2));
  line.writeln;
}

struct Linear {
  double slope;
  double intercept;

  this(Tensor X, Tensor Y) {
    assert(X.nrow == Y.nrow);

    double n = cast(double)X.nrow;

    this.slope = (n * sum(X * Y) - sum(X) * sum(Y)) / (n*sum(X^^2) - sum(X)^^2);
    this.intercept = 1/n * (sum(Y) - this.slope * sum(X));
  }
}
