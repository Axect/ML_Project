import std.stdio : writeln;

import dnum.tensor;
import dnum.stats;
import dnum.linalg;
import dnum.utils;

void main() {
  auto weight = Tensor([64,66,68,69,73], false);
  auto score = Tensor([580,570,590,660,600], false);
  auto age = Tensor([29,33,37,46,55], false);

  auto m = cbind(weight, score).cbind(age);
  m.cmean.writeln;
}
