#!/usr/bin/env bash

set -xe


################################################################################
# Setup
################################################################################

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TMP_DIR="$(mktemp -d -p "$DIR" dev-webassembly.XXXXXX)"
pushd "$TMP_DIR" > /dev/null


################################################################################
# Download Base Image
################################################################################

wget http://cdimage.ubuntu.com/ubuntu-base/releases/17.04/release/ubuntu-base-17.04-base-amd64.tar.gz


################################################################################
# Start Image Build
################################################################################

acbuild begin --build-mode=oci ./ubuntu-base-17.04-base-amd64.tar.gz


################################################################################
# Basic Development Tools
################################################################################

acbuild run -- apt-get update -qq
acbuild run -- apt-get upgrade -qq

acbuild run -- apt-get install -qq wget
acbuild run -- apt-get install -qq build-essential
acbuild run -- apt-get install -qq pkg-config
acbuild run -- apt-get install -qq git
acbuild run -- apt-get install -qq jq


################################################################################
# Sphinx
################################################################################

# Python pip is in Ubuntu universe.
acbuild run -- apt-get install -qq software-properties-common
acbuild run -- apt-add-repository universe
acbuild run -- apt-get update -qq

acbuild run -- apt-get install -qq python2.7
acbuild run -- apt-get install -qq python-pip
acbuild run -- pip install -q --upgrade pip

acbuild run -- pip install -q Sphinx
acbuild run -- pip install -q sphinx_bootstrap_theme


################################################################################
# Rust
################################################################################

acbuild run -- apt-get install -qq curl graphviz cmake libssl-dev

acbuild run -- curl -sSf https://sh.rustup.rs -o rustup.sh
acbuild run -- sh rustup.sh -y
acbuild run -- rm rustup.sh

# The PATH locations for the Rust binaries are automatically added to .profile
# but this isn't read when the Bash entry point is executed in the container.
acbuild run -- bash -c 'echo "export PATH=\"\$HOME/.cargo/bin:\$PATH\"" >> /root/.bashrc'

acbuild run -- /root/.cargo/bin/cargo install rustfmt
acbuild run -- /root/.cargo/bin/cargo install cargo-sphinx
acbuild run -- /root/.cargo/bin/cargo install cargo-outdated

acbuild run -- /root/.cargo/bin/rustup install nightly
acbuild run -- /root/.cargo/bin/rustup run nightly cargo install clippy


################################################################################
# Emscripten
################################################################################

EMSCRIPTEN_VERSION=1.37.21

acbuild run -- /root/.cargo/bin/rustup target add wasm32-unknown-emscripten

acbuild run -- wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz
acbuild run -- tar xzf emsdk-portable.tar.gz -C /opt
acbuild run -- rm emsdk-portable.tar.gz

acbuild run -- /opt/emsdk-portable/emsdk update
acbuild run -- /opt/emsdk-portable/emsdk install clang-e${EMSCRIPTEN_VERSION}-64bit
acbuild run -- /opt/emsdk-portable/emsdk install emscripten-${EMSCRIPTEN_VERSION}

acbuild run -- /opt/emsdk-portable/emsdk activate clang-e${EMSCRIPTEN_VERSION}-64bit
acbuild run -- /opt/emsdk-portable/emsdk activate emscripten-${EMSCRIPTEN_VERSION}

# Add the PATH locations for the Emscripten binaries.
acbuild run -- bash -c "echo \"EMSCRIPTEN_VERSION=${EMSCRIPTEN_VERSION}\" >> /root/.bashrc"
acbuild run -- bash -c 'echo "export PATH=\"/opt/emsdk-portable:\$PATH\"" >> /root/.bashrc'
acbuild run -- bash -c 'echo "export PATH=\"/opt/emsdk-portable/clang/e$EMSCRIPTEN_VERSION_64bit:\$PATH\"" >> /root/.bashrc'
acbuild run -- bash -c 'echo "export PATH=\"/opt/emsdk-portable/emscripten/\$EMSCRIPTEN_VERSION:\$PATH\"" >> /root/.bashrc'


################################################################################
# Node
################################################################################

NODE_VERSION=6.11.4

acbuild run -- wget -q https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz
acbuild run -- tar xJf node-v${NODE_VERSION}-linux-x64.tar.xz -C /usr/ --strip-components=1
acbuild run -- rm node-v${NODE_VERSION}-linux-x64.tar.xz


################################################################################
# Yarn
################################################################################

YARN_VERSION=1.1.0

acbuild run -- wget -q https://github.com/yarnpkg/yarn/releases/download/v${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz
acbuild run -- tar xzf yarn-v${YARN_VERSION}.tar.gz -C /usr/ --strip-components=1
acbuild run -- rm yarn-v${YARN_VERSION}.tar.gz


################################################################################
# Webpack
################################################################################

acbuild run -- yarn global add --no-progress webpack@3.6.0
acbuild run -- yarn global add --no-progress webpack-dev-server@2.9.1


################################################################################
# Finalise Image
################################################################################

acbuild run -- apt-get -qq autoremove
acbuild run -- apt-get -qq clean

acbuild port add 8080-tcp tcp 8080

acbuild set-exec -- /bin/bash
acbuild write --overwrite ../dev-webassembly.oci

acbuild end


################################################################################
# Teardown
################################################################################

popd > /dev/null
rm -fr "$TMP_DIR"
