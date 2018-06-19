mod stats;

use stats::{Vector, Statistics};

fn main() {
    let a: Vector = vec![1.,2.,3.,4.,5.,6.];
    println!("Vector: {:?}", a);
    println!("Mean: {}", a.mean());
    println!("Var: {}", a.var());
    println!("Std: {}", a.std());
}
