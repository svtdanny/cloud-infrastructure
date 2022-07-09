FROM nginx

COPY gateway.conf.template /etc/nginx/conf.d/

ENV APP_HOST=localhost
ENV APP_PORT=8080

CMD envsubst '${APP_HOST} ${APP_PORT}' < /etc/nginx/conf.d/gateway.conf.template > /etc/nginx/conf.d/gateway.conf && "nginx" "-g" "daemon off;"
