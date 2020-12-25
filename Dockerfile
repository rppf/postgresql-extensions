FROM postgres:12-alpine

RUN apk --no-cache add postgis

RUN apk --no-cache add timescaledb -U --repository https://sjc.edge.kernel.org/alpine/edge/testing

RUN apk --no-cache add gosu -U --repository https://sjc.edge.kernel.org/alpine/edge/testing

RUN cp -R /usr/share/postgresql/extension/* /usr/local/share/postgresql/extension

RUN cp -R /usr/lib/postgresql/* /usr/local/lib/postgresql

ENV PG_CRON_VERSION 1.3.0

RUN apk add --no-cache --virtual .build-deps build-base ca-certificates clang-dev llvm10 openssl tar \
    && wget -O /pg_cron.tgz https://github.com/citusdata/pg_cron/archive/v$PG_CRON_VERSION.tar.gz \
    && tar xvzf /pg_cron.tgz && cd pg_cron-$PG_CRON_VERSION \
    && sed -i.bak -e 's/-Werror//g' Makefile \
    && sed -i.bak -e 's/-Wno-implicit-fallthrough//g' Makefile \
    && make && make install \
    && cd .. && rm -rf pg_cron.tgz && rm -rf pg_cron-* \
    && apk del .build-deps

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]

EXPOSE 5432

CMD ["postgres"]