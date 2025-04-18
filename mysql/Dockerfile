FROM mysql:8.1  

ENV MYSQL_ROOT_PASSWORD=example
ENV MYSQL_DATABASE=testdb

EXPOSE 5655

HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=3 \
 CMD mysqladmin ping -h localhost -pexample || exit 1