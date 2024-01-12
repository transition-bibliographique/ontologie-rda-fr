---
pagetitle: Ontologie RDA-FR
toc-title: Table des matières
---
## Introduction : architecture et choix de conception

L’ontologie RDA-FR, en cours d’élaboration, est une représentation formelle du code RDA-FR, sous forme d’une ontologie OWL.

**Avertissement** : tout au long du processus d’élaboration, la version publiée est susceptible d’évoluer (par des compléments ou des corrections) en fonction des décisions du groupe de travail. Ces évolutions seront documentées au fil des publications.

<div align="center">

_Vue globale de la hiérarchie des classes de l’ontologie RDA-FR._  \
_Les classes grisées ci-dessous ne font pas partie de cette version._

![HierarchieClassesV0 3 0](https://github.com/transition-bibliographique/ontologie-rda-fr/assets/51800062/4ab0dd08-ba78-4dd5-b585-a2268191dcb4)

</div>

### Domaine de l’ontologie RDA-FR et espaces de noms

Pour des besoins de clarté, toutes les classes, propriétés et vocabulaires de l’ontologie RDA-FR sont déclarées dans l’espace de nom [https://rdafr.fr](https://rdafr.fr), avec des URIs qui leurs sont propres, sans reprise directe ni réutilisation des URIs des classes ou des propriétés d’une autre ontologie existante.

Il est pourtant prévu d’établir des alignements avec les autres ontologies pour pouvoir dialoguer avec d’autres acteurs du secteur des bibliothèques et ceux d’autres secteurs. En premier lieu, des alignements seront déclarés avec l’[ontologie IFLA LRM](https://www.iflastandards.info/lrm), avec laquelle l’ontologie RDA-FR est en cohérence, comme l’est l’[ontologie RDA](https://www.rdaregistry.info/).

### Le code RDA-FR, le modèle IFLA LRM et l’ontologie RDA-FR - classes et propriétés de l’univers bibliographique

Dans le système des classes et propriétés : 

* Pour chacune des entités du code RDA-FR, on trouve la classe correspondante dans l’ontologie RDA-FR (classes Œuvre, Personne, etc.). Ces classes sont organisées selon la même hiérarchie que dans le code RDA-FR.
Toutefois le code RDA-FR a un champ d’application plus vaste que l’ontologie IFLA LRM afin de couvrir tous les besoins de traitement en catalogage courant, notamment l’indexation matière. En conséquence, certaines classes de l’ontologie RDA-FR, par exemple la classe Personne, ont une définition plus large que les classes correspondantes dans le modèle IFLA LRM. Elles portent toutes les propriétés applicables à l’entité concernée.
Pour ces classes, une propriété ‘est une instance du monde réel’ (avec un choix Vrai/Faux) permet de distinguer d’une part les instances qui peuvent être alignées avec les classes IFLA LRM correspondantes, d’autre part celles qui relèvent de la classe Res de IFLA LRM : par exemple, “personne réelle” et “personne fictive”. Cela concerne en particulier les agents et les lieux.
* Les attributs des entités du code RDA-FR, ainsi que les relations entre entités du code constituent des propriétés dans l’ontologie RDA-FR (‘a pour langue de la personne’, ou ‘est membre de’ pour une relation entre une Personne et une Collectivité, etc.).
* Les référentiels associés aux entités du code RDA-FR font l’objet de vocabulaires contrôlés dans l’ontologie RDA-FR (voir plus bas).

#### Remarques générales sur les classes de l’ontologie RDA-FR

* **_Entité RDA-FR_** est la classe de niveau supérieur à la racine de l’ontologie RDA-FR ; elle est déclarée comme sous-classe de la classe _Res_ du modèle IFLA LRM. Toute classe de l’ontologie RDA-FR est déclarée comme sous-classe de celle-ci. Les propriétés de cette classe, en vertu du principe d’héritage, s’appliquent à toutes les sous-classes de l’ontologie.
* La classe **_Métadonnées de la description_** permet de fournir les métadonnées portant sur l'ensemble de la description de l'instance d'une classe.
* La classe **_Nomen_** est déclarée comme une classe distincte dans l’ontologie RDA-FR. Dans le code RDA-FR, il n’y a pas d’entité propre Nomen : les noms, titres d’œuvre etc., points d’accès et identifiants sont traités comme des attributs des entités qu’ils servent à identifier ou représenter. Il n’en reste pas moins que ces noms, titres, points d’accès et identifiants, du point de vue du modèle IFLA LRM, relèvent de l’entité Nomen. Ainsi, dans l’ontologie RDA-FR, toutes les propriétés qui représentent des noms, des titres, des points d’accès et des identifiants ont pour classe cible la classe Nomen.
* La classe **_Agent_** est créée dans l’ontologie RDA-FR comme classe générique des sous-classes Personne et Agent collectif. Elle permet de factoriser un certain nombre de propriétés, mais aussi de traiter les cas où les informations sur la nature de l’agent sont lacunaires.
* La classe **_Agent collectif_** ne fait pas partie du code RDA-FR. Elle est aussi ajoutée dans l’ontologie RDA-FR pour servir de super-classe aux classes Collectivité, Groupe informel (voir plus bas) et Famille. De ce fait, ces dernières héritent des propriétés de la classe Agent collectif.
* La classe **_Groupe informel_**, absente du code RDA-FR, est créée dans l’ontologie RDA-FR comme sous-classe de la classe Agent collectif, pour permettre de traiter comme groupes du monde réel les groupes de personnes qui ne sont ni des familles ni des collectivités. C’est le cas, notamment, des groupes identifiés par un pseudonyme collectif dont le nom se présente formellement comme un nom de personne (le pseudonyme collectif, lui-même, relève de la classe Identité publique). Cette classe permet d’établir, par exemple, la relation de création entre le groupe informel et son œuvre, ou la relation entre le groupe et les personnes qui le composent.
* La classe **_Identité publique_**, spécifique à l’ontologie RDA-FR, reflète l’approche du chapitre 9 du code RDA-FR Identification des personnes et de leurs identités publiques, qui distingue clairement les personnes de leurs identités publiques. Une personne ou un groupe informel a toujours au moins une identité publique. Le modèle IFLA LRM appréhende l’Identité publique comme une grappe de Nomen (voir [IFLA LRM, 2017, traduction française](https://repository.ifla.org/bitstream/123456789/1703/1/IFLA-LRM-traduction-francaise.pdf), paragraphe 5.5 Modélisation des identités bibliographiques). C’est pour cette raison que dans l’ontologie RDA-FR, la classe Identité publique est déclarée comme une sous-classe de la classe racine ‘Entité RDA-FR’.

<div align="center">
  
_Schéma représentant les relations entre la classe Identité publique et les classes Personne ou Groupe informel, ainsi que les relations de ces dernières avec la classe Oeuvre_
![Identité publiqueV0 3 0](https://github.com/transition-bibliographique/ontologie-rda-fr/assets/51800062/65a977f3-c860-4c0f-999c-16a84438ac85)

</div>

* La classe **_Laps de temps_** (ainsi que ses sous-classes) est déclarée dans l’ontologie RDA-FR car elle sert de classe cible à toute propriété qui exprime des notions temporelles.
* Les classes **_Concept_**, **_Objet_**, **_Événement_**, sont d’ores et déjà créées dans l’ontologie RDA-FR pour leur réserver la place qui convient dans l’architecture globale. Elles seront abordées en détail, ou modifiées, lorsque les chapitres correspondants ou les orientations normatives du code RDA-FR seront publiés, sous réserve de l’avancée des travaux des groupes nationaux de la Transition Bibliographique.

### Les référentiels du code RDA-FR dans l’ontologie

Les référentiels associés aux entités du code RDA-FR sont traités dans l’ontologie comme des vocabulaires contrôlés. Pour leur gestion, l’ontologie RDA-FR fait appel au standard du W3C [SKOS Simple Knowledge Organization System](https://www.w3.org/2009/08/skos-reference/skos.html). Ainsi les vocabulaires contrôlés de l’ontologie RDA-FR relèvent de la classe **_[skos:ConceptScheme](http://www.w3.org/2004/02/skos/core#ConceptScheme)_** de ce standard. 

Les référentiels propres au code RDA-FR et ceux repris de RDA avec adaptations et/ou enrichissements, sont tous déclarés dans l’espace de nom [https://rdafr.fr](https://rdafr.fr), sous [https://rdafr.fr/vocabulary/](/vocabulary/). 

Pour les référentiels régis par des normes internationales ISO, en raison d’absence de leur déclaration en Linked Data par l’ISO même, une démarche pragmatique est adoptée. Notamment : 

* Pour les codes de langue de la norme ISO 639-2, le vocabulaire de la Library of Congres, exposé en Linked data sur id.loc.gov est utilisé [https://id.loc.gov/vocabulary/iso639-2.html](https://id.loc.gov/vocabulary/iso639-2.html)
* Pour les codes de représentation des écritures de la norme ISO 15924, le référentiel sera déclaré dans les vocabulaires RDA-FR, en reprenant le code ISO comme suffixe dans l’URI. ex: [https://rdafr.fr/vocabulary/ecriture-ISO15924/Latn](https://rdafr.fr/vocabulary/ecriture-ISO15925/Latn)
* Pour les codes de pays de la norme ISO 3166, le choix est laissé à chaque institution qui implémente l’ontologie RDA-FR d’utiliser ses propres sources.

### Mécanismes fonctionnels de l’ontologie RDA-FR

* Pour rappel, toute classe de l’ontologie RDA-FR est déclarée comme sous-classe de la classe racine **_Entité RDA-FR_**. Les propriétés de cette classe, en vertu du principe d’héritage, s’appliquent à toutes les sous-classes de l’ontologie, qu’il s’agisse des classes correspondant aux entités bibliographiques, de celles ajoutées pour les besoins fonctionnels de l’ontologie RDA-FR, ou encore des classes ajoutées pour permettre une structuration fine et précise des données.

#### Principe de réification

Pour permettre l’ajout d’assertions sur les propriétés (ou des “méta-métadonnées”), le mécanisme de la réification a été implémentée dans l’Ontologie RDA-FR, avec utilisation du même URI pour une propriété réifiée et sa classe de réification. Ce mécanisme est basé sur le standard [ETSI GS CIM 006 V1.2.1 (2023-06)](https://cdn.standards.iteh.ai/samples/62514/ecace437fb864fd3aa25efa184825e05/ETSI-GS-CIM-006-V1-2-1-2023-06-.pdf). Pour cela deux classes de réification sont créées :

* la classe P100008r **_‘a une propriété réifiée’_** a été introduite pour permettre l’ajout d’assertions sur toutes les propriétés de l’ontologie qui correspondent aux attributs des entités du code RDA-FR. Par exemple, il est possible d’indiquer un niveau de fiabilité, ou une source pour le domaine d’activité d’une personne. Elle permet aussi de donner, à la propriété en question, une valeur textuelle ou une URI. Chaque propriété de ce type est systématiquement réifiée par une classe dont l’URI est la même que celle de la propriété. Cette classe est déclarée comme une sous classe de la classe P100008 _‘a une propriété réifiée’_. \
Font exception de cette règle :  les propriétés d’appellation, comme ‘a pour nom de la collectivité’, ‘a pour titre de la manifestation’ qui pointent vers la classe Nomen, ainsi que les propriétés de datation qui pointent vers la classe Laps de temps. 


<div align="center">

_Exemple de réification de la propriété ‘a pour domaine d’activité de la personne’_
![ProprieteReifie_aPourDomaineActivitePersonneV0 3 0](https://github.com/transition-bibliographique/ontologie-rda-fr/assets/51800062/3a157a4c-3d89-4a98-8820-f3501d02450e)


</div>

* la classe P100001r **_‘est en relation avec’_** a été introduite pour permettre d’ajouter des assertions sur toutes les propriétés qui expriment une relation entre des instances de deux classes de l’ontologie (et qui, de fait, correspondent aux relations entre instances d’entités du code RDA-FR). Elle permet par exemple de donner des précisions (source, période, etc.) sur une relation de type _‘est élève de’ / ‘est enseignant de’_ entre deux personnes. Chaque propriété de ce type est systématiquement réifiée par une classe dont l’URI est la même que celle de la propriété. Cette classe est déclarée comme une sous classe de la classe P100001r _‘est en relation avec’_. \
Font exception de cette règle les relations dites fondamentales du modèle IFLA LRM entre les classes Oeuvre, Expression, Manifestation et Item.

<div align="center">

_Exemple de réification de la relation ‘est élève de’ / ‘est enseignant de’_ 
![RelationReifie-estEleveDe-estEnseignantDeV0 3 0](https://github.com/transition-bibliographique/ontologie-rda-fr/assets/51800062/3bd81023-be6d-4a6a-8e6c-4660b5952617)


</div>

#### Principe de déclaration des propriétés, dites génériques, applicables à plusieurs entités

Dans le code RDA-FR il existe des propriétés (relations ou attributs du code RDA-FR) qui peuvent être établies entre plusieurs entités. 

* Dans **le code RDA-FR**, elles sont déclarées expressément au niveau précis de chacune des entités auxquelles elles s’appliquent. Par exemple, on trouvera la relation ‘_collabore avec_’ déclarée à la fois, entre deux personnes, entre deux collectivités, entre une personne et une collectivité, etc. 
* Dans **[l’ontologie RDA-FR (en OWL)](/ontologie/)**, pour ces types de propriétés, le choix a été fait de déclarer seulement une propriété générique au niveau de la classe parente de ces classes (niveau le plus haut pertinent), en appliquant le principe d'héritage.
* Dans **[le profil d’application de l’ontologie RDA-FR](/profil-application/)**, ces propriétés sont déclarées non seulement au niveau générique, mais aussi au niveau précis de chacune des sous-classes auxquelles elles s’appliquent. A noter qu’à ce niveau spécifique la propriété conserve le même URI et le même libellé que cette même propriété déclarée au niveau générique. Le profil d’application (SHACL) offre la possibilité de décrire les règles métier du code RDA-FR, avec, notamment les possibilités suivantes au niveau de chaque classe : 
* lorsque, **dans l’ontologie RDA-FR**, une propriété est déclarée au niveau générique d’une super-classe (ex.: Agent), mais que son application n’est pas pertinente pour une de ses sous-classes (ex.: Famille), dans le profil d’application de l’ontologie RDA-FR, cette propriété n’est simplement pas reprise au niveau de la sous-classe en question (la sous-classe Famille, le cas échéant). 
* **dans le profil d’application de l’ontologie RDA-FR**, pour toutes ces propriétés génériques, il est possible de donner leur contexte d’application précis dans le cadre de la sous-classe précise, en donnant une définition contextuelle et en y associant des règles spécifiques lorsqu’il y a lieu, etc.

Dans l’exemple de la propriété ‘_collabore avec_’, celle-ci est déclarée comme propriété de la classe Agent. Elle est ensuite reprise, dans le profil d’application (avec le même URI et libellé), au niveau des sous-classes Personne, Collectivité, Famille partout où elle est pertinente avec des précisions d’application contextuelles.

### L’ontologie RDA-FR en OWL et son profil d’application

Le choix a été fait de publier une ontologie (OWL) et d’un profil d’application (SHACL). 

* **L’ontologie RDA-FR** modélise en classes et propriétés l’univers du discours couvert  par le code RDA-FR, elle est exprimée en langage [OWL](https://www.w3.org/OWL/) (Web Ontology Language).
* **Le profil d’application RDA-FR** définit les règles et contraintes pour produire et valider les données RDF du graphe des données. Le profil d’application est exprimé en langage [SHACL](https://www.w3.org/TR/shacl/) (Shapes Constraint Language). Il s’agit d’un standard du W3C spécialement conçu pour la validation des graphes RDF de données, créées, dans notre cas, avec l’ontologie RDA-FR, dans le respect des règles et contraintes fixées pour cette ontologie. Dans le cadre de cette publication les règles SHACL expriment explicitement et de manière systématique les règles et contraintes génériques inhérentes au code RDA-FR, qu’elles soient explicitement ou implicitement formulées dans le code. Ces règles peuvent être des contraintes sur les cardinalités des propriétés, sur l’utilisation d’un vocabulaire contrôlé spécifique pour une propriété donnée, etc.

Cette dissociation a pour avantages : 

* de disposer de **[l’ontologie RDA-FR en OWL](/ontologie/)**, porteuse de la structure de base qui exprime l’univers du discours couvert par le code RDA-FR ;
* de mettre à disposition **[le profil d’application de l’ontologie RDA-FR](/profil-application/)**, qui intègre les règles et les contraintes des données, gérées en langage SHACL, plus riches que celles contenues dans l’ontologie, car elles permettent d’indiquer l’utilisation ou non d’une propriété dans une sous classe, ainsi que des indications spécifiques d’utilisation ;
* de pouvoir adapter et enrichir ces règles sans modifier l’ontologie de base ;
* d’exécuter les règles SHACL sur les instances du graphe de connaissance pour vérifier que les données sont cohérentes et conformes à l'ontologie.

### Déclaration de classes et propriétés relevant des chapitres non publiés du code RDA-FR

Il est à souligner que l’ontologie peut avoir un trait d’avance par rapport au code RDA-FR. En effet, pour certaines entités et leurs attributs ainsi que pour certaines relations entre les entités du code RDA-FR l’état d’avancement permet d’ores et déjà de dispenser des listes fournies d’attributs ou de relations, bien que les règles afférentes ne soient pas encore finalisées au niveau du code lui-même. Une mise en cohérence de l’ontologie RDA-FR avec ces parties concernées du code est prévue au moment de leur publication.

### Modalités techniques de publication de l’ontologie RDA-FR


* La version HTML du profil d’application RDA-FR est publiée ici : [https://rdafr.fr/profil-application/](/profil-application/)
* La version SHACL du profil d’application (au format turtle) est publiée ici : [https://rdafr.fr/profil-application/rdafr-shacl.ttl](/profil-application/rdafr-shacl.ttl)
* La version HTML de l’ontologie est publiée ici : [https://rdafr.fr/ontologie/](/ontologie/)
* La version OWL de l’ontologie est publiée ici : [https://rdafr.fr/ontologie/rdafr.ttl](/ontologie/rdafr.ttl)
* Les vocabulaires contrôlés associés à l’ontologie sont publiés ici : [https://rdafr.fr/vocabulary/](/vocabulary/)

L’ensemble de l’ontologie est géré depuis le compte GitHub du programme Transition bibliographique : [https://github.com/transition-bibliographique/ontologie-rda-fr](https://github.com/transition-bibliographique/ontologie-rda-fr).

### Historique des versions

* [V 0.3.0 (janvier 2024)](/release-notes.html#v0.3.0)
* [V 0.2.0 (novembre 2023)](/release-notes.html#v0.2.0)
* [V 0.1.0 (mai 2023)](/release-notes.html#v0.1.0)
* [V 0.0.1 (janvier 2023) - première publication](/release-notes.html#v0.0.1)

### Contributeurs associés à ce projet

* BnF : Anila Angjeli, Vincent Boulet, Philippe Cantié, Etienne Cavalié, Alice Faure, Françoise Leresche, Mélanie Roche
* Abes : Benjamin Bober, Mathis Eon, Stéphane Gully, Laure Jestaz, Héloïse Lecomte
* La conception de cette ontologie a bénéficié de l’expertise et des compétences de Jean Delahousse.

Pour toute question relative à l’ontologie RDA-FR et sa publication merci d’écrire à [ontologie-rdafr@abes.fr](mailto:ontologie-rdafr@abes.fr)
