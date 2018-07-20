import std.stdio : writeln;
import dnum.vector;
import dnum.stats;
import dnum.utils;

void main() {
	auto v = weightInit(3,2);
	auto w = weightInit(3,1);

	auto x = Matrix([
		[0, 0],
		[0, 1],
		[1, 0],
		[1, 1],
	]);

	auto t = Matrix([
		[0],
		[1],
		[1],
		[0],
	]);

	auto q = Matrix([
		[0.1],
		[0.2],
		[0.3],
		[0.4],
	]);

	auto y = train(v, w, x, t, 0.25, 10000);

	y.writeln;
}

Matrix weightInit(int m, int n) {
	auto w = runif(m, -1, 1);
	switch(n) {
		case 1:
			break;
		default:
			foreach(i; 1 .. n) {
				w = cbind(w, runif(m, -1, 1));
			}
			break;
	}
	return w;
}

double sigmoid(double x) {
	import std.math : exp;
	return 1 / (1 + exp(-x));
}

Matrix forward(Matrix weight, Matrix inputb) {
	auto s = inputb % weight;
	auto g = VectorizeM(x => sigmoid(x));
	return g(s);
}

Matrix addBias(Matrix input, double bias = -1) {
	auto b = Matrix(bias, input.row, 1);
	auto x = cbind(b, input);
	return x;
}

Matrix hideBias(Matrix weight) {
	auto w = Matrix(weight.data[1 .. weight.row][]);
	return w;
}

Matrix train(Matrix weight1, Matrix weight2, Matrix input, Matrix answer, double eta, int times) {
	auto x = input;
	auto v = weight1;
	auto w = weight2;
	auto t = answer;
	auto xb = addBias(x, -1);
	foreach(i; 0 .. times) {
		auto a = forward(v, xb);
		auto ab = addBias(a, -1);
		auto y = forward(w, ab);
		auto wb = hideBias(w);
		auto delo = (y - t) * y * (y * (-1) + 1);
		auto delh = (delo % wb.transpose) * a * (a * (-1) + 1);
		w = w - (ab.transpose % delo) * eta;
		v = v - (xb.transpose % delh) * eta;
	}
	auto a = forward(v, xb);
	auto ab = addBias(a, -1);
	auto y = forward(w, ab);
	return y;
}