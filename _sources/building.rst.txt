Building
========
The build stack uses the Rust_ development tools on your system. Install these
on your system with rustup_ if they are not already available.

.. _Rust: https://www.rust-lang.org
.. _rustup: https://www.rustup.rs

The following dependencies are also needed to build the project.

* CMake_: Needed by Cargo tool library dependency.
* Libssl_: Needed by Cargo tool library dependency.

.. _CMake: https://cmake.org
.. _Libssl: https://wiki.openssl.org/index.php/Libssl_API

Emscripten_ is needed to compile ``.wasm`` files. Install it using:

.. _Emscripten: https://github.com/kripken/emscripten

::

    EMSCRIPTEN_VERSION=1.37.21
    wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz
    tar xzf emsdk-portable.tar.gz
    cd emsdk-portable

    emsdk update
    emsdk install clang-e${EMSCRIPTEN_VERSION}-64bit
    emsdk install emscripten-${EMSCRIPTEN_VERSION}

    emsdk activate emscripten-${EMSCRIPTEN_VERSION}
    emsdk activate clang-e${EMSCRIPTEN_VERSION}-64bit

Then add the location of the ``emsdk-portable`` directory,
``emsdk-portable/clang/e$EMSCRIPTEN_VERSION_64bit``, and
``emsdk-portable/emscripten/$EMSCRIPTEN_VERSION`` to your PATH.

Finally install the Rust WebAssembly target architecture.

::

    rustup target add wasm32-unknown-emscripten

The build stack also uses `Node.js`_, the Yarn_ package manager, and the
Webpack_ module bundler. Install these on your system if they are not already
available.

.. _Node.js: https://nodejs.org
.. _Yarn: https://yarnpkg.com
.. _Webpack: https://webpack.js.org

It is also useful to have the `Webpack development server`_ installed.

.. _Webpack development server: https://github.com/webpack/webpack-dev-server

A rkt_ container build script is included in the project repository and
provides an installation which can be used to build the project also. See the
description on building and running the container in the :ref:`dev` section
of this document for details.

.. _rkt: https://coreos.com/rkt

For macOS, RktMachine_ provides a CoreOS VM which supports developing using
the rkt container system.

.. _RktMachine: https://github.com/woofwoofinc/rktmachine

For the Webpack build, first install Literacy_ and the other project
dependencies using Yarn.

.. _Literacy: https://github.com/woofwoofinc/literacy

::

    $ yarn

Then run the Webpack development server to build and serve a test site.

::

    $ webpack-dev-server -d

.. CAUTION::
   Use the following if developing on the included rkt container in this
   repository. The extra options are needed for the development server to be
   reachable from the host machine.

   .. code-block:: bash

       $ webpack-dev-server -d --host 0.0.0.0 --public rktmachine.local:8080

The test site can be accessed via a browser on
`localhost:8080 <http://localhost:8080>`_.

To test the Rust project, use:

::

    cargo test
