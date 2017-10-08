#[macro_use]
extern crate lazy_static;
extern crate rand;
extern crate statrs;

use statrs::distribution::{Distribution, Normal};

lazy_static! {
    static ref NORMAL: Normal = Normal::new(0.0, 1.0).unwrap();
}

#[no_mangle]
pub fn normal() -> f64 {
    NORMAL.sample(&mut rand::thread_rng())
}

fn main() {}
