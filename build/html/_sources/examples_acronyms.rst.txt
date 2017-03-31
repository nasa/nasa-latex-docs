*******************************************
Examples: LaTeX Acronyms
*******************************************

.. include:: example_note.rst

General Notes Regarding Acronyms
===========================================

The :code:`nasa-latex-docs` engine for acronyms tracking is the :code:`glossaries` package (`Wiki Link <https://en.wikibooks.org/wiki/LaTeX/Glossary>`_). Once acronyms are defined, this package tracks their usage within the document and ensures that it is fully defined upon first use. This make documents incredibly portable when certain sections are pulled out of one document and inserted into another document.

Defining and Using Acronyms
===========================================

Acronyms may be defined anywhere in the document, but it is typically good practice to place a small list of acronyms in the preamble portion of the root TeX document. If the acronyms list is larger, it may be placed into a separate :code:`.tex` file and simply included within the preamble as follows:

.. code-block:: latex

   \input{acronyms}

To add a new acronym: :code:`\newacronym{acronym-label}{acronym}{full-name}`, for example:

.. code-block:: latex
   
   \newacronym{nasa}{NASA}{National Aeronautics and Space Administration}

With the new acronym defined, it may be used anywhere in the document as: 

.. code-block:: latex
   
   \gls{nasa}

The following:

.. code-block:: latex
   
   \gls{nasa} is an acronym example. \gls{nasa} is cool.

Results in:

::
   
   National Aeronautics and Space Administration (NASA) is an acronym example. NASA is cool.

Alternate Usage Examples
===========================================

To print the the plural form of the defined term:

.. code-block:: latex
   
   \glspl{nasa} results in: NASAs

To print the singular form of the term with the first character converted to upper case:

.. code-block:: latex
   
   \Gls{nasa} results in: NASA

To print the plural form of the term with the first character converted to upper case:

.. code-block:: latex
   
   \Glspl{nasa} results in: NASA

To link acronym but use alternate text:

.. code-block:: latex
   
   \glslink{nasa}{the NASA} results in: the NASA


Force the print out of the long form, not matter if it has been defined already:

.. code-block:: latex
   
   \acrlong{nasa} results in: National Aeronautics and Space Administration

Force the print out of the full form, not matter if it has been defined already:

.. code-block:: latex
   
   \acrfull{nasa} -> National Aeronautics and Space Administration (NASA)
 
Force the print out of the short form, not matter if it has not been defined yet:

.. code-block:: latex
   
   \acrshort{nasa} results in: NASA         

.. +--------------------------------+------------------------------------+----------------------------------------------+
.. | **LaTeX Code**                 | **Description**                    | **Output**                                   |
.. +--------------------------------+------------------------------------+----------------------------------------------+
.. | :code:`\gls{nasa}`             | First usage                        | National Aeronautics and Space Administration|
.. +--------------------------------+------------------------------------+----------------------------------------------+
.. | :code:`\gls{nasa}`             | Second usage                       | NASA                                         |
.. +--------------------------------+------------------------------------+----------------------------------------------+
.. | :code:`\glspl{nasa}`           | Plural form                        | NASA                                         |
.. +--------------------------------+------------------------------------+----------------------------------------------+

