FROM nginx:stable

ARG WORKDIR=/var/www/html
ARG PORT
ENV DOCUMENT_ROOT=${WORKDIR}
ENV DOMAIN=_
ENV CLIENT_MAX_BODY_SIZE=15M
ENV PHP_FPM_HOST=127.0.0.1:9000

RUN rm -rf /etc/nginx/conf.d/default.conf
RUN rm -rf /etc/nginx/sites-enabled/default
RUN rm -rf /etc/nginx/sites-available/default

RUN rm -rf /etc/nginx/nginx.conf
COPY  config/proxy.inc /etc/nginx/proxy.inc
COPY  config/nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN ln -s /usr/local/bin/entrypoint.sh /

ENTRYPOINT ["entrypoint.sh"]
EXPOSE $PORT
CMD [ "entrypoint" ]