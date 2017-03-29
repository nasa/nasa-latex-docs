*******************************************
Using buildPDF.py Script
*******************************************

The :code:`buildPDF.py` script performs all the required functions for building any LaTeX document including generating the final PDF as well as building the bibliography, glossary, and acronym databases. Usage of :code:`buildPDF.py` is simple and a help menu can be generated at any point by running the following:

::

   python buildPDF.py -h

This script is an executable and may also be called through the following (if Python environment is already setup):

::

   ./buildPDF.py -h

General Script Usage
===========================================

Assuming you are trying to build a file named :code:`texfile.tex`, the script may be called as:

::

   ./buildPDF.py texfile.tex <OPTIONS>

Example usage of passing the `Script User Options: Flags`_:

::

   ./buildPDF.py texfile.tex -f -c -v

Or using a combination of short name and long name for the options

::

   ./buildPDF.py texfile.tex -f --clean -v

Or these inputs may even me strung together as follows:

::

   ./buildPDF.py texfile.tex -fcv

Script User Options: Flags
===========================================

The following :code:`buildPDF.py` options are flags the perform certain functions within the script during or after the build.

+---------------------------------+----------------------------------------------------------------+
| **Option**                      | **Brief Description**                                          |
+---------------------------------+----------------------------------------------------------------+
| :code:`-h` or :code:`--help`    | Show this help message and exit                                |
+---------------------------------+----------------------------------------------------------------+
| :code:`-v` or :code:`--verbose` | Verbose option of build output to screen                       | 
+---------------------------------+----------------------------------------------------------------+
| :code:`-f` or :code:`--force`   | Force a new build even if no file changes detected             | 
+---------------------------------+----------------------------------------------------------------+
| :code:`-w` or :code:`--watch`   | Enables continuous builds on any detected file changes         | 
+---------------------------------+----------------------------------------------------------------+
| :code:`-c` or :code:`--clean`   | Removes the tmp/ directory after successful build              |
+---------------------------------+----------------------------------------------------------------+
| :code:`-e` or :code:`--export`  | Creates a standalone version of the document                   |
+---------------------------------+----------------------------------------------------------------+

Option Details: :code:`--help`
-------------------------------------------

Prints a simple version of the option descriptions to the user's screen for quick reference. Whenever this option is passed, no other option is enabled and a **build will not take place**. 

Option Details: :code:`--verbose`
-------------------------------------------

Prints additional information to screen during the build for debugging and informational purposes. 

Option Details: :code:`--force`
-------------------------------------------

Sometimes users make changes that do not trigger a build, this options allows a force build not matter if changes are detected by :code:`latexmk`.

Option Details: :code:`--watch`
-------------------------------------------

This option enables a continuous build capability by watching for file changes, i.e. upon a user saving a file, and will automatically trigger a build. Very useful when used with the :code:`--preview` for real-time document editing and typesetting.

Option Details: :code:`--clean`
-------------------------------------------

This option removes the :code:`tmp/` directory that is created in each document folder. This folder houses all of the build auxiliary and log files. There is really no reason to ever delete the :code:`tmp/` directory unless the document is complete or you suspect that some of the files have become stale and are causing erroneous build failures or unexpected build behavior. When the :code:`tmp/` directory is deleted, the document will be re-built from scratch which typically takes longer the first time around - often requiring several passes. 

Option Details: :code:`--export`
-------------------------------------------

This option will create a standalone version of your document. Standalone means that it will create a version of your document that has **no ties** to the :code:`nasa-latex-docs` repository. All of the file dependencies (in their *current state* at the time of the build) will be copied into a single location that can be delivered to other users who may or may not have the repository. For example, the following usage:  

::

   ./buildPDF.py My_Technical_Report.tex --export

Will create the document PDF (:code:`My_Technical_Report.pdf`) as well as a new folder titled :code:`My_Technical_Report_standalone` with the following items:

* All files (TeX and images) used by your document (matching your document folder tree)
* A copy of anything within the :code:`nasa-latex-docs` repository that was linked
* A copy of the :code:`buildPDF.py` script and :code:`latexmkrc` configuration file 

When appropriate, all files from within the :code:`nasa-latex-docs` repository will be "archived" into a single file to reduce the amount of files copied. This archiving only takes place if the :code:`nasa-latex-docs` class is called at the top of the document, i.e. :code:`\documentclass{nasa-latex-docs}`. A list of archived files will be printed on the screen if archiving is possible.

Script User Options: Inputs
===========================================

The following :code:`buildPDF.py` options may accept (or even require) inputs from the user. 
 
+-----------------------------------+------------------------------------------------------------------------+
| **Option**                        | **Brief Description**                                                  |
+-----------------------------------+------------------------------------------------------------------------+
| :code:`-l` or :code:`--latexpath` | Adds LaTeX installation on computer to top of :code:`PATH` environment |
+-----------------------------------+------------------------------------------------------------------------+
| :code:`-t` or :code:`--texinputs` | Adds user defined location to :code:`TEXINPUTS` environment            | 
+-----------------------------------+------------------------------------------------------------------------+
| :code:`-o` or :code:`--output`    | Rename the output PDF to a different name                              | 
+-----------------------------------+------------------------------------------------------------------------+
| :code:`-p` or :code:`--preview`   | Launches a PDF viewer after successful build                           | 
+-----------------------------------+------------------------------------------------------------------------+
| :code:`-s` or :code:`--structure` | Creates a template document structure for easy document setup          |
+-----------------------------------+------------------------------------------------------------------------+

Option Details: :code:`--latexpath`
-------------------------------------------

This option adds the location of the user desired LaTeX distribution installed on their machine for use when building the document. The user input is added to the **front** of the :code:`PATH` environment to ensure that it is used. 

Example usage for the typical LaTeX installation location on a Mac:

::

   ./buildPDF.py texfile.tex --latexpath /Library/TeX/texbin

Option Details: :code:`--texinputs`
-------------------------------------------

This option may be used to point to a location on the users computer that is not located within the current document to add to the search path. This may be useful for common :code:`.tex` or :code:`.bib` files that are used often across multiple projects. For example, instead of copying an instance of an acronyms database to each new document, you can simply point to the directory path (the :code:`~/Documents/common/latex` path is used here as an example) with the :code:`--texinputs` option:

::

   ./buildPDF.py texfile.tex --texinputs ~/Documents/common/latex

Option Details: :code:`--output`
-------------------------------------------

By default a :code:`.tex` file named :code:`My_Technical_Report.tex`, for example,  will be typeset to a PDF file name :code:`My_Technical_Report.pdf`. The :code:`--output` option may be used to rename the output of a given build:

::

   ./buildPDF.py My_Technical_Report.tex --output My_Technical_Report_v3.pdf

Option Details: :code:`--preview`
-------------------------------------------

This option launches a PDF previewer after a successful build for the resulting PDF. The default preview program on a Mac is :code:`preview`, on Linux is :code:`evince`, and on Windows :code:`SumatraPDF` (`link <https://www.sumatrapdfreader.org/download-free-pdf-viewer.html>`_). For example, running the following on a Mac:

::

   ./buildPDF.py My_Technical_Report.tex -p

Will result in a Mac :code:`preview` window opening with the latest PDF build. One issue with using the Mac :code:`preview` program is that it does not effectively load new PDFs without resetting the document location. A much better option is to use `Skim <http://skim-app.sourceforge.net/>`_ if it is installed on the computer. Assuming it is, it may be used as the preview program by simply doing the following:

::

   ./buildPDF.py My_Technical_Report.tex -p Skim

Option Details: :code:`--structure`
-------------------------------------------

This option is incredibly useful for starting new documents using the `general document architecture <architecture.html#general-document-architecture>`_ described in a previous section of this documentation. Suppose you want to start a new document and you know that your main :code:`.tex` will be called :code:`My_Technical_Report.tex` and you want all the document content to be housed in a directory named :code:`Quarterly_Report/`. All of this may be accomplished through the following:

::

   ./buildPDF.py My_Technical_Report.tex -s Quarterly_Report


If no option is passed to :code:`buildPDF.py`, then the document folder will be named after the name of the :code:`.tex` file. For example, the following code (with no user option passed to :code:`--structure`) will create the document structure in a directory named :code:`My_Technical_Report/`. In this scenario the :code:`buildPDF.py` script will ask for a confirmation regarding the file name for the document directory to which the user must respond :code:`y/n`.

::

   ./buildPDF.py My_Technical_Report.tex -s
