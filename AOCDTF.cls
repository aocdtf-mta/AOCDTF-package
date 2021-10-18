% Declare that this style file requires at least LaTeX version 2e.
\NeedsTeXFormat{LaTeX2e}

% Provide the name of your page, the date it was last updated, and a comment about what it's used for
\ProvidesClass{AOCDTF}
\LoadClass[a4paper, 11pt, twoside, fleqn]{memoir}

%--------------------------------------
%PREAMBULE COMMUN A TOUS LES COURS - A MODIFIER AVEC PRUDENCE
%--------------------------------------

	%--------------------------------------
	%Inclusion de vidéos encapsulées
	%-----------------------------------

\RequirePackage[bigfiles]{pdfbase}
\ExplSyntaxOn
\cs_new:Npn\embedvideo#1#2{
  \leavevmode
  \pbs_pdfobj:nnn{}{fstream}{{}{#2}}
  \pbs_pdfobj:nnn{}{dict}{
    /Type/Filespec/F~(#2)/UF~(#2)
    /EF~<</F~\pbs_pdflastobj:>>
  }
  \tl_set:Nx\video{\pbs_pdflastobj:}%
  %
  \pbs_pdfobj:nnn{}{dict}{
    /Type/RichMediaInstance/Subtype/Video
    /Asset~\video
    /Params~<</Binding/Foreground>>
  }
  %
  \pbs_pdfobj:nnn{}{dict}{
    /Type/RichMediaConfiguration/Subtype/Video
    /Instances~[\pbs_pdflastobj:]
  }
  %
  \pbs_pdfobj:nnn{}{dict}{
    /Type/RichMediaContent
    /Assets~<<
      /Names~[(#2)~\video]
    >>
    /Configurations~[\pbs_pdflastobj:]
  }
  \tl_set:Nx\rmcontent{\pbs_pdflastobj:}%
  %
  \pbs_pdfobj:nnn{}{dict}{
    /Activation~<<
      /Condition/XA
      /Presentation~<<
        /Transparent~true
        /Style/Embedded
        /PassContextClick~true
      >>
    >>
    /Deactivation~<</Condition/PC>>
  }
  %
  \hbox_set:Nn\l_tmpa_box{#1}
  \tl_set:Nx\l_box_wd_tl{\dim_use:N\box_wd:N\l_tmpa_box}
  \tl_set:Nx\l_box_ht_tl{\dim_use:N\box_ht:N\l_tmpa_box}
  \tl_set:Nx\l_box_dp_tl{\dim_use:N\box_dp:N\l_tmpa_box}
  \pbs_pdfxform:nnnnn{1}{1}{}{}{\l_tmpa_box}
  %
  \pbs_pdfannot:nnnn{\l_box_wd_tl}{\l_box_ht_tl}{\l_box_dp_tl}{
    /Subtype/RichMedia
    /BS~<</W~0/S/S>>
    /Contents~(embedded~video~file:#2)
    /NM~(rma:#2)
    /AP~<</N~\pbs_pdflastxform:>>
    /RichMediaSettings~\pbs_pdflastobj:
    /RichMediaContent~\rmcontent
  }
  \phantom{#1}
}%
\ExplSyntaxOff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


	%--------------------------------------
	%Packages pour le document
	%--------------------------------------

	\RequirePackage[french]{babel}
	\RequirePackage[T1]{fontenc}
	\RequirePackage[french]{translator}
	\RequirePackage{lmodern, marvosym, microtype}
	\let\newfloat\undefined\RequirePackage{floatrow} %nouvel environnement flottant
	%\RequirePackage{fontspec}
	%\defaultfontfeatures{Extension = .otf}
	%\RequirePackage{fontawesome5} %gestion fine des police de caractère
	\RequirePackage[svg, table, svgnames, dvipsnames, x11names]{xcolor} %gestion des couleurs
	\RequirePackage[nowarn, noredefwarn,acronym, toc, xindy, ucmark]{glossaries}
	%\RequirePackage{tablestyles}
	\RequirePackage[amsmath, hyperref, thref, framed]{ntheorem}
	\RequirePackage{thmtools, import, docmute, auxhook, tokcycle}
	\RequirePackage[xindy, makeindex]{imakeidx}
	\RequirePackage[bookmarksnumbered=false, breaklinks=true, linktoc=all]{hyperref} %référençage
	\RequirePackage{varioref, memhfixc, hypbmsec, bookmark, xurl, tocloft, xsim, mVersion} % amélioration du référencage
	\RequirePackage{pict2e, picture, multicol, pdflscape, graphicx, eso-pic, preview, graphbox, wrapfig, svg-extract, smoothpic}
	\RequirePackage{callouts, circledsteps} %annotation d'image
	\RequirePackage[absolute]{textpos}  % disposition d'images
	\RequirePackage{authblk, tocbibind, calc, mdframed, ragged2e, lastpage, paralist, everypage, genmpage} %gestion mise en page
	\RequirePackage[noframe]{showframe}
	\RequirePackage{ifthen, xifthen, multido, etoolbox, ifpdf} %appel de fonction conditionnelles\\
	\RequirePackage{shadethm, amsmath, mathtools, amsfonts, amssymb, mathrsfs, wasysym, icomma, numprint} %écriture des mathématiques avec référénces
	\RequirePackage{chemfig, bohr, tikzorbital, chemgreek, xparse, l3keys2e, xargs, trimspaces, listofitems, expl3} %gestion de l'écriture en chimie
	\RequirePackage[version=4]{mhchem}
	\RequirePackage{modiagram} %orbitale atomique
	\RequirePackage{cancel, colortbl, soul} %packages nécessaires pour le chargement du package SIunitx
	\RequirePackage{siunitx, xfrac} %gestion des unités de physique
	\RequirePackage[export]{adjustbox}
	\RequirePackage[pdf]{pstricks}
	\RequirePackage{animate, multimedia, media9} %animation d'image
	\RequirePackage{subcaption, capt-of} %gestion des sous-figures et des légendes communes
	\RequirePackage{enumitem} %mise en page type code informatique et listes
	\RequirePackage{verbatim, fancyvrb, fvextra, spverbatim, listings, cprotect} %mise en page type code informatique et listes
	\RequirePackage{rotating, mdframed} %rotation
	\RequirePackage[scale=1,angle=0,opacity=1,contents={}]{background} %gestion de l'arrière-plan 
	\RequirePackage{xspace, xpatch, letltxmacro, environ} %macros de luxe
	\RequirePackage{pgf, pgfplots}
	\RequirePackage{tikz, tikz-qtree, pgfcalendar, pgfgantt, pgfplotstable, schemabloc} %création de figures et schémas
	\RequirePackage[edges]{forest}
	\RequirePackage{pdfpages, scrbase} %inclusion des PDF
	\RequirePackage{array, xstring, multirow, booktabs, makecell, longtable, arydshln, xltabular} %gestion fine des tableaux (sans \ltablex !)
	\RequirePackage[siunitx, european, RPvoltages]{circuitikz}%création de schémas électriques
	\RequirePackage{threeparttable} %notes dans tableaux
	\RequirePackage{fontawesome, tikzsymbols} %liste de logo (CHECK LA DOC http://tug.ctan.org/info/symbols/comprehensive/symbols-a4.pdf)
	\RequirePackage[section]{placeins} %force les figures à rester dans leur section
	\RequirePackage{impnattypo, varwidth} %règle de typographie française
	\RequirePackage{tcolorbox, pbox}
	\RequirePackage{morewrites}
	\RequirePackage{blindtext}
	\RequirePackage{newtxmath, minted, threeparttablex, hvqrurl}

	
		%--------------------------------------
		%packages aidant à la rédaction
		%--------------------------------------

		\RequirePackage{lipsum} %insertion LIPSUM
		%\RequirePackage{showframe} %montre la structure du document
		\RequirePackage{comment} %commentaire de code sur plusieurs lignes

	%--------------------------------------
	%Packages pour la bibliographie
	%--------------------------------------

	\RequirePackage[backend=biber, style=numeric, hyperref=auto, citestyle=numeric-comp, autopunct=false]{biblatex}
	\RequirePackage{biblatex-anonymous}
	\RequirePackage[autostyle]{csquotes}
	\RequirePackage[font=itshape]{quoting}
	\RequirePackage[left = \flqq{},right = \frqq{},leftsub = \flq{},rightsub = \frq{}]{dirtytalk}
	
	%--------------------------------------
	%Paramètrage de la bibliographie
	%--------------------------------------
	
	\DefineBibliographyStrings{french}{in={dans},inseries={dans}}

	\NewBibliographyString{chapitre}
	\DefineBibliographyStrings{french}{chapitre = {Chap.},}
	
	\DeclareCiteCommand{\ppracite}
  {\usebibmacro{prenote}}
  {\ifciteindex
     {\indexfield{indextitle}}
     {}%
   \printfield[citetitle]{labeltitle}%
   \setunit{\addspace}%
   \printtext[parens]{\usebibmacro{cite}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\NewBibliographyString{pprby}
\DefineBibliographyStrings{french}{pprby = {de}}

\DeclareCiteCommand{\pprbcite}
  {\usebibmacro{prenote}}
  {\ifciteindex
     {\indexfield{indextitle}}
     {}%
   \printfield[citetitle]{labeltitle}%
   \setunit{\addspace}%
   \bibstring{pprby}%
   \setunit{\addspace}%
   \printnames{labelname}}
  {\multicitedelim}
  {\usebibmacro{postnote}}
  
%--------------------------------------
%paramétrage des packages pour le document
%--------------------------------------

%\frenchbsetup{StandardLists=true} %liste au format français

\tcbuselibrary{breakable, theorems, skins, xparse}

\fvset{ %paramètre pour \begin{Verbatim}
	fontsize = \small ,
	frame=lines,
	framerule=0.5mm, 
	rulecolor=\color{blue!50!white}, 
	framesep=3mm, 
	label=Code, 
	breaklines=true, 
	breaksymbolleft={},
	breakaftersymbolpre={},
	breakafter=_ ,
	breakbefore=\\ / ,
	breakbeforesymbolpre={},
	breakautoindent=false,
	tabsize=3
	}      

\setminted[latex]{ %verbatim de luxe avec couleurs
	fontsize = \footnotesize ,
	frame=lines,
	framerule=0.5mm, 
	rulecolor=\color{blue!50!white}, 
	framesep=3mm, 
	label=Code, 
	breaklines=true, 
	breaksymbolleft={},
	breakaftersymbolpre={},
	breakafter=_ ,
	breakbefore=\\ / ,
	breakbeforesymbolpre={},
	breakautoindent=false,
	tabsize=3,
	}



\sisetup{%
	locale=FR, %règles de typo française
	detect-all, %on prend la font du document
	group-minimum-digits = 3,	 %nombre de chiffre entre chaque séparation
	free-standing-units=true, %macro pour les unités existants en dehors des arguments \si et \SI
	group-minimum-digits=5, %groupe si au moins 5 chiffres
	load-configurations=abbreviations, % charge les abréviations avec l'argument \SI
	number-unit-product,
	range-phrase=~à~,     % Utilise le tiret court pour dire "de... à"
	range-units=single,  % Cache l'unité sur la première borne
	separate-uncertainty = true,
	}  

\DeclareSIUnit\force{f}
\DeclareSIUnit\bit{bit}	


%\floatsetup[table]{capposition=top}

\AtEndDocument{\label{lastpage}}

\makeatletter 
\setlength{\@fptop}{0pt}
\makeatother

	%--------------------------------------
	%paramétrage Tikz-PGF
	%--------------------------------------

	\usetikzlibrary{babel}
	\usetikzlibrary{calc}
	\usetikzlibrary{fadings}
	\usetikzlibrary{patterns}
	\usetikzlibrary{shadows.blur}
	\usetikzlibrary{circuits, circuits.ee.IEC, circuits.ee.IEC.relay, shapes.gates.ee.IEC}
	\usetikzlibrary{arrows, arrows.meta}
	\usetikzlibrary{pgfplots.dateplot}
	\usetikzlibrary{shapes.misc, shapes.callouts, shapes.geometric}
	\usetikzlibrary{positioning}
	\usetikzlibrary{mindmap}
	\usetikzlibrary{plotmarks}
	\usetikzlibrary{fit}
	\usetikzlibrary{matrix}
	\usetikzlibrary{intersections}
	\usetikzlibrary{decorations, decorations.pathmorphing, decorations.pathreplacing, decorations.shapes, decorations.text, decorations.markings, decorations.fractals, decorations.footprints, svg.path} 
			
	\tikzset{->-/.style={decoration={
  markings,
  mark=at position #1 with {\arrow{>}}},postaction={decorate}}}
		\tikzset{-<-/.style={decoration={
  markings,
  mark=at position #1 with {\arrow{<}}},postaction={decorate}}}
	
	\tikzset{lightning bolt to/.style={to path={
		let \p1=(\tikztostart), \p2=(\tikztotarget), \n1={veclen(\y2-\y1,\x2-\x1)} in
  		(\p1) -- (\((\)(\p1)!0.6!(\p2)\()!\n1*.1!-90:(\p2)\)) -- (\((\p1)!0.55!(\p2)\)) --
  		(\p2) -- (\((\)(\p1)!0.4!(\p2)\()!\n1*.1!90:(\p2)\)) -- (\((\p1)!0.45!(\p2)\)) -- 
  		cycle (\p2)}}}
  		
	\usepgfplotslibrary{dateplot, fillbetween}
	\pgfplotsset{compat=1.16}

  	\pgfplotsset{/pgfplots/layers/axistopgridbelow/.define layer set={
        axis background,axis grid,main,axis ticks,axis lines,axis tick labels,
        axis descriptions,axis foreground}{/pgfplots/layers/standard}}

	\tikzstyle{element}=[rectangle, draw, minimum width=3cm, text centered, text width=2.5cm] %bloc de texte utilisé dans les schémas fléchés
	
	\pgfdeclaredecoration{lightning bolt}{draw}{%éclair dans les figures
		\state{draw}[width=\pgfdecoratedpathlength]{
 			\pgfpathmoveto{\pgfpointorigin}%
  		\pgfpathlineto{\pgfpoint{\pgfdecoratedpathlength*0.6}%
    		{-\pgfdecoratedpathlength*.1}}%
  		\pgfpathlineto{\pgfpoint{\pgfdecoratedpathlength*0.55}{0pt}}%
  		\pgfpathlineto{\pgfpoint{\pgfdecoratedpathlength}{0pt}}%
  		\pgfpathlineto{\pgfpoint{\pgfdecoratedpathlength*0.4}%
    		{\pgfdecoratedpathlength*.1}}%
  		\pgfpathlineto{\pgfpoint{\pgfdecoratedpathlength*0.45}{0pt}}%
 	 	\pgfpathclose%
		}%
		}
		
		\tikzset{
  		% style to apply some styles to each segment of a path
  		on each segment/.style={
    		decorate,
    		decoration={
      		show path construction,
     		moveto code={},
      		lineto code={
       			\path [#1]
        			(\tikzinputsegmentfirst) -- (\tikzinputsegmentlast);
    				},
      		curveto code={
       			\path [#1] (\tikzinputsegmentfirst) .. controls (\tikzinputsegmentsupporta) and (\tikzinputsegmentsupportb) .. (\tikzinputsegmentlast);
       			},
      		closepath code={
       			\path [#1]
        			(\tikzinputsegmentfirst) -- (\tikzinputsegmentlast);
    				},
    			},
  		},
  % style to add an arrow in the middle of a path
  mid arrow/.style={postaction={decorate,decoration={
  	markings, mark=at position .5 with {\arrow[#1]{stealth}}}}},
}
		
		\forestset{
  direction switch/.style={
    for tree={edge+=thick, font=\sffamily},
    where level>=1{folder, grow'=0}{for children=forked edge},
    where level=3{}{draw},
  },
}
		%--------------------------------------
		%grille d'aide au placement des éléments
		%--------------------------------------
	
		\makeatletter
		\newif\ifmygrid@coordinates
			\tikzset{/mygrid/step line/.style={line width=0.80pt,draw=gray!80},
         		/mygrid/steplet line/.style={line width=0.25pt,draw=gray!80}}
			\pgfkeys{/mygrid/.cd,
         		step/.store in=\mygrid@step,
        			steplet/.store in=\mygrid@steplet,
         		coordinates/.is if=mygrid@coordinates}
			\def\mygrid@def@coordinates(#1,#2)(#3,#4){%
   				\def\mygrid@xlo{#1}%
    				\def\mygrid@xhi{#3}%
    				\def\mygrid@ylo{#2}%
    				\def\mygrid@yhi{#4}%
			}
		\newcommand\DrawGrid[3][]{%
    			\pgfkeys{/mygrid/.cd,coordinates=true,step=1,steplet=0.2,#1}%
    			\draw[/mygrid/steplet line] #2 grid[step=\mygrid@steplet] #3;
    			\draw[/mygrid/step line] #2 grid[step=\mygrid@step] #3;
    			\mygrid@def@coordinates#2#3%
    			\ifmygrid@coordinates%
       			\draw[/mygrid/step line]
        			\foreach \xpos in {\mygrid@xlo,...,\mygrid@xhi} {%
         			(\xpos,\mygrid@ylo) -- ++(0,-3pt)
         			node[anchor=north] {\(\xpos\)}
        			}
        			\foreach \ypos in {\mygrid@ylo,...,\mygrid@yhi} {%
          			(\mygrid@xlo,\ypos) -- ++(-3pt,0)
					node[anchor=east] {\(\ypos\)}
        			};
    			\fi%
		}
		\makeatother
		
%--------------------------------------
%macros
%--------------------------------------

\renewcommand{\say}[1]{\og #1 \fg}

\renewcommand*\glspostdescription{\dotfill} %pour le style de glossaire

	\let\oldnewacronym\newacronym
	\newcommand*{\provideacronym}[3]{%
	  \ifglsentryexists{#1}{%
	  }{%
	    \oldnewacronym{#1}{#2}{#3}%
	  }%
	}

\makeatletter
\newenvironment{tablehere}
  {\def\@captype{table}}
  {}

\newenvironment{figurehere}
  {\def\@captype{figure}}
  {}
\makeatother

\newcounter{myWeekNum}
\stepcounter{myWeekNum}
%
\newcommand{\myWeek}{\themyWeekNum
    \stepcounter{myWeekNum}
    \ifnum\themyWeekNum=53
    \setcounter{myWeekNum}{1}
    \else\fi
}

\renewcommand\chaptermark[1]{\markboth{\thechapter.~#1}{}}

\makeatletter
\newcommand{\matiere}[1]{\def\@matiere{#1}}
\newcommand{\showmatiere}{\@matiere}

\newcommand{\cours}[1]{\def\@cours{#1}}
\newcommand{\showcours}{\@cours}

\newcommand{\formation}[1]{\def\@formation{#1}}
\newcommand{\showformation}{\@formation}

\newcommand{\corpsdemetier}[1]{\def\@corpsdemetier{#1}}
\newcommand{\showcorpsdemetier}{\@corpsdemetier}

\newcommand{\siglemetier}[1]{\def\@siglemetier{#1}}
\newcommand{\showsiglemetier}{\@siglemetier}

\newcommand{\auteura}[2]{\def\@auteura{\rmfamily #1 \textsc{#2}}}
\newcommand{\showauteura}{\@auteura}

\newcommand{\siglemetierauteura}[1]{\def\@siglemetierauteura{#1}}
\newcommand{\showsiglemetierauteura}{\@siglemetierauteura}

\newcommand{\auteurb}[2]{\def\@auteurb{\rmfamily #1 \textsc{#2}}}
\newcommand{\showauteurb}{\@auteurb}

\newcommand{\siglemetierauteurb}[1]{\def\@siglemetierauteurb{#1}}
\newcommand{\showsiglemetierauteurb}{\@siglemetierauteurb}

\newcommand{\auteurc}[2]{\def\@auteurc{\rmfamily #1 \textsc{#2}}}
\newcommand{\showauteurc}{\@auteurc}

\newcommand{\siglemetierauteurc}[1]{\def\@siglemetierauteurc{#1}}
\newcommand{\showsiglemetierauteurc}{\@siglemetierauteurc}

\newcommand{\auteurd}[2]{\def\@auteurd{\rmfamily #1 \textsc{#2}}}
\newcommand{\showauteurd}{\@auteurd}

\newcommand{\siglemetierauteurd}[1]{\def\@siglemetierauteurd{#1}}
\newcommand{\showsiglemetierauteurd}{\@siglemetierauteurd}

\newcommand{\decoupagechapitre}[1]{\def\@decoupagechapitre{#1}}
\newcommand{\showdecoupagechapitre}{\@decoupagechapitre}

\newcommand{\nombreauteur}[1]{\def\@nombreauteur{#1}}
\newcommand{\thenombreauteur}{\@nombreauteur}
\makeatother
                 
\newcommand{\auteur}[6]{%
    \IfEqCase{#1}{
    		{0}{#2}%
        	{1}{#3}%
        	{2}{#4}
        	{3}{#5}
       	{4}{#6}}}%

\newcommand{\discolorlinks}[1]{{\hypersetup{hidelinks}#1}}


\definecolor{orangelogo}{RGB}{249,125,0} %couleur orange du logo
\definecolor{bleulogo}{RGB}{11,92,180} %couleur bleue du logo

\newcommand{\circref}[1]{\CircledText{\small\textbf{\ref{#1}}} : } %référence des pastilles
\newcommand{\circrefseul}[1]{\CircledText{\small\textbf{\ref{#1}}}} %référence des pastilles

\newcommand{\textdirectcurrent}{%
  \settowidth{\dimen0}{\(=\)}%
  \vbox to .85ex {\offinterlineskip
    \hbox to \dimen0{\leaders\hrule\hfill}
    \vskip.35ex
    \hbox to \dimen0{%
      \leaders\hrule\hskip.2\dimen0\hfill
      \leaders\hrule\hskip.2\dimen0\hfill
      \leaders\hrule\hskip.2\dimen0
    }
    \vfill
  }%
}
\newcommand{\mathdirectcurrent}{\mathrel{\textdirectcurrent}}

\newcommand*{\siecle}[1]{%
\ifnum#1=1%
\bsc{\romannumeral #1}\textsuperscript{er}~siècle%
\else%
\bsc{\romannumeral #1}\textsuperscript{e}~siècle%
\fi}
 
\newcommand*{\siecles}[2]{%
\bsc{\romannumeral #1} - %
\bsc{\romannumeral #2}\textsuperscript{e}~siècles%
}

\newcommand*{\millenaire}[1]{%
\ifnum#1=1%
\bsc{\romannumeral #1}\textsuperscript{er}~millénaire%
\else%
\bsc{\romannumeral #1}\textsuperscript{e}~millénaire%
\fi}


\newcommand*{\millenaires}[2]{%
\bsc{\romannumeral #1} - %
\bsc{\romannumeral #2}\textsuperscript{e}~millénaires%
}

\newcommand{\apjc}{apr. J.-C.\xspace}
\newcommand{\avjc}{av. J.-C.\xspace}

\makeatletter
\def\minus@test{-}
\def\annee#1{\xannee#1\@nul}
\def\xannee#1#2\@nul{\def\first@arg{#1}\ifx\first@arg\minus@test{an~\(#2\) (avant J.-C.)}\else{an~\first@arg#2}\fi}
\makeatother

\newcommand{\ex}{ex. \xspace}
\newcommand{\parexemple}{p. ex. \xspace}

\newcommand{\madame}{M\textsuperscript{me}}
\newcommand{\mesdames}{M\textsuperscript{mes}}
\newcommand{\mademoiselle}{M\textsuperscript{lle}}
\newcommand{\mademoiselles}{M\textsuperscript{lles}}
\newcommand{\monsieur}{M. \xspace}
\newcommand{\messieurs}{MM. \xspace}

\newcommand{\docteur}{D\textsuperscript{r}}
\newcommand{\docteurs}{D\textsuperscript{rs}}
\newcommand{\maitre}{M\textsuperscript{e}}
\newcommand{\maitres}{M\textsuperscript{es}}
\newcommand{\professeur}{P\textsuperscript{r}}
\newcommand{\professeurs}{P\textsuperscript{rs}}

\newcommand{\numero}{n\textsuperscript{o}}
\newcommand{\numeros}{n\textsuperscript{os}}

\newcommand{\saint}{St-}
\newcommand{\saints}{Sts-}
\newcommand{\sainte}{Ste-}
\newcommand{\saintes}{Stes-}

\catcode`_=12 %
\renewcommand{\texttt}[1]{%
  \begingroup
  \ttfamily
  \begingroup\lccode`~=`/\lowercase{\endgroup\def~}{/\discretionary{}{}{}}%
  \begingroup\lccode`~=`[\lowercase{\endgroup\def~}{[\discretionary{}{}{}}%
  \begingroup\lccode`~=`.\lowercase{\endgroup\def~}{.\discretionary{}{}{}}%
  \begingroup\lccode`~=`_\lowercase{\endgroup\def~}{_\discretionary{}{}{}}%
  \catcode`/=\active\catcode`[=\active\catcode`.=\active\catcode`_=\active
  \hyphenchar\font=`\-\scantokens{#1\noexpand}%
  \endgroup
}
\catcode`_=8 % 

\let\oldminipage\minipage
\let\endoldminipage\endminipage
\renewenvironment{minipage}{\oldminipage}{\endoldminipage\medskip}

\newcounter{champtextecounter}

	\makeatletter 
\newcommand{\labelchamptexte}[1]{\def\@labelchamptexte{#1}\setcounter{champtextecounter}{1}}
\newcommand{\showlabelchamptexte}{\@labelchamptexte}
	\makeatother
\labelchamptexte{}

\newsavebox\TBox
\NewDocumentCommand{\champtexte}{ O{} m m }
{\sbox\TBox{#3 : }
\noindent{\TextField[#1, name=checkbox:\showlabelchamptexte:\thechamptextecounter, backgroundcolor=gray!30, bordercolor=gray!30, borderwidth=0,width=\dimexpr#2\linewidth-\wd\TBox]{#3 :}}\stepcounter{champtextecounter}}

\newcounter{checkboxcounter}

	\makeatletter 
\newcommand{\labelcheckbox}[1]{\def\@labelcheckbox{#1}\setcounter{checkboxcounter}{1}}
\newcommand{\showlabelcheckbox}{\@labelcheckbox}
	\makeatother
\labelcheckbox{}


\newcommand{\checkbox}[2][]
{\mbox{\CheckBox[#1, name=\showlabelcheckbox:\thecheckboxcounter, height=0.4cm, width=0.4cm, backgroundcolor=gray!30, bordercolor=gray!30, borderwidth=0]{#2}}	\stepcounter{checkboxcounter}}


\newcommand{\signature}{
\begin{flushright}
\fbox{
\begin{minipage}[t]{0.4\textwidth}
          Date et signature  
          \vspace{2cm}   
\end{minipage}}
\end{flushright}}

	%--------------------------------------
	%macro pour le type de document
	%--------------------------------------

	\makeatletter 
		\newcommand{\typemedia}[1]{\def\@typemedia{#1}\mediamacro}
		\newcommand{\thetypemedia}{\@typemedia}
	\makeatother

	\newcommand{\media}[3]{%
    		\IfEqCase{#1}{%
        {paper}{#2}%
        {screen}{#3}}}%

	%--------------------------------------
	%redéfinition des noms
	%--------------------------------------

	\addto\captionsfrench{\renewcommand{\listfigurename}{Liste des figures}} %remplacement des titres automatiques
	\addto\captionsfrench{\renewcommand{\appendixtocname}{Annexes}}
	\addto\captionsfrench{\renewcommand{\appendixpagename}{Annexes}}
 
 	\addto\extrasfrench{%traduction des références automatiques
	\def\sectionautorefname{section}%
    \def\subsectionautorefname{sous-section}%
    \def\figureautorefname{figure}%
    \def\tableautorefname{tableau}%
    \def\exerciceautorefname{exercice}%
    \def\appendixautorefname{annexe}%
    }
    
    \makeatletter
		\newcommand\tcb@cnt@definitionautorefname{définition}
		\newcommand\tcb@cnt@exempleautorefname{exemple}
		\newcommand\tcb@cnt@formuleautorefname{formule}
	\makeatother
    
	\def\frenchfigurename{{\scshape Fig.}} %style des légendes
	\def\frenchtablename{{\scshape Tab.}}
	
	%--------------------------------------
	%paramètres des tableaux
	%--------------------------------------

	\renewcommand\theadfont{\bfseries\small} %style de caractère des en-têtes des tableaux
	\renewcommand\theadalign{cc} %position des en-têtes des tableaux
	\renewcommand\theadgape{} %espacement des en-têtes des tableaux
	
	\newcolumntype{C}{>{\centering\arraybackslash}X} %nouvelle colonne de type C avec largeur automatique au centre
	\newcolumntype{R}{>{\raggedleft\arraybackslash}X} %nouvelle colonne de type R avec largeur automatique à droite
	
	\newcolumntype{i}{>{\(}l<{\)}} %nouvelle colonne de type i qui insère automatiquement un environnement mathématique à gauche
	\newcolumntype{j}{>{\(}c<{\)}}	%nouvelle colonne de type j qui insère automatiquement un environnement mathématique centré
	\newcolumntype{k}{>{\(}r<{\)}} %nouvelle colonne de type k qui insère automatiquement un environnement mathématique à droite
	
	\newcolumntype{I}{>{\(}X<{\)}} %nouvelle colonne de type I qui insère automatiquement un environnement mathématique à gauche avec largeur automatique
	\newcolumntype{J}{>{\(}C<{\)}}	%nouvelle colonne de type J qui insère automatiquement un environnement mathématique au centre avec largeur automatique
	\newcolumntype{K}{>{\(}R<{\)}} %nouvelle colonne de type K qui insère automatiquement un environnement mathématique à droite avec largeur automatique
	
	\newcolumntype{O}{k@{\({\enspace{}}={\enspace{}}\)}i} %nouvelle colonne de type O qui combine deux colonnes (d et g) pour pouvoir aligner le signe = dans un tableau
	\newcolumntype{Q}{K@{\({\enspace{}}={\enspace{}}\)}I} %nouvelle colonne de type Q qui combine deux colonnes (d et g) pour pouvoir aligner le signe = dans un tableau

	\newcolumntype{P}[1]{>{\centering\arraybackslash}p{#1}} %nouvelle colonne de type P qui centre horizontalement des colonnes avec une largeur définie de type p (pratique avec les long titres de colonnes) 
	\newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}} %nouvelle colonne de type P qui centre horizontalement des colonnes avec une largeur définie de type m (pratique avec les long titres de colonnes) 
	\newcolumntype{B}[1]{>{\centering\arraybackslash}b{#1}} %nouvelle colonne de type B qui centre horizontalement des colonnes avec une largeur définie de type b (pratique avec les long titres de colonnes) 


	\newcommand{\middashrule}{\hdashline\addlinespace} %ligne pointillée de milieu de tableau, en-dessous d'un inter-titre
	\newcommand{\HRule}{\rule{\linewidth}{0.5mm}} %ligne fine


	\newcommand{\mcrot}[4]{\multicolumn{#1}{#2}{\rlap{\rotatebox{#3}{#4}~}}} %nouvelle commande pour inclure des cellules avec rotation paramétrées (nmbr de colonnes à cheval, angle, position du texte) 
	
	\newcommand*{\twoelementtable}[3][l]% 
	{\renewcommand{\arraystretch}{0.8}%
    \begin{tabular}[t]{@{}#1@{}}%
        #2\tabularnewline
        #3%
    \end{tabular}}
    
\newenvironment{tableau}[4][]{%
	\noindent
    \tabularx{#2}[#1]{#3}
	\toprule
    #4\\
    \midrule
} {%
    \bottomrule 
    \endtabularx
}


\NewDocumentEnvironment{longtableau}{ o m m m m m O{}}{%
	\noindent
    \xltabular{#2}[#1]{#3}
	\toprule
    #6\\
    \midrule
    \endfirsthead 
	\multicolumn{#4}{l}{\small\textit{Page précédente}} \\
	\midrule
	#6\\
	\midrule
	\endhead 
	\midrule
	\multicolumn{#4}{r}{\small\textit{Page suivante}} \\
	\endfoot
	\bottomrule
	\ifx&#5&
	\else
	\\[-1em]
	\caption{#5}\\
	\fi
	#7
	\endlastfoot
} {%
    \endxltabular
}
    \newcommand{\notetableau}{\insertTableNotes}
    
	%--------------------------------------
	%paramétrage mathématique
	%--------------------------------------
	
	\renewcommand*{\overrightarrow}[1]{\vbox{\halign{##\cr %écriture des vecteurs sans que la flèche touche les lettres
 	\tiny\rightarrowfill\cr\noalign{\nointerlineskip\vskip1pt} 
  	\(#1\mskip2mu\)\cr}}}
  	
  	\LetLtxMacro{\OldSqrt}{\sqrt} %grosse prise de tête pour que la nième racine de trucmuche s'aligne correctement suite à un clash avec le package newtxmath (qui sert au lettrage en grec)
	\RenewDocumentCommand{\sqrt}{O{} O{1} O{2} m}{\OldSqrt[\leftroot{#2}\uproot{#3}#1]{#4}}%

\newcommand*{\NLS}{%
  \par
  \nobreak
  \vspace{-\parskip}%
  \noindent
  \ignorespaces
}

% expandable loop (used to avoid scope problems in tabular cells with the
% standard \loop)
\def\boucle #1\repeat {#1\b@@cle {#1}\repeat \repeat }
\def\b@@cle #1{\repeat #1\b@@cle {#1}}

\makeatletter
\newcount\@nn
\newcount\@mm
\newcount\@base
\newcount\@baseminusone

% please do not use this at home
% #1 must be a counter name, not something expanding to a number.
\def\@arabalpha #1{\ifcase #10\or1\or2\or3\or4\or5\or6\or7\or8\or9\or 
A\or B\or C\or D\or E\or F\or G\or H\or I\or J\or K\or L\or M\or N\or O\or
P\or Q\or R\or S\or T\or U\or V\or W\or X\or Y\or Z\fi}

\newcommand{\baseexpansion}[2][2]{% no negative numbers please!
\def\@digits{}%
\@base#1\relax \@baseminusone\@base\advance\@baseminusone-1
\@nn #2\relax  % this is the number to be written in base #1
%
\ifnum\@baseminusone<36
\def\onerow{#1\kern.1em\hbox{\vrule
   \vtop {\hbox{\ \the\@nn}\kern.3ex\hrule height.1ex }} &%
   \global\@mm\@nn \global\divide\@mm\@base 
   \multiply\@mm\@base \advance\@nn-\@mm 
   \the\@nn \xdef\@digits{\@arabalpha\@nn\@digits}}%
\else
\def\onerow{#1\kern.1em\hbox{\vrule
   \vtop {\hbox{\ \the\@nn}\kern.3ex\hrule height.1ex }} &%
   \global\@mm\@nn \global\divide\@mm\@base 
   \multiply\@mm\@base \advance\@nn-\@mm 
   \the\@nn \xdef\@digits{\the\@nn.\@digits}}%
\fi
%
\leavevmode\oalign{\(#2_{10}:\)\hfil\cr
      \(\left.
      \begin{tabular}{r|l}
         \boucle \onerow \\ \ifnum\@nn>\@baseminusone\global\@nn\@mm \repeat
      \end{tabular}\right\rbrace=
      \mathtt{\@digits}_{#1}\)}}     % \hfil removed from the macro

\makeatother




	\newlength{\conditionwd} %environnement de description "muibene" pour les équations et les formules
	\newenvironment{numvariables}
  		{Avec :\NLS\tabularx{\textwidth}[t]{
			j@{\({}:\enspace{}\)}X X >{\((\enspace{}}l<{\enspace{})\)} O}
			\multicolumn{2}{c}{\thead{Grandeur dans l'ISQ}} & \multicolumn{2}{c}{\thead{Unité SI de mesure}} & \multicolumn{2}{c}{\thead{Valeur}} \\
			\midrule}	%preambule du tableau à 5 colonnes
		{\endtabularx\\[\belowdisplayskip]}
		
	\newenvironment{textvariables}
  		{Avec :\NLS\tabularx{\textwidth}[t]{
			j@{\({}:\enspace{}\)}l r >{\((\enspace{}}l<{\enspace{})\)} X}
			\multicolumn{2}{c}{\thead{Grandeur dans l'ISQ}} & \multicolumn{2}{c}{\thead{Unité SI de mesure}} & \thead{Description} \\
			\midrule}	%preambule du tableau à 5 colonnes
		{\endtabularx\\[\belowdisplayskip]}
	
	\newcommand{\pc}[1]{\SI{#1}{\percent}} %nouvelle commande pour afficher les pourcents dans SIunitx

		%--------------------------------------
		%Listes théorèmes/style
		%--------------------------------------		
		
		\newtcbtheorem[number within=chapter, list inside=dfn]{definition}{Définition}
		{breakable, 
		enhanced,
		frame empty,
		fonttitle=\bfseries,
		colframe=red!50!white, 
		coltitle=red!50!black,
		 colbacktitle=red!15!white, 
		 borderline={0.5mm}{0mm}{red!15!white},
		 attach boxed title to top left={yshift=-2mm, xshift=2mm}, 
		 boxed title style={boxrule=0.4pt},
		 varwidth boxed title}{def}
		
		\newtcbtheorem[number within=chapter, list inside=frm]{formule}{Formule}
		{breakable, 
		enhanced,
		frame empty,
		fonttitle=\bfseries,
		colframe=ForestGreen!50!white, 
		coltitle=ForestGreen!50!black,
		colbacktitle=ForestGreen!15!white, 
		borderline={0.5mm}{0mm}{ForestGreen!15!white},
		attach boxed title to top left={yshift=-2mm, xshift=2mm}, 
		boxed title style={boxrule=0.4pt},
		varwidth boxed title}{form}
		
		\newtcbtheorem[number within=chapter, list inside=xmpl]{exemple}{Exemple}
		{breakable, 
		enhanced,
		frame empty,
		fonttitle=\bfseries,
		colframe=blue!50!white, 
		coltitle=blue!50!black,
		 colbacktitle=blue!15!white, 
		 borderline={0.5mm}{0mm}{blue!15!white},
		 attach boxed title to top left={yshift=-2mm, xshift=2mm}, 
		 boxed title style={boxrule=0.4pt},
		 varwidth boxed title}{ex}
	
	%--------------------------------------
	%macros pour les listes
	%--------------------------------------
	
	\newlist{tabdescription}{description}{2} %liste utilisée pour les descriptions dans les tableaux (alignement sur les cellules contenant du texte)
	\setlist[tabdescription, 1]{
	leftmargin=*, % 
	topsep=0ex, %
	parsep=0pt}
	
	\setlist[tabdescription, 2]{
	nosep,
	leftmargin=*}

	\newlist{tabitemize}{itemize}{3} %liste compacte et sans marge
	\setlist[tabitemize, 1]{
	label=\(-\), %
	nosep, %
	leftmargin=*}
	
	 \setlist[tabitemize, 2]{
	 label=\(-\), %
	 nosep,
	 leftmargin=*}
	 
	\makeatletter %instruction pour éviter les espace avant les listes qui débutent dans les colonnes des tableaux à insérer dans l'appel des colonnes >{\compress}X (ou autre type de colonnes)
	\newcommand*{\compress}{\@minipagetrue}
	\makeatother

%--------------------------------------
%Mise en page du document
%--------------------------------------

	\newif\ifFrame %instruction conditionnelle pour les couleurs des pages
	\Frametrue

	\newif\ifformation %instruction conditionnelle pour les l'inclusion d'une image dans le titre
	\formationtrue
	
	%--------------------------------------
	%Marges
	%--------------------------------------

	\setlrmarginsandblock{25mm}{20mm}{*} %réglage marge gauche-droite
	\setulmarginsandblock{20mm}{20mm}{*} %réglage marge haut-bas
	\setheadfoot{\baselineskip}{3\baselineskip} %reglage en hauteur des en-têtes et pied-de-page
	\checkandfixthelayout

	%--------------------------------------
	%En-tête et pied-de-page
	%--------------------------------------

	\pagestyle{plain}{} %réglage de la présence d'en-tête et de pied-de-page 
	\makeevenhead{plain}{}{}{} %en-tête page paire 
	\makeoddhead{plain}{}{}{} %en-tête page impaire 
	\makeevenfoot{plain}{}
	{\includegraphics[scale=0.03]{fichiers_multimedias/logo_compagnons}}
	{\ifFrame %instruction conditionelle selon la booleenne Frame
			\begin{tikzpicture}
				\draw node [rounded corners=3pt, draw=\BoxColor, fill=\BoxColor, text=black, inner xsep=2ex, inner ysep=5pt]{\sffamily\textbf{\thepage/\discolorlinks{\pageref{LastPage}}}};
			\end{tikzpicture}
		\else
		    \if\inappendix %instruction conditionelle pour savoir si on se situe dans les annexes ou pas (grosse prise de tête)
			\sffamily\textbf{\thepage/\discolorlinks{\pageref{LastPage}}}
			\else
			\sffamily\textbf{\thepage}
			\fi
		\fi} %pied-de-page page paire

	\makeoddfoot{plain}{\ifFrame %instruction conditionelle selon la booleenne Frame
		\begin{tikzpicture}
			\draw node [rounded corners=3pt, draw=\BoxColor, fill=\BoxColor, text=black, inner xsep=2ex, inner ysep=5pt]{\sffamily\textbf{\thepage/\discolorlinks{\pageref{LastPage}}}};
		\end{tikzpicture}
	\else
		    \if\inappendix %instruction conditionelle pour savoir si on se situe dans les annexes ou pas (grosse prise de tête)
			\sffamily\textbf{\thepage/\discolorlinks{\pageref{LastPage}}}
			\else
			\sffamily\textbf{\thepage}
			\fi
	\fi}
	{\includegraphics[scale=0.03]{fichiers_multimedias/logo_compagnons}}
	{}
	
	%--------------------------------------
	%macros de mise en page
	%--------------------------------------
	
	\maxsecnumdepth{subsubsection}\setsecnumdepth{subsubsection} %numérotation des sous-sous-sections
	\setcounter{tocdepth}{1} %affichage des sous-sections dans la table des matières

	\makeatletter %nouvelle commande conditionnelle interne pour différencier un chapitre en corps de texte et en annexes
		\newcommand{\inappendix}{\fi\expandafter\ifx\@chapapp\appendixname}
	\makeatother
	
	%--------------------------------------
	%Liens des titres vers la table des matières
	%--------------------------------------

\makeatletter

\newcounter{tocBackrefCount}

\def\MPR@command#1{%
  \AtBeginDocument{\csletcs{HYPBMSEC@#1}{#1}\csletcs{#1}{MPR@#1}}%
  \@namedef{MPR@#1}{\@ifstar{\@nameuse{HYPBMSEC@#1}*}{\@nameuse{MPR@#1@}}}%
  % define \MPR@<command>@
  \expandafter\DeclareDocumentCommand\csname MPR@#1@\endcsname{d() o m}{
    \stepcounter{tocBackrefCount}
    \IfNoValueTF{##1}
      {\IfNoValueTF{##2}
        {\@nameuse{HYPBMSEC@#1}(##3)[\mpr@opt{##3}]{\mpr@mand{##3}}}
        {\@nameuse{HYPBMSEC@#1}(##2)[\mpr@opt{##2}]{\mpr@mand{##3}}}
      }
      {\IfNoValueTF{##2}
        {\@nameuse{HYPBMSEC@#1}(##1)[\mpr@opt{##3}]{\mpr@mand{##3}}}
        {\@nameuse{HYPBMSEC@#1}(##1)[\mpr@opt{##2}]{\mpr@mand{##3}}}
      }
  }
}
\def\mpr@opt#1{\protect\raisebox{\baselineskip}{%
  \protect\hypertarget{toc:backref:\thetocBackrefCount}{}}#1}
\def\mpr@mand#1{\hyperlink{toc:backref:\thetocBackrefCount}{#1}}

\MPR@command{chapter}
\MPR@command{section}

\makeatother


	%--------------------------------------
	%Chapitre
	%--------------------------------------
	
	%--------------------------------------
	%Chapitre
	%--------------------------------------
	
	\makeatletter
	\makechapterstyle{douchy}{
  	\chapterstyle{komalike}
  	  \setlength{\beforechapskip}{0pt}
 	\renewcommand\printchapternum{}
  	\renewcommand\printchaptertitle[1]{
  	  		\if@mainmatter
    \begin{tabularx}{\linewidth}{@{}l @{\quad} c @{\quad} >{\raggedright\arraybackslash} X@{}}
    \raisebox{-0.93\height}{\bfseries\sffamily\small\MakeUppercase \@chapapp} & 
    \if\inappendix %instruction conditionelle pour savoir si on se situe dans les annexes ou pas (grosse prise de tête)
		\multirow{2}{*}{\raisebox{-0.99\height}{\resizebox{31,5pt}{!}{{\mdseries\sffamily \thechapter}}}}
		\else
		\ifnum\value{chapter}>9
    		\multirow{2}{*}{\raisebox{-1.02\height}{\resizebox{48pt}{!}{{\mdseries\sffamily \thechapter}}}}
    		\else
		\multirow{2}{*}{\raisebox{-1\height}{\resizebox{24,3pt}{!}{{\mdseries\sffamily \thechapter}}}}
		\fi
		\fi & \hrule depth 1pt \\
     &  &  \Huge\sffamily\bfseries\discolorlinks{##1}
  	\end{tabularx}
    \vspace{0.5cm}
	\hrule depth 1pt
  	\else
    \begin{tabularx}{\linewidth}{@{}>{\raggedright\arraybackslash} X@{}}
    \hrule depth 1pt
  	\vspace{0.5cm}
   	\Huge\sffamily\bfseries\discolorlinks{##1}
	\vspace{0.5cm}
	\hrule depth 1pt
  	\end{tabularx}
  	\fi}}
	
	\makeatother
		
	\chapterstyle{douchy}
	
	%--------------------------------------
	%Section
	%--------------------------------------
	
	\setsecheadstyle{\huge\sffamily\bfseries\discolorlinks}


	%--------------------------------------
	%Sous-section
	%--------------------------------------

	\setsubsecheadstyle{\Large\sffamily\bfseries\color{black!75}}

	%--------------------------------------
	%Sous-sous-section
	%--------------------------------------

	\setcounter{secnumdepth}{3}
	\setsubsubsecheadstyle{\large\sffamily\bfseries\color{gray}}
	
%--------------------------------------
%Prise de tête pour le verbatim coloré dans un tableau
%--------------------------------------	

\makeatletter
\let\oldmintinline\mintinline
\def\mintinline#1#2{%
\ifx\@footnotetext\TX@trial@ftn
\detokenize{#2}%
\else
\oldmintinline{#1}{#2}%
\fi}
\makeatother
	
	
%--------------------------------------
%programmations spécifiques de mise-en-pages adaptables selon les matières et les cours
%--------------------------------------

\RequirePackage{AOCDTF_couverture}
\RequirePackage{AOCDTF_titre}
\RequirePackage{AOCDTF_marqueurchapitre}
\RequirePackage{AOCDTF_mediamacro}


% Finally, we'll use \endinput to indicate that LaTeX can stop reading this file. LaTeX will ignore anything after this line.

\endinput