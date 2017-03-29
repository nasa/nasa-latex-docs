*******************************************
Document Templates Overview
*******************************************

The purpose of these document templates is to provide end users with pre-defined formatting under which to generate their document content. By **focusing more on content** and not having to worry about formatting, end users can more efficiently prepare documents. The most versatile feature of these templates is that **any document content** can be seamlessly transfer over to a new document template with a single line change... no copying, no pasting, no time wasted.

.. note:: Any of these document templates may be invoked through the :code:`nasa-latex-docs` class, through the following:

   .. code-block:: latex

      \documentclass[template=<option>]{nasa-latex-docs}

      % document preamble

      \begin{document}
      
      % document content
      
      \end{document}

The following templates are currently available:

+-----------------------------------+------------------------------------------------------------------------+
| **Template Name**                 | **Brief Description**                                                  |
+-----------------------------------+------------------------------------------------------------------------+
| :code:`template=aiaa-journal`     | AIAA template adhering to standards for a journal entry                |
+-----------------------------------+------------------------------------------------------------------------+
| :code:`template=aiaa-conference`  | AIAA template adhering to standards for a conference paper             |
+-----------------------------------+------------------------------------------------------------------------+
| :code:`template=aiaa-submission`  | AIAA template adhering to standards for a journal entry for submission |
+-----------------------------------+------------------------------------------------------------------------+
| :code:`template=ieee-journal`     | *Coming soon*                                                          |
+-----------------------------------+------------------------------------------------------------------------+
| :code:`template=tech-report`      | Generic template for creating a technical report                       |
+-----------------------------------+------------------------------------------------------------------------+
| :code:`template=tech-brief`       | *Coming soon*                                                          |
+-----------------------------------+------------------------------------------------------------------------+
| :code:`template=tech-memo`        | *Coming soon*                                                          |
+-----------------------------------+------------------------------------------------------------------------+

