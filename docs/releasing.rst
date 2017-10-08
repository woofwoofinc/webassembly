Releasing
=========

Publishing the Documentation
----------------------------
Project documentation is published to `woofwoofinc.github.io/webassembly`_
using `GitHub Pages`_.

.. _woofwoofinc.github.io/webassembly: https://woofwoofinc.github.io/webassembly
.. _GitHub Pages: https://pages.github.com

Build and publish the documentation as described in :ref:`documentation`. The
GitHub configuration for this project is to serve documentation from the
``gh-pages`` branch.

::

    cargo sphinx --push

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
