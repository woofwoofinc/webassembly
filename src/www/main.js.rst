WebAssembly
-----------
Illustrate using a WebAssembly module compiled from Rust. Start by loading the
``.wasm`` code. This is generated from Rust source by the Webpack loader.

.. code-block:: javascript

    import wasm from '../lib.rs';

This creates ``wasm`` as a Promise resolving to a `WebAssembly.Instance`_.

.. _WebAssembly.Instance: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Instance

Unlike Emscripten, the LLVM backend for wasm-unknown-unknown target does not
provide linking for math functions. More details are in this
`StackOverflow question <https://stackoverflow.com/questions/47997306/rust-wasm32-unknown-unknown-math-functions-not-linking>`_.

To get round this, we provide JavaScript implementations for the missing
functions and the WebAssembly loader inserts these into the environment for the
loaded module.

The Rust random number generator causes an exception when used in WebAssembly
modules because it relies on ``/dev/random`` for implementation. Again, we stub
this out with the JavaScript ``Math.random`` from the browser. But in this
case we also follow `Rust and WebAssembly With Turtle`_ and create a Rust random
number generator backed by the JavaScript ``Math.random`` as an extern function.
This allows us to access the function in our Rust code for use since we need it
at compile time instead of just runtime.

.. _Rust and WebAssembly With Turtle: https://varblog.org/blog/2018/01/08/rust-and-webassembly-with-turtle/

.. code-block:: javascript

    const env =
      {
        'env': {
          exp: Math.exp,
          log: Math.log,
          javascript_math_random: Math.random,
        },
      };

Now load the module and collect the exported methods needed.

.. code-block:: javascript

    wasm(env).then(result => {
      const { normal } = result.instance.exports;

We can now use the function as if it were regular JavaScript.

.. code-block:: javascript

      console.log(normal());
      console.log(normal());
      console.log(normal());
      console.log(normal());
      console.log(normal());
      console.log(normal());
      console.log(normal());
    });
