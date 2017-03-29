*******************************************
Quick Start Guide
*******************************************

The fastest and most efficient way to start a new document is utilize the :code:`buildPDF.py` script's :code:`--structure` option in order to create a document tree with the minimum necessary files. For example, let's assume you would like to create a new document whose main (root) :code:`.tex` is to be titled :code:`XYZ_Conference_Paper.tex` (it does not currently exist) and you want all the document content to be housed in a directory named :code:`XYZ_Conference_Paper_2017/`. All of this may be accomplished through the following:

::

   ./buildPDF.py XYZ_Conference_Paper.tex -s XYZ_Conference_Paper_2017

This will create a document with the same structure as described in the `General Document Architecture <architecture.html#general-document-architecture>`_ section.

.. note:: TODO: Add image of document tree.

The Root TeX File
===========================================

Once the new document folder is created, it will contain your :code:`XYZ_Conference_Paper.tex` file with the following contents:

.. literalinclude:: latex/XYZ_Conference_Paper_2017/XYZ_Conference_Paper.tex
   :language: latex

Currently, the document will be built with no template and in turn no pre-defined formatting. We can specify that we would like to create an AIAA conference paper by calling that :code:`aiaa-conference` template as follows:

:: 
   
   \documentclass[template=aiaa-conference]{nasa-latex-docs}

Text
