pub fn main() {
    let a: List = vec![1,3,5,4,2].into_iter().map(|x| x as f64).collect();
    println!("{}", mean(a.clone()));
    println!("{}", var(a.clone()));
    println!("{}", median(a.clone()));
    println!("{}", mode(a.clone()).expect("None!"));
    println!("{:?}", quick_sort(a.clone()));
}

type List = Vec<f64>;

fn mean(xs: List) -> f64 {
    xs.clone()
        .into_iter()
        .fold(
            0f64,
            |x, y| x + y
        ) / xs.len() as f64
}

fn var(xs: List) -> f64 {
    let m = mean(xs.clone());
    xs.clone().into_iter()
        .map(|x| (x - m).powf(2f64))
        .fold(
            0f64,
            |x, y| x + y
        ) / (xs.len() as f64 - 1f64)
}

fn median(xs: List) -> f64 {
    let qs = quick_sort(xs);
    let l = qs.len();
    if l%2 == 1 { qs[l / 2] } else { (qs[l / 2] + qs[l/2 - 1]) / 2f64 }
}

fn mode(xs: List) -> Option<f64> {
    let mut max: u32 = 0;
    let mut result: f64 = std::f64::MIN;
    for i in 0 .. xs.len() {
        let x = xs[i];
        let mut count = 1u32;
        for j in (i+1) .. xs.len() {
            if xs[j] == x {
                count += 1;
            }
        }
        if max < count {
            result = x;
            max = count;
        } else if max == count {
            result = std::f64::MIN;
        }
    }
    if result == std::f64::MIN {
        return None;
    }
    return Some(result);
}

fn quick_sort(xs: List) -> List {
    let l = xs.len();
    if l == 0 || l == 1 {
        return xs;
    }

    let p = xs[ l / 2 ];
    let mut less: Vec<f64> = Vec::new();
    let mut more: Vec<f64> = Vec::new();
    let mut equal: Vec<f64> = Vec::new();

    for x in xs {
        if x < p {
            less.push(x);
        } else if x > p {
            more.push(x);
        } else {
            equal.push(x);
        }
    }

    let mut result = quick_sort(less);
    let more_result = quick_sort(more);

    result.extend(equal);
    result.extend(more_result);

    return result;
}