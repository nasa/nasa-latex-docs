.. Create reference to page
.. _LatexListing:

###########################################
LaTeX Code Listings
###########################################

.. contents:: Quick Links
    :local:
    :backlinks: none

Overview
###########################################

The ``lstinputlisting`` command can be used to generated style code listings directly within the document. This feature is great for documenting code or adding it into a document for reference purposes. Useful links: `Overleaf <https://www.overleaf.com/learn/latex/Code_listing#Code_styles_and_colours>`_ and `Wiki <https://en.wikibooks.org/wiki/LaTeX/Source_Code_Listings>`_.

By default ``lstinputlisting`` only supports `certain languages <https://www.overleaf.com/learn/latex/Code_listing#Supported_languages>`_ for syntax highlighting. ``Matlab`` is not a supported langauge for syntax highlighting, but ``nasa-latex-docs`` has extended functionality to also support ``Matlab`` syntax highlighting! Another free benefit of using ``nasa-latex-docs``. See examples below.

Simple Code Listings
###########################################

.. literalinclude:: /static/snippets/listing_cpp.tex
   :language: latex

.. image:: /static/snippets/listing_cpp.png
   :align: center

.. _LatexListingCustomizeManual:

Customization Options
###########################################

Code listings can be customized in a variety of ways. The following is a summary of the various options. More details on each can be researched by the end user - this simply serves as a cursory reference.

.. code-block:: latex

    backgroundcolor=\color{white},   % choose the background color
    basicstyle=\footnotesize,        % the size of the fonts that are used for the code
    breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace
    breaklines=true,                 % sets automatic line breaking
    captionpos=b,                    % sets the caption-position to bottom
    commentstyle=\color{mygreen},    % comment style
    deletekeywords={...},            % if you want to delete keywords from the given language
    escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
    extendedchars=true,              % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
    firstnumber=1000,                % start line enumeration with line 1000
    frame=single,                    % adds a frame around the code
    keepspaces=true,                 % keeps spaces in text, useful for keeping indentation of code (possibly needs columns=flexible)
    keywordstyle=\color{blue},       % keyword style
    language=Octave,                 % the language of the code
    morekeywords={*,...},            % if you want to add more keywords to the set
    numbers=left,                    % where to put the line-numbers; possible values are (none, left, right)
    numbersep=5pt,                   % how far the line-numbers are from the code
    numberstyle=\tiny\color{mygray}, % the style that is used for the line-numbers
    rulecolor=\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
    showspaces=false,                % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
    showstringspaces=false,          % underline spaces within strings only
    showtabs=false,                  % show tabs within strings adding particular underscores
    stepnumber=2,                    % the step between two line-numbers. If it's 1, each line will be numbered
    stringstyle=\color{mymauve},     % string literal style
    tabsize=2,                       % sets default tabsize to 2 spaces

Creating a Predefined Style
###########################################

In order to reuse styles, the ``\lstdefinestyle`` command can be used to define a custom style configuration using the options defined in the previous section.

.. code-block:: latex

    \lstdefinestyle{myStyle}{
        belowcaptionskip=1\baselineskip,
        breaklines=true,
        frame=none,
        numbers=none, 
        basicstyle=\footnotesize\ttfamily,
        keywordstyle=\bfseries\color{green!40!black},
        commentstyle=\itshape\color{purple!40!black},
        identifierstyle=\color{blue},
        backgroundcolor=\color{gray!10!white},
    }

Setting a Local Style
###########################################

User can define a style configuration to be used for a specific code listing using the ``style`` keyword:

.. code-block:: latex

    \lstinputlisting[caption=Example C++, label={lst:listing-cpp}, language=C++, style=myStyle]{code_sample.cpp}

Setting a Global Style
###########################################

User can define a style configuration to be used as the default for all code listings using the ``lstset`` command:

.. code-block:: latex

    \lstset{style=myStyle}

Customization of Code Listings - Style
###########################################

The following is an example of using an existing pre-defined style to customize a code listing.

.. literalinclude:: /static/snippets/listing_customize_style.tex
   :language: latex

.. image:: /static/snippets/listing_customize_style.png
   :align: center

Customization of Code Listings - Manual
###########################################

If a ``style`` is not define, users can manually apply certain styles. This method can also be used to override default styles.

.. literalinclude:: /static/snippets/listing_customize.tex
   :language: latex

.. image:: /static/snippets/listing_customize.png
   :align: center

Referencing Code Listings
###########################################

The example below highlights how the ``\label`` command is used to define a **unique** label to this specific code listing and how it can be referenced within the text of the document using the ``\ref`` command.

.. literalinclude:: /static/snippets/listing_reference.tex
   :language: latex

.. image:: /static/snippets/listing_reference.png
   :align: center

Referencing Range of Code Listings
###########################################

The example below highlights how the ``\refrange`` command can be used to reference a range of code listings.

.. literalinclude:: /static/snippets/listing_reference_range.tex
   :language: latex

.. image:: /static/snippets/listing_reference_range.png
   :align: center