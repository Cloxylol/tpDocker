FROM mysql:8.1

COPY conf/init.sql /docker-entrypoint-initdb.d/

HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
  CMD mysqladmin ping -h 127.0.0.1 -P 3306 -pexample || exit 1
