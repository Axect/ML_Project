import std.stdio : writeln;
import dnum.vector;
import dnum.stats;
import dnum.utils;

void main() {
	auto a = Matrix([[1,2],[3,4]]);
	a.writeln;
  auto res = a.lu;
	res[0].writeln;
	res[1].writeln;
	a.writeln;
}
