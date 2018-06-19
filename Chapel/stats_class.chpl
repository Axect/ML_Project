use Math;

proc main() {
    var a = new STVector(int, 6);
    for i in a.D do a[i] = i; // [] and () no matter
    writeln(a);
    writeln(a + 2);
    writeln(a - 2);
    writeln(a * 2);
    writeln(a / 2);
    writeln(a.mean());

    delete a;
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

    proc pow(power: int) {
        for i in this.D {
            this[i] = this[i]**2;
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

    // proc variance(): numType {
    //     this.sub(this.mean()).pow(2).div(this.D.size);
    //     return + reduce this;
    // }
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

// =============================================================================
// Vector Ops with Vector
// =============================================================================
proc +(A, B: STVector(?T)): STVector(T) {
    assert(A.D == B.D);
    var N = new STVector(A);
    for i in N.D {
        N[i] += B[i];
    }
    return N;
}

proc -(A, B: STVector(?T)): STVector(T) {
    assert(A.D == B.D);
    var N = new STVector(A);
    for i in N.D {
        N[i] -= B[i];
    }
}

proc *(A, B: STVector(?T)): STVector(T) {
    assert(A.D == B.D);
    var N = new STVector(A);
    for i in N.D {
        N[i] *= B[i];
    }
    return N;
}

proc /(A, B: STVector(?T)): STVector(T) {
    assert(A.D == B.D);
    var N = new STVector(A);
    for i in N.D {
        N[i] /= B[i];
    }
    return N;
}