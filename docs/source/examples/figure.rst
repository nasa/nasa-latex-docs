.. Create reference to page
.. _LatexFigure:

###########################################
LaTeX Figures
###########################################

.. contents:: Quick Links
    :local:
    :backlinks: none

Overview
###########################################

Useful reference: `Wiki Link <https://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions>`_.

Figure with Caption
###########################################

.. literalinclude:: /static/snippets/one_figure_one_caption.tex
   :language: latex

.. image:: /static/snippets/one_figure_one_caption.png
   :align: center

Two Figures with Two Captions
###########################################

.. hint::
   Note that the actual ``figure`` environment logic in this example is no different than the simple single example shown above. We are simply utilizing the ``minipage`` environment in order to create temporary sections within our document to place images. In the example below, we create two ``minipage`` environments each occupying half the page as denoted by ``0.5\textwidth``. This same logic can be extended to any layout the user wants!

.. literalinclude:: /static/snippets/two_figures_two_captions.tex
   :language: latex

.. image:: /static/snippets/two_figures_two_captions.png
   :align: center

Two Figures with One Caption
###########################################

.. literalinclude:: /static/snippets/two_figures_one_captions.tex
   :language: latex

.. image:: /static/snippets/two_figures_one_captions.png
   :align: center

Sub-Figures with Sub-Captions
###########################################

.. literalinclude:: /static/snippets/sub_figures_sub_captions.tex
   :language: latex

.. image:: /static/snippets/sub_figures_sub_captions.png
   :align: center

Referencing Figures
###########################################

The example below highlights how the ``\label`` command is used to define a **unique** label to this specific figure and how it can be referenced within the text of the document using the ``\ref`` command.

.. literalinclude:: /static/snippets/reference_figure.tex
   :language: latex
   :emphasize-lines: 5,8

.. image:: /static/snippets/reference_figure.png
   :align: center

Referencing Sub-Figures
###########################################

The example below highlights how the ``\ref`` command operates exactly the same on ``subfigure`` as it does on ``figure`` environment.

.. literalinclude:: /static/snippets/reference_subfigures.tex
   :language: latex
   :emphasize-lines: 6,12,15

.. image:: /static/snippets/reference_subfigures.png
   :align: center

Referencing Range of Figures
###########################################

The example below highlights how the ``\refrange`` command can be used to reference a range of figures.

.. literalinclude:: /static/snippets/reference_range_figures.tex
   :language: latex
   :emphasize-lines: 6,14,22

.. image:: /static/snippets/reference_range_figures.png
   :align: center