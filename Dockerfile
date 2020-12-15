FROM postgres:12-alpine

RUN apk --no-cache add postgis

RUN apk --no-cache add postgresql-pg_cron -U --repository https://sjc.edge.kernel.org/alpine/edge/community

RUN apk --no-cache add gosu -U --repository https://sjc.edge.kernel.org/alpine/edge/testing

RUN echo "shared_preload_libraries = 'pg_cron'" >> /var/lib/postgresql/data/postgresql.conf

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]

EXPOSE 5432

CMD ["postgres"]