\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jsass-nenkai}[2023/02/15 JSASS Nenkai Template Class]

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
% \setmainjfont{MogaMincho}[Scale=0.95,AutoFakeSlant=0.25] % Recommended for Linux, MacOS, etc.
\setmainfont{Times New Roman}[Scale=0.95]


% Title
\RequirePackage[usestackEOL]{stackengine}

\newcommand{\@lectnum}{\@empty}
\newcommand{\@etitle}{\@empty}
\newcommand{\@eauthor}{\@empty}
\newcommand{\@institute}{\@empty}
\newcommand{\@einstitute}{\@empty}
\newcommand{\@keywords}{\@empty}
\newcommand{\lectnum}[1]{\renewcommand{\@lectnum}{#1}}
\newcommand{\etitle}[1]{\renewcommand{\@etitle}{#1}}
\newcommand{\eauthor}[1]{\renewcommand{\@eauthor}{#1}}
\newcommand{\institute}[1]{\renewcommand{\@institute}{#1}}
\newcommand{\einstitute}[1]{\renewcommand{\@einstitute}{#1}}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}

\renewcommand{\maketitle}{\par
  \begingroup
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
  \global\let\@einstitute\@empty
  \global\let\@eauthor\@empty
  \global\let\@etitle\@empty
  \global\let\@institute\@empty
  \global\let\@author\@empty
  \global\let\@title\@empty
  \global\let\@lectnum\@empty
  \global\let\lectnum\relax
  \global\let\title\relax
  \global\let\etitle\relax
  \global\let\author\relax
  \global\let\eauthor\relax
  \global\let\institute\relax
  \global\let\einstitute\relax
  \global\let\keywords\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage\null
  \begin{center}%
    \let\footnote\thanks
    \vspace{-3pt}
    {\fontsize{17pt}{17pt}\bfseries
      \setlength{\tabcolsep}{8pt}
      \begin{tabular}[t]{c c}%
        \@lectnum & \Longunderstack{\@title}
      \end{tabular}\par}%
    \vskip 1.5em\vskip 5pt
    ○\textbf{\@author}（\@institute）
    \vskip 1.5em
    \@etitle\\[-1pt]
    \@eauthor~(\@einstitute)
    \vskip 1.5em
    Key Words：\@keywords
  \end{center}%
  \par\vskip 1.2em
  \ifvoid\@abstractbox\else\centerline{\box\@abstractbox}\vskip 1.5em\fi
}

\renewcommand{\abstractname}{Abstract}
\renewenvironment{abstract}{%
  \global\setbox\@abstractbox\hbox\bgroup
  \begin{minipage}[b]{\textwidth}
    \begin{center}%
      {\bfseries \abstractname\vspace{-0.8em}\vspace{\z@}}%
    \end{center}%
    \list{}{%
      \listparindent\parindent%
      \itemindent\listparindent%
      \rightmargin0pt%
      \leftmargin0pt}%
    \item\relax
}{\endlist\end{minipage}\egroup}


% Sections
\RequirePackage{cleveref}
\RequirePackage{titlesec}

\titleformat{\section}{\normalfont\normalsize\bfseries}{\thesection}{0em}{．}
\titleformat{\subsection}{\normalfont\normalsize}{\thesubsection}{1em}{}

\titlespacing{\section}{0pt}{1.5em}{0pt}
\titlespacing{\subsection}{0pt}{0pt}{0pt}

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
\RequirePackage{cleveref}

\renewcommand{\thetable}{\fullwidtharabic{table}}
\renewcommand{\thefigure}{\fullwidtharabic{figure}}
\crefformat{table}{#2表#1#3}
\Crefformat{table}{#2表#1#3}
\crefformat{figure}{#2図#1#3}
\Crefformat{figure}{#2図#1#3}