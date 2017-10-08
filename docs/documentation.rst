.. _documentation:

Documentation
=============
The project documentation under ``docs`` can be compiled using Cargo Sphinx.
Output is placed in ``docs/_build/html``.

::

    cargo sphinx

If this does not work, raise a bug then use the Makefile as fallback.

::

    cd docs
    make clean html

The development container provides an installation of Python and Sphinx which
can be used to build this documentation also. The latest published Cargo Sphinx
is also included.

Build the container as described in :ref:`dev`. Then change to the project root
directory and start the container with this directory mounted at
``/webassembly``.

::

    sudo rkt run \
        --interactive \
        --volume webassembly,kind=host,source=$(pwd) \
        dev-webassembly \
        --mount volume=webassembly,target=/webassembly

Inside the container, change directory to ``/webassembly`` and run the build
command.

::

    cargo sphinx

The compiled document is written to the shared location and is available on the
host machine under ``docs/_build/html``.

It is published to `woofwoofinc.github.io/webassembly`_ using `GitHub Pages`_.

.. _woofwoofinc.github.io/webassembly: https://woofwoofinc.github.io/webassembly
.. _GitHub Pages: https://pages.github.com

Publishing from the container fails for missing GitHub credentials. In this case
it is possible to run the publication command in the container interactively and
complete it on the host machine. Compile and generate the Git repository to push
in ``docs/_build/html`` by running the following in the container.

::

    cargo sphinx --push

Then on the host, change to ``docs/_build/html`` which is now a new Git
repository with the documentation HTML committed on master. Push this to origin
by specifying the remote.

::

    cd docs/_build/html
    git push -f git@github.com:woofwoofinc/webassembly.git master:gh-pages
