FROM nginx:1.20.2


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
COPY ./.docker/footer.html /usr/share/nginx/html/
RUN sed -i "s#LAST_MODIFICATION_DATE_PLACEHOLDER#$(date +'%e %B %Y')#g" /usr/share/nginx/html/footer.html
COPY ./.docker/style.css   /usr/share/nginx/html/
WORKDIR /usr/share/nginx/html/
RUN pandoc --standalone --toc \
      --shift-heading-level-by=-1 \
      -c style.css \
      -A footer.html \
      README.md -o ./index.html


# Lance le serveur web
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80