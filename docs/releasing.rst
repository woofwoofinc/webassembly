Releasing
=========

Publishing the Documentation
----------------------------
Project documentation is published to `woofwoofinc.github.io/webassembly`_
using `GitHub Pages`_.

.. _woofwoofinc.github.io/sketch-favicon: https://woofwoofinc.github.io/webassembly
.. _GitHub Pages: https://pages.github.com

First build the documentation as described in :ref:`documentation`.

The GitHub configuration for this project is to serve documentation from the
``gh-pages`` branch. Rather than attempt to build a new ``gh-pages`` in the
current repository, it is simpler to copy the repository, change to ``gh-pages``
in the repository copy, and clean everything from there. This has the advantage
of not operating in the current repository too so it is non-destructive.

Create a copy of the repository.

::

    cp -r webassembly webassembly-gh-pages

Then change into the new repository and swap to the ``gh-pages`` branch.

::

    pushd webassembly-gh-pages > /dev/null
    git checkout -b gh-pages

Clear out everything in the branch. This uses dot globing and extended glob
options to arrange deletion of everything except the .git directory.

::

    shopt -s dotglob
    shopt -s extglob
    rm -fr !(.git)

    shopt -u extglob
    shopt -u dotglob

Next, copy in the contents of ``docs/_build/html`` from the main project
repository. This is the latest build of the documentation. Dot globing is
used again since the dot files in the ``docs/_build/html`` directory are also
needed.

::

    shopt -s dotglob
    cp -r ../webassembly/docs/_build/html/* .

    shopt -u dotglob

Commit the documentation and push the ``gh-pages`` branch to GitHub.

::

    git add -A
    git commit -m "Add latest documentation."
    git push origin gh-pages

Then clean up the temporary repository.

::

    popd > /dev/null
    rm -fr webassembly-gh-pages