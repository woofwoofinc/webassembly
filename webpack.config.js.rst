WebAssembly
===========
For an introduction to Webpack_, the following two resources are recommended.

* `Getting Started With Webpack 2`_ Medium post by Drew Powers,
* The article series at SurviveJS_.

See the project README and `project documentation`_ for build instructions and
command lines.

.. _Webpack: https://webpack.js.org
.. _Getting Started With Webpack 2: https://blog.madewithenvy.com/getting-started-with-webpack-2-ed2b86c68783
.. _SurviveJS: https://survivejs.com
.. _project documentation: https://woofwoofinc.github.io/webassembly

Webpack does not normally incorporate ``index.html`` into the build. For deploy
convenience we want to copy ``index.html`` to the ``dist`` output directory so
that it forms a complete site. The copy-webpack-plugin allows us to do this, to
copy files and directory structures to the output.

.. code-block:: javascript

    const CopyWebpackPlugin = require('copy-webpack-plugin');

Webpack output and build operations are configured by the ``module.exports`` of
the configuration module we define in this file.

.. code-block:: javascript

    const path = require('path');

    module.exports = {

Enable ``.js.rst`` requires without suffix.

.. code-block:: javascript

      resolve: {
        extensions: ['.js', '.json', '.js.rst']
      },

Build from ``src/www`` into ``dist``.

.. code-block:: javascript

      context: path.resolve(__dirname, './src/www'),
      output: {
        path: path.resolve(__dirname, 'dist'),
        filename: '[name].bundle.js'
      },

Webpack uses the ``entry`` object to list the start files to process.
Dependencies required in these files are also processed and their dependencies,
etc. The path is relative to the ``context`` directory specified in the previous
block.

.. code-block:: javascript

      entry: {
        main: './main'
      },

Generate source maps to show original ``.rst.js`` files in browser debugger
tools.

.. code-block:: javascript

      devtool: 'source-map',

Plugins are enabled by listing them in ``plugins`` with their configurations.

.. code-block:: javascript

      plugins: [

For CopyWebpackPlugin to copy ``index.html`` to the output directory.

.. code-block:: javascript

        new CopyWebpackPlugin([
          { from: 'index.html' }
        ])
      ],

The ``module.rules`` block is where Webpack finds out which and how we want it
to process our files. Each rule has a ``test`` property specifying the files to
apply the rule to by their filenames. The ``loader`` and ``options`` in the rule
define how the given file should be processed. Different loaders are used for
different file types and handling.

.. code-block:: javascript

      module: {
        rules: [

Include a rule in ``modules.exports.modules`` for handing ``.js.rst`` files.

.. code-block:: javascript

          {
            test: /\.js\.rst$/,
            use: [
              'eslint-loader',
              'literacy-loader',
            ]
          },

Rule for building Rust files by shelling out to cargo. Make sure to use the
release build or will see "indirect call signature mismatch" errors.

.. code-block:: javascript

          {
            test: /\.rs$/,
            use: [
              'wasm-loader',
              {
                loader: 'rust-native-wasm-loader',
                options: {
                  release: true,
                  gc: true
                }
              }
            ]
          }
        ]
      },

Emscripten requires ``fs`` and ``path`` from Node and emits require references
but they are unused in the browser. Instruct Webpack to omit them.

.. code-block:: javascript

      externals: {
        'fs': true,
        'path': true,
      }
    };
