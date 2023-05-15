FROM debian:stable-20230502-slim AS builder

RUN mkdir /build/
COPY ./siteweb/*   /build/
COPY ./siteweb/.docker/*   /build/

# Installation des dépendances
# locales : pour avoir les dates en français auto-générées par l'outil pandoc dans footer.html
# pandoc : l'outil pour générer les contenus html du site web à partir des fichiers markdown
# default-jdk : pour pouvoir utiliser l'outil widoco (qui est un outil en java) utilisé pour générer l'ontologie en HTML 
# curl : pour faire des appels aux webservices de Sparna (génération des fichiers TTL et NT) et l'installation de Widoco

RUN apt update && DEBIAN_FRONTEND=noninteractive apt -y install locales pandoc default-jdk curl

# Configuration des locales en français

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

# Installation de Widoco

RUN curl -L https://github.com/dgarijo/Widoco/releases/download/v1.4.17/java-17-widoco-1.4.17-jar-with-dependencies.jar -o widoco.jar

# Récupération de l'ontologie au format nt

RUN curl -L --request GET 'https://xls2rdf.sparna.fr/rest/convert?noPostProcessings=true' \
      -H "Connection: keep-alive" \
      -F url='https://docs.google.com/spreadsheets/d/1CZIf3bxuuH3aghFn7B7P89DrLqp_jzv4moI_BpI9PzY/export?format=xlsx' \
      -F format=text/plain \
      -o ./rdafr.nt

# Pré traitement de l'ontologie

RUN sed -e "#http://www.w3.org/ns/shacl#d" -e "/_:node/d" -i ./rdafr.nt

# Génération de la documentation de l'ontologie

RUN java -jar widoco.jar \
      -ontFile ./rdafr.nt \
      -outFolder ./ontologie/ \
      -rewriteAll \
      -lang en\
      -excludeIntroduction \
      -noPlaceHolderText \
      -ignoreIndividuals

RUN mv ./ontologie/index-en.html ./ontologie/index.html

# Génération du profil d'application

RUN mkdir -p profil-application

RUN curl -L --request GET 'https://xls2rdf.sparna.fr/rest/convert?noPostProcessings=true' \
      -H "Connection: keep-alive" \
      -F url='https://docs.google.com/spreadsheets/d/1CZIf3bxuuH3aghFn7B7P89DrLqp_jzv4moI_BpI9PzY/export?format=xlsx' \
      -F format=ttl \
      -o ./profil-application/rdafr-shacl.ttl

RUN curl -F inputShapeFile=@profil-application/rdafr-shacl.ttl \
      -F shapesSource=file \
      -F language=fr \
      -H 'Accept-Language: fr-FR,fr' \
      https://shacl-play.sparna.fr/play/doc \
      > ./profil-application/index.html

# Post traitement du profil d'application

RUN sed -E -i ./profil-application/index.html \
    -e 's#<a href="(https://rdafr\.fr/Elements.*?/)" target="_blank">.*?</a>#\1#' \
    -e 's#<a href="https://rdafr\.fr/(Elements|termList).*?>(.*?)</a>#\2#'


FROM nginx:1.20.2
ENV ONTOLOGIE_RDAFR_VERSION 0.3.5

COPY --from=builder /build ./usr/share/nginx/html/

# Lance le serveur web
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
