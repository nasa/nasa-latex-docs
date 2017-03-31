###########################################
NASA-LaTeX-Docs
###########################################

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
Get the repository
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

.. toctree::
   :maxdepth: 3
   :caption: Navigation Pane:
   :hidden:
   
   self
   architecture
   buildPDF
   templates
   quick
   examples_figures
   examples_tables
   examples_acronyms
   examples_equations
   template_aiaa
   template_ieee
   template_tech
   creating_templates