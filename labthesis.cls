%% labthesis.cls
%% Class file for the lab thesis template (bachelor's IRP report / master's thesis).
%% You normally do not need to edit this file: change the settings at the top of main.tex.
%%
%% This template is based on the GSEP / TSE Department guidelines (2021); see README.md.
%% Released under the MIT License (see LICENSE).
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{labthesis}[2026/11/20 v1.0 Lab thesis template]

%% ---------------------------------------------------------------------------
%% Engine check: upLaTeX (dvipdfmx) or LuaLaTeX
%% ---------------------------------------------------------------------------
\newif\iflt@lua
\ifdefined\directlua
  \lt@luatrue
\else
  \ifdefined\enablecjktoken\else
    \ClassError{labthesis}{%
      This template must be compiled with upLaTeX.\MessageBreak
      The file latexmkrc is missing: upload it again\MessageBreak
      from the template's ZIP to the top of the project}{}%
    \@@end
  \fi
\fi

%% ---------------------------------------------------------------------------
%% Options
%% ---------------------------------------------------------------------------
\newif\iflt@en
\newif\iflt@master
\chardef\lt@headstyle=0
\DeclareOption{ja}{\lt@enfalse}
\DeclareOption{en}{\lt@entrue}
\DeclareOption{bachelor}{\lt@masterfalse}
\DeclareOption{master}{\lt@mastertrue}
\DeclareOption{heading-default}{\chardef\lt@headstyle=0 }
\DeclareOption{heading-simple}{\chardef\lt@headstyle=1 }
\DeclareOption{heading-setsu}{\chardef\lt@headstyle=2 }
\DeclareOption*{\ClassWarning{labthesis}{Unknown option `\CurrentOption' ignored}}
\ProcessOptions\relax

\iflt@lua
  \LoadClass[a4paper,12pt,nomag*,oneside,openany]{ltjsbook}
\else
  \LoadClass[uplatex,dvipdfmx,a4paper,12pt,nomag*,oneside,openany]{jsbook}
\fi

%% ---------------------------------------------------------------------------
%% `zw` (full-width unit) is a keyword in upTeX and the macro \zw in LuaTeX-ja
\ifdefined\zw\else\def\zw{zw}\fi

%% Japanese characters at the full 12pt (jsclasses scale them to about 92.5%)
%% ---------------------------------------------------------------------------
\iflt@lua
  \DeclareKanjiFamily{JY3}{ltmc}{}
  \DeclareKanjiFamily{JY3}{ltgt}{}
  \DeclareFontShape{JY3}{ltmc}{m}{n}{<-> s * [1] \ltj@stdmcfont:-kern;jfm=min}{}
  \DeclareFontShape{JY3}{ltgt}{m}{n}{<-> s * [1] \ltj@stdgtfont:-kern;jfm=min}{}
  \DeclareKanjiFamily{JT3}{ltmc}{}
  \DeclareKanjiFamily{JT3}{ltgt}{}
  \DeclareFontShape{JT3}{ltmc}{m}{n}{<->ssub*mc/m/n}{}
  \DeclareFontShape{JT3}{ltgt}{m}{n}{<->ssub*gt/m/n}{}
  \def\lt@JY{JY3}
\else
  \DeclareKanjiFamily{JY2}{ltmc}{}
  \DeclareKanjiFamily{JY2}{ltgt}{}
  \DeclareFontShape{JY2}{ltmc}{m}{n}{<-> s * [1] upjisr-h}{}
  \DeclareFontShape{JY2}{ltgt}{m}{n}{<-> s * [1] upjisg-h}{}
  \DeclareKanjiFamily{JT2}{ltmc}{}
  \DeclareKanjiFamily{JT2}{ltgt}{}
  \DeclareFontShape{JT2}{ltmc}{m}{n}{<-> s * [1] upjisr-v}{}
  \DeclareFontShape{JT2}{ltgt}{m}{n}{<-> s * [1] upjisg-v}{}
  \def\lt@JY{JY2}
\fi
\def\lt@declaresub#1#2#3#4{%
  \expandafter\DeclareFontShape\expandafter{\lt@JY}{#1}{#2}{#3}{<->ssub*#4}{}%
  \iflt@lua\DeclareFontShape{JT3}{#1}{#2}{#3}{<->ssub*#4}{}\else\DeclareFontShape{JT2}{#1}{#2}{#3}{<->ssub*#4}{}\fi}
\lt@declaresub{ltmc}{bx}{n}{ltgt/m/n}
\lt@declaresub{ltmc}{b}{n}{ltgt/m/n}
\lt@declaresub{ltgt}{bx}{n}{ltgt/m/n}
\lt@declaresub{ltgt}{b}{n}{ltgt/m/n}
\lt@declaresub{ltmc}{m}{it}{ltmc/m/n}
\lt@declaresub{ltmc}{m}{sl}{ltmc/m/n}
\lt@declaresub{ltmc}{m}{sc}{ltmc/m/n}
\lt@declaresub{ltmc}{bx}{it}{ltgt/m/n}
\lt@declaresub{ltmc}{bx}{sl}{ltgt/m/n}
\lt@declaresub{ltgt}{m}{it}{ltgt/m/n}
\lt@declaresub{ltgt}{m}{sl}{ltgt/m/n}
\lt@declaresub{ltgt}{bx}{it}{ltgt/m/n}
\lt@declaresub{ltgt}{bx}{sl}{ltgt/m/n}
\renewcommand{\mcdefault}{ltmc}
\renewcommand{\gtdefault}{ltgt}
\normalfont\normalsize
\setlength\parindent{1\zw}

%% ---------------------------------------------------------------------------
%% Page layout: A4, 12pt, 1.5 line spacing
%% ---------------------------------------------------------------------------
\iflt@lua
  \RequirePackage{geometry}
  \RequirePackage{graphicx}
\else
  \RequirePackage[dvipdfm]{geometry}
  \RequirePackage[dvipdfmx]{graphicx}
  %% Compile-time saver for Overleaf's time limit: with dvipdfmx, every image
  %% starts an external extractbb process on every LaTeX pass. Keep each image's
  %% bounding box in the .aux file, keyed by the image file's date and size, so
  %% later passes (and later compiles) reuse it. A changed file is measured again,
  %% and a missing file or a failed measurement is never kept.
  \ifdefined\pdffilemoddate\ifdefined\pdfstrcmp
    \def\lt@bbstamp#1{\pdffilemoddate{#1}/\pdffilesize{#1}}
    \def\lt@bbcache#1#2#3#4#5{%
      \ifnum\pdfstrcmp{\pdffilesize{#3}}{}=\z@\else
        \ifnum\pdfstrcmp{\lt@bbstamp{#3}}{\detokenize{#4}}=\z@
          \global\@namedef{#1 bbox#2}{#5}%
        \fi
      \fi}
    \def\lt@bbfailed{0 0 72 72 }
    \let\lt@Gread@generic\Gread@generic
    \def\Gread@generic#1#2{%
      \lt@Gread@generic{#1}{#2}%
      \ifx\@gtempa\lt@bbfailed\else
        \if@filesw
          \immediate\write\@mainaux{\string\lt@bbcache{#1}{\Gread@attr@hash}%
            {\Gin@base\Gin@ext}{\lt@bbstamp{\Gin@base\Gin@ext}}{\@gtempa}}%
        \fi
      \fi}
  \fi\fi
\fi
\iflt@en
  \geometry{a4paper,top=20mm,bottom=25mm,left=25mm,right=25mm,
    headheight=0pt,headsep=0pt,footskip=12mm}
\else
  \geometry{a4paper,top=20mm,bottom=25mm,left=20mm,right=20mm,
    headheight=0pt,headsep=0pt,footskip=12mm}
\fi
%% jsclasses use a 19.2pt baseline at 12pt. 1.5 lines of a 12pt font
%% (single line = 1.2 x 12pt = 14.4pt) is 21.6pt, so stretch by 1.125.
\RequirePackage{setspace}
\setstretch{1.125}
%% Extra half line above and below display equations
\g@addto@macro\normalsize{%
  \abovedisplayskip 16pt \@plus3pt \@minus4pt
  \belowdisplayskip 16pt \@plus3pt \@minus4pt
  \abovedisplayshortskip 10pt \@plus3pt
  \belowdisplayshortskip 10pt \@plus3pt}
\normalsize

\RequirePackage{amsmath}
\RequirePackage[round]{natbib}

%% ---------------------------------------------------------------------------
%% Settings commands used in main.tex
%% ---------------------------------------------------------------------------
\def\lt@supervisor{}
\def\lt@affiliation{}
\def\lt@year{}
\def\lt@month{}
\def\lt@kind{}
\def\lt@citestyle{}
\newcommand{\supervisor}[1]{\gdef\lt@supervisor{#1}}
\newcommand{\affiliation}[1]{\gdef\lt@affiliation{#1}}
\newcommand{\submitdate}[2]{\gdef\lt@year{#1}\gdef\lt@month{#2}}
\newcommand{\thesiskind}[1]{\gdef\lt@kind{#1}}
\newcommand{\citationstyle}[1]{\gdef\lt@citestyle{#1}}

\iflt@en
  \iflt@master
    \thesiskind{Master's Thesis}
  \else
    \thesiskind{Independent Research Project}
  \fi
  \citationstyle{Harvard style (author--date)}
\else
  \iflt@master
    \thesiskind{修士論文}
  \else
    \thesiskind{特定課題研究　報告書}
  \fi
  \citationstyle{Harvard 形式（著者・年方式）}
\fi

%% Folder that holds the body text: ja/ or en/
\newcommand{\textfolder}{\iflt@en en\else ja\fi}

\def\lt@monthname#1{\ifcase#1\or January\or February\or March\or April\or
  May\or June\or July\or August\or September\or October\or November\or
  December\fi}
\def\lt@date{%
  \iflt@en \lt@monthname{\lt@month}\ \lt@year
  \else \lt@year 年\lt@month 月\fi}

%% ---------------------------------------------------------------------------
%% Names
%% ---------------------------------------------------------------------------
\providecommand{\abstractname}{}
\renewcommand{\headfont}{\bfseries}
\iflt@en
  \renewcommand{\contentsname}{Table of Contents}
  \renewcommand{\listfigurename}{List of Figures}
  \renewcommand{\listtablename}{List of Tables}
  \renewcommand{\bibname}{References}
  \renewcommand{\refname}{References}
  \renewcommand{\abstractname}{Abstract}
  \renewcommand{\figurename}{Figure}
  \renewcommand{\tablename}{Table}
  \renewcommand{\appendixname}{Appendix~}
  \renewcommand{\prechaptername}{Chapter~}
  \renewcommand{\postchaptername}{}
  \def\lt@namesep{~}
  \def\lt@capsep{\hskip.5em\relax}
  \def\lt@secsep{\hskip.5em\relax}
\else
  \renewcommand{\contentsname}{目次}
  \renewcommand{\listfigurename}{図一覧}
  \renewcommand{\listtablename}{表一覧}
  \renewcommand{\bibname}{参考文献}
  \renewcommand{\refname}{参考文献}
  \renewcommand{\abstractname}{要約}
  \renewcommand{\figurename}{図}
  \renewcommand{\tablename}{表}
  \renewcommand{\appendixname}{付録}
  \renewcommand{\prechaptername}{第}
  \renewcommand{\postchaptername}{章}
  \def\lt@namesep{}
  \def\lt@capsep{\hskip1\zw\relax}
  \def\lt@secsep{\hskip1\zw\relax}
\fi

%% ---------------------------------------------------------------------------
%% Heading numbers
%%   heading-default : 第1章 / 1.1 / 1.1.1
%%   heading-simple  : 1． / 1) / (1)
%%   heading-setsu   : 第1章 / 第1節 / 第1項
%% ---------------------------------------------------------------------------
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
\ifcase\lt@headstyle
\or % simple
  \renewcommand{\prechaptername}{}
  \renewcommand{\postchaptername}{．}
  \renewcommand{\thesection}{\@arabic\c@section)}
  \renewcommand{\thesubsection}{(\@arabic\c@subsection)}
  \setcounter{secnumdepth}{2}
\or % setsu
  \renewcommand{\thesection}{第\@arabic\c@section 節}
  \renewcommand{\thesubsection}{第\@arabic\c@subsection 項}
  \setcounter{secnumdepth}{2}
\fi
\def\@seccntformat#1{\csname the#1\endcsname\lt@secsep}

%% Chapter headings
\def\@makechapterhead#1{%
  {\parindent\z@ \normalfont \interlinepenalty\@M
   \iflt@en
     \centering\Large\headfont
     \ifnum\c@secnumdepth>\m@ne\if@mainmatter
       \@chapapp\thechapter\@chappos\par\nobreak\vskip.25\baselineskip
     \fi\fi
     #1\par\nobreak
   \else
     \raggedright\Large\headfont
     \ifnum\c@secnumdepth>\m@ne\if@mainmatter
       \@chapapp\thechapter\@chappos\hskip1\zw
     \fi\fi
     #1\par\nobreak
   \fi
   \vskip\baselineskip}}
\def\@makeschapterhead#1{%
  {\parindent\z@ \normalfont \interlinepenalty\@M
   \centering\Large\headfont #1\par\nobreak
   \vskip\baselineskip}}
\renewcommand{\section}{%
  \@startsection{section}{1}{\z@}%
    {\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
    {.3\Cvs \@plus.3\Cdp}%
    {\normalfont\large\headfont\raggedright}}
\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{\z@}%
    {\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
    {.2\Cvs \@plus.3\Cdp}%
    {\normalfont\normalsize\headfont\raggedright}}
\renewcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{\z@}%
    {.5\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
    {.1\Cvs \@plus.3\Cdp}%
    {\normalfont\normalsize\headfont\raggedright}}

%% ---------------------------------------------------------------------------
%% Figure, table and equation numbers (per chapter)
%%   ja: 図 2.1 / 表 2.1 / （式 2-1）, referred to as 式 2-1
%%   en: Figure 2.1 / Table 2.1 / (Eq. 2.1), referred to as Eq. (2.1)
%% ---------------------------------------------------------------------------
\def\fnum@figure{\figurename\lt@namesep\thefigure}
\def\fnum@table{\tablename\lt@namesep\thetable}
\long\def\@makecaption#1#2{{\normalsize
  \advance\leftskip .0628\linewidth
  \advance\rightskip .0628\linewidth
  \vskip\abovecaptionskip
  \centering #1\lt@capsep #2\par
  \vskip\belowcaptionskip}}
%% Figure captions go below the figure, table captions above the table.
\setlength\abovecaptionskip{6pt}
\setlength\belowcaptionskip{0pt}
\renewenvironment{table}%
  {\setlength\abovecaptionskip{0pt}\setlength\belowcaptionskip{6pt}\@float{table}}%
  {\end@float}
%% Source line under a figure or table: \source{著者による}
\iflt@en
  \newcommand{\source}[1]{\par{\centering\small (Source: #1)\par}}
\else
  \newcommand{\source}[1]{\par{\centering\small （出典：#1）\par}}
\fi

\iflt@en
  \renewcommand{\theequation}{\ifnum\c@chapter>\z@\thechapter.\fi\@arabic\c@equation}
  \def\tagform@#1{\maketag@@@{(Eq.~\ignorespaces#1\unskip\@@italiccorr)}}
  \renewcommand{\eqref}[1]{Eq.~(\ref{#1})}
  \newcommand{\figref}[1]{Fig.~\ref{#1}}
  \newcommand{\tabref}[1]{Table~\ref{#1}}
\else
  \renewcommand{\theequation}{\ifnum\c@chapter>\z@\thechapter-\fi\@arabic\c@equation}
  \def\tagform@#1{\maketag@@@{（式\ignorespaces#1\unskip\@@italiccorr）}}
  \renewcommand{\eqref}[1]{式\ref{#1}}
  \newcommand{\figref}[1]{図\ref{#1}}
  \newcommand{\tabref}[1]{表\ref{#1}}
\fi

%% ---------------------------------------------------------------------------
%% Table of contents, list of figures, list of tables
%% ---------------------------------------------------------------------------
\renewcommand*{\l@chapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{.4em \@plus1pt}%
    \begingroup
      \parindent\z@ \rightskip\@tocrmarg \parfillskip-\rightskip
      \leavevmode\headfont
      \setlength\@lnumwidth{\jsc@tocl@width}\advance\@lnumwidth 2.683\zw
      \advance\leftskip\@lnumwidth \hskip-\leftskip
      #1\nobreak
      \if\relax\detokenize{#2}\relax\hfil\null
      \else\jsTocLine\nobreak\hb@xt@\@pnumwidth{\hss\normalfont#2}\fi
      \par
      \penalty\@highpenalty
    \endgroup
  \fi}
\def\lt@lofnumberline#1{\hb@xt@\@lnumwidth{\lt@lofname\lt@namesep#1\hfil}\hspace{0pt}}
\iflt@en
  \def\lt@lofwidth{6em}
\else
  \def\lt@lofwidth{5\zw}
\fi
\renewcommand*{\l@figure}[2]{{%
  \let\numberline\lt@lofnumberline \let\lt@lofname\figurename
  \@dottedtocline{1}{\z@}{\lt@lofwidth}{#1}{#2}}}
\renewcommand*{\l@table}[2]{{%
  \let\numberline\lt@lofnumberline \let\lt@lofname\tablename
  \@dottedtocline{1}{\z@}{\lt@lofwidth}{#1}{#2}}}

%% en: the citation style is stated below the table of contents,
%%     and the lists of figures and tables are listed in it.
\let\lt@tableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
  \lt@tableofcontents
  \iflt@en
    \par\vspace{\baselineskip}\noindent Citation style: \lt@citestyle\par
  \fi}
\let\lt@listoffigures\listoffigures
\renewcommand{\listoffigures}{%
  \iflt@en\addtocontents{toc}{\protect\contentsline{chapter}{\listfigurename}{}{}}\fi
  \lt@listoffigures}
\let\lt@listoftables\listoftables
\renewcommand{\listoftables}{%
  \iflt@en\addtocontents{toc}{\protect\contentsline{chapter}{\listtablename}{}{}}\fi
  \lt@listoftables}

%% ---------------------------------------------------------------------------
%% Cover page
%% ---------------------------------------------------------------------------
\renewcommand{\maketitle}{%
  \begin{titlepage}%
    \setstretch{1}\centering\normalfont
    \null\vskip 10mm
    {\fontsize{16}{24}\selectfont \lt@kind\par}%
    \vskip 18mm
    {\fontsize{18}{30}\selectfont\bfseries \@title\par}%
    \iflt@en
      \vskip 16mm
      {\fontsize{12}{16}\selectfont \lt@affiliation\par}%
      \vskip 16mm
    \else
      \vskip 32mm
    \fi
    {\fontsize{14}{21}\selectfont \lt@date\par}%
    \vskip 20mm
    {\fontsize{14}{21}\selectfont
      \iflt@en Submitted By\par\fi
      \@author\par}%
    \vskip 24mm
    {\fontsize{14}{21}\selectfont
      \iflt@en Research Supervisor\else 指導教員\fi\par
      \lt@supervisor\par}%
    \vfill
  \end{titlepage}}

%% ---------------------------------------------------------------------------
%% Abstract: its own page, title centred in bold
%% ---------------------------------------------------------------------------
\renewenvironment{abstract}{%
  \clearpage\thispagestyle{empty}%
  {\centering\normalsize\headfont\abstractname\par}%
  \vspace{\baselineskip}}{\clearpage}

%% ---------------------------------------------------------------------------
%% Page numbers: none in the front matter; page 1 is the first page of
%% chapter 1; numbers centred in the footer.
%% ---------------------------------------------------------------------------
\AtBeginDocument{\frontmatter\pagestyle{empty}}
\renewcommand{\mainmatter}{%
  \clearpage\@mainmattertrue\pagenumbering{arabic}\pagestyle{plainfoot}}

%% ---------------------------------------------------------------------------
%% References
%% ---------------------------------------------------------------------------
\renewcommand{\bibsection}{%
  \chapter*{\bibname}\addcontentsline{toc}{chapter}{\bibname}}
\iflt@en
  \setlength{\bibhang}{2em}
  %% en: references are single-spaced (1.2 x 12pt)
  \renewcommand{\bibfont}{\setstretch{0.75}}
\else
  \setlength{\bibhang}{2\zw}
  \renewcommand{\bibfont}{\setstretch{1}}
\fi
\setlength{\bibsep}{.3\baselineskip}

%% ja: the citation style is stated at the end of the report
\iflt@en\else
  \AtEndDocument{%
    \par\vspace{\baselineskip}\noindent
    \addcontentsline{toc}{chapter}{引用形式：\lt@citestyle に準拠}%
    引用形式：\lt@citestyle に準拠\par}
\fi

\endinput
