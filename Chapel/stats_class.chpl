use Math;

proc main() {
    var a = new STVector(int, 6);
    for i in a.D do a[i] = i; // [] and () no matter

    var b = new STVector(a, real(64));
    writeln(a);
    writeln(b);
    writeln(a + 2);
    writeln(a - 2);
    writeln(a * 2);
    writeln(a / 2);
    writeln(a.mean());
    writeln(a.variance());
    writeln(a.std());

    delete a;
    delete b;
}
// =============================================================================
// STVector Class
// =============================================================================
class STVector {
    type numType;
    var D: domain(1);
    var components: [D] numType;

    // Initializer
    proc STVector(type numType, length: int) {
        this.D = {1 .. #length};
    }

    // Copy
    proc STVector(other: STVector(?t), type numType = t) {
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
    
    // =========================================================================
    // Basic Operation
    // =========================================================================
    proc add(s: numType) {
        for i in this.D do this[i] += s;
    }

    proc sub(s: numType) {
        for i in this.D do this[i] -= s;
    }

    proc mul(s: numType) {
        for i in this.D do this[i] *= s;
    }

    proc div(s: numType) {
        for i in this.D do this[i] /= s;
    }

    proc pow(power: ?t) {
        for i in this.D {
            this[i] = this[i] ** power;
        }
    }

    proc sqrt() {
        for i in this.D {
            this[i] = Math.sqrt(this[i]): numType;
        }
    }
    
    // =========================================================================
    // Statistics Ops
    // =========================================================================
    proc mean(): real(64) {
        return ((+ reduce this): real(64)) / this.D.size;
    }

    proc variance(): real(64) {
        var temp = new STVector(this, real(64));
        return (+ reduce ((temp - this.mean())**2)) / (this.D.size - 1);
    }

    proc std(): real(64) {
        return Math.sqrt(this.variance());
    }
}

// =============================================================================
// Vector Ops with Scalar
// =============================================================================
proc +(A: STVector(?T), s: T): STVector(T) {
    var B = new STVector(A);
    B.add(s);
    return B;
}

proc -(A: STVector(?T), s: T): STVector(T) {
    var B = new STVector(A);
    B.sub(s);
    return B;
}

proc *(A: STVector(?T), s: T): STVector(T) {
    var B = new STVector(A);
    B.mul(s);
    return B;
}

proc /(A: STVector(?T), s: T): STVector(T) {
    var B = new STVector(A);
    B.div(s);
    return B;
}

proc **(A: STVector(?T), s: T): STVector(T) {
    var B = new STVector(A);
    B.pow(s);
    return B;
}

// =============================================================================
// Vector Ops with Vector
// =============================================================================
proc +(A, B: STVector(?T)): STVector(T) {
    assert(A.D == B.D, "Domain mismatch!");
    var N = new STVector(A);
    for i in N.D {
        N[i] += B[i];
    }
    return N;
}

proc -(A, B: STVector(?T)): STVector(T) {
    assert(A.D == B.D, "Domain mismatch!");
    var N = new STVector(A);
    for i in N.D {
        N[i] -= B[i];
    }
}

proc *(A, B: STVector(?T)): STVector(T) {
    assert(A.D == B.D, "Domain mismatch!");
    var N = new STVector(A);
    for i in N.D {
        N[i] *= B[i];
    }
    return N;
}

proc /(A, B: STVector(?T)): STVector(T) {
    assert(A.D == B.D, "Domain mismatch!");
    var N = new STVector(A);
    for i in N.D {
        N[i] /= B[i];
    }
    return N;
}