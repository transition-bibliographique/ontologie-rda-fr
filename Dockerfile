FROM nginx:1.20.2
ENV ONTOLOGIE_RDAFR_VERSION 0.3.4

# Installation et configuration de la locale FR
# pour avoir les dates auto-générées du footer.html en français
RUN apt update && DEBIAN_FRONTEND=noninteractive apt -y install locales
RUN sed -i '/fr_FR.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8


# Compilation du siteweb en partant des markdown
# 01_INTRO.md et 02_CONTENT.md
# pour générer la page HTML de https://rdafr.fr
# en utilisant l'outil pandoc https://pandoc.org/
RUN DEBIAN_FRONTEND=noninteractive apt install -y pandoc
COPY ./siteweb/*   /usr/share/nginx/html/
COPY ./siteweb/.docker/*   /usr/share/nginx/html/
RUN sed -i "s#LAST_MODIFICATION_DATE_PLACEHOLDER#$(date +'%e %B %Y')#g" /usr/share/nginx/html/footer.html
WORKDIR /usr/share/nginx/html/
RUN pandoc 01_INTRO.md -o intro.html
RUN pandoc --standalone \
      --toc \
      --shift-heading-level-by=-1 \
	  --template template.html \
      -c style.css \
      -B intro.html \
      -A footer.html \
      02_CONTENT.md -o ./index.html


# Compilation des SHACL .ttl en HTML en utilisant
# l'outil https://shacl-play.sparna.fr/play/doc
RUN DEBIAN_FRONTEND=noninteractive apt install -y curl
COPY ./profil-application/ /usr/share/nginx/html/profil-application/
RUN curl -F inputShapeFile=@profil-application/rdafr-shacl.ttl \
         -F shapesSource=file \
         -F language=fr \
         -H 'Accept-Language: fr-FR,fr' \
         https://shacl-play.sparna.fr/play/doc \
         > /usr/share/nginx/html/profil-application/index.html

# Suppression des URLs non déréférençables
RUN sed -i -E 's/<a href="(https:\/\/rdafr\.fr\/Elements\/.*?\/)" target="_blank">.*?<\/a>/\1/;s/<a href="https:\/\/rdafr\.fr\/(Elements|termList)\/.*?>(.*?)<\/a>/\2/' /usr/share/nginx/html/profil-application/index.html

#COPY ./ontologie/ /usr/share/nginx/html/ontologie/
# todo : ajouter ici la convertion en HTML du OWL
COPY ./vocabulaire/ /usr/share/nginx/html/vocabulaire/
# todo : ajouter la convertion en HTML des vocabulaires


# Lance le serveur web
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
