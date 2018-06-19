use Math;

proc main() {
    var a = new StatsArray(int, 6);
    for i in a.D do a[i] = i; // [] and () no matter
    for i in a.D do write(a(i), ",");
    writeln();
    var b = a + a;
    writeln(b);

    delete a;
    delete b;
}

class StatsArray {
    type numType;
    var D: domain(1);
    var components: [D] numType;

    // Initializer
    proc StatsArray(type numType, length: int) {
        this.D = {1 .. #length};
    }

    // Copy
    proc StatsArray(other: StatsArray(?t), type numType = t) {
        this.D = other.D;
        this.components = other.components;
    }

    // Item - getter implementation
    proc this(i: int) ref: numType {
        return this.components[i];
    }

    // Iteration implementation
    iter these() ref: numType {
        for i in this.D {
            yield this[i];
        }
    }

    proc mean(): numType {
        return + reduce components;
    }
}



proc +(A, B: StatsArray(?t)): StatsArray(t) {
    assert(A.D == B.D);
    var N = new StatsArray(A);
    for i in N.D {
        N[i] += B[i];
    }
    return N;
}

proc -(A, B: StatsArray(?t)): StatsArray(t) {
    assert(A.D == B.D);
    var N = new StatsArray(A);
    for i in N.D {
        N[i] -= B[i];
    }
}