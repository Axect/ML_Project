import std.stdio : writeln;
import std.math : PI;

import dnum.tensor;
import dnum.utils;
import dnum.stats;

/++
  Fastest ways - use foreach parallel fold
+/
void main() {
  import std.parallelism : taskPool;

  auto xs = runif(1000000, 0, 1);
  
  foreach (ref elem; taskPool.parallel(xs.data[0])) {
    elem = 4 / (1 + elem ^^ 2);
  }
  double pi = xs.psum;

  pi /= 1_000_000;
  pi.writeln;
}



/++
  Fastest ways - use foreach parallel with workerlocalstorage
+/
//void main() {
//  import std.parallelism : taskPool;
//
//  auto xs = runif(1000000, 0, 1); // Pick 100 uniform random values
//  auto pis = taskPool.workerLocalStorage(0.0);
//  foreach (x; taskPool.parallel(xs.data[0])) {
//    pis.get += 4 / (1 + x^^2);
//  }
//  
//  double pi = 0;
//  foreach (res; pis.toRange) {
//    pi += res;
//  }
//  pi /= 1000000;
//  pi.writeln;
//}

/++
  Second fastest - use fmap & parallel
+/
//void main() {
//  import std.parallelism : taskPool;
//  auto xs = runif(1000000, 0, 1);
//  double pi = taskPool.reduce!"a + b"(xs.fmap(x => 4 / (1 + x^^2)).data[0]);
//  pi /= 1000000;
//  pi.writeln;
//}

/++
  Slowest - vector ops
+/
//void main() {
//  auto xs = runif(1000000, 0, 1);
//  double pi = sum(4 / (1 + x^^2));
//  pi /= 1000000;
//  pi.writeln;
//}
