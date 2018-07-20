import std.stdio : writeln;
import dnum.vector;
import dnum.stats;
import dnum.utils;

void main() {
	auto a = Matrix([[1,2],[3,4]]);
	a.writeln;
	a.inv.writeln;
	a.writeln;
	writeln(a % a);
}