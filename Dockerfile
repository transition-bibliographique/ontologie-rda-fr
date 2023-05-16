FROM debian:stable-20230502-slim AS builder

# Installation des dépendances
# locales : pour avoir les dates en français auto-générées par l'outil pandoc dans footer.html
# pandoc : l'outil pour générer les contenus html du site web à partir des fichiers markdown
# default-jdk : pour pouvoir utiliser l'outil widoco (qui est un outil en java) utilisé pour générer l'ontologie en HTML
# curl : pour faire des appels aux webservices de Sparna (génération des fichiers TTL et NT) et l'installation de Widoco

RUN apt update && DEBIAN_FRONTEND=noninteractive apt -y install locales pandoc default-jdk curl

# Installation de Widoco

RUN curl -L https://github.com/dgarijo/Widoco/releases/download/v1.4.17/java-17-widoco-1.4.17-jar-with-dependencies.jar -o /tmp/widoco.jar

RUN mkdir /build/
COPY ./siteweb/* /build/
COPY ./siteweb/.docker/* /build/

# Les données de l'ontologie ne sont nécessaires que pour la documentation du profil d'application et de l'ontologie

COPY ./ontologie/ /tmp/ontologie/

# Configuration des locales en français pour avoir une génération de date en français

RUN sed -i '/fr_FR.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8

WORKDIR /build/

# Génération du site web

RUN sed -i "s#LAST_MODIFICATION_DATE_PLACEHOLDER#$(date +'%e %B %Y')#g" ./footer.html

RUN pandoc ./index-intro.md -o ./intro.html
RUN pandoc --standalone \
      --toc \
      --shift-heading-level-by=-1 \
      --template ./template.html \
      -c style.css \
      -B ./intro.html \
      -A ./footer.html \
      index-content.md -o ./index.html

RUN pandoc --standalone \
      --toc \
      --shift-heading-level-by=-1 \
      --template ./template.html \
      -c style.css \
      -A ./footer.html \
      ./release-notes.md -o ./release-notes.html

# Génération de la documentation de l'ontologie

RUN mkdir -p ontologie

# Ajout des métadonnées à l'ontologie. On rajoute les métadonnées à la fin. Widoco prend les dernières en cas de répétition
RUN cat /tmp/ontologie/rdafr.nt /tmp/ontologie/ontologie-metadata.nt > /tmp/ontologie/ontologie-avec-meta.nt

# Enlève les noeuds vides et les éléments shacl qui sont problématiques pour Widoco
RUN sed -e "#http://www.w3.org/ns/shacl#d" -e "/_:node/d" -i /tmp/ontologie/ontologie-avec-meta.nt

RUN java -jar /tmp/widoco.jar \
      -ontFile /tmp/ontologie/ontologie-avec-meta.nt \
      -outFolder ontologie \
      -rewriteAll \
      -lang en \
      -excludeIntroduction \
      -noPlaceHolderText \
      -ignoreIndividuals

# Renomme index-en.html, qui est généré automatiquement par Widoco, en index.html
RUN mv ./ontologie/index-en.html ./ontologie/index.html

# Génération du profil d'application

RUN mkdir -p profil-application

# Ajout des métadonnées au profil d'application
RUN cat /tmp/ontologie/profil-application-metadata.nt /tmp/ontologie/rdafr.nt > /tmp/ontologie/profil-application-avec-meta.nt

RUN curl -F inputShapeFile=@/tmp/ontologie/profil-application-avec-meta.nt \
      -F shapesSource=file \
      -F language=fr \
      -H 'Accept-Language: fr-FR,fr' \
      https://shacl-play.sparna.fr/play/doc \
      > ./profil-application/index.html

# Post traitement du profil d'application

RUN sed -E -i ./profil-application/index.html \
    -e 's#<a href="(https://rdafr\.fr/Elements.*?/)" target="_blank">.*?</a>#\1#' \
    -e 's#<a href="https://rdafr\.fr/(Elements|termList).*?>(.*?)</a>#\2#'

# Copie le profil d'application pour que l'utilisateur puisse le récupérer depuis http://rdafr.fr/profil-application/rdafr-shacl.ttl
RUN mv /tmp/ontologie/profil-application-avec-meta.nt /build/profil-application/rdafr-shacl.ttl

FROM nginx:1.20.2
ENV ONTOLOGIE_RDAFR_VERSION 0.3.5

COPY --from=builder /build ./usr/share/nginx/html/

# Lance le serveur web
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
