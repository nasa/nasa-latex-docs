.. Create reference to page
.. _LatexSections:

###########################################
LaTeX Sections
###########################################

.. contents:: Quick Links
    :local:
    :backlinks: none

Overview
###########################################

Sections in LaTeX are generated using the following commands that are defined in the native ``article`` document class:

* Level 1: ``\section``
* Level 2: ``\subsection``
* Level 3: ``\subsubsection``
* Level 4: ``\paragraph``
* Level 5: ``\subparagraph``

Section Depth Guidelines
===========================================

Why are there only five levels? Modern document standards generally agree that five levels should be sufficient for any sort of technical report. Writers that think they *need* more than five levels should instead consider restructuring their document in a manner that does not require this level of nested sectioning. Increased section granularity can actually begin to detract from document clarity. 

If possible, it is a general guideline to aim to only utilize three levels: ``\section``, ``\subsection``, ``\subsubsection``. Extend to a fourth level, ``\paragraph``, if you truly believe your document readability can be improved by having more granularity. The fifth level, ``\subparagraph``, should be used sparingly if at all.

Referencing Sections
###########################################

Section labels are generated using the ``\label`` command and can then be referenced using ``\ref``. 

.. literalinclude:: /static/snippets/sections.tex
   :language: latex
   :lines: 1-4

Referencing Range of Sections
###########################################

The example below highlights how the ``\refrange`` command can be used to reference a range of sections.

.. literalinclude:: /static/snippets/sections.tex
   :language: latex
   :lines: 27-28

Sample Code and Output
###########################################

The following snippet produces the output seen below. Please note that the format of the section headings depends on the chosen template. Each template has a specified header formatting to meet the guidelines associated with that template, e.g. ``aiaa-journal`` will match the AIAA journal format guidelines.

.. literalinclude:: /static/snippets/sections.tex
   :language: latex

.. image:: /static/snippets/sections.png
   :align: left
