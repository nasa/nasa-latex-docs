.. Create reference to page
.. _QuickStartGuide:

###########################################
Quick Start Guide
###########################################

.. contents::
   :local:
   :backlinks: none

.. warning::
    Before starting, please ensure that the :ref:`SoftwareRequirements` are met. Namely, the ``Python`` and ``LaTeX`` installations with valid versions. If requirements are not met, some functionality may not work appropriately or at all. 

Getting the Repository
###########################################

GitHub Location: https://github.com/nasa/nasa-latex-docs

.. code-block:: bash

    git clone https://github.com/nasa/nasa-latex-docs

This repository is constantly being updated and improved. Be sure to pull the latest changes often to make sure that your clone of the repository is up to date:

.. code-block:: bash

   cd nasa-latex-docs

.. code-block:: bash

   git pull

.. _CreateNewDocument:

Create a New Document
###########################################

.. note::
   Although new documents *can be created* from within an existing document because each document will have its own ``buildPDF.py`` script, it is **always best to create new documents from the latest version** of ``nasa-latex-docs`` as found on the `Github Repository <https://github.com/nasa/nasa-latex-docs>`_. This way it ensures that all new documents are up to date with the latest features and improvements from the core ``nasa-latex-docs``.

A new document can be simply created as follows using the ``buildPDF.py`` found within the ``nasa-latex-docs`` repository:

.. code-block:: bash

   path/to/nasa-latex-docs/support/buildPDF.py --new <PATH TO NEW DOCUMENT>

So, for example:

.. code-block:: bash

   path/to/nasa-latex-docs/support/buildPDF.py --new ~/Desktop/MyDocument

This will create the ``MyDocument/`` directory in the specified path by the user. Within ``MyDocument/`` you will find:

:: 

    MyDocument/
        │ 
        ├── MyDocument.tex
        │     The main .tex file for entire document
        │  
        ├── bib/ 
        │     Folder to house document bibliography entries
        │  
        ├── fig/
        │     Folder to house all document figures and images
        │  
        ├── tex/
        │      Folder to house all document .tex files
        │  
        └── support/
              The nasa-latex-docs tool and logic directory
              Users should not need to touch this directory

The purpose of this directory is to get users started with a template document and folder structure to begin working. This makes it incredibly easy to get started on new documents with little to no setup overhead.

Build Document
###########################################

Now with the document created, we can navigate to the document location and build it! All new documents have sample content so they should be ready to build right away with no user modification:

.. code-block:: bash

   cd ~/Desktop/MyDocument

From here, we can build the document:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex

Once this completes you will notice the built ``MyDocument.pdf`` file right next to the main ``MyDocument.tex`` file at the root of the ``MyDocument/`` directory.

.. hint::
   Please refer to :ref:`BuildPDF` page for details on all the various script options and how to use them.

.. _TemporaryBuildArtifacts:

Temporary Build Artifacts
###########################################

During the document build process a ``tmp/`` directory is generated to house all of the temporary build artifacts and ``LaTeX`` log files. This directory is **not to be tracked** into any version control software. Advanced ``LaTeX`` users might need to go into this folder to interrogate the log files, but most users should not need to worry about any files within the ``tmp/`` directory.

There is really no reason to ever delete the tmp/ directory unless the document is complete or you suspect that some of the files have become stale and are causing erroneous build failures or unexpected build behavior. When the tmp/ directory is deleted, the document will be re-built from scratch which typically takes longer the first time around - often requiring several passes.

Modify the Document
###########################################

From here, you can start to modify your ``LaTeX`` document with your content and configuration and start adding new `.tex` files. The rest of the :ref:`Home` documentation provides details on how to:

    * Use the pre-built templates (see: :ref:`TemplateOverview`)
    * Define document parameters (see: :ref:`DocumentParameters`)
    * Sample snippets for tables, figures, equations, etc...