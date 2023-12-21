FROM node:20

ARG WORKDIR=/var/www/html

ENV WORKDIR=${WORKDIR}

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN ln -s /usr/local/bin/entrypoint.sh /

ENTRYPOINT ["entrypoint.sh"]

RUN chmod -R 755 $WORKDIR
RUN chown -R www-data:www-data $WORKDIR

EXPOSE 3000
CMD [ "entrypoint" ]