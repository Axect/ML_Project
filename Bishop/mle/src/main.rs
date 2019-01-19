extern crate peroxide;
use peroxide::*;

fn main() {
    let a = Normal(0, 1);
    let range = seq(-4, 4, 0.01);
    let mut records = zeros(range.len(), 6);
    records.subs_col(0, range.clone());
    records.subs_col(1, range.fmap(|x| a.pdf(x)));

    for i in 1 .. 5 {
        let sample = a.sample(10f64.powi(i) as usize);
        let (mu, sigma) = maximum_likelihood_estimate(sample);
        let b = Normal(mu, sigma);
        println!("mu: {}, sigma: {}", mu, sigma);
        records.subs_col((i+1) as usize, range.fmap(|x| b.pdf(x)))
    }

    records.write_with_header("data/mle.csv", vec!["x", "origin", "n_10", "n_100", "n_1000", "n_10000"]);
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
