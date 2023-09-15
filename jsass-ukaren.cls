%% jsass-ukaren.cls
%
% Copyright (C) 2023 conjikidow
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is conjikidow.
%
% This file is part of the "latex-templates-jsass" (The Work in LPPL)
% and all files in that bundle must be distributed together.


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jsass-ukaren}[2023/08/05 JSASS Ukaren Template Class]

\LoadClass[a4paper,notitlepage,twocolumn,10pt]{ltjsarticle}


% Layout
\RequirePackage[vmargin=25truemm,hmargin=23truemm]{geometry}
\pagestyle{empty}
\setlength{\columnsep}{7.5mm}
\renewcommand{\baselinestretch}{0.9}


% Fonts
\RequirePackage{luatexja-fontspec}

% \setmainjfont{Harano Aji Mincho}[Scale=0.95,AutoFakeSlant=0.25] % Default font for Linux, MacOS, etc.
\setmainjfont{MS Mincho}[Scale=0.95,AutoFakeBold=2,AutoFakeSlant=0.25] % Default font for Windows
% \setmainjfont{Moga Mincho}[Scale=0.95,AutoFakeSlant=0.25] % Recommended font for Linux, MacOS, etc.
\setmainfont{Times New Roman}[Scale=0.95]


% Title
\RequirePackage{authblk}
\RequirePackage[usestackEOL]{stackengine}

\newcommand{\@lectnum}{\@empty}
\newcommand{\@etitle}{\@empty}
\newcommand{\@keywords}{\@empty}
\newcommand{\lectnum}[1]{\renewcommand{\@lectnum}{#1}}
\renewcommand{\title}[2]{\renewcommand{\@title}{#1}\renewcommand{\@etitle}{#2}}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}

\renewcommand\Authfont{\normalfont}
\renewcommand\Authsep{，}
\renewcommand\Authands{，}
\renewcommand\Authand{，}
\newcommand\eAuthfont{\normalfont}
\newcommand\eAffilfont{\normalfont}
\newcommand\eAuthsep{, }
\newcommand\eAuthands{, and }
\newcommand\eAuthand{ and }
\@namedef{@esep1}{}
\@namedef{@esep2}{\eAuthand}
\newcommand\AB@eauthlist{}
\let\AB@note@prev\@empty

\RenewDocumentCommand\author{o m m}{
  \ifnewaffil\addtocounter{affil}{1}%
    \edef\AB@thenote{\arabic{affil}}
  \fi
  \if\relax#1\relax
    \def\AB@note{\AB@thenote}
  \else
    \def\AB@note{#1}%
    \setcounter{Maxaffil}{0}
  \fi
  \ifnum\value{authors}>1\relax
    \@namedef{@sep\number\c@authors}{\Authsep}
    \@namedef{@esep\number\c@authors}{\eAuthsep}
  \fi
  \addtocounter{authors}{1}%
  \begingroup
    \let\protect\@unexpandable@protect
    \@temptokena=\expandafter{\AB@authlist}%
    \let\\=\authorcr
    \xdef\AB@authlist{\the\@temptokena%
      \ifx\AB@note@prev\@empty\else
        \ifx\AB@note@prev\AB@note\else
          {\protect\Affilfont（\@nameuse{affil@\AB@note@prev}）}%
        \fi
      \fi
      \protect\@nameuse{@sep\number\c@authors}%
      \protect{\Authfont#2}%
    }%
    \@temptokena=\expandafter{\AB@eauthlist}%
    \xdef\AB@eauthlist{\the\@temptokena%
      \ifx\AB@note@prev\@empty\else
        \ifx\AB@note@prev\AB@note\else
          {\protect\eAffilfont~(\@nameuse{eaffil@\AB@note@prev})}%
        \fi
      \fi
      \protect\@nameuse{@esep\number\c@authors}%
      \protect{\eAuthfont#3}%
    }%
  \endgroup
  \let\AB@note@prev\AB@note
  \ifnum\value{authors}>2\relax
    \@namedef{@sep\number\c@authors}{\Authands}
    \@namedef{@esep\number\c@authors}{\eAuthands}
  \fi
  \newaffilfalse
}

\let\affil\undefined
\NewDocumentCommand\affiliation{o m m}{
  \newaffiltrue\let\AB@blk@and\AB@pand
  \if\relax#1\relax
    \def\AB@note{\AB@thenote}
  \else
    \def\AB@note{#1}%
    \setcounter{Maxaffil}{0}
  \fi
  \@namedef{affil@\AB@note}{#2}
  \@namedef{eaffil@\AB@note}{#3}
}

\renewcommand{\@author}{○\AB@authlist}
\newcommand{\@eauthor}{\AB@eauthlist}

\renewcommand{\maketitle}{\par
  \begingroup
    \begingroup
      \let\protect\@unexpandable@protect
      \@temptokena=\expandafter{\AB@authlist}%
      \let\\=\authorcr
      \xdef\AB@authlist{\the\@temptokena%
        {\protect\Affilfont（\@nameuse{affil@\AB@note@prev}）}%
      }%
      \@temptokena=\expandafter{\AB@eauthlist}%
      \xdef\AB@eauthlist{\the\@temptokena%
        {\protect\eAffilfont~(\@nameuse{eaffil@\AB@note@prev})}%
      }%
    \endgroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\advance\leftskip 3\zw
      \parindent 1\zw\noindent
      \llap{\@textsuperscript{\normalfont\@thefnmark}\hskip0.3\zw}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@
      \@maketitle
    \fi
    \plainifnotempty
    \@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@date\@empty
  \global\let\@keywords\@empty
  \global\let\@eauthor\@empty
  \global\let\@etitle\@empty
  \global\let\@author\@empty
  \global\let\@title\@empty
  \global\let\@lectnum\@empty
  \global\let\lectnum\relax
  \global\let\title\relax
  \global\let\author\relax
  \global\let\affiliation\relax
  \global\let\keywords\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage\null
  \begin{center}%
    \let\footnote\thanks
    \vspace{-14pt}
    {\fontsize{17pt}{25pt}\mdseries
      \setlength{\tabcolsep}{0.5\zw}
      \begin{tabular}[t]{c c}%
        \@lectnum & \Longunderstack{\@title}
      \end{tabular}\par}%
    \vskip 1em\vskip 5pt
    {\fontsize{11pt}{17pt}\mdseries
      \@author
      \vskip 1.5em
      \@etitle
      \vskip 1pt
      \@eauthor
    }
    \vskip 1.5em
    Key Words~:~\@keywords
  \end{center}%
  \par\vskip 1.5em
  \ifvoid\@abstractbox\else\centerline{\box\@abstractbox}\vskip 3.5em\fi
}

\renewcommand{\abstractname}{Abstract}
\renewenvironment{abstract}{%
  \global\setbox\@abstractbox\hbox\bgroup
  \begin{minipage}[b]{\textwidth}
    \begin{center}%
      {\abstractname\vspace{-8.5pt}\vspace{\z@}}%
    \end{center}%
    \list{}{%
      \listparindent\parindent%
      \itemindent\listparindent%
      \rightmargin0pt%
      \leftmargin0pt}%
    \item\relax
}{\endlist\end{minipage}\egroup}


% Sections
\RequirePackage{amsmath} % Must be loaded before cleverref
\RequirePackage[unicode,hidelinks]{hyperref} % Must be loaded before cleverref
\RequirePackage{cleveref}
\RequirePackage{titlesec}

\titleformat{\section}{\normalfont\normalsize\bfseries}{\thesection.}{1.5em}{}
\titleformat{\subsection}{\normalfont\normalsize\bfseries}{\thesubsection.}{1.5em}{}

\titlespacing{\section}{0pt}{1.5em}{0pt}
\titlespacing{\subsection}{0pt}{0.5em}{0pt}

\let\subsubsection\undefined

\crefformat{section}{#2#1節#3}
\Crefformat{section}{#2#1節#3}
\crefformat{subsection}{#2#1項#3}
\Crefformat{subsection}{#2#1項#3}


% Floats
\RequirePackage{caption}

\captionsetup{format=hang,font={normalsize},labelsep=quad}

\crefformat{table}{#2表#1#3}
\Crefformat{table}{#2表#1#3}
\crefformat{figure}{#2図#1#3}
\Crefformat{figure}{#2図#1#3}


% References
\RequirePackage[style=numeric-comp, backend=biber]{biblatex}
\ExecuteBibliographyOptions{
  maxbibnames=2,
  giveninits=true,
  doi=false,
  eprint=false,
  isbn=false,
  hyperref=true,
  backref=false,
  sorting=none
}

\DeclareCiteCommand{\supercite}[\mkbibsuperscript]
  {\usebibmacro{cite:init}%
   \let\multicitedelim=\supercitedelim
   \let\multicitesubentrydelim=\supercitesubentrydelim
   \let\multiciterangedelim=\superciterangedelim
   \let\multicitesubentryrangedelim=\supercitesubentryrangedelim
   \iffieldundef{prenote}
     {}
     {\BibliographyWarning{Ignoring prenote argument}}%
   \iffieldundef{postnote}
     {}
     {\BibliographyWarning{Ignoring postnote argument}}}
  {\usebibmacro{citeindex}%
   \usebibmacro{cite:comp}}
  {}
  {\usebibmacro{cite:dump})}
\let\cite\supercite

\DeclareFieldFormat{labelnumberwidth}{#1)}

\DeclareFieldFormat*{title}{#1}
\DeclareFieldFormat*{journaltitle}{#1}
\DeclareFieldFormat*{booktitle}{#1}
\DeclareFieldFormat[article,periodical,inproceedings,thesis]{volume}{%
  \ifinteger{#1}
  {\iffieldequalstr{langid}{japanese}
    {第#1巻}
    {Vol\adddot~#1}}
  {#1}}
\DeclareFieldFormat[article,periodical,inproceedings,thesis]{number}{%
  \ifinteger{#1}
  {\iffieldequalstr{langid}{japanese}
    {第#1号}
    {No\adddot~#1}}
  {#1}}
\DeclareFieldFormat{url}{\url{#1}}
\DeclareFieldFormat{urldate}{\mkbibparens{閲覧日\space\thefield{urlyear}/\thefield{urlmonth}/\thefield{urlday}}}

\renewcommand*{\newblockpunct}{：}
\renewcommand*{\newunitpunct}{\addcomma\space\,}
\uspunctuation

\newbibmacro*{journal+pages+year}{%
  \usebibmacro{journal}\newunit%
  \printfield{volume}\newunit%
  \printfield{number}\newunit%
  \printfield{pages}\newunit%
  \printfield{year}}

\newbibmacro*{proceedingtitle+pages+year}{%
  \usebibmacro{booktitle}\newunit%
  \printlist{publisher}\newunit%
  \printfield{volume}\newunit%
  \printfield{number}\newunit%
  \printfield{pages}\newunit%
  \printfield{year}}

\newbibmacro*{event+venue+year}{%
  \printfield{eventtitle}\newunit%
  \printfield{eventtitleaddon}%
  \iffieldundef{volume}
  {}
  {\newunit\printfield{volume}}%
  \newunit%
  \ifboolexpr{test {\iffieldundef{venue}}}
    {\ifboolexpr{test {\iflistundef{location}}}{}{\printlist{location}}}
    {\printfield{venue}}%
  \ifboolexpr{test {\iffieldundef{eventyear}}}
    {\ifboolexpr{test {\iffieldundef{year}}}{}{\newunit\printfield{year}}}
    {\newunit\printfield{eventyear}}%
  \newunit}

\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author}\newblock%
  \usebibmacro{title}%
  \usebibmacro{journal+pages+year}%
  \usebibmacro{finentry}%
}

\DeclareBibliographyDriver{inproceedings}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author}\newblock%
  \usebibmacro{title}%
  \iffieldundef{booktitle}
  {\usebibmacro{event+venue+year}}
  {\usebibmacro{proceedingtitle+pages+year}}%
  \usebibmacro{finentry}%
}

\DeclareBibliographyDriver{online}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author}\newblock%
  \usebibmacro{title}%
  \printlist{organization}\newunit%
  \printfield{year}\newunit%
  \usebibmacro{url+urldate}%
  \usebibmacro{finentry}%
}

\DeclareNameAlias{author}{family-given}
\renewrobustcmd*{\bibnamedelima}{\,}
\renewrobustcmd*{\bibnamedelimd}{\,}
\renewrobustcmd*{\bibinitdelim}{\,}
\DeclareDelimFormat{multinamedelim}{\addcomma\space\,}
\DeclareDelimFormat{andothersdelim}{\addspace\,}

\DeclareDelimFormat{finalnamedelim}{%
  \ifnumgreater{\value{liststop}}{2}{\finalandcomma}{}%
  \iffieldequalstr{langid}{japanese}
  {\multinamedelim}
  {\multinamedelim\bibstring{and}\space}}

\newbibmacro*{name:japanese-full}[4]{%
  \usebibmacro{name:delim}{#2#3#1}%
  \usebibmacro{name:hook}{#2#3#1}%
  \mkbibnamefamily{#1}\isdot%
  \ifdefvoid{#3}{}{\ifdefvoid{#1}{}{\bibnamedelimd}\mkbibnameprefix{#3}\isdot}%
  \ifdefvoid{#2}{}{\ifdefvoid{#1}{}{\bibnamedelima}\mkbibnamegiven{#2}\isdot}%
  \ifdefvoid{#4}{}{\ifdefvoid{#1}{}{\bibnamedelimd}\mkbibnameaffix{#4}\isdot}}

\renewbibmacro*{name:andothers}{%
  \ifboolexpr{
    test {\ifnumequal{\value{listcount}}{\value{liststop}}}
    and
    test \ifmorenames
  }
    {\ifnumgreater{\value{liststop}}{1}
        {\finalandcomma}
        {}%
      \printdelim{andothersdelim}%
      \iffieldequalstr{langid}{japanese}{他}{\bibstring{andothers}}}
    {}
  }

\DeclareNameFormat{family-given}{%
  \iffieldequalstr{langid}{japanese}
  {\usebibmacro{name:japanese-full}%
    {\namepartgiven}%
    {\namepartfamily}%
    {\namepartprefix}%
    {\namepartsuffix}%
    \usebibmacro{name:andothers}}
  {\usebibmacro{name:family-given}%
    {\namepartfamily}%
    {\namepartgiveni}%
    {\namepartprefix}%
    {\namepartsuffix}%
    \usebibmacro{name:andothers}}}
