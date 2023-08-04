\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jsass-nenkai}[2023/02/13 JSASS Nenkai Template Class]

\LoadClass[a4paper,notitlepage,twocolumn,10pt]{ltjsarticle}


% Layout
\RequirePackage[vmargin=25truemm,hmargin=23truemm]{geometry}
\pagestyle{empty}
\setlength{\columnsep}{7mm}
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

\renewcommand\Authfont{\normalfont\bfseries}
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
    \vspace{-10.5pt}
    {\fontsize{17pt}{25pt}\bfseries
      \setlength{\tabcolsep}{8pt}
      \begin{tabular}[t]{c c}%
        \@lectnum & \Longunderstack{\@title}
      \end{tabular}\par}%
    \vskip 1.5em\vskip 3.5pt
    \@author
    \vskip 1.5em
    \@etitle\\
    \@eauthor
    \vskip 1.5em
    Key Words~:~\@keywords
  \end{center}%
  \par\vskip 1.5em\vspace{-3pt}
  \ifvoid\@abstractbox\else\centerline{\box\@abstractbox}\vskip 1.5em\vspace{-0.5pt}\fi
}

\renewcommand{\abstractname}{Abstract}
\renewenvironment{abstract}{%
  \global\setbox\@abstractbox\hbox\bgroup
  \begin{minipage}[b]{\textwidth}
    \begin{center}%
      {\bfseries \abstractname\vspace{-8.5pt}\vspace{\z@}}%
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

\titleformat{\section}{\normalfont\normalsize\bfseries}{\thesection．}{0em}{}
\titleformat{\subsection}{\normalfont\normalsize}{\thesubsection}{1em}{}

\titlespacing{\section}{0pt}{1.5em}{0pt}
\titlespacing{\subsection}{0pt}{1em}{0pt}

\newcommand{\fullwidtharabic}[1]{\expandafter\@fullwidtharabic\csname c@#1\endcsname}
\newcommand{\@fullwidtharabic}[1]{\expandafter\@@fullwidtharabic\number#1@}
\newcommand{\@@fullwidtharabic}[1]{%
  \if#1@\else
  \ifcase#1０\or １\or ２\or ３\or ４\or ５\or ６\or ７\or ８\or ９\fi
  \expandafter\@@fullwidtharabic
  \fi
}

\renewcommand{\thesection}{\fullwidtharabic{section}}
\renewcommand{\thesubsection}{\thesection －\fullwidtharabic{subsection}}

\let\subsubsection\undefined

\crefformat{section}{#2#1節#3}
\Crefformat{section}{#2#1節#3}
\crefformat{subsection}{#2#1項#3}
\Crefformat{subsection}{#2#1項#3}


% Floats
\RequirePackage{caption}

\renewcommand{\thetable}{\fullwidtharabic{table}}
\renewcommand{\thefigure}{\fullwidtharabic{figure}}

\DeclareCaptionLabelSeparator{full-space}{　}
\captionsetup{format=hang,font={normalsize},labelsep=full-space}

\crefformat{table}{#2表#1#3}
\Crefformat{table}{#2表#1#3}
\crefformat{figure}{#2図#1#3}
\Crefformat{figure}{#2図#1#3}