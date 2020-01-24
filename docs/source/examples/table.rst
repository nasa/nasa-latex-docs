.. Create reference to page
.. _LatexTable:

###########################################
LaTeX Tables
###########################################

.. contents:: Quick Links
    :local:
    :backlinks: none

Overview
###########################################

Useful reference: `Wiki Link <https://en.wikibooks.org/wiki/LaTeX/Tables>`_.

Table with Caption
###########################################

.. literalinclude:: /static/snippets/table_caption.tex
   :language: latex

.. image:: /static/snippets/table_caption.png
   :align: center

Table with Row Span
###########################################

.. literalinclude:: /static/snippets/table_multicol.tex
   :language: latex

.. image:: /static/snippets/table_multicol.png
   :align: center

Table with Column Span
###########################################

.. literalinclude:: /static/snippets/table_multirow.tex
   :language: latex

.. image:: /static/snippets/table_multirow.png
   :align: center

Referencing Tables
###########################################

The example below highlights how the ``\label`` command is used to define a **unique** label to this specific table and how it can be referenced within the text of the document using the ``\ref`` command.

.. literalinclude:: /static/snippets/reference_table.tex
   :language: latex
   :emphasize-lines: 3,16

.. image:: /static/snippets/reference_table.png
   :align: center

Referencing Range of Tables
###########################################

The example below highlights how the ``\refrange`` command can be used to reference a range of tables.

.. literalinclude:: /static/snippets/reference_range_tables.tex
   :language: latex
   :emphasize-lines: 3,18,31

.. image:: /static/snippets/reference_range_tables.png
   :align: center