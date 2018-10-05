fn main() {
    let x: Vec<f64> = vec![1.0, 2.0, 3.0];
    let y: Vec<f64> = vec![3.0, 2.0, 1.0];
    println!("{}", cov_val(x,y));
}

type List = Vec<f64>;
type Matrix = Vec<Vec<f64>>;

fn mean(x: List) -> f64 {
    x.into_iter().fold(
        0f64,
        |x, y| x + y
    ) / (x.len() as f64)
}

fn var(x: List) -> f64 {
    let m = mean(x.clone());
    let l = x.len() as f64;
    x.into_iter().map(|x| (x - m).powf(2f64))
        .fold(0f64, |x, y| x + y) / (l - 1f64)
}

fn std(x: List) -> f64 {
    var(x).sqrt()
}

fn cov_val(x: List, y: List) -> f64 {
    let m_x = mean(x.clone());
    let m_y = mean(y.clone());
    let l = x.len() as f64;
    x.clone().into_iter().zip(y.into_iter())
        .map(|(x,y)| (x - m_x) * (y - m_y))
        .fold(0f64, |x,y| x + y) / (l - 1f64) 
}