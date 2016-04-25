%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NASA LaTeX Docs - LaTeX Templates and Build Script
% Software Release: This code is is governed by NPR 2210.1C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Prepare class file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Package with programming tools geared primarily towards LaTeX class and package authors 
\RequirePackage{layouts,etoolbox}  			

% Must indicate that we are using LaTeX2e (LaTeX2e is the latest stable release of LaTeX)
\NeedsTeXFormat{LaTeX2e}

% Define class name, date, and version
\ProvidesClass{nasa-latex-docs}[2016/02/02 v1.0 NASA LaTeX Docs]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Determine the document type option passed to class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Custom function to quickly declare toggles and set document type values 
\newcommand{\parseInputType}[3]{
   \newtoggle{#1}
   \DeclareOption{#1}{
      \toggletrue{#1} 
      \let\docType=#2 
      \def\@@ptsize{#3}
   }
}

% Define each enumeration value
\def\caseAIAAConference{1}
\def\caseAIAAJournal{2}
\def\caseIEEE{3}
\def\caseTechMemo{4}
\def\caseTechBrief{5} 
\def\caseTechReport{6}

% Define document type variable
\def\docType{\caseTechReport}       

% Declare the possible document types to pass in as true/false toggles (from: etoolbox)
\parseInputType{AIAA-Conference}{\caseAIAAConference}{10pt}
\parseInputType{AIAA-Journal}{\caseAIAAJournal}{10pt}
\parseInputType{IEEE}{\caseIEEE}{10pt}
\parseInputType{Tech-Memo}{\caseTechMemo}{12pt}
\parseInputType{Tech-Brief}{\caseTechBrief}{12pt}
\parseInputType{Tech-Report}{\caseTechReport}{12pt}

% Journal manuscript submission is to be single column - so it inherits from "AIAA-Conference"
\parseInputType{AIAA-Journal-Submit}{\caseAIAAConference} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Parse all other class options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define font-size class input options
\DeclareOption{8pt}{\def\@@ptsize{5pt}}
\DeclareOption{9pt}{\def\@@ptsize{9pt}}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}
\DeclareOption{13pt}{\def\@@ptsize{13pt}}
\DeclareOption{14pt}{\def\@@ptsize{14pt}}

\newcommand{\parseInput}[1]{
   \newtoggle{#1}
   \DeclareOption{#1}{\toggletrue{#1}}
}

% Define all other options
\newtoggle{twocolumns} % \parseInput{twocolumns}
\parseInput{times}

% Process the options - they are now 'live' in the class file
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Setup the general options for each document type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Toggle class loading based on \docType enumeration
\ifcase\docType
   \or % matches caseAIAAConference
      \LoadClass[letterpaper,\@@ptsize]{article}
      \RequirePackage[backend=bibtex, firstinits=true, natbib=true, style=aiaa, autocite=superscript]{biblatex} 
      \let\cite\autocite
   \or % matches caseAIAAJournal
      \LoadClass[letterpaper,\@@ptsize,twoside,twocolumn]{article}
      \RequirePackage[backend=bibtex, firstinits=true, natbib=true, style=aiaa, autocite=superscript]{biblatex} 
      \let\cite\autocite
      \toggletrue{twocolumns}
   \or % matches caseIEEE
      \LoadClass[letterpaper,\@@ptsize]{article}
      \toggletrue{twocolumns}
   \or % matches caseTechMemo
      \LoadClass[letterpaper,\@@ptsize]{article}
   \or % matches caseTechBrief
      \LoadClass[letterpaper,\@@ptsize]{article}
   \or % matches caseTechReport
      \LoadClass[letterpaper,\@@ptsize]{article}
\fi

% Override in order to use Times New Roman font
\iftoggle{times}{
   \RequirePackage{times}
   \RequirePackage{mathptmx}
}

% Define the column separation distance default value
\iftoggle{twocolumns}{
   \setlength{\columnsep}{0.75cm}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load Required Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{packages.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load document command shortcuts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{doc-shortcuts.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load document parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{doc-params.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: General formatting definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define graphics inputs
\DeclareGraphicsExtensions{.pdf,.png,.jpg,.ps,.gif,.eps}

% For breaking long underscored words into next line where appropriate
\renewcommand\_{\textunderscore\allowbreak}

% Create the bibliography
% Put this here because you want it at called before the "lastpage" package is loaded
\AtEndDocument{
   \phantomsection
   \addcontentsline{toc}{section}{References}
   
   \renewcommand*{\bibfont}{\small}

   \printbibliography

   % Command to reset glossary defs (avoids the need to delete .glsdefs each time)
   \glsresetall
}

% Include the lastpage package
\RequirePackage{lastpage}        % to determine last page of each section

% Remove white space caused by using the various package environments
\AtBeginEnvironment{center}{\vspace{-\baselineskip}}
\AtEndEnvironment{center}{\vspace{-\baselineskip}}

% This piece of code centers all float environments "[H]"
\AtEndPreamble{
   \makeatletter
   \g@addto@macro\@floatboxreset\centering
   \makeatother
}

% Command to fix issue with outter quotation marks being the wrong direction
\MakeOuterQuote{"}

% Define spacing between Section titles and text
\titlespacing{\section}{0pt}{\baselineskip}{5pt}
\titlespacing{\subsection}{0pt}{\baselineskip}{5pt}
\titlespacing{\subsubsection}{0pt}{\baselineskip}{5pt}
\titlespacing{\paragraph}{0pt}{\baselineskip}{5pt}

% Make figure, table, and equation captions bold
\captionsetup[table]{font={bf,normalsize},position=above,skip=0.5\baselineskip}
\captionsetup[figure]{font={bf,normalsize},position=below}
\captionsetup[equation]{font={bf,normalsize},position=right}
\captionsetup[lstlisting]{font={bf,normalsize},position=above,skip=\baselineskip}

% Define the caption skip parameter
\setlength{\belowcaptionskip}{-0.25\baselineskip}

% Change list structure spacing
\setlist[itemize]{itemsep = 0pt}
\setlist[enumerate]{itemsep = 0pt}
\setlist[description]{itemsep = 0pt}

% Set up hyperlink options
\hypersetup{hidelinks}
\hypersetup{urlcolor=cyan}

\AtBeginDocument{
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
      \def\chapterautorefname{Section}%
      \def\partautorefname{Section}%
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
      \def\chapterautorefname{Section}%
      \def\partautorefname{Section}%
      \orgautoref}

   % Pass the "\ref" command to \autoref
   \let\ref\autoref

   % Create a new command "\Ref" to call \Autoref - for alternate form
   \let\Ref\Autoref

   % Disable hyperlinks for acronyms
   \glsdisablehyper 

   % Setup bookmarks to be numbered
   \bookmarksetup{numbered}

   % Add a PDF bookmark in PDF viewer THIS WILL BE USEFUL FOR T-078 - combines all bookmarks under 1
   %\phantomsection
   %\pdfbookmark[0]{Report}{report}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Useful commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Environment to define nomenclature section
\newlength{\docNomenclatureVarWidthDefault}
\setlength{\docNomenclatureVarWidthDefault}{2.75em}

\newenvironment{nomenclature}[1][]
{
   \noindent\tabular{@{} p{\@docNomenclatureScale\docNomenclatureVarWidthDefault} @{\hspace{2pt}=\hspace{0.5em}} l} %
}{
   \endtabular
}

% Command to create the nomenclature section
\newcommand{\makeNomenclature}{
   % Create the nomenclature section - If conference paper format
   \ifdefstring{\@docNomenclature}{}{
      % Do nothing, there is no nomenclature section
   }{
      \section*{Nomenclature}
      \begin{nomenclature}
         \@docNomenclature 
      \end{nomenclature}
   }      
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load custom definitions for each document type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Toggle class loading based on \docType enumeration
\ifcase\docType
   \or % matches caseAIAAConference
      \input{aiaa-conference.tex}  
      \geometry{margin=1in,includefoot}    
   \or % matches caseAIAAJournal
      \input{aiaa-journal.tex}
      \geometry{margin=1in,includefoot} 
   \or % matches caseIEEE
      \input{ieee.tex}
      \geometry{margin=1in,top=0.75in,bottom=0.9in,headheight=0.5\baselineskip}  
   \or % matches caseTechMemo
      \input{tech-brief.tex}
      \geometry{head=0.5in,foot=0.25in,top=0.65in,left=1in,right=1in,bottom=0.95in,includeheadfoot}  
   \or % matches caseTechBrief
      \input{tech-memo.tex}
      \geometry{head=0.5in,foot=0.25in,top=0.65in,left=1in,right=1in,bottom=0.95in,includeheadfoot}  
   \or % matches caseTechReport
      \input{tech-report.tex}
      \geometry{head=0.5in,foot=0.25in,top=0.65in,left=1in,right=1in,bottom=0.95in,includeheadfoot}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Main Report Section
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{

   % Create the glossaries for citations and acronyms
   \makeglossaries 

   % Reset the glossary entries (acronyms) so that they are re-defined after the executive summary or synopsis
   \glsresetall

}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Bibliography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add the bibliography source file
\DeclareNameAlias{sortname}{last-first}
\DeclareNameAlias{default}{last-first}

% Change the citation to include "Reference" before citation number
% \DeclareCiteCommand{\cite}[Ref.] % Uncomment this if you want to prepend word
% % \DeclareCiteCommand{\cite}[\mkbibbrackets]
% {\usebibmacro{prenote}}
% {\usebibmacro{citeindex}
% \usebibmacro{cite}}
% {\multicitedelim}
% {\usebibmacro{postnote}}

\endinput
