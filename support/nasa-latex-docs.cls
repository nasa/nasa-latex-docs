%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NASA LaTeX Docs - LaTeX Templates and Build Script
% Software Release: This code is is governed by NPR 2210.1C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Prepare class file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Package with programming tools geared primarily towards LaTeX class and package authors 
\RequirePackage{etoolbox}       
\RequirePackage{kvoptions}

% Must indicate that we are using LaTeX2e (LaTeX2e is the latest stable release of LaTeX)
\NeedsTeXFormat{LaTeX2e}

% Define class name, date, and version
\ProvidesClass{nasa-latex-docs}[2016/02/02 v1.0 NASA LaTeX Docs]

\def\docType{99}      

\SetupKeyvalOptions{
  family=class,
  prefix=class@
}

\DeclareStringOption[none]{template}
\DeclareBoolOption[false]{showframe}
\DeclareBoolOption[false]{convert}
\ProcessKeyvalOptions*

% Process the options - they are now 'live' in the class file
% \ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Setup the general options for each document type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reference commmad to pass options to package
% \PassOptionsToPackage{<option=value>{<package name>}

\ifdefstring{\class@template}{standalone}{
   \ifclass@convert
      \LoadClass[preview,margin=3,convert={density=300,subjobname=\jobname-STANDALONECONVERT}]{standalone}
   \else
      \LoadClass[preview,margin=3]{standalone}
   \fi
}{
   \LoadClass[letterpaper,12pt]{article}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load Required Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{packages.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load document command shortcuts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ----- MATH COMMANDS ---------------------------------------------------------
% Command for Leibniz notation of derivatives
\newcommand{\dd}[2]{\frac{d#1}{d#2}}
% Command for Leibniz notation of partial derivatives
\newcommand{\pd}[2]{\frac{\partial#1}{\partial#2}}
% Command for norm
\newcommand{\norm}[1]{\lVert#1\rVert}
% Command for absolute value
\newcommand{\abs}[1]{\lvert#1\rvert}


%% ----- TEXT COMMANDS ---------------------------------------------------------
% Command for 'and others'
\newcommand{\etal}{{et al.}\thinspace}
% Command for 'for example'
\newcommand{\eg}{{e.g.}\thinspace}
% Command for 'that is'
\newcommand{\ie}{{i.e.}\thinspace}
% Command for 'and the rest'
\newcommand{\etc}{{etc.}\thinspace}

\newcommand{\rom}[1]{\uppercase\expandafter{\romannumeral #1\relax}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load document parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{doc-params.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Define the warning thresholds before LaTeX spits out a underfull/overfull warning
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Defines how fussy LaTeX is about underfull or overfull boxes (horizontal and vertical )
\hbadness=2000
\vbadness=2000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: General formatting definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define base geometry
\geometry{margin=1in,includefoot,marginparwidth=0in} 

% Define graphics inputs
\DeclareGraphicsExtensions{.pdf,.png,.jpg,.ps,.gif,.eps}

% For breaking long underscored words into next line where appropriate
\renewcommand\_{\textunderscore\allowbreak}

% Remove white space caused by using the various package environments
\AtBeginEnvironment{center}{\vspace{-\baselineskip}}
\AtEndEnvironment{center}{\vspace{-\baselineskip}}

% This piece of code centers all float environments "[H]"
% \AtEndPreamble{
%    \makeatletter
%    \g@addto@macro\@floatboxreset\centering
%    \makeatother
% }

% Command to fix issue with outter quotation marks being the wrong direction
\MakeOuterQuote{"}

% Define spacing between Section titles and text
\titlespacing{\section}{0pt}{\baselineskip}{5pt}
\titlespacing{\subsection}{0pt}{\baselineskip}{5pt}
\titlespacing{\subsubsection}{0pt}{\baselineskip}{5pt}
\titlespacing{\paragraph}{0pt}{\baselineskip}{5pt}
\titlespacing{\subparagraph}{0pt}{\baselineskip}{5pt}

% Custom title formatting - to force new line for paragraph and subparagraph
\titleformat{\paragraph}[hang]{\normalfont\normalsize}{\theparagraph}{1em}{}
\titleformat{\subparagraph}[hang]{\normalfont\normalsize\itshape}{\thesubparagraph}{1em}{}

% Make figure, table, and equation captions bold
\captionsetup[table]{font={bf,normalsize},position=above,skip=0.5\baselineskip}
\captionsetup[figure]{font={bf,normalsize},position=below}
\captionsetup[equation]{font={bf,normalsize},position=right}
\captionsetup[lstlisting]{font={bf,normalsize},position=above,skip=\baselineskip}

% Add new table columns 
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% Define the caption skip parameter
\setlength{\belowcaptionskip}{-0.25\baselineskip}

% Change list structure spacing
\setlist[itemize]{itemsep = 0pt}
\setlist[enumerate]{itemsep = 0pt}
\setlist[description]{itemsep = 0pt}

% Set up hyperlink options
\hypersetup{hidelinks}
\hypersetup{urlcolor=cyan}

% Define the maximum section depth
\setcounter{secnumdepth}{6} 

\AtBeginDocument{

    % begin appendix autoref patch 
    % [\autoref subsections in appendix](https://tex.stackexchange.com/questions/149807/autoref-subsections-in-appendix)
    \makeatletter
    \patchcmd{\hyper@makecurrent}{%
        \ifx\Hy@param\Hy@chapterstring
            \let\Hy@param\Hy@chapapp
        \fi
    }{%
        \iftoggle{inappendix}{%true-branch
            % list the names of all sectioning counters here
            \@checkappendixparam{chapter}%
            \@checkappendixparam{section}%
            \@checkappendixparam{subsection}%
            \@checkappendixparam{subsubsection}%
            \@checkappendixparam{paragraph}%
            \@checkappendixparam{subparagraph}%
        }{}%
    }{}{\errmessage{failed to patch}}

    \newcommand*{\@checkappendixparam}[1]{%
        \def\@checkappendixparamtmp{#1}%
        \ifx\Hy@param\@checkappendixparamtmp
            \let\Hy@param\Hy@appendixstring
        \fi
    }
    \makeatletter

    \newtoggle{inappendix}
    \togglefalse{inappendix}

    \apptocmd{\appendix}{\toggletrue{inappendix}}{}{\errmessage{failed to patch}}
    \apptocmd{\subappendices}{\toggletrue{inappendix}}{}{\errmessage{failed to patch}}
    
    % The above patch only works with \appendix applied. Make sure this is called before call to appendices environment
    \BeforeBeginEnvironment{appendices}{\appendix} 
    % end appendix autoref patch


   % Place here in order to capture any abstract referencing to sections
   % Allow the autoref package (within hyperref to take care of appending "Figure" "Section" and "Table" to labels)
   % Save the original autoref definition - use "let" instead of def
   \let\orgautoref\autoref

   % Define autoref for beginning of sentence usage
   \providecommand{\Autoref}{%
      \def\equationautorefname{Equation}%
      \def\figureautorefname{Figure}%
      \def\subfigureautorefname{Figure}%
      \def\Itemautorefname{Item}%
      \def\tableautorefname{Table}%
      \def\sectionautorefname{Section}%
      \def\subsectionautorefname{Section}%
      \def\subsubsectionautorefname{Section}%
      \def\paragraphautorefname{Section}%
      \def\subparagraphautorefname{Section}%
      \def\chapterautorefname{Section}%
      \def\partautorefname{Section}%
      \def\Appendixautorefname{Appendix}%
      \orgautoref}

   % Define autoref for default usage   
   \renewcommand{\autoref}{%
         \def\equationautorefname{Eq.}%
         \def\figureautorefname{Figure}%
         \def\subfigureautorefname{Figure}%
         \def\Itemautorefname{Item}%
         \def\tableautorefname{Table}%
         \def\sectionautorefname{Section}%
         \def\subsectionautorefname{Section}%
         \def\subsubsectionautorefname{Section}%
         \def\paragraphautorefname{Section}%
         \def\subparagraphautorefname{Section}%
         \def\chapterautorefname{Section}%
         \def\partautorefname{Section}%
         \def\Appendixautorefname{Appendix}%
         \orgautoref}

   % Define labels for cleveref usage 
   \crefname{equation}{Equation}{equations}
   \Crefname{equation}{Equation}{Equations}
   \crefname{table}{Table}{Tables}
   \Crefname{table}{Table}{Tables}
   \crefname{figure}{Figure}{Figures}
   \Crefname{figure}{Figure}{Figures}
   \crefname{section}{Section}{Sections}
   \Crefname{section}{Section}{Sections}
   \crefname{paragraph}{Section}{Sections}
   \Crefname{paragraph}{Section}{Sections}
   \crefname{subparagraph}{Section}{Sections}
   \Crefname{subparagraph}{Section}{Sections}

   % Define a range formatting
   \crefrangeformat{section}{\mbox{Sections #3#1#4\@docRefRangeConjunction#5#2#6}}
   \crefrangeformat{subsection}{\mbox{Sections #3#1#4\@docRefRangeConjunction#5#2#6}}
   \crefrangeformat{subsubsection}{\mbox{Sections #3#1#4\@docRefRangeConjunction#5#2#6}}
   \crefrangeformat{paragraph}{\mbox{Sections #3#1#4\@docRefRangeConjunction#5#2#6}}
   \crefrangeformat{subparagraph}{\mbox{Sections #3#1#4\@docRefRangeConjunction#5#2#6}}

   % Pass the "\ref" command to \autoref
   \let\ref\autoref

   % Create a new command "\Ref" to call \Autoref - for alternate form
   \let\Ref\Autoref

   % Pass the "\refrange" command to \crefrange
   \let\refrange\crefrange

   % Disable hyperlinks for acronyms
   \glsdisablehyper 

   % Setup bookmarks to be numbered
   \bookmarksetup{numbered}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Useful commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Environment to define nomenclature section
\newlength{\docNomenclatureVarWidthDefault}
\setlength{\docNomenclatureVarWidthDefault}{2.75em}

\newenvironment{nomenclature}[1][]
{
   \noindent\tabular{@{} p{\@docNomenclatureScale\docNomenclatureVarWidthDefault} @{\hspace{2pt}\@docNomenclatureSeparator\hspace{0.5em}} l} %
}{
   \endtabular
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load custom definitions for each document type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifclass@showframe
   \AtBeginDocument{
      \newpage \clearpage \thispagestyle{empty} 
      \addtocounter{page}{-5}

      \RequirePackage{layouts}

      \begin{center}\vspace*{0.25in}\LARGE\bfseries Layout and Geometry Details \vspace{\baselineskip}\end{center}

      \begin{itemize}
      \item Selected Document Template = \texttt{\class@template}
      \item Geometry frame is provided on each page (graphic/values on next page)
      \item Other useful geometry values
      \begin{itemize}
         \item Text Width = \printinunitsof{in}\prntlen{\textwidth} (\printinunitsof{pt}\prntlen{\textwidth})
         \item Text Height = \printinunitsof{in}\prntlen{\textheight} (\printinunitsof{pt}\prntlen{\textheight})
      \end{itemize}
      \item list (i.e. \texttt{description}, \texttt{enumerate} and \texttt{itemize} environments) settings

      \begin{quote}
      \printinunitsof{pt}
      \listvalues
      \end{quote}

      \end{itemize}

      \newpage \clearpage \thispagestyle{empty} 
      \begin{center}\vspace*{0.25in}\LARGE\bfseries Single Column Generic Diagram \vspace{\baselineskip}\end{center}
      \drawmarginparsfalse
      \currentpage
      \pagediagram
      \newpage \clearpage \thispagestyle{empty}
      \begin{center}\vspace*{0.25in}\LARGE\bfseries Single Column Design (Current Settings) \vspace{\baselineskip}\end{center} 
      \currentpage
      \pagedesign

      \newpage \clearpage \thispagestyle{empty} 
      \begin{center}\vspace*{0.25in}\LARGE\bfseries Two Column Generic Diagram \vspace{\baselineskip}\end{center}
      \drawmarginparsfalse
      \twocolumnlayouttrue
      \pagediagram
      \newpage \clearpage \thispagestyle{empty}
      \begin{center}\vspace*{0.25in}\LARGE\bfseries Two Column Design (Current Settings) \vspace{\baselineskip}\end{center}  
      \drawmarginparsfalse
      \twocolumnlayouttrue
      \pagedesign

      \newpage
   }
\else
   % Do not print the layout help pages
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Define some useful shortcuts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Option to create new page for bibliography - default is not to
\newcommand{\PREprintbibliography}{}  
\newcommand{\PREprintNomenclature}{}

\newcommand{\printTOC}{
   \ifdefstring{\@docTOC}{true}{
      % Create the TOC
      \newpage
      \setlength{\parskip}{0.4\baselineskip}
      % Add a PDF bookmark in PDF viewer 
      \phantomsection
      \renewcommand\contentsname{Table of Contents}
      \pdfbookmark[2]{Table of Contents}{ToC}
      % Create the ToC 
      \begingroup
      \hypersetup{linkcolor=black}
      \tableofcontents
      \endgroup
      \setlength{\parskip}{\baselineskip}
   }{}
}

\newcommand{\printLOT}{
   \ifdefstring{\@docLOT}{true}{
      % Create a Table of Contents Entry for LOT
      \newpage
      \setlength{\parskip}{0.4\baselineskip}
      \phantomsection
      \bookmarksetupnext{level=subsection}
      \addcontentsline{toc}{section}{List of Tables}
      % Create LOT
      \listoftables
      \setlength{\parskip}{\baselineskip}
   }{}
}

\newcommand{\printLOF}{
   \ifdefstring{\@docLOF}{true}{
      % Create a Table of Contents Entry for LOF
      \newpage
      \setlength{\parskip}{0.4\baselineskip}
      \phantomsection
      \bookmarksetupnext{level=subsection}
      \addcontentsline{toc}{section}{List of Figures}
      % Creat LOF
      \listoffigures
      \setlength{\parskip}{\baselineskip}
   }{}
}

\newcommand{\printLOL}{
   \ifdefstring{\@docLOL}{true}{
      % Create a Table of Contents Entry for LOL
      \newpage
      \setlength{\parskip}{0.4\baselineskip}
      \phantomsection
      \renewcommand{\lstlistlistingname}{List of Code Listings\vspace{0.25\baselineskip}}
      \bookmarksetupnext{level=subsection}
      \addcontentsline{toc}{section}{List of Code Listings}
      % Creat LOL
      \lstlistoflistings
      \setlength{\parskip}{\baselineskip}
   }{}
}

\newcommand{\printLOA}{
   \ifdefstring{\@docLOA}{true}{
      % Change the glossary title to nothing, we will create our own
      \renewcommand{\glossarysection}[2][]{}
      \newpage
      \setlength{\parskip}{0.25\baselineskip}
      \phantomsection
      \bookmarksetupnext{level=subsection}
      \addcontentsline{toc}{section}{Acronyms}
      \section*{Acronyms}
      \printglossary[style=alttree,type=\acronymtype]
      \setlength{\parskip}{\baselineskip} 
   }{}
}

% Command to create the nomenclature section
\newcommand{\printNomenclature}{
   % Create the nomenclature section - If conference paper format
   \ifdefstring{\@docNomenclature}{}{
      % Do nothing, there is no nomenclature section
   }{ 
      \PREprintNomenclature
      \phantomsection
      \bookmarksetupnext{level=subsection}
      \addcontentsline{toc}{section}{Nomenclature}
      \section*{Nomenclature}
      \begin{nomenclature}
         \@docNomenclature 
      \end{nomenclature}
   }      
}

\newcommand{\printExportFooter}{
   \ifdefstring{\@docExport}{true}{
      \footnotesize \textbf{Export Controlled Information}
      \ifdefstring{\@docSBU}{true}{\footnotesize \textbf{- SBU}}{}
      \ifdefstring{\@docITAR}{true}{\footnotesize \textbf{- ITAR}}{}
   }{} 
}

\newcommand{\printExport}{
   \newtoggle{printExport}
   \ifdefstring{\@docSBU}{true}{\toggletrue{printExport}}{} 
   \ifdefstring{\@docITAR}{true}{\toggletrue{printExport}}{} 
   \ifdefstring{\@docExportText}{}{}{\toggletrue{printExport}} 
   % Include the Tech Report Export page
   \iftoggle{printExport}{
      \newpage \null
      % Add a PDF bookmark in PDF viewer 
      \phantomsection
      \pdfbookmark[2]{Export Page}{export}
      \begin{center}
          \textbf{EXPORT INFORMATION}
      \end{center}
      % Print the custom user defined export control text
      \ifdefstring{\@docExportText}{}{}{
          \vspace{0.25in}
          \begin{center}
              \fbox{
              \begin{minipage}{5.5in}
                  {\footnotesize\@docExportText}
              \end{minipage}
              }
          \end{center}
      }
      % Print the SBU information
      \ifdefstring{\@docSBU}{true}{
          \vspace{0.25in}
          \begin{center}
              \fbox{
              \begin{minipage}{5.5in}
                  {\footnotesize\input{sbu.tex}}
              \end{minipage}
              }
          \end{center}
      }{}
      % Print the ITAR information
      \ifdefstring{\@docITAR}{true}{
          \vspace{0.25in}
          \begin{center}
              \fbox{
              \begin{minipage}{5.5in}
                  {\footnotesize\input{itar.tex}}
              \end{minipage}
              }
          \end{center}
      }{}
   }{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load the user defined template file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifdefstring{\class@template}{none}{
   % Do nothing, no template provided - just load the biblatex package to avoid errors
   \RequirePackage[backend=bibtex8, giveninits=true, natbib=true, style=aiaa, autocite=inline, bibwarn=false]{biblatex}
}{
   \ifdefstring{\class@template}{standalone}{
      % No template for standalone but change some necessary settings to avoid warnings
      \captionsetup{hypcap=false}
   }{
      % Load the user define template file
      \input{template-\class@template.tex}
   }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Main Report Section
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{
   
   % Create the glossaries for citations and acronyms
   \makeglossaries 

   % Define glossary style
   \renewcommand{\glsnamefont}[1]{\hspace{-0.5\parindent}\textbf{#1}} % Set aronyms back to bold
   \renewcommand{\glossarypreamble}{\normalsize} % Change fontsize
   \renewcommand{\arraystretch}{1.2}
   \setlength{\glspagelistwidth}{1.2\textwidth}
   \setlength{\glsdescwidth}{\textwidth}
   \glssetwidest[0]{ALongPlaceHolder}

   % Reset the glossary entries (acronyms) so that they are re-defined after the executive summary or synopsis
   \glsresetall

}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Bibliography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifdef{\printbibliography}{
   % Add the bibliography source file
   \DeclareNameAlias{sortname}{last-first}
   \DeclareNameAlias{default}{last-first}
   
   % Rename the original \printbibliography command
   \let\oldprintbibliography\printbibliography

   % Renew the original \printbibliography command with some other settings
   \renewcommand{\printbibliography}[1]{
      \phantomsection
      
      \PREprintbibliography

      % For numbered bibliograpy section:
      %\oldprintbibliography[title={References},heading=bibnumbered]

      % For non-numbered bibliography section:
      \addcontentsline{toc}{section}{References}
      \oldprintbibliography

      % Command to reset glossary defs (avoids the need to delete .glsdefs each time)
      \glsresetall
      }
}{
   % Do nothing, the a bibliography management package was not loaded, i.e. biblatex
}

\endinput
