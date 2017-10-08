.. _dev:

Development Tools Container
===========================
The project source comes with a ``dev`` directory which contains a script for
building a rkt Ubuntu container with useful development tools.

To build this you must have a system with an installation of rkt and acbuild.
For macOS, the RktMachine_ project provides an xhyve-based VM running CoreOS
with installations of rkt, acbuild, docker2aci, and other useful container
tools.

.. _RktMachine: https://github.com/woofwoofinc/rktmachine


Building
--------
Build the container using the provided build script:

::

    ./dev-webassembly.acbuild.sh

This will make a ``dev-webassembly.oci`` in the directory. Convert this to
``dev-webassembly.aci`` for installation into rkt:

::

    gunzip < dev-webassembly.oci > dev-webassembly.oci.tar
    docker2aci dev-webassembly.oci.tar
    rm dev-webassembly.oci.tar
    mv dev-webassembly-latest.aci dev-webassembly.aci

Install this into rkt:

::

    rkt --insecure-options=image fetch ./dev-webassembly.aci

This container is intended for interactive use, so to run it with rkt use:

::

    sudo rkt run \
        --interactive \
        --port=8080-tcp:8080 \
        --volume webassembly,kind=host,source=$(pwd) \
        dev-webassembly \
        --mount volume=webassembly,target=/webassembly

The current working directory is available on the container at ``/webassembly``.
