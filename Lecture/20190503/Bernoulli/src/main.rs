extern crate peroxide;
use peroxide::*;

fn main() {
    // Generate Data
    // 1. Coin
    let b1 = Bernoulli(0.5);
    let coin_data = b1.sample(100);
    // 2. Dice
    let b2 = Bernoulli(1./6.);
    let dice_data = b2.sample(100);

    // Maximum Likelihood
    // 1. Coin
    let coin_mle = mle(coin_data.clone());
    println!("Coin MLE : mu = {}", coin_mle);
    // 2. Dice
    let dice_mle = mle(dice_data.clone());
    println!("Dice MLE : mu = {}", dice_mle);

    // Bayesian
    // 1. Coin
    let mut coin_bayes = Beta(2f64, 2f64);
    for i in 0 .. 5 {
        let mut twenty_data = vec![0f64; 20];
        let start = 20*i;
        for j in 0 .. 20 {
            twenty_data[j] = coin_data[start + j];
        }
        coin_bayes = bayesian_update(coin_bayes, twenty_data);
        println!("Coin bayesian {:?}", coin_bayes);
    }
    // 2. Dice
    let mut dice_bayes = Beta(2f64, 2f64);
    for i in 0 .. 5 {
        let mut twenty_data = vec![0f64; 20];
        let start = 20*i;
        for j in 0 .. 20 {
            twenty_data[j] = dice_data[start + j];
        }
        dice_bayes = bayesian_update(dice_bayes, twenty_data);
        println!("Dice bayesian {:?}", dice_bayes);
    }
}

fn mle(data: Vec<f64>) -> f64 {
    let mut l = 0usize;
    let mut s = 0f64;

    for value in data.into_iter() {
        s += value;
        l += 1;
    }
    s / (l as f64)
}

fn bayesian_update(prior: TPDist<f64>, data: Vec<f64>) -> TPDist<f64> {
    let mut m = 0f64;
    let l: f64;
    let len = data.len() as f64;
    for value in data.into_iter() {
        if value == 1f64 {
            m += 1f64;
        }
    }
    l = len - m;

    match prior {
        Beta(a, b) => Beta(a + m, b + l),
        _ => unreachable!()
    }
}
