extern crate peroxide;
use peroxide::*;

fn main() {
    let a = Normal::new(0, 1);

    for i in 1 .. 5 {
        let sample = a.sample(10f64.powi(i) as usize);
        let (mu, sigma) = maximum_likelihood_estimate(sample);
        let b = Normal::new(mu, sigma);
        println!("{:?}", b);
    }
}

fn maximum_likelihood_estimate(samples: Vec<f64>) -> (f64, f64) {
    let l = samples.len();
    let n = l as f64;

    let mu = samples.reduce(0., |x, y| x + y) / n;
    let sigma = (samples
        .fmap(|x| (x - mu).powi(2))
        .reduce(0., |x, y| x + y) / n).sqrt();
    (mu, sigma)
}
