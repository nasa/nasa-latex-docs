.. Create reference to page
.. _Home:

###########################################
NASA-LaTeX-Docs
###########################################

.. contents::
   :local:
   :backlinks: none


.. admonition:: Github Repository
   :class: banner

   The Github repository is located here: https://github.com/nasa/nasa-latex-docs

The purpose of ``nasa-latex-docs`` is to handle the time consuming process of developing standardized ``LaTeX`` templates that are not only reusable amongst teams, but also easy to modify and customize. With this package, the formatting is all handled internally, for free, and in turns **allows the end user to focus on the more important task of content creation**.

* An OS independent python build script: :code:`buildPDF.py`
   
   * Can be used to build any LaTeX document
   * Works with :code:`latexmk` under the hood
   * Efficiently builds document, bibliography, glossaries, and acronyms
   * Provides warning and error log summaries after each build
   * Comes with a variety of user options of enhanced capability (see: :ref:`BuildPDF`)

* Built in Templates:

   * :ref:`TechnicalMemo`
   * :ref:`TechnicalReport`
   * :ref:`AIAAJournal`
   * :ref:`AIAAConference`
   * :ref:`AIAASubmission`
   * :ref:`Standalone`
   * Ability to create new templates using existing document hooks (see: :ref:`TemplateCustom`)

Software Requirements
###########################################

Using ``nasa-latex-docs`` requires a basic ``Python`` installation and a farily recent version of ``LaTeX``. Please see :ref:`SoftwareRequirements` for a full list of software and links to install.

Getting Started
###########################################

To get started with using ``nasa-latex-docs``, head over to :ref:`QuickStartGuide`.

________________________________________________________

Site Map
###########################################

.. toctree::
   :maxdepth: 0
   :titlesonly:

   self
   misc/software-requirements
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

   examples/section
   examples/figure
   examples/table
   examples/equation
   examples/listing
   examples/graphics

.. toctree::
   :caption: Miscellaneous
   :maxdepth: 0
   :titlesonly:

   misc/tex-editors
   misc/contribute
