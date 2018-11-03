extern crate peroxide;
use peroxide::*;

fn main() {
    let v = weights_init(3, 2);
    let w = weights_init(3, 1);

    let x = matrix(
        c!(0, 0, 1, 1, 0, 1, 0, 1),
        4,
        2,
        Col
    );

    println!("{}", x);

    let t = matrix(c!(0,1,1,0), 4, 1, Col);

    println!("{}", t);
    
    let y = train(v, w, x, t, 0.25, 5000);

    println!("{}", y);
}

// Weight Init
fn weights_init(m: usize, n: usize) -> Matrix {
    let w = rand!(m, n).change_shape();
    w.fmap(|x| 2_f64 * x - 1_f64)
}

// Sigmoid function
fn sigmoid(x: f64) -> f64 {
    1_f64 / (1_f64 + (-x).exp())
}

// Forward
fn forward(weight: &Matrix, inputb: &Matrix) -> Matrix {
    let s = inputb.clone() % weight.clone();
    s.fmap(|x| sigmoid(x))
}

fn add_bias(input: &Matrix, bias: f64) -> Matrix {
    let b = matrix(vec![bias; input.row], input.row, 1, Col);
    cbind!(b, input)
}

fn hide_bias(weight: &Matrix) -> Matrix {
    let v = weight.data.clone();
    let r = weight.row;
    let c = weight.col;
    matrix(v[c .. ].to_vec(), r - 1, c, weight.shape)
}

fn train(weight1: Matrix, weight2: Matrix, input: Matrix, answer: Matrix, eta: f64, times: usize) -> Matrix {
    let x = input;
    let mut v = weight1;
    let mut w = weight2;
    let t = answer;
    let xb = add_bias(&x, -1f64);
    for _i in 1 .. times {
        let a = forward(&v, &xb);
        let ab = add_bias(&a, -1f64);
        let y = forward(&w, &ab);
        let yt = y.clone() - t.clone();
        let _err = yt.transpose() % yt.clone();
        let wb = hide_bias(&w);
        let del_o = yt * y.clone() * (-y + 1f64);
        let del_h = (del_o.clone() % wb.transpose()) * a.clone() * (-a + 1f64);
        w = w - (ab.transpose() % del_o) * eta;
        v = v - (xb.transpose() % del_h) * eta;
    }
    let a = forward(&v, &xb);
    let ab = add_bias(&a, -1f64);
    let y = forward(&w, &ab);
    return y;
}
