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

Create a New Document
###########################################

A new document can be simply created as follows:

.. code-block:: bash

   path/to/nasa-latex-docs/support/buildPDF.py --new ~/Desktop/MyDocument

This will create the ``MyDocument/`` directory in the specified path by the user. Within ``MyDocument`` you will find:

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
*******************************************

Now with the document build, we can simply navigate to the document location and build it:

.. code-block:: bash

   cd ~/Desktop/MyDocument

From here, we can build the document:

.. code-block:: bash

   ./support/buildPDF.py MyDocument.tex

Once this completes you will notice the built ``MyDocument.pdf`` file right next to the main `MyDocument.tex` file. That's all there is to it!

Modify the Document
*******************************************

From here, you can start to modify your ``LaTeX`` document with your content and configuration and start adding new `.tex` files. The rest of the :ref:`Home` documentation provides details on how to:

    * Use the pre-built templates (see: :ref:`TemplateOverview`)
    * Define document parameters (see: :ref:`DocumentParameters`)
    * Sample snippets for tables, figures, equations, etc...