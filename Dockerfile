FROM debian:stable-20230502-slim AS builder

# Installation des dépendances
# locales : pour avoir les dates en français auto-générées par l'outil pandoc dans footer.html
# pandoc : l'outil pour générer les contenus html du site web à partir des fichiers markdown
# default-jdk : pour pouvoir utiliser l'outil widoco (qui est un outil en java) utilisé pour générer l'ontologie en HTML
# curl : pour installer les outils de Sparna (génération des fichiers TTL et NT) et Widoco depuis GitHub.

RUN apt update && DEBIAN_FRONTEND=noninteractive apt -y install locales pandoc default-jdk curl

# Installation de Widoco
RUN curl -L https://github.com/dgarijo/Widoco/releases/download/v1.4.20/widoco-1.4.20-jar-with-dependencies_JDK-17.jar -o /tmp/widoco.jar

RUN mkdir /build/
COPY siteweb/ /build/
COPY ./siteweb/.docker/* /build/

# Les données de l'ontologie ne sont nécessaires que pour la documentation du profil d'application et de l'ontologie
RUN mkdir -p /tmp/ontologie
COPY ./ontologie/ /tmp/ontologie/

# Configuration des locales en français pour avoir une génération de date en français
RUN sed -i '/fr_FR.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8

WORKDIR /build/

# Génération du site web
RUN sed -i "s#LAST_MODIFICATION_DATE_PLACEHOLDER#$(date +'%e %B %Y')#g" /build/footer.html

RUN pandoc /build/index-intro.md -o /build/intro.html
RUN pandoc --standalone \
      --toc \
      --shift-heading-level-by=-1 \
      --template template.html \
      -c /style.css \
      -B /build/intro.html \
      -A /build/footer.html \
      /build/index-content.md -o /build/index.html

RUN pandoc --standalone \
      --toc \
      --shift-heading-level-by=-1 \
      --template template.html \
      -c /style.css \
      -A /build/footer.html \
      /build/release-notes.md -o /build/release-notes.html


RUN pandoc /build/vocabulary/index-intro.md -o /build/vocabulary/intro.html
RUN pandoc --standalone \
      --toc \
      --shift-heading-level-by=-1 \
      --template template.html \
      -c /style.css \
      -B /build/vocabulary/intro.html \
      -A /build/footer.html \
      /build/vocabulary/index-content.md -o /build/vocabulary/index.html

# Génération de la documentation de l'ontologie
RUN mkdir -p ontologie

# Ajout des métadonnées à l'ontologie. On rajoute les métadonnées à la fin. Widoco prend les dernières en cas de répétition
RUN cat /tmp/ontologie/rdafr.nt /tmp/ontologie/ontologie-metadata.nt > /tmp/ontologie/ontologie-avec-meta.nt

RUN java -jar /tmp/widoco.jar \
      -ontFile /tmp/ontologie/ontologie-avec-meta.nt \
      -outFolder ontologie \
      -rewriteAll \
      -lang en \
      -ignoreIndividuals

# Copie le profil d'application pour que l'utilisateur puisse le récupérer depuis http://rdafr.fr/ontologie/rdafr.ttl
# On conserve aussi ontology.ttl qui est référencé par widoco dans un bouton de téléchargement
RUN cp /build/ontologie/ontology.ttl /build/ontologie/rdafr.ttl

# Renomme index-en.html, qui est généré automatiquement par Widoco, en index.html
RUN mv /build/ontologie/index-en.html /build/ontologie/index.html
# On supprime les sections vides de la documentation HTML de l'ontologie
RUN rm /build/ontologie/sections/abstract-en.html /build/ontologie/sections/introduction-en.html /build/ontologie/sections/references-en.html

# Génération du profil d'application
RUN mkdir -p profil-application

# Ajout des métadonnées au profil d'application. On copie les métadonnées au format NT dans le fichier TTL, pour faire apparaître les préfixes dans le profil d'application
# Deux fichier sont utilisés : le fichier `rdafr-doc` qui est un fichier simplifié pour la documentation HTML et le fichier rdafr.ttl qui est distribué à l'utilisateur final.
RUN cat /tmp/ontologie/profil-application-metadata.nt /tmp/ontologie/rdafr-doc.ttl > /tmp/ontologie/profil-application-doc-avec-meta.ttl
RUN cat /tmp/ontologie/profil-application-metadata.nt /tmp/ontologie/rdafr.ttl > /tmp/ontologie/profil-application-avec-meta.ttl

# Installation de shacl play
RUN curl -L https://github.com/sparna-git/shacl-play/releases/download/0.7.0/shacl-play-app-0.7.0-onejar.jar \
      -o shacl-play.jar

# Génération du profil d'application
RUN java -jar shacl-play.jar doc -i /tmp/ontologie/profil-application-doc-avec-meta.ttl -o /build/profil-application/index.html -l fr

# Post traitement du profil d'application
RUN sed -E -i /build/profil-application/index.html \
    -e 's#<a href="(https://rdafr\.fr/Elements.*?/)" target="_blank">.*?</a>#\1#' \
    -e 's#<a href="https://rdafr\.fr/(Elements|termList).*?>(.*?)</a>#\2#'

# Copie le profil d'application pour que l'utilisateur puisse le récupérer depuis http://rdafr.fr/profil-application/rdafr-shacl.ttl
RUN mv /tmp/ontologie/profil-application-avec-meta.ttl /build/profil-application/rdafr-shacl.ttl


# Génération des vocabulaires contrôlés

RUN mkdir -p /build/vocabulary/
COPY ./vocabulaire/* /build/vocabulary/

# Installation de l'outil skos play 
RUN curl -L https://github.com/sparna-git/skos-play/releases/download/0.9.1/skos-play-cli-0.9.1-onejar.jar -o skos-play.jar

# Génération d'un fichier HTML par vocabulaire
# Depuis la page d'un vocabulaire, l'utilisateur peut ajouter le suffix .ttl à l'url pour récupérer les données au format RDF.
RUN for i in /build/vocabulary/*.ttl; do \
      java -jar skos-play.jar alphabetical -i $i -o ${i%.ttl}.html -f html -l fr ; \
      # Suppression des top terms dans le fichier HTML
      sed -i '/<h2 class="title">.*<\/h2>/d' ${i%.ttl}.html ; \
      sed -i "s/<li>DEF : /<li>Périmètre d'application : /g" ${i%.ttl}.html ; \
    done

FROM nginx:1.20.2
ENV ONTOLOGIE_RDAFR_VERSION 0.5.0

COPY --from=builder /build ./usr/share/nginx/html/

# Lance le serveur web
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
