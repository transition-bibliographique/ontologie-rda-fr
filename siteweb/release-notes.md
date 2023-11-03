# Ontologie RDA-FR - Historique des versions

## v0.2.0, novembre 2023 {#v0.2.0}

Version toujours qualifiée comme bêta, reste partielle, et le caractère évolutif de l’ontologie d’une version à l’autre toujours valable. Apports de cette version : 

* Classes et leurs propriétés
  * Déclaration de trois nouvelles classes, ***Oeuvre***, ***Manifestation*** et ***Lieu***, et de leurs propriétés. 
* Vocabulaires contrôlés 
  * Cette version voit pour la première fois la publication des vocabulaires contrôlés associés aux attributs des entités Oeuvre, Manifestation et Lieu. Les vocabulaires contrôlés sont déclarés dans l’espace de nom [https://rdafr.fr/vocabulary](https://rdafr.fr/vocabulary).  \
Chacun des 44 référentiels déclarés fait l’objet d’une page distincte. Le nombre des valeurs dans un référentiel peut être très variable. Chacune d’entre elles fait l’objet d’une déclaration en propre.
* Quelques nouvelles propriétés pour les classes déjà publiées
* Quelques correctifs et modifications dans les propriétés déjà publiées

Toute nouveauté (nouvelle classe, nouvelle propriété, les référentiels et leurs valeurs, correctifs et modifications sur les propriétés déjà publiées) est identifiable par le numéro de version V 0.2.0 de cette publication.

## v0.1.0, mai 2023 {#v0.1.0}

Version, toujours qualifiée comme beta, reste partielle, et le caractère évolutif de l’ontologie d’une version à l’autre toujours valable. Apports de cette version : 

* Publication de la première vue de l’ontologie RDA-FR en OWL

* Sur les classes et leur propriétés publiées : 
  * déclaration des propriétés pour deux nouvelles entités, ***Collectivité*** et ***Famille***, complétant ainsi le bloc des entités ***Agent*** : 
  * ajout de nombreuses nouvelles propriétés pour les classes qui faisaient déjà partie de la version V 0.1.0. Il s’agit essentiellement de propriétés qui expriment des relations entre entités Agent du code RDA-FR. Il est à souligner que les deux sous-groupes de la Tb, Personnes & Familles et Collectivités, en charge de la section 9, ont donné leur accord pour inclure dans cette version 0.1.0 de l’ontologie RDA-FR toutes les relations entre agents identifiées à ce stade et ce, en amont de la publication de la section 9. 
  plus d'informations sur toutes les propriétés. Cette version 0.1.0 s’enrichit avec : 
    * les descriptions de chacune des propriétés
    * la citation de la référence au code RDA-FR de l’attribut correspondant.

* Sur les choix architecturaux et de gestion : 
  * des explications supplémentaires dans le texte explicatif sur https://rdafr.fr, éclairant davantage sur les différents choix pour l’ontologie RDA-FR, avec, notamment : 
l’explication sur le choix de dissocier l’ontologie RDA-FR (en OWL) de son profil d’application (en SHACL) ;
  * des explications sur la gestion des propriétés génériques ;
  * une mise à jour du schéma qui donne la vue globale de la hiérarchie des classes de l’ontologie RDA-FR, avec mise en lumière des classes faisant l’objet de la publication de cette version ;
  * des correctifs mineurs sur les autres schémas de modélisation.

* Sur l’historicisation des versions : 
  * la page https://rdafr.fr, page contiendra désormais : 
    * le texte d’accueil portant sur le cadre de l’élaboration de l’ontologie et son objectif, 
    * les explications nécessaires à la compréhension des choix architecturaux et des mécanismes fonctionnels de gestion de cette ontologie et de son profil d’application (texte évolutif au fil des versions)
    * les informations sur les modalités techniques de publication de l’ontologie RDA-FR
    * cette page portera aussi la mention du numéro de la dernière version de publication de l’ontologie, le numéro de cette version étant V 0.1.0. 
    * les nouveautés d’une version à l’autre sont retracées dans la page distincte Historique des versions https://rdafr.fr/release-notes à laquelle on accède aussi depuis la section Historique des versions de la page https://rdafr.fr.

* Sur l’historicisation des versions : 
  * la page https://rdafr.fr porte la mention du numéro de la dernière version de publication de l’ontologie, le numéro de cette version étant V 0.1.0. 
  * Elle comporte également une section Historique des versions, qui renvoie vers la présente page [https://rdafr.fr/release-notes](/release-notes)  où sont présentes les nouveautés de l’ontologie RDA-FR d’une version à l’autre.

## v0.0.1, janvier 2023 - première publication {#v0.0.1}

La première publication de l’ontologie RDA-FR comprend :

* une introduction sur : 
  * le cadre de l’élaboration de l’ontologie RDA-FR et ses objectifs ;  
  * le choix des deux agences bibliographiques, la BnF et l’Abes, de publier l’ontologie RDA-FR progressivement, par blocs de classes cohérents, au fur et à mesure de son élaboration ;
  * le texte explicatif sur les choix architecturaux et les mécanismes fonctionnels de gestion de cette ontologie et de son profil d’application (texte évolutif au fil des versions) ;
* la publication du profil d’application de l’ontologie RDA-FR, relatif aux classes : Agent, Agent collectif, Groupe informel, Personne, Identité publique ;
* l’information sur les modalités techniques de publication de l’ontologie RDA-FR, avec accès aux pages html concernées et le compte GitHub où l’ensemble de l’ontologie est géré.
