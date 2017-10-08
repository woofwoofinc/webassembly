# ![WebAssembly](https://raw.githubusercontent.com/woofwoofinc/webassembly/master/docs/assets/title.png)

[![Build Status](https://travis-ci.org/woofwoofinc/webassembly.svg?branch=master)](https://travis-ci.org/woofwoofinc/webassembly)
[![License](https://img.shields.io/badge/license-Apache--2.0%20OR%20MIT-blue.svg)](https://github.com/woofwoofinc/webassembly#license)

Demo project for building [WebAssembly] projects using Rust.

[WebAssembly]: http://webassembly.org

Detailed documentation is provided in the [docs] directories and at
[woofwoofinc.github.io/webassembly].

[docs]: docs
[woofwoofinc.github.io/webassembly]: https://woofwoofinc.github.io/webassembly


Developing
----------
The project build stack uses the [Rust] development tools. Install these on your
system with [rustup] if they are not already available.

[Rust]: https://www.rust-lang.org
[rustup]: https://www.rustup.rs

[Emscripten] is needed to compile `.wasm` files. Install it using:

[Emscripten]: https://github.com/kripken/emscripten

    EMSCRIPTEN_VERSION=1.37.21
    wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz
    tar xzf emsdk-portable.tar.gz
    cd emsdk-portable
    
    emsdk update
    emsdk install emscripten-${EMSCRIPTEN_VERSION}
    emsdk install clang-e${EMSCRIPTEN_VERSION}-64bit

    emsdk activate emscripten-${EMSCRIPTEN_VERSION}
    emsdk activate clang-e${EMSCRIPTEN_VERSION}-64bit

Then add the location of the `emsdk-portable` directory,
`emsdk-portable/clang/e$EMSCRIPTEN_VERSION_64bit` and
`emsdk-portable/emscripten/$EMSCRIPTEN_VERSION` to your PATH.

Finally install the Rust WebAssembly target architecture.

    rustup target add wasm32-unknown-emscripten

The project build stack also uses [Node.js], the [Yarn] package manager, and the
[Webpack] module bundler. Install these on your system if they are not already
available.

[Node.js]: https://nodejs.org
[Yarn]: https://yarnpkg.com
[Webpack]: https://webpack.js.org

It is also useful to have the [Webpack development server] installed.

[Webpack development server]: https://github.com/webpack/webpack-dev-server

A [rkt] container build script is included in the project repository and
provides an installation which can be used to build the project also. See the
description on building and running the container in the Development Tools
Container section of the documentation for more information.

[rkt]: https://coreos.com/rkt

For macOS, [RktMachine] provides a CoreOS VM which supports developing using
the rkt container system.

[RktMachine]: https://github.com/woofwoofinc/rktmachine

For the Webpack build, first install [Literacy] and the other project
dependencies using Yarn.

[Literacy]: https://github.com/woofwoofinc/literacy

    $ yarn

Then run the Webpack development server to build and serve a test site.

    $ webpack-dev-server -d

**CAUTION:** See the documentation if developing on the included rkt container
or using RktMachine. Extra options are needed for the development server to be
reachable from the host machine.

The test site can be accessed via a browser on [localhost:8080].

[localhost:8080]: http://localhost:8080

To test the Rust project, use:

    $ cargo test
    
If you want to help extend and improve this project, then your contributions
would be greatly appreciated. Check out our [GitHub issues] for ideas or a
place to ask questions. Welcome to the team!

[GitHub issues]: https://github.com/woofwoofinc/webassembly/issues


License
-------
This work is dual-licensed under the Apache License, Version 2.0 and under the
MIT Licence.

You may license this work under the Apache License, Version 2.0.

    Copyright 2017 Woof Woof, Inc. contributors

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

Alternatively, you may license this work under the MIT Licence at your option.

    Copyright (c) 2017 Woof Woof, Inc. contributors

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

The license explainers at [Choose a License] may be helpful. They have
descriptions for both the [Apache 2.0 Licence] and [MIT Licence] conditions.

[Choose a License]: http://choosealicense.com
[Apache 2.0 Licence]: http://choosealicense.com/licenses/apache-2.0/
[MIT Licence]: http://choosealicense.com/licenses/mit/


Contributing
------------
Please note that this project is released with a [Contributor Code of Conduct].
By participating in this project you agree to abide by its terms. Instances of
abusive, harassing, or otherwise unacceptable behavior may be reported by
contacting the project team at woofwoofinc@gmail.com.

[Contributor Code of Conduct]: docs/conduct.rst

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.
