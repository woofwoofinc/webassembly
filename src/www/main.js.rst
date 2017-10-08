WebAssembly
-----------
Illustrate using a WebAssembly module compiled from Rust. Start by loading the
``.wasm`` code. This is generated from Rust source by the Webpack loader.

.. code-block:: javascript

    const wasm = require('../main.rs');

Next, initialize the WebAssembly module and create JavaScript wrappers for the
Rust functions contained in the module.

The Rust source must have a ``main`` function or it does not compile. However,
``exit(0)`` is implicit at the end of ``main`` which would cause the WebAssembly
runtime to exit. Pass ``noExitRuntime`` to the module initialisation to suppress
this behaviour.

.. code-block:: javascript

    wasm.initialize({ noExitRuntime: true }).then(module => {
      const normal = module.cwrap('normal', 'number', []);

We can now use the functions as if they were regular JavaScript.

.. code-block:: javascript

      console.log(normal());
      console.log(normal());
      console.log(normal());
      console.log(normal());
      console.log(normal());
      console.log(normal());
      console.log(normal());
    });
