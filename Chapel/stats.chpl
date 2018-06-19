use Math;

proc main() {
    var a: [1 .. 10000000] int;
    forall i in a.domain do a[i] = i;
    writeln(mean(a));
    writeln(variance(a));
    writeln(std(a));
}

proc mean(vec: [?D] ?t): real(64) {
    var s = 0;
    for x in vec.domain {
        s += x;
    }
    return (s: real(64)) / vec.size;
}

proc variance(vec: [?D] ?t): real(64) {
    var m = mean(vec);
    var s: real(64) = 0;
    for x in vec.domain {
        s += ((x: real(64)) - m) ** 2;
    }

    return (s: real(64)) / (vec.size - 1);
}

proc std(vec: [?D] ?t): real(64) {
    return sqrt(variance(vec));
}