extern crate rand;
extern crate statrs;

use rand::StdRng;
use statrs::distribution::{Distribution, Normal};

fn main() {}

#[no_mangle]
pub fn normal() -> f64 {
    let mut r = StdRng::new().unwrap();
    let n = Normal::new(0.0, 1.0).unwrap();

    return n.sample::<StdRng>(&mut r);
}
