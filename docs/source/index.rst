.. Create reference to page
.. _Home:

###########################################
NASA-LaTeX-Docs
###########################################

.. contents::
    :local:
    :backlinks: none

*******************************************
Overview
*******************************************

With this LaTeX package, the formatting is all handled internally. Helps to alleviate a lot of the hassle associated with re-creating document template formats and in turns allows the end user to focus on the more important task of content creation.

* An OS independent python build script: :code:`buildPDF.py`
   
   * Can be used to build any LaTeX document
   * Works with :code:`latexmk` under the hood
   * Efficiently builds document, bibliography, glossaries, and acronyms
   * Provides warning and error log summaries after each build
   * Comes with a variety of user options of enhanced capability

* Built in Templates:

   * AIAA Journal
   * AIAA Conference
   * AIAA Journal Submission
   * Generic technical document templates
   * Ability to create new templates using existing document hooks

*******************************************
Getting the Repository
*******************************************

GitHub Location: https://github.com/nasa/nasa-latex-docs

::

   git clone https://github.com/nasa/nasa-latex-docs


This repository is constantly being updated and improved. Be sure to pull the latest changes often to make sure that your clone of the repository is up to date:


::

   cd nasa-latex-docs

::

   git pull

*******************************************
System Requirements
*******************************************

Two programs are required prior to using this repository: a compatible TeX distribution and a Python installation. These may already be installed on your computer, for example most Mac OS installations come with Python pre-installed.

* **TeX Distribution 2015+** (with latest updates)
   
   * Mac OSX: TexLive (MacTeX) Distribution: `TexLive MacTeX <https://tug.org/mactex/mactex-download.html>`_ 
   * Linux: TexLive Distribution: `TexLive Linux <http://www.tug.org/texlive/>`_  
   * Windows: proTeXt (based on MiKTeX) Distribution: `TexLive proTeXt <https://www.tug.org/protext/>`_

* **Python 2.6+**
   
   * Anaconda Python Distribution: `Anaconda <https://www.continuum.io/downloads>`_

*******************************************
Updating Your LaTeX Installation
*******************************************

Each distribution year may be updated. First the package manager is updated by:

::

   tlmgr update --self

Then the actual packages may be updated by:

::

   tlmgr update --all

________________________________________________________

*******************************************
Documentation Site Map
*******************************************

.. toctree::
    :maxdepth: 0

    self
    misc/quick-start
    misc/build-script

.. toctree::
    :caption: Document Templates
    :maxdepth: 0
    :titlesonly:

    templates/overview
    templates/doc-params
    templates/tech-memo
    templates/tech-report
    templates/aiaa-journal
    templates/aiaa-conference
    templates/aiaa-submission
    templates/standalone
    templates/custom

.. toctree::
    :caption: Additional Features
    :maxdepth: 0
    :titlesonly:

    features/revision-history
    features/acronyms
    features/nomenclature
    features/bibliography
    features/appendix

.. toctree::
    :caption: LaTeX Snippets & Examples
    :maxdepth: 0
    :titlesonly:

    examples/figure
    examples/table
    examples/equation
    examples/listing

.. toctree::
    :caption: Miscellaneous
    :maxdepth: 0
    :titlesonly:

    misc/tex-editors
    misc/contribute
    