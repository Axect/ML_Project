import std.stdio : writeln;
import dnum.tensor;
import dnum.linalg;
import dnum.stats;
import dnum.utils;

void main() {
	auto w = weightInit(3, 1);
	w.writeln;
}

Tensor weightInit(int m, int n) {
	auto w = runif(m, -1, 1, false);
	switch(n) {
		case 1:
			break;
		default:
			foreach(i; 1 .. n) {
				w = cbind(w, runif(m, -1, 1, false));
			}
			break;
	}
	return w;
}
