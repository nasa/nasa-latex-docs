.. Create reference to page
.. _BuildPDF:

###########################################
Build Script: buildPDF.py
###########################################

.. contents::
   :local:
   :backlinks: none

Overview
###########################################

The ``buildPDF.py`` is an incredibly versatile, OS independent, Python build script with preconfigured Latexmk options for easy document type-setting and warning/error detection. The ``buildPDF.py`` script performs all the required functions for building any LaTeX document including generating the final PDF as well as building the bibliography, glossary, and acronym databases. 

Usage of ``buildPDF.py`` is simple and a help menu can be generated at any point by running the following:

.. code-block:: bash

   python ./support/buildPDF.py --help

or 

.. code-block:: bash

   python ./support/buildPDF.py -h

This script is an executable and may also be called through the following (if Python environment is already setup). This is the preferred method and, since most users will already have Python environment already configured, likely that way that most users will call the script:

.. code-block:: bash

   ./support/buildPDF.py -h

General Script Usage
###########################################

Assuming you have created a new document (see :ref:`CreateNewDocument`) are trying to build a file named ``MyDocument.tex``, the script may be called as follows from within the root of your newly created documented folder:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex <OPTIONS>

Example usage of passing example :ref:`BuildScriptOptions`

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex -f -c -v

Or using a combination of short name and long name for the options

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex -f --clean -v

Or these inputs may even me strung together as follows:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex -fcv

.. _BuildScriptOptions:

Script Options
###########################################

The following ``buildPDF.py`` options are flags the perform certain functions within the script during or after the build.


Option: ``-h`` or ``--help``
===========================================

Prints a simple version of the option descriptions to the user’s screen for quick reference. Whenever this option is passed, no other option is enabled and a **build will not take place**.

Option: ``-v`` or ``--verbose``
===========================================

Prints additional information to screen during the build for debugging and informational purposes.

Option: ``-q`` or ``--quiet``
===========================================

Suppress all console output to screen from build process. Useful when running a batch process or for integration into continuous development pipelines.

Option: ``-f`` or ``--force``
===========================================

Sometimes users make changes that do not trigger a build, this options allows a force build not matter if changes are detected by ``latexmk``.

Option: ``-w`` or ``--watch``
===========================================

This option enables a continuous build capability by watching for file changes, i.e. upon a user saving a file, and will automatically trigger a build. In a command prompt, users can run the following command from within their document:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex --watch

This will run a continuous process in that command prompt and the user can now work on the document in any text editor they choose! Each time they save a file in their text editor, the document will build and the changes reflected in whatever PDF viewer the user has open.

.. hint::
    This essentially allows you to turn **any combination** of text editor and PDF viewer you choose into your own customized ``LaTeX`` integrated development environment (IDE) and not being forced to use an existing IDE: e.g. ``TeXShop``, ``TexMaker``, ``TeXStudio``, etc...

Option: ``-c`` or ``--clean``
===========================================

This option removes the ``tmp/`` directory housing the :ref:`TemporaryBuildArtifacts` that is created in each document folder. This folder houses all of the build auxiliary and log files. There is really no reason to ever delete the tmp/ directory unless the document is complete or you suspect that some of the files have become stale and are causing erroneous build failures or unexpected build behavior. When the tmp/ directory is deleted, the document will be re-built from scratch which typically takes longer the first time around - often requiring several passes.

Option: ``-l`` or ``--latexpath``
===========================================

This option adds the location of the user desired LaTeX distribution installed on their machine for use when building the document. The user input is added to the **front** of the ``PATH`` environment to ensure that it is used. 

Example usage for the typical LaTeX installation location on a Mac:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex --latexpath /Library/TeX/texbin

Option: ``-t`` or ``--texinputs``
===========================================

This option may be used to point to a location on the users computer that is not located within the current document to add to the search path. This may be useful for common ``.tex`` or ``.bib`` files that are used often across multiple projects. For example, instead of copying an instance of an acronyms database to each new document, you can simply point to the directory path (the :``~/Documents/common/latex`` path is used here as an example) with the ``--texinputs`` option:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex --texinputs ~/Documents/common/latex

Anything under ``~/Documents/common/latex`` will be recursively added to the ``LaTeX`` search path during the build so that it is available for use in your current document. This folder may contain any number of items that you find common across multiple documents.

Option: ``-o`` or ``--output``
===========================================

By default a ``.tex`` file named ``MyDocument.tex``, for example,  will be typeset to a PDF file name ``MyDocument.pdf``. The ``--output`` option may be used to rename the output of a given build:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex --output Technical_Report_v3.pdf

The output may even be rerouted to a new location:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex --output ~/Desktop/Technical_Report_v3.pdf

Option: ``-p`` or ``--preview``
===========================================

This option launches a PDF previewer after a successful build for the resulting PDF. The default preview program on a Mac is ``preview``, on Linux is ``evince``, and on Windows ``SumatraPDF`` (`link <https://www.sumatrapdfreader.org/download-free-pdf-viewer.html>`_). For example, running the following on a Mac:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex -p

Will result in a Mac :code:`preview` window opening with the latest PDF build. One issue with using the Mac :code:`preview` program is that it does not effectively load new PDFs without resetting the document location. A much better option is to use `Skim <http://skim-app.sourceforge.net/>`_ if it is installed on the computer. Assuming it is, it may be used as the preview program by simply doing the following:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex -p Skim

The same applies for any other platform and user choice of PDF viewer.

Option: ``-n`` or ``--new``
===========================================

This option is used to create new documents as described in :ref:`CreateNewDocument`.

Option: ``--update``
===========================================

Suppose you create a document and start working on it. Some time later the ``nasa-latex-docs`` `Github Repository <https://github.com/nasa/nasa-latex-docs>`_ is updated with a new feature that you want to add to your document. The ``--update`` option is available to make that easy! Simply call ``--update`` from within your document and the latest version of the ``nasa-latex-docs`` will be automatically fetched from `Github <https://github.com/nasa/nasa-latex-docs>`_ and update the relevant ``support`` files in your document.

.. code-block:: bash

   ./support/buildPDF.py --update

This option **does not** modify any user content so there is no risk of losing any work. This command will simple replace the ``support`` directory of your document with the latest version. Now, you can use the new feature in your existing document and continue adding content!

Option: ``--standalone-pdf``
===========================================

This option allows you to convert any ``LaTeX`` snippet into a standalone, cropped, PDF. Suppose you have the following content in a file called ``snippet.tex`` and nothing more, i.e: no ``docuemntclass``, no preamble, no ``begindocument``, but rather JUST a raw ``LaTeX`` snippet:

.. literalinclude:: /static/snippets/one_figure_one_caption.tex
   :language: latex

You can then build this small snippet in a "standalone" mode as follows:

.. code-block:: bash

   ./support/buildPDF.py snippet.tex --standalone-pdf

The output of the above command will be a ``snippet.pdf`` (seen below) file that will be fully cropped to only contain the content created by your snippet! This option is incredibly useful for creating cropped ``LaTeX`` outputs that can then be used in presentations, emails, other documents, and any where else the user may have find useful.

.. image:: /static/snippets/one_figure_one_caption.png
   :align: center

Option: ``--standalone-png``
===========================================

This option operates just like the example above except the output will be a ``snippet.png``

.. code-block:: bash

   ./support/buildPDF.py snippet.tex --standalone-png

Option: ``--standalone-all``
===========================================

This option operates just like the examples above except will produce **both** outputs: ``snippet.pdf`` and ``snippet.png``.

.. code-block:: bash

   ./support/buildPDF.py snippet.tex --standalone-all

