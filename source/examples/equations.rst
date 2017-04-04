*******************************************
Examples: LaTeX Equations
*******************************************

.. include:: example_note.rst

Creating Equations
===========================================

LaTex's greatest strength over other typesetting systems is its ability to efficiently and cleanly handle the insertion of high-quality equations into documents. This can be done rather easily using the equation environment. An example of inserting an equation into your document is provided below:

.. literalinclude:: latex/tex/equation_1.tex
   :language: latex

.. image:: latex/figs/equation_1.png
   :align: center

Equations may also be produced inline with text, for example:


.. literalinclude:: latex/tex/equation_2.tex
   :language: latex

.. image:: latex/figs/equation_2.png
   :align: center

Referencing Equations
===========================================

Equations may be referenced by referring to the equation label if it is provided. For the example above:

.. code-block:: latex
   
   \ref{eq:example-equation} results in: Equation 1

Creating a Matrices and Arrays
===========================================   

The following commands can be used to create arrays of any size with various types of enclosing brackets.

.. literalinclude:: latex/tex/equation_matrix.tex
   :language: latex
   :lines: 1-7

.. image:: latex/figs/equation_matrix.png
   :align: center

.. literalinclude:: latex/tex/equation_matrix.tex
   :language: latex
   :lines: 9-15

.. image:: latex/figs/equation_bmatrix.png
   :align: center   

.. literalinclude:: latex/tex/equation_matrix.tex
   :language: latex
   :lines: 17-23

.. image:: latex/figs/equation_bmatrix2.png
   :align: center

.. literalinclude:: latex/tex/equation_matrix.tex
   :language: latex
   :lines: 25-31

.. image:: latex/figs/equation_pmatrix.png
   :align: center   

.. literalinclude:: latex/tex/equation_matrix.tex
   :language: latex
   :lines: 33-39

.. image:: latex/figs/equation_vmatrix.png
   :align: center   

.. literalinclude:: latex/tex/equation_matrix.tex
   :language: latex
   :lines: 41-47

.. image:: latex/figs/equation_vmatrix2.png
   :align: center   

.. literalinclude:: latex/tex/equation_matrix.tex
   :language: latex
   :lines: 49-55

.. image:: latex/figs/equation_smallmatrix.png
   :align: center   

Aligning Multiple Equations
===========================================  

Multiple equations may be aligned using the :code:`split` environment where the :code:`&` symbol is used to define where the alignment is to take place. This can be very useful for proofs and stepping through derivations.

.. literalinclude:: latex/tex/equation_split.tex
   :language: latex

.. image:: latex/figs/equation_split.png
   :align: center



