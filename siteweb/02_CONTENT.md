---
pagetitle: Ontologie RDA-FR
toc-title: Table des matières
---

### Première publication de l’ontologie RDA-FR : version 0.0.1 beta, partielle

#### Introduction
L’ontologie RDA-FR, en cours d’élaboration, est une représentation formelle du code RDA-FR, sous forme d'une ontologie OWL.

Cette première publication est une version beta, partielle. Elle concerne la partie de l’ontologie RDA-FR relative aux classes : Agent, Agent collectif, Groupe informel, Personne, Identité publique.

**Avertissement** : tout au cours du processus d’élaboration, la version publiée est susceptible d'évoluer (par des compléments ou des corrections) en fonction des décisions du groupe de travail. Ces évolutions seront documentées au fil des publications.

Le schéma suivant donne une vue globale de la hiérarchie des classes de l’ontologie RDA-FR. Seules sont traitées dans cette version bêta les classes non grisées ci-dessous.

![](https://user-images.githubusercontent.com/51800062/215845393-ead4cc13-63bf-4763-a791-d5f714f5579b.jpg)

#### Architecture et choix de conception

##### Domaine de l’ontologie RDA-FR et espaces de noms

Pour des besoins de clarté, toutes les classes, propriétés et vocabulaires de l’ontologie RDA-FR sont déclarées dans l’espace de nom https://rdafr.fr, avec des URIs qui leurs sont propres, sans reprise directe ni réutilisation des URIs des classes ou des propriétés d’une autre ontologie existante. 

Il est, pourtant, prévu d’établir des alignements avec les autres ontologies pour pouvoir dialoguer avec d’autres acteurs du secteur des bibliothèques et ceux d’autres secteurs. En premier lieu, des alignements seront déclarés avec l’[ontologie IFLA LRM](https://www.iflastandards.info/lrm), avec laquelle l’ontologie RDA-FR est en cohérence, comme l’est l’[ontologie RDA](https://www.rdaregistry.info/).

##### Le code RDA-FR, le modèle IFLA LRM et l’ontologie RDA-FR - classes et propriétés de l’univers bibliographique

Dans le système des classes et propriétés :
- Pour chacune des entités du code RDA-FR on trouve la classe correspondante dans l’ontologie RDA-FR (classes Œuvre, Personne, etc.). Ces classes sont organisées selon la même hiérarchie que dans le code RDA-FR, en conformité avec l’ontologie IFLA LRM. A contrario, certaines classes présentes dans l’ontologie RDA-FR sont créées pour les besoins propres de celle-ci et ne se retrouvent pas dans le code RDA-FR (voir plus bas les explications sur, par exemple, la classe Groupe informel).
- Les attributs des entités du code RDA-FR, ainsi que les relations entre entités du code constituent des propriétés dans l'ontologie RDA-FR  (« a pour langue de la personne », « est membre de » pour une relation entre une Personne et une Collectivité, etc.).

**Point d’attention sur la version 0.0.1**

La liste des relations entre les entités concernées par cette publication n’est pas exhaustive. Elle sera enrichie au fil des versions. Les relations présentes dans cette version permettent de montrer le mécanisme mis en œuvre pour leur expression. 

**Remarques générales sur les classes de l’ontologie RDA-FR**

- ***Entité RDA-FR*** est la classe de niveau supérieur à la racine de l’ontologie RDA-FR ; elle est déclarée comme sous-classe de la classe *Res* du modèle IFLA LRM. Toute classe de l’ontologie RDA-FR est déclarée comme sous-classe de celle-ci. Les propriétés de cette classe, en vertu du principe d’héritage, s’appliquent à toutes les sous-classes de l’ontologie. 
- La classe ***Nomen*** (entité du modèle IFLA LRM) a été déclarée comme une classe distincte dans l’ontologie RDA-FR. Dans le code RDA-FR, il n’y a pas d’entité propre Nomen : les noms, titres d'œuvre etc., points d’accès et identifiants sont traités comme des attributs des entités qu’ils servent à identifier ou représenter. Il n’en reste pas moins que ces noms, titres, points d’accès et identifiants, du point de vue du modèle IFLA LRM, relèvent de l’entité Nomen. Ainsi, dans l’ontologie RDA-FR, toutes les propriétés qui représentent des noms, des titres, des points d’accès et des identifiants ont pour co-domaine la classe Nomen. 
- La classe ***Agent*** (entité du modèle IFLA LRM) a été créée dans l’ontologie RDA-FR comme classe générique des sous-classes Personne et Agent collectif. Elle permet de factoriser un certain nombre de propriétés, mais aussi de traiter les cas où les informations sur la nature de l’agent sont lacunaires.
- La classe ***Agent collectif*** (entité du modèle IFLA LRM) ne fait pas partie du code RDA-FR. Elle a aussi été ajoutée dans l’ontologie RDA-FR pour servir de super-classe aux classes Collectivité, Groupe informel (voir plus bas) et Famille. De ce fait, ces dernières héritent des propriétés de la classe Agent collectif.
- La classe ***Groupe informel***, absente du code RDA-FR, a été créée dans l’ontologie RDA-FR comme sous-classe de la classe Agent collectif, pour permettre de traiter comme groupes du monde réel les groupes de personnes qui ne sont ni des familles ni des collectivités. C’est le cas, notamment, des groupes identifiés par un pseudonyme collectif dont le nom se présente formellement comme un nom de personne (le pseudonyme collectif, lui-même, relève de la classe Identité publique). Cette classe permet d’établir, par exemple, la relation de création entre le groupe informel et son œuvre, ou la relation entre le groupe et les personnes qui le composent.
- La classe ***Identité publique***, spécifique à l’ontologie RDA-FR, reflète l’approche du chapitre 9 du code RDA-FR Identification des personnes et de leurs identités publiques, où la distinction claire entre les personnes et leurs identités publiques est actée. Une personne ou un groupe informel a toujours au moins une identité publique. Le modèle IFLA LRM appréhende l’Identité publique comme une grappe de Nomen (voir [IFLA LRM, 2017, traduction française](https://repository.ifla.org/bitstream/123456789/1703/1/IFLA-LRM-traduction-francaise.pdf), paragraphe 5.5 Modélisation des identités bibliographiques). Dans l’ontologie RDA-FR, la classe Identité publique est déclarée comme une sous-classe de la classe racine ‘Entité RDA-FR’. 

  Pour les relations entre la classe Identité publique et les classes Personne ou Groupe informel, ainsi que les relations de ces dernières avec la classe Oeuvre, voir le schéma ci-dessous :
  
  ![](https://user-images.githubusercontent.com/51800062/215847616-c2702b44-4875-408b-bcbf-ff37b82464a9.jpg)
  
- Les classes ***Lieu*** et ***Laps de temps*** (entités du modèle IFLA LRM), les classes ***Concept***, ***Objet***, ***Événement***, ainsi que les sous-classes de Lieu et de Laps de temps, sont d’ores et déjà créées dans l’ontologie RDA-FR pour leur réserver la place qui convient dans l’architecture globale. Elles seront abordées en détail, ou modifiées, lorsque les chapitres correspondants ou les orientations normatives du code RDA-FR seront publiés, sous réserve de l’avancée des travaux des groupes nationaux de la Transition Bibliographique.

##### Mécanismes fonctionnels de l’ontologie RDA-FR

- Pour rappel, toute classe de l’ontologie RDA-FR est déclarée comme sous-classe de la classe racine ***Entité RDA-FR***. Les propriétés de cette classe, en vertu du principe d’héritage, s’appliquent à toutes les sous-classes de l’ontologie, qu’il s’agisse des classes correspondant aux entités bibliographiques, que de celles ajoutées pour les besoins fonctionnels de l’ontologie RDA-FR, ou encore des classes ajoutées pour permettre une structuration fine et précise des données.
- Les vocabulaires contrôlés dans l’ontologie RDA-FR relèvent de la classe [***skos:ConceptScheme***](http://www.w3.org/2004/02/skos/core#ConceptScheme). Ils correspondent aux référentiels associés aux attributs des entités du code RDA-FR.

  **Principe de réification**
  
  Pour permettre l’ajout d’assertions sur les propriétés, le mécanisme de la réification systématique des propriétés en utilisant le même URI pour la propriété et sa réification a été implémenté dans l’ontologie RDA-FR. Ce mécanisme est basé sur le standard [ETSI GS CIM 006 V1.1.1 (2019 07)](https://drive.google.com/open?id=1EH-WjUL-2vwkze3JAM9xtc_l4czbSpIN). Pour cela deux classes sont créées : 

- la classe P100008 ***‘a une propriété réifiée’*** a été introduite pour permettre d'ajouter des assertions sur toutes les propriétés de l’ontologie qui correspondent aux attributs des entités du code RDA-FR. Par exemple, il est possible d’indiquer un niveau de fiabilité, ou une source pour un lieu de naissance d’une personne. Elle permet aussi de donner, à la propriété en question, une valeur textuelle ou une URI. Chaque propriété de ce type est systématiquement réifiée par une classe dont l’URI est la même que celle de la propriété. Cette classe est déclarée comme une sous classe de la classe P100008 *‘a une propriété réifiée’* :

  Exemple de réification de l’attribut *“a pour lieu de naissance de la personne”*
![](https://user-images.githubusercontent.com/51800062/215849996-0a586184-0635-4a11-bee0-5fc292bd8ab9.jpg "Exemple de réification de l’attribut “a pour lieu de naissance de la personne”")

- la classe P100001r ***'a une relation avec [dans la relation]’*** a été introduite pour permettre d’ajouter des assertions sur toutes les propriétés qui expriment une relation entre des instances de deux classes de l’ontologie (et qui, de fait, correspondent aux relations entre instances d’entités du code RDA-FR). Elle permet par exemple de donner des précisions (source, période, etc.) sur une relation de type *“a pour créateur / créateur de”* entre une oeuvre et une personne.
Chaque propriété de ce type est systématiquement réifiée par une classe dont l’URI est la même que celle de la propriété. Cette classe est déclarée comme une sous classe de la classe P100001r *'a une relation avec [dans la relation]’*.

  Font exception de cette règle les relations dites fondamentales du modèle IFLA LRM entre les classes Oeuvre, Expression, Manifestation et Item.

  Exemple de réification de la relation *“a pour créateur / créateur de”*
![](https://user-images.githubusercontent.com/51800062/215851006-1a5e66c8-ec3c-4ac5-ac69-75c8c73b1955.jpg "Exemple de réification de la relation “a pour créateur / créateur de”")

##### Gestion des règles et des contraintes

A l’ontologie RDA-FR sont associés des règles et des contraintes d’utilisation de ses classes et propriétés dans la pratique, permettant ainsi d’assurer l’implémentation de l’ontologie conforme au code RDA-FR. Il est à noter que plusieurs de ces règles et contraintes s’ajoutent aux instructions déjà incluses dans le code RDA-FR. Elles relèvent des instructions pour l’implémentation du code dans la gestion informatisée des données. En font partie des règles relatives au champ d’application d’une propriété, à la répétabilité, au caractère obligatoire ou non, au caractère confidentiel ou non, au type d’information attendu, etc. 
Ces règles et contraintes sont exprimées et gérées séparément de l’ontologie RDA-FR, en langage SHACL [(Shapes Constraint Language)](https://www.w3.org/TR/shacl/). Il s’agit d’un standard du W3C spécialement conçu pour la validation des graphes RDF de données, créées, dans notre cas, avec l’ontologie RDA-FR, dans le respect des règles et contraintes fixées pour cette ontologie. 

#### Modalités techniques de publication de l’ontologie RDA-FR

- La version HTML du profil d’application RDA-FR est publiée ici : [https://rdafr.fr/ontologie/](/ontologie/)
- La version SHACL (au format turtle) est publiée ici : [https://rdafr.fr/ontologie/shacl.ttl](/ontologie/shacl.ttl)
- Une version HTML et OWL de l’ontologie seront publiées ultérieurement.

L'ensemble de l'ontologie est géré depuis le compte GitHub du programme Transition bibliographique : [https://github.com/transition-bibliographique/ontologie-rda-fr](https://github.com/transition-bibliographique/ontologie-rda-fr). 

#### Contributeurs associés à ce projet

- BnF : Anila Angjeli, Vincent Boulet, Etienne Cavalié, Françoise Leresche
- Abes : Benjamin Bober, Mathis Eon, Stéphane Gully, Laure Jestaz, Héloïse Lecomte
- La conception de cette ontologie a bénéficié de l’expertise et des compétences de Jean Delahousse.

Pour toute question sur cette publication merci d’écrire à [ontologie-rdafr@abes.fr](ontologie-rdafr@abes.fr) 
