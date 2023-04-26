FROM nginx:1.20.2
ENV ONTOLOGIE_RDAFR_VERSION 0.3.5

COPY ./build/siteweb/* /usr/share/nginx/html/
COPY ./build/profil-application/ /usr/share/nginx/html/profil-application/
COPY ./build/ontologie/ /usr/share/nginx/html/ontologie/
COPY ./vocabulaire/ /usr/share/nginx/html/vocabulaire/

# todo : ajouter la convertion en HTML des vocabulaires

# Lance le serveur web
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80