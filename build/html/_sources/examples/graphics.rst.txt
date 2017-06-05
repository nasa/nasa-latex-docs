*******************************************
Examples: LaTeX Graphics
*******************************************

.. include:: example_note.rst

General Notes Regarding Acronyms
===========================================

The :code:`nasa-latex-docs` engine for acronyms tracking is the :code:`glossaries` package (`Wiki Link <https://en.wikibooks.org/wiki/LaTeX/PGF/TikZ>`_). Once acronyms are defined, this package tracks their usage within the document and ensures that it is fully defined upon first use. This make documents incredibly portable when certain sections are pulled out of one document and inserted into another document.

General Notes Regarding LaTeX Graphics
===========================================

Graphics within LaTeX may be generated using portable graphics format (PGF) and TikZ command layers (`Wiki Link <https://en.wikibooks.org/wiki/LaTeX/PGF/TikZ>`_). Although the syntax can be complex at times, it offers a very powerful method for generating portable graphics directly within the LaTeX document.


Simple Block Diagram
===========================================

Text

.. literalinclude:: latex/tex/tikz_block.tex
   :language: latex

.. image:: latex/figs/tikz_block.png
   :align: center
