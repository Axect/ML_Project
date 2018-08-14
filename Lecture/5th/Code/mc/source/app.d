import std.stdio : writeln;
import std.math : PI;

import dnum.tensor;
import dnum.utils;
import dnum.stats;

/++
  Fastest ways - use foreach
+/
//void main() {
//  auto xs = runif(1000000, 0, 1); // Pick 100 uniform random values
//  double pi = 0;
//
//  foreach (x; xs.data[0]) {
//    pi += 4 / (1 + x^^2);
//  }
//  pi /= 1000000;
//  pi.writeln;
//}

/++
  Second fastest - use fmap
+/
void main() {
  auto xs = runif(1000000, 0, 1);
  double pi = xs.fmap(x => 4 / (1 + x^^2)).sum;
  pi /= 1000000;
  pi.writeln;
}

/++
  Slowest - vector ops
+/
//void main() {
//  auto xs = runif(1000000, 0, 1);
//  double pi = sum(4 / (1 + x^^2));
//  pi /= 1000000;
//  pi.writeln;
//}
