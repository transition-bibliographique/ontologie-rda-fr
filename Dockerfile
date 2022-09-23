FROM nginx:1.20.2
COPY ./build/* /usr/share/nginx/html/
#ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80