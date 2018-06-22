use Math;

proc main() {
    var a: [1 .. 10000000] int;
    forall i in a.domain do a[i] = i;
    writeln(mean(a));
    writeln(variance(a));
    writeln(std(a));

    writeln([1,2,3,4] + [1,2,3,4]);
}

proc mean(vec: [?D] ?t): real(64) {
    var l = 0;
    var s = 0;
    for x in vec.domain {
        l += 1;
        s += x;
    }
    return (s: real(64)) / (l: real(64));
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

proc +(v1: [?D] ?T, v2: [D] T): [D] T {
  var v: [D] T;
  forall i in v.domain {
    v[i] = v1[i] + v2[i];
  }
  return v;
}
