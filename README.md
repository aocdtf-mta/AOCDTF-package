## Package AOCDTF

LaTeX package for template to AOCDTF's educational content.

Ce dépôt contient les packages LaTeX nécessaire à la bonne compilation du template AOCDTF, dont les packages propriétaitres AOCDTF et AOCDTF_diaporama. Il s'agit de packages destinés à contenir les paramètrages précis du template AOCDTF. Ce dépôt a pour fonction de tenir aisément à jour les packages spécifiques au template AOCDTF.

## Etapes à effectuer

0. Maitriser les bases de la programmation sous l'environnement LaTeX et se familiariser avec le langage de versionnage Git :
- `commit/push` pour exporter en ligne les modifications dans une branche à son prenom_nom.
- `merge` pour intégrer ses modifications dans la branche "master"
- `pull` pour importer les modifications de la branche "master" (ou autre) depuis le dépôt Github

Divers documents de tutoriel pour tous les niveaux sont disponibles dans la base de données et sur internet, avec entre autre : 
- `base_de_donnees/latex/masson-fiches_latex/...`
- `base_de_donnees/latex/goulet-redaction_latex.pdf`
- [cours Openclassrooms](https://openclassrooms.com/fr/courses/5641721-utilisez-git-et-github-pour-vos-projets-de-developpement)
    
1. Installer 
 - LaTeX avec la distribution [TexLive](https://www.tug.org/texlive/)
 - Editeur [Texmaker](https://www.xm1math.net/texmaker/index_fr.html)
 - Gestionnaire de dépôt [GitKraken](https://www.gitkraken.com)
 - S'inscrire sur le site d'éditeur de dessin SVG (dessin vectoriel importable dans LaTeX) [Draw](https://www.draw.io)
 - Programme de gestion des bibliographie [Biber](http://biblatex-biber.sourceforge.net)
 - Editeur d'image en format vectoriel [Inkscape](https://inkscape.org/fr/)
 - Extracteur de données issues de graphiques [WebPlotDigitzer](https://automeris.io/WebPlotDigitizer/)
 - Logiciel de géométrie [Geogebra](https://www.geogebra.org/?lang=fr)
 - S'inscrire sur le site d'éditeur de dessin Tikz (code de dessin LaTeX) [Mathcha](https://www.mathcha.io/editor)

2. Importer le dépôt AOCDTF-package à l'aide de GitKraken dans l'emplacement des packages de la distribution TexLive :
`texlive/2020/texmf-dist/tex/latex` et ne pas oublier de mettre à jour la base de données des packages (se référer au tutoriel présent dans le document "tutoriel_ajout_packages.pdf").

