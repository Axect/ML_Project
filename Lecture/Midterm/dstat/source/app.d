import std.stdio : writeln;

import dnum.tensor;
import dnum.stats;
import dnum.linalg;
import dnum.utils;

void main() {
  auto weight = Tensor([64,66,68,69,73], Shape.Col);
  auto score = Tensor([580,570,590,660,600], Shape.Col);
  auto age = Tensor([29,33,37,46,55], Shape.Col);

  auto m = cbind(weight, score, age);

  // 1. Find Covariance Matrix
  m.cov.writeln;

  // 2. Correlation
  m.cor.writeln;

  // 3. Person
  auto p = Tensor([66, 640, 44], Shape.Col);
  //p.writeln;
  //m.cmean.transpose.writeln;
  //m.cov.inv.writeln;
  mahalanobis(p, m).writeln;
}

auto mahalanobis(Tensor p, Tensor dat) {
  import std.math : sqrt;

  auto ms = dat.cmean.transpose;
  auto cs = dat.cov;
  return sqrt(((p - ms).transpose % cs.inv % (p - ms))[0,0]);
}

