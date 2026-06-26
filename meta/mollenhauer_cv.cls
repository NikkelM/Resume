\RequirePackage[dvipsnames]{xcolor}
\LoadClass[12pt]{article}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{meta/mollenhauer_cv}[2023/05/22 CV class]
\RequirePackage[sfdefault]{noto}
\RequirePackage{etoolbox}
\RequirePackage{pgffor}
\RequirePackage{titlesec}
\RequirePackage{tikz}
\RequirePackage[left=0.4in,top=0.25in,right=0.4in,bottom=0.15in]{geometry} % Document margins
\RequirePackage{hyperref}
\RequirePackage{fontawesome}
\RequirePackage{mfirstuc}
\RequirePackage{ifthen}
\RequirePackage{lipsum}
\RequirePackage{array}
\RequirePackage{tabularx}
\usepackage[absolute]{textpos}
\pagestyle{empty}
\RequirePackage{enumitem}
\renewcommand{\footnotesize}{\fontsize{9pt}{11pt}\selectfont}

%Setup

\newcommand*{\setname}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\setaddress}[1]{\def\@address{#1}}
\newcommand*{\setmobile}[1]{\def\@mobile{#1}}
\newcommand*{\setposition}[1]{\def\@position{#1}}
\newcommand*{\setmail}[1]{\def\@mail{#1}}
\newcommand*{\setthemecolor}[1]{\def\@themecolor{#1}}
\newcommand*{\setlinkedinaccount}[1]{\def\@linkedinaccount{#1}}
\newcommand*{\setgithubaccount}[1]{\def\@githubaccount{#1}}
\newcommand*{\setportfolio}[1]{\def\@portfolio{#1}}
\newcommand*{\setlinkedinaccountdisplay}[1]{\def\@linkedinaccountdisplay{#1}}
\newcommand*{\setgithubaccountdisplay}[1]{\def\@githubaccountdisplay{#1}}
\newcommand*{\setportfoliodisplay}[1]{\def\@portfoliodisplay{#1}}
\newcommand*{\setlocationdisplay}[1]{\def\@locationdisplay{#1}}


%Setup for coverletter

\newcommand*{\setcompanyname}[1]{\def\@companyname{#1}}
\newcommand*{\setcontactperson}[1]{\def\@contactperson{#1}}
\newcommand*{\setclaimedposition}[1]{\def\@claimedposition{#1}}

\hypersetup{
  colorlinks=true,
  urlcolor=cyan,
}

% View commands
% Header
\newcommand{\setpicture}[1]{%
  \ifthenelse{\equal{#1}{\string 1}}
  {\newcommand\headerview{
      \begin{minipage}{0.2\linewidth}
        \profpic{0.1}{images/profile}
      \end{minipage}% 
      \hfill
      \begin{minipage}{0.8\linewidth}
        \center \name \\%[0.05cm]
        \contact
      \end{minipage}
    }}
  {\newcommand\headerview{
      \begin{minipage}{\linewidth}
        \center \name \\%[0.05cm]
        \contact
      \end{minipage}
    }}%
}

%profilepicture

\newsavebox{\picbox}
\newcommand{\profpic}[2]{%
  \savebox{\picbox}{%
    \includegraphics[scale=#1]{#2}}% 
  \tikz\node [draw, circle,%
    line width=4pt, color=white,% 
    minimum width=\wd\picbox,minimum height=\ht\picbox,%
    path picture={ \node at (path picture bounding box.center)% 
        {\usebox{\picbox}};}]% 
  {};}

%contactsubviews 

\newcommand{\githubview}{\faLinkedin\ \href{\@linkedinaccount}{\footnotesize \@linkedinaccountdisplay}}
\newcommand{\linkedinview}{\faGithub\ \href{\@githubaccount}{\footnotesize \@githubaccountdisplay}}
\newcommand{\portfolioview}{\faGlobe\ \href{\@portfolio}{\footnotesize \@portfoliodisplay}}
\newcommand{\emailview}{\faEnvelope\ \@mail}
\newcommand{\locationview}{\faMapMarker\ \@locationdisplay}

\newcommand{\name}{%
  {\large \@firstname \ \textsc{\@lastname}}
}

\newcommand{\contact}{%
  {\small \emailview\ \cpshalf \locationview\ \\
      \linkedinview\ \cpshalf \githubview\ \cpshalf \portfolioview\ \\
    }
}

% Coverletterview

\newcommand\coverletter[1]{
  \\  \coverlettersubview
  \section{} \vspace{1ex}
  % \textbf{ Dear \@contactperson, \\[0.1cm]}
  \textbf{}
  #1
}

\newcommand\coverlettersubview{
  \begin{tabular}{>{\scshape \bfseries \color{\@themecolor}}l  >{\small }l}
    Company:  & \@companyname     \\
    Position: & \@claimedposition \\
  \end{tabular}
}


% Helper commands

\newcommand\ruleafter[1]{#1~{\color{black!60!\@themecolor}\hrulefill}} % a trick to put the line with <before> parameter in \titleformat

%colorfulpipeseperator

\newcommand{\cps}{{\color{\@themecolor} \quad$\mid$ \quad}}
\newcommand{\cpshalf}{{\color{\@themecolor} \hspace{0.2em}$\mid$ \hspace{0.2em}}}

\newenvironment{coloreditemize}{
  \begin{itemize}[
      leftmargin=15pt, % How much extra space on the left of the itemize environment.
      label=\textcolor{\@themecolor}{\textbullet},
      itemsep=0pt,
      parsep=0pt
    ]
    }
    {\end{itemize}
}

% Edit section styles

\titleformat{\section}      % Customise the \section command 
{\large\bfseries\scshape\raggedright\color{\@themecolor}} % Make the \section headers large (\Large),
% small capitals (\scshape) and left aligned (\raggedright)
{}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
{\ruleafter}                           % Can be used to insert code before the heading

% To adjust spacing above, change second argument, for spacing below, the third argument
\titlespacing*{\section}{-1pt}{-20pt}{3pt}

% Textview commands

\newcommand{\experience}[2]{
  \mbox { \hspace{1em} \textbf{#1} }
}

\newcommand{\datetext}[1]{%
  {\footnotesize \mdseries \color{black!60!\@themecolor} #1 }
}

% Like \datetext but without the surrounding padding spaces, for use inside fixed-width date boxes.
\newcommand{\datetextnopad}[1]{%
  {\footnotesize \mdseries \color{black!60!\@themecolor}#1}%
}

% Fixed widths for the start/end date columns, sized to the widest expected tokens so that date
% ranges line up vertically across every experience entry. A small cushion is added to the start
% column so proportional-width digits never overflow the box. \xpDateEndWidth covers "present".
\newlength{\xpDateStartWidth}
\newlength{\xpDateEndWidth}
\settowidth{\xpDateStartWidth}{\footnotesize 00/0000}
\addtolength{\xpDateStartWidth}{0.2em}
\settowidth{\xpDateEndWidth}{\footnotesize present}

% Colored hyphen separator with explicit surrounding space (spaces inside a colored group are
% unreliable next to boxes, so spacing is set with \hspace by the callers below).
\newcommand{\xpDateSep}{\hspace{0.33em}\datetextnopad{-}\hspace{0.33em}}

% Fixed-width start/end date columns (no location): start right-aligned, end left-aligned, so the
% start dates, the separating dash, and the end dates each form clean vertical columns. Anchored to
% the right margin via the caller's \hfill, so these columns align across all experience entries.
\newcommand{\xpDateCols}[2]{% #1 start  #2 end
  \makebox[\xpDateStartWidth][r]{\datetextnopad{#1}}\xpDateSep\makebox[\xpDateEndWidth][l]{\datetextnopad{#2}}%
}

% Same as \xpDateCols but prefixed with a location (right-aligned ahead of the start column).
\newcommand{\xpDate}[3]{% #1 location  #2 start  #3 end
  \datetextnopad{#1}\xpDateSep\xpDateCols{#2}{#3}%
}

% To be used with an \explanation right below. Less bottom margin than \datedExperienceTitle
\newcommand{\datedexperience}[2]{%
  \begin{small} \mbox { \textbf{#1} } \end{small} \hfill \datetext{#2}\\[0.05cm] %
}

\newcommand{\datedExperienceTitle}[3]{%
  \begin{small} \mbox { \textbf{#1} } {\footnotesize \textit{#2}} \end{small} \hfill \datetext{#3}\\[0.2cm] %
}

% Single experience entry with aligned date columns. Location/start/end are passed separately so the
% date range lines up with every other experience entry (see \xpDate).
% #1 company  #2 title  #3 location  #4 start  #5 end
\newcommand{\datedExperienceEntry}[5]{%
  \begin{small} \mbox { \textbf{#1} } {\footnotesize \textit{#2}} \end{small} \hfill \xpDate{#3}{#4}{#5}\\[0.2cm] %
}

\newif\ifxpPromoFirst
\newcommand{\xpPromoCompany}{}
\newcommand{\xpPromoLoc}{}
\newlength{\xpRoleWidth}

% Measures the role (part before the dash) of one promotion row, tracking the widest into
% \xpRoleWidth so the dash and org/team line up across rows. #1 role  #2 org  #3 start  #4 end
\newcommand{\xpMeasureRole}[4]{%
  \settowidth{\dimen@}{\footnotesize\itshape #1}%
  \ifdim\dimen@>\xpRoleWidth \global\xpRoleWidth=\dimen@ \fi
}

% Typesets a promotion title: the role left-aligned in a fixed-width column (so the dash aligns
% across rows), followed by " - org" only when an org is given. #1 role  #2 org
\newcommand{\xpTitle}[2]{%
  {\footnotesize\itshape \makebox[\xpRoleWidth][l]{\footnotesize\itshape #1}\notblank{#2}{ - #2}{}}%
}

% Renders one role row inside \datedExperiencePromotion. The first row shows the company (bold) and
% location; later rows indent under the title and omit the location, keeping the date columns aligned.
% #1 role  #2 org  #3 start  #4 end
\newcommand{\xpPromoRow}[4]{%
  \ifxpPromoFirst
    \begin{small} \mbox { \textbf{\xpPromoCompany} } \xpTitle{#1}{#2} \end{small} \hfill \xpDate{\xpPromoLoc}{#3}{#4}%
    \global\xpPromoFirstfalse
  \else
    \begin{small} \mbox { \phantom{\textbf{\xpPromoCompany}} } \xpTitle{#1}{#2} \end{small} \hfill \xpDateCols{#3}{#4}%
  \fi
}

% Experience entry for one or more promotions within the same company. The company and location are
% shown once; each role is a {role}{org}{start}{end} quadruple, current first, listed top to bottom
% with tight spacing so they read as a single continuous role. Works for any number of roles
% (including just one). The role/org titles align on the dash, and date ranges align with each other
% and with every other experience entry. Pass an empty org ({}) to show a role with no team suffix.
% #1 company  #2 location  #3 comma-separated list of {role}{org}{start}{end} quadruples
\newcommand{\datedExperiencePromotion}[3]{%
  \renewcommand{\xpPromoCompany}{#1}\renewcommand{\xpPromoLoc}{#2}%
  \global\xpRoleWidth=0pt
  \foreach \xpRow in {#3}{\expandafter\xpMeasureRole\xpRow}%
  \global\xpPromoFirsttrue
  \foreach \xpRow in {#3}{%
    \ifxpPromoFirst\else\\[-0.12cm]\fi
    \expandafter\xpPromoRow\xpRow
  }%
  \\[0.2cm]%
}

% Second argument is to be used for a \href, will be smaller
\newcommand{\datedExperienceLink}[3]{%
  \begin{small} \mbox { \textbf{#1} } \end{small} \begin{footnotesize} {#2} \end{footnotesize} \hfill \datetext{#3}\\[0.2cm] %
}

% Similar to above, but smaller bottom margin, and the second argument is aligned to be in the same column each line
\newcommand{\datedExperienceLinkSmall}[3]{%
  \phantom{}\hspace{0.175em} 
  \begin{tabularx}{\linewidth}{@{\extracolsep{\fill}} p{0.5\linewidth} >{\raggedright\arraybackslash}X r}
    \begin{small}\textbf{#1}\end{small} & \begin{footnotesize}#2\end{footnotesize} & \hfill \datetext{#3\hspace{-0.54em}}  \\
  \end{tabularx}\\[0.075cm] %
}

% Third argument is to be used for a \href. Also includes an italic title/position argument
\newcommand{\datedExperienceTitleLink}[4]{%
  \begin{small} \mbox { \textbf{#1} } { \textit{#2} } \end{small} \begin{footnotesize} {#3} \end{footnotesize} \hfill \datetext{#4}\\[0.2cm] %
}

% 
\newcommand{\explanation}[1]{%
  \mbox { \itshape \footnotesize #1}\\[0.2cm]
}

\newcommand{\explanationdetail}[1]{%
  \begin{minipage}{0.99\linewidth} \footnotesize #1 \end{minipage} \\[0.2cm]
}

\newcommand{\itemwithtext}[1]{%
  \begin{minipage}{\linewidth} \footnotesize \item #1 \end{minipage}
}

\newcommand{\addblocktext}[2]{%
  \section{#1}
  \indent \explanationdetail{\hspace{2ex} #2}
}

\newcommand\createskill[2]{%
  \textsc{\textbf{#1}} & #2
}

\newcommand\createtablecontent[1]{%
  \foreach \x [count=\xi] in {#1} {\ifthenelse{\xi=1}{\x}{\\ \x}}
}

\newcommand\createskills[1]{%
  \explanationdetail{
    \begin{tabular}{rl}
      \makeatletter
      \@for\thisitem:=#1\do{\thisitem \\[0.1cm]}
      \makeatother
    \end{tabular}
  }
}

\newcommand\createbullets[1]{%
  \renewcommand{\labelitemi}{\coloredbullet}
  \begin{itemize}
    \makeatletter
    \@for\thisitem:=#1\do{\itemwithtext{\thisitem}}
    \makeatother
  \end{itemize}
}

\newcommand\createfootnote{%
  \begin{textblock*}{\textwidth}(0.5cm,27.3cm) % Adjust these values as needed
    \fontsize{7pt}{9pt}\selectfont
    {\today{} - View on \href{https://github.com/NikkelM/Resume}{\faGithub{} GitHub}}
  \end{textblock*}
}