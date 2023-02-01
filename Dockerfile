FROM nginx:1.20.2
ENV ONTOLOGIE_RDAFR_VERSION 0.0.2

# Installation et configuration de la locale FR
# pour avoir les dates auto-générées du footer.html en français
RUN apt update && DEBIAN_FRONTEND=noninteractive apt -y install locales
RUN sed -i '/fr_FR.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8


# Compilation du README.md en page d'acceuil
# de https://rdafr.fr avec l'outil pandoc https://pandoc.org/
RUN DEBIAN_FRONTEND=noninteractive apt install -y pandoc
COPY ./README.md   /usr/share/nginx/html/
COPY ./.docker/template.html   /usr/share/nginx/html/
COPY ./.docker/footer.html /usr/share/nginx/html/
RUN sed -i "s#LAST_MODIFICATION_DATE_PLACEHOLDER#$(date +'%e %B %Y')#g" /usr/share/nginx/html/footer.html
COPY ./.docker/style.css   /usr/share/nginx/html/
WORKDIR /usr/share/nginx/html/
RUN pandoc --standalone --toc \
      --shift-heading-level-by=-1 \
	  --template template.html \
      -c style.css \
      -A footer.html \
      README.md -o ./index.html


# Compilation des SHACL .ttl en HTML en utilisant
# l'outil https://shacl-play.sparna.fr/play/doc
RUN DEBIAN_FRONTEND=noninteractive apt install -y curl
COPY ./personne/ /usr/share/nginx/html/personne/
RUN curl -F inputShapeFile=@personne/shacl-20230130.ttl \
         -F shapesSource=file \
         -F language=fr \
         -H 'Accept-Language: fr-FR,fr' \
         https://shacl-play.sparna.fr/play/doc \
         > /usr/share/nginx/html/personne/index.html
COPY ./vocabulaire/ /usr/share/nginx/html/vocabulaire/


# Lance le serveur web
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
