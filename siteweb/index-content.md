---
pagetitle: Ontologie RDA-FR
toc-title: Table des matières
---
## Introduction : architecture et choix de conception

L’ontologie RDA-FR, en cours d’élaboration, est une représentation formelle du code RDA-FR, sous forme d’une ontologie OWL.

**Avertissement** : tout au long du processus d’élaboration, la version publiée est susceptible d’évoluer (par des compléments ou des corrections) en fonction des décisions du groupe de travail. Ces évolutions seront documentées au fil des publications.

Le schéma suivant donne une vue globale de la hiérarchie des classes de l’ontologie RDA-FR. Seules sont traitées dans cette version bêta les classes non grisées ci-dessous.

![](https://user-images.githubusercontent.com/51800062/215845393-ead4cc13-63bf-4763-a791-d5f714f5579b.jpg)

### Domaine de l’ontologie RDA-FR et espaces de noms

Pour des besoins de clarté, toutes les classes, propriétés et vocabulaires de l’ontologie RDA-FR sont déclarées dans l’espace de nom <https://rdafr.fr>, avec des URIs qui leurs sont propres, sans reprise directe ni réutilisation des URIs des classes ou des propriétés d’une autre ontologie existante.

Il est pourtant prévu d’établir des alignements avec les autres ontologies pour pouvoir dialoguer avec d’autres acteurs du secteur des bibliothèques et ceux d’autres secteurs. En premier lieu, des alignements seront déclarés avec l’[ontologie IFLA LRM](https://www.iflastandards.info/lrm), avec laquelle l’ontologie RDA-FR est en cohérence, comme l’est l’[ontologie RDA](https://www.rdaregistry.info/).

### Le code RDA-FR, le modèle IFLA LRM et l’ontologie RDA-FR - classes et propriétés de l’univers bibliographique

Dans le système des classes et propriétés :

* Pour chacune des entités du code RDA-FR, on trouve la classe correspondante dans l’ontologie RDA-FR (classes Œuvre, Personne, etc.). Ces classes sont organisées selon la même hiérarchie que dans le code RDA-FR, en conformité avec l’ontologie IFLA LRM. A contrario, certaines classes présentes dans l’ontologie RDA-FR sont créées pour les besoins propres de celle-ci et ne se retrouvent pas dans le code RDA-FR (voir plus bas les explications sur, par exemple, la classe Groupe informel).
* Les attributs des entités du code RDA-FR, ainsi que les relations entre entités du code constituent des propriétés dans l’ontologie RDA-FR (« a pour langue de la personne », « est membre de » pour une relation entre une Personne et une Collectivité, etc.).

#### Remarques générales sur les classes de l’ontologie RDA-FR

* **_Entité RDA-FR_** est la classe de niveau supérieur à la racine de l’ontologie RDA-FR ; elle est déclarée comme sous-classe de la classe _Res_ du modèle IFLA LRM. Toute classe de l’ontologie RDA-FR est déclarée comme sous-classe de celle-ci. Les propriétés de cette classe, en vertu du principe d’héritage, s’appliquent à toutes les sous-classes de l’ontologie.
* La classe **_Nomen_** (entité du modèle IFLA LRM) a été déclarée comme une classe distincte dans l’ontologie RDA-FR. Dans le code RDA-FR, il n’y a pas d’entité propre Nomen : les noms, titres d’œuvre etc., points d’accès et identifiants sont traités comme des attributs des entités qu’ils servent à identifier ou représenter. Il n’en reste pas moins que ces noms, titres, points d’accès et identifiants, du point de vue du modèle IFLA LRM, relèvent de l’entité Nomen. Ainsi, dans l’ontologie RDA-FR, toutes les propriétés qui représentent des noms, des titres, des points d’accès et des identifiants ont pour co-domaine la classe Nomen.
* La classe **_Agent_** (entité du modèle IFLA LRM) a été créée dans l’ontologie RDA-FR comme classe générique des sous-classes Personne et Agent collectif. Elle permet de factoriser un certain nombre de propriétés, mais aussi de traiter les cas où les informations sur la nature de l’agent sont lacunaires.
* La classe **_Agent collectif_** (entité du modèle IFLA LRM) ne fait pas partie du code RDA-FR. Elle a aussi été ajoutée dans l’ontologie RDA-FR pour servir de super-classe aux classes Collectivité, Groupe informel (voir plus bas) et Famille. De ce fait, ces dernières héritent des propriétés de la classe Agent collectif.
* La classe **_Groupe informel_**, absente du code RDA-FR, a été créée dans l’ontologie RDA-FR comme sous-classe de la classe Agent collectif, pour permettre de traiter comme groupes du monde réel les groupes de personnes qui ne sont ni des familles ni des collectivités. C’est le cas, notamment, des groupes identifiés par un pseudonyme collectif dont le nom se présente formellement comme un nom de personne (le pseudonyme collectif, lui-même, relève de la classe Identité publique). Cette classe permet d’établir, par exemple, la relation de création entre le groupe informel et son œuvre, ou la relation entre le groupe et les personnes qui le composent.
* La classe **_Identité publique_**, spécifique à l’ontologie RDA-FR, reflète l’approche du chapitre 9 du code RDA-FR Identification des personnes et de leurs identités publiques, où la distinction claire entre les personnes et leurs identités publiques est actée. Une personne ou un groupe informel a toujours au moins une identité publique. Le modèle IFLA LRM appréhende l’Identité publique comme une grappe de Nomen (voir [IFLA LRM, 2017, traduction française](https://repository.ifla.org/bitstream/123456789/1703/1/IFLA-LRM-traduction-francaise.pdf), paragraphe 5.5 Modélisation des identités bibliographiques). Dans l’ontologie RDA-FR, la classe Identité publique est déclarée comme une sous-classe de la classe racine ‘Entité RDA-FR’. \
Pour les relations entre la classe Identité publique et les classes Personne ou Groupe informel, ainsi que les relations de ces dernières avec la classe Oeuvre, voir le schéma ci-dessous :

![](https://user-images.githubusercontent.com/51800062/215847616-c2702b44-4875-408b-bcbf-ff37b82464a9.jpg)

* Les classes **_Lieu_** et **_Laps de temps_** (entités du modèle IFLA LRM), les classes **_Concept_**, **_Objet_**, **_Événement_**, ainsi que les sous-classes de Lieu et de Laps de temps, sont d’ores et déjà créées dans l’ontologie RDA-FR pour leur réserver la place qui convient dans l’architecture globale. Elles seront abordées en détail, ou modifiées, lorsque les chapitres correspondants ou les orientations normatives du code RDA-FR seront publiés, sous réserve de l’avancée des travaux des groupes nationaux de la Transition Bibliographique.

### Mécanismes fonctionnels de l’ontologie RDA-FR

* Pour rappel, toute classe de l’ontologie RDA-FR est déclarée comme sous-classe de la classe racine **_Entité RDA-FR_**. Les propriétés de cette classe, en vertu du principe d’héritage, s’appliquent à toutes les sous-classes de l’ontologie, qu’il s’agisse des classes correspondant aux entités bibliographiques, que de celles ajoutées pour les besoins fonctionnels de l’ontologie RDA-FR, ou encore des classes ajoutées pour permettre une structuration fine et précise des données.
* Les vocabulaires contrôlés dans l’ontologie RDA-FR relèvent de la classe **_[skos:ConceptScheme](http://www.w3.org/2004/02/skos/core#ConceptScheme)_**. Ils correspondent aux référentiels associés aux attributs des entités du code RDA-FR.

#### Principe de réification

Pour permettre l’ajout d’assertions sur les propriétés, le mécanisme de la réification systématique des propriétés en utilisant le même URI pour la propriété et sa réification a été implémenté dans l’ontologie RDA-FR. Ce mécanisme est basé sur le standard [ETSI GS CIM 006 V1.1.1 (2019 07)](https://drive.google.com/open?id=1EH-WjUL-2vwkze3JAM9xtc_l4czbSpIN). Pour cela deux classes sont créées :

* la classe P100008 **_‘a une propriété réifiée’_** a été introduite pour permettre d’ajouter des assertions sur toutes les propriétés de l’ontologie qui correspondent aux attributs des entités du code RDA-FR. Par exemple, il est possible d’indiquer un niveau de fiabilité, ou une source pour un lieu de naissance d’une personne. Elle permet aussi de donner, à la propriété en question, une valeur textuelle ou une URI. Chaque propriété de ce type est systématiquement réifiée par une classe dont l’URI est la même que celle de la propriété. Cette classe est déclarée comme une sous classe de la classe P100008 _‘a une propriété réifiée’_ :

Exemple de réification de l’attribut _“a pour lieu de naissance de la personne”_

![](https://user-images.githubusercontent.com/51800062/215849996-0a586184-0635-4a11-bee0-5fc292bd8ab9.jpg "Exemple de réification de l’attribut “a pour lieu de naissance de la personne”")

* la classe P100001r **_‘a une relation avec [dans la relation]’_** a été introduite pour permettre d’ajouter des assertions sur toutes les propriétés qui expriment une relation entre des instances de deux classes de l’ontologie (et qui, de fait, correspondent aux relations entre instances d’entités du code RDA-FR). Elle permet par exemple de donner des précisions (source, période, etc.) sur une relation de type _“a pour créateur / créateur de”_ entre une oeuvre et une personne. Chaque propriété de ce type est systématiquement réifiée par une classe dont l’URI est la même que celle de la propriété. Cette classe est déclarée comme une sous classe de la classe P100001r _‘a une relation avec [dans la relation]’_. \
Font exception de cette règle les relations dites fondamentales du modèle IFLA LRM entre les classes Oeuvre, Expression, Manifestation et Item.

Exemple de réification de la relation _“a pour créateur / créateur de”_

![](https://user-images.githubusercontent.com/51800062/215851006-1a5e66c8-ec3c-4ac5-ac69-75c8c73b1955.jpg "Exemple de réification de la relation “a pour créateur / créateur de”")

#### Principe de déclaration des propriétés, dites génériques, applicables à plusieurs entités

Dans le code RDA-FR il existe des propriétés (relations ou attributs du code RDA-FR) qui peuvent être établies entre plusieurs entités.

* Dans **le code RDA-FR**, elles sont déclarées expressément au niveau précis de chacune des entités auxquelles elles s’appliquent. Par exemple, on trouvera la relation _“collabore avec”_ déclarée à la fois, entre deux personnes, entre deux collectivités, entre une personne et une collectivité, etc.
* Dans **l’ontologie RDA-FR** (en OWL) [https://rdafr.fr/ontologie/ontology.ttl](https://rdafr.fr/ontologie/ontology.ttl), pour ces types de propriété, le choix a été fait de déclarer seulement une propriété générique au niveau de la classe parente de ces classes (niveau le plus haut pertinent), en appliquant le principe d'héritage.
* Dans **[le profil d’application de l’ontologie RDA-FR](/profil-application/)**, ces propriétés sont déclarées non seulement au niveau générique, mais aussi au niveau précis de chacune des sous-classes auxquelles elles s’appliquent. A noter qu’à ce niveau spécifique la propriété conserve le même URI et le même libellé que cette même propriété déclarée au niveau générique. Le profil d’application (SHACL) offre la possibilité de décrire les règles métier du code RDA-FR, avec, notamment les possibilités suivantes au niveau de chaque classe :
* lorsque, **dans l’ontologie RDA-FR**, une propriété est déclarée  au niveau générique d’une super-classe (ex.: Agent), mais que son application n’est pas pertinente pour une de ses sous-classes (ex.: Famille), dans le profil d’application de l’ontologie RDA-FR, cette propriété n’est simplement pas reprise au niveau de la sous-classe en question (la sous-classe Famille, le cas échéant).
* **dans le profil d’application de l’ontologie RDA-FR**, pour toutes ces propriétés génériques, il est possible de donner leur contexte d’application précis dans le cadre de la sous-classe précise, en donnant une définition contextuelle et en y associant des règles spécifiques lorsqu’il y a lieu, etc.

Dans l’exemple de la propriété _“collabore avec”_, celle-ci est déclarée comme propriété de la classe Agent. Elle est ensuite reprise, dans le profil d’application (avec le même URI et libellé), au niveau des sous-classes Personne, Collectivité, Famille partout où elle est pertinente avec, si besoin, des précisions d’application contextuelles.

### L’ontologie RDA-FR en OWL et son profil d’application

Le choix a été fait de publier le modèle de données RDA-FR sous la forme d’une ontologie (OWL) et d’un profil d’application (SHACL).

* **L’ontologie RDA-FR** modélise en classes et propriétés l’univers du discours couvert  par le code RDA-FR, elle est exprimée en langage [OWL](https://www.w3.org/OWL/) (Web Ontology Language).
* **Le profil d’application RDA-FR** définit les règles et contraintes pour produire et valider les données RDF du graphe des données. Le profil d’application est exprimé en langage [SHACL](https://www.w3.org/TR/shacl/) (Shapes Constraint Language). Il s’agit d’un standard du W3C spécialement conçu pour la validation des graphes RDF de données, créées, dans notre cas, avec l’ontologie RDA-FR, dans le respect des règles et contraintes fixées pour cette ontologie. Dans le cadre de cette publication les règles SHACL expriment explicitement et de manière systématique les règles et contraintes génériques inhérentes au code RDA-FR, qu’elles soient explicitement ou implicitement formulées dans le code. Ces règles peuvent être des contraintes sur les cardinalités des propriétés, sur l’utilisation d’un vocabulaire contrôlé spécifique pour une propriété, etc.

Cette dissociation a pour avantages :

* de disposer de **[l’ontologie RDA-FR en OWL](/ontologie/ontology.ttl)**, porteuse de la structure de base qui exprime l’univers du discours couvert par le code RDA-FR ;
* de mettre à disposition **[le profil d’application de l’ontologie RDA-FR](/profil-application/)**, qui intègre les règles et les contraintes des données, gérées en langage SHACL, plus riches que celles contenues dans l’ontologie car elles permettent d’indiquer l’utilisation ou non d’une propriété dans une sous classe, et des règles spécifiques d’utilisation ;
* de pouvoir adapter et enrichir ces règles sans modifier l’ontologie de base;
* d’exécuter les règles SHACL sur les instances du graphe de connaissance pour vérifier que les données sont cohérentes et conformes à l'ontologie.

### Déclaration de propriétés relevant des chapitres non publiés du code RDA-FR

Il est à souligner que la section 9 du code RDA-FR, qui traite des relations entre agents, est toujours en cours de rédaction et non diffusée. Cependant, l’état d’avancement des travaux permet d’ores et déjà de disposer des listes fournies de relations entre agents. Une mise en cohérence de l’ontologie RDA-FR avec la section 9 sera effectuée au moment de la publication de cette dernière.

### Modalités techniques de publication de l’ontologie RDA-FR

* La version HTML du profil d’application RDA-FR est publiée ici : [https://rdafr.fr/profil-application/](/profil-application/)
* La version SHACL du profil d’application (au format turtle) est publiée ici : [https://rdafr.fr/profil-application/rdafr-shacl.ttl](/profil-application/rdafr-shacl.ttl)
* La version HTML et OWL de l’ontologie est publiée ici : **[https://rdafr.fr/ontologie/](/ontologie/)**.

L’ensemble de l’ontologie est géré depuis le compte GitHub du programme Transition bibliographique : [https://github.com/transition-bibliographique/ontologie-rda-fr](https://github.com/transition-bibliographique/ontologie-rda-fr).

### Historique des versions

* v.0.1.0 (mai 2023)
* v.0.0.1 (janvier 2023) - première publication

### Contributeurs associés à ce projet

* BnF : Anila Angjeli, Vincent Boulet, Etienne Cavalié, Françoise Leresche
* Abes : Benjamin Bober, Mathis Eon, Stéphane Gully, Laure Jestaz, Héloïse Lecomte
* La conception de cette ontologie a bénéficié de l’expertise et des compétences de Jean Delahousse.

Pour toute question sur cette publication merci d’écrire à [ontologie-rdafr@abes.fr](mailto:ontologie-rdafr@abes.fr)

