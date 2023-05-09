FROM nginx:1.20.2
ENV ONTOLOGIE_RDAFR_VERSION 0.3.5

RUN apt update && DEBIAN_FRONTEND=noninteractive apt -y install locales 
RUN sed -i '/fr_FR.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y pandoc default-jdk

COPY ./siteweb/*   /usr/share/nginx/html/
COPY ./siteweb/.docker/*   /usr/share/nginx/html/
RUN sed -i "s#LAST_MODIFICATION_DATE_PLACEHOLDER#$(date +'%e %B %Y')#g" /usr/share/nginx/html/footer.html

WORKDIR /usr/share/nginx/html/

# Génération du site web 

RUN pandoc ./01_INTRO.md -o ./intro.html
RUN pandoc --standalone \
      --toc \
      --shift-heading-level-by=-1 \
      --template ./template.html \
      -c style.css \
      -B ./intro.html \
      -A ./footer.html \
      02_CONTENT.md -o ./index.html

# Génération des releases notes

RUN pandoc --standalone \
      --toc \
      --shift-heading-level-by=-1 \
      --template ./template.html \
      -c style.css \
      -A ./footer.html \
      ./release-notes.md -o ./release-notes.html

# Installation de widoco

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

RUN java -jar widoco.jar -ontFile ./rdafr.nt -outFolder ./ontologie/ -rewriteAll -lang fr -excludeIntroduction -includeAnnotationProperties -noPlaceHolderText -webVowl
RUN mv ./ontologie/index-fr.html ./ontologie/index.html

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
    -e 's#<a href="(https://rdafr\.fr/Elements/.*?/)" target="_blank">.*?</a>#\1#' \
    -e 's#<a href="https://rdafr\.fr/(Elements|termList)/.*?>(.*?)</a>#\2#'

# Lance le serveur web
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
