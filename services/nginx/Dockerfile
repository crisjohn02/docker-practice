FROM nginx:alpine

ARG WORKDIR=/var/www/html
ARG PORT=80
ENV DOCUMENT_ROOT=${WORKDIR}
ENV DOMAIN=_
ENV CLIENT_MAX_BODY_SIZE=15M
ENV PHP_FPM_HOST=127.0.0.1:9000
ENV PORT=${PORT}


RUN rm -rf /etc/nginx/conf.d/default.conf \
    && rm -rf /etc/nginx/sites-enabled/default \
    && rm -rf /etc/nginx/sites-available/default

RUN rm -rf /etc/nginx/nginx.conf
COPY config/proxy.inc /etc/nginx/proxy.inc
COPY config/nginx.conf /etc/nginx/nginx.conf

# Make sure the directory exists before copying nginx.conf
#RUN mkdir -p /etc/nginx

WORKDIR ${WORKDIR}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN ln -s /usr/local/bin/entrypoint.sh /

# RUN touch /var/run/nginx.pid
# RUN chown -R ${USER_NAME}:${USER_NAME} /etc/nginx/conf.d/default.conf && \
#  chown -R ${USER_NAME}:${USER_NAME} /var/cache/nginx/ && \
#  chown -R ${USER_NAME}:${USER_NAME} /var/log/nginx/ && \
#  chown -R ${USER_NAME}:${USER_NAME} /var/run/nginx.pid

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80
CMD [ "entrypoint" ]