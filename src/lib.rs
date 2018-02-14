#[macro_use]
extern crate lazy_static;
extern crate rand;

use rand::Rng;
use rand::distributions::{IndependentSample, Normal};

///
/// A rand::Rng implementation which is safe for wasm-unknown-unknown.
///
/// Requires `javascript_math_random` to be an import identifier corresponding
/// to the browser's JavaScript Math.random function.
///
pub struct JavaScriptRng;

extern "C" {
    fn javascript_math_random() -> f64;
}

impl Rng for JavaScriptRng {
    fn next_u32(&mut self) -> u32 {
        unsafe {
            // The maximum value of a u32 is 4,294,967,295. We go one over here
            // because the JavaScript Math.random call returns values between
            // 0 (inclusive) and 1 (exclusive). Without the + 1 here, the floor
            // call would mean the maximum u32 value couldn't be returned.
            let upper: i64 = 4_294_967_295 + 1;
            let deviate: f64 = javascript_math_random() * (upper as f64);

            deviate.floor() as u32
        }
    }
}

lazy_static! {
    static ref NORMAL: Normal = Normal::new(0.0, 1.0);
}

///
/// Normal distribution example function.
///
#[no_mangle]
pub fn normal() -> f64 {
    NORMAL.ind_sample(&mut JavaScriptRng)
}
