pub fn main() {
    let a: Vector = (1..1000_0000+1).map(|x| x as f64).collect();
    println!("Mean: {}", a.mean());
    println!("Var: {}", a.var());
    println!("Std: {}", a.std());
}

trait Statistics {
    fn mean(&self) -> f64;
    fn var(&self) -> f64;
    fn std(&self) -> f64;
}

type Vector = Vec<f64>;

impl Statistics for Vector {
    fn mean(&self) -> f64 {
        let l = self.len() as f64;
        self.into_iter().fold(0f64, |x, y| x + y) / l
    }
    fn var(&self) -> f64 {
        let l = self.len();
        let mut s: f64 = 0f64;
        let m = self.mean();
        for i in 0 .. l {
            s +=  (self[i] - m).powf(2.) / (l as f64 - 1f64);
        }
        return s;
    }
    fn std(&self) -> f64 {
        self.var().sqrt()
    }
}

