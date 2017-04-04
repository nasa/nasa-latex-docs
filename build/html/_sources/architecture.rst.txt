*******************************************
General Document Architecture
*******************************************

.. note:: Although this generic document architecture is not required to build a document, it is generally good practice to adhere to these structure principals for both clarity and ease of use when document complexity grows.

It is good practice to create a new folder (project directory) for each new LaTeX document. The folder structure for a project architecture has many possibilities, but :code:`nasa-latex-docs` will present a basic one that can be generated using :code:`buildPDF.py` (as described `here <buildPDF.html#option-details-structure>`_).

This document structure is summarized below:

* Project Directory (where all document content is housed)

   * :code:`root.tex`
      * This is the root level :code:`.tex` file that is used to build the document
      * Contains the :code:`\documentclass[]{}` definition
      * Contains any document preamble content 
      * Contains any :code:`nasa-latex-docs` template `document parameters <templates.html#document-parameters>`_
      * Contains the :code:`\begin{document}` and :code:`\end{document}` directives
      * Contains the :code:`\input{}` or :code:`\include{}` directives for all other document :code:`.tex` file(s)

   * :code:`bib/` : Contains the bibliography file(s) for referencing
   * :code:`fig/` : Contains all figures and images used within the document
   * :code:`tex/` : Contains the actual document content in the form of separate :code:`.tex` file(s)
   * Any other folders that the user finds useful for their own document architecture

Document Search Path Visibility 
===========================================

When using the :code:`buildPDF.py` script, it is important to understand what is going on under the hood with regards to the user's environment and where document content is searched for. When using the :code:`buildPDF.py` script, the user's environment is **automatically configured** to add the following to the search path environment variable, :code:`TEXINPUTS`, that is used by LaTeX to search for content:

* All folders and files under the :code:`nasa-latex-docs/` repository folder
* All folders and files at or under the level of the root TeX file that is being built.
* All folders and files that are passed to :code:`buildPDF.py` using the :code:`--texinputs` `option <buildPDF.html#option-details-texinputs>`_

The :code:`--texinputs` option to :code:`buildPDF.py` is useful for end users to define a custom location on their computer where they can place TeX documents that are common to all of their documents. Examples of common files include a comprehensive bibliography list, an acronyms database, or even their own `custom defined templates <creating_templates.html#creating-a-custom-template>`_.

.. image:: examples/latex/figs/doc_visibility.png
   :align: center