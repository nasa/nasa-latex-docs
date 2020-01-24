.. Create reference to page
.. _LatexEquations:

###########################################
LaTeX Equations
###########################################

.. contents:: Quick Links
    :local:
    :backlinks: none

Overview
###########################################

LaTex’s greatest strength over other typesetting systems is its ability to efficiently and cleanly handle the insertion of high-quality equations into documents. This can be done rather easily using the equation environment.

Simple Equation
###########################################

.. literalinclude:: /static/snippets/equation.tex
   :language: latex

.. image:: /static/snippets/equation.png
   :align: center

Inline Equation 
###########################################

.. literalinclude:: /static/snippets/equation_inline.tex
   :language: latex

.. image:: /static/snippets/equation_inline.png
   :align: center

Creating Matrices
###########################################

.. literalinclude:: /static/snippets/equation_matrix.tex
   :language: latex

.. image:: /static/snippets/equation_matrix.png
   :align: center

.. literalinclude:: /static/snippets/equation_matrix_braces.tex
   :language: latex

.. image:: /static/snippets/equation_matrix_braces.png
   :align: center

.. literalinclude:: /static/snippets/equation_matrix_bracket.tex
   :language: latex

.. image:: /static/snippets/equation_matrix_bracket.png
   :align: center

.. literalinclude:: /static/snippets/equation_matrix_line.tex
   :language: latex

.. image:: /static/snippets/equation_matrix_line.png
   :align: center

.. literalinclude:: /static/snippets/equation_matrix_double_line.tex
   :language: latex

.. image:: /static/snippets/equation_matrix_double_line.png
   :align: center

.. literalinclude:: /static/snippets/equation_matrix_parentheses.tex
   :language: latex

.. image:: /static/snippets/equation_matrix_parentheses.png
   :align: center

.. literalinclude:: /static/snippets/equation_matrix_small.tex
   :language: latex

.. image:: /static/snippets/equation_matrix_small.png
   :align: center

Aligning Multiple Equations
###########################################

Multiple equations may be aligned using the ``split`` environment where the ``&`` symbol is used to define where the alignment is to take place. This can be very useful for proofs and stepping through derivations.

.. literalinclude:: /static/snippets/equation_alignment.tex
   :language: latex

.. image:: /static/snippets/equation_alignment.png
   :align: center

Referencing Equations
###########################################

The example below highlights how the ``\label`` command is used to define a **unique** label to this specific equation and how it can be referenced within the text of the document using the ``\ref`` command.

.. literalinclude:: /static/snippets/equation_reference.tex
   :language: latex

.. image:: /static/snippets/equation_reference.png
   :align: center

Referencing Range of Equations
###########################################

The example below highlights how the ``\refrange`` command can be used to reference a range of equations.

.. literalinclude:: /static/snippets/equation_reference_range.tex
   :language: latex

.. image:: /static/snippets/equation_reference_range.png
   :align: center