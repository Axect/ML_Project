import std.algorithm.iteration : map, sum;

void main() {
    import std.stdio : writeln;
    import std.range : iota;
    import std.array : array;
    
    double[] a = iota(1,10_000_001).map!(x => cast(double)x).array;
    mean(a).writeln;
    var(a).writeln;
    std(a).writeln;
}

double mean(T)(T[] vec) {
    return vec.sum / vec.length;
}

double var(T)(T[] vec) {
    immutable double m = mean(vec);
    return cast(double)vec.map!(x => (x - m)^^2).sum / (cast(double)vec.length - 1);
}

double std(T)(T[] vec) {
    import std.math : sqrt;
    return sqrt(var(vec));
}