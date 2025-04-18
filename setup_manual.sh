#!/bin/bash

# 1. Create networks and volume
docker network create db_network
docker network create site_network
docker volume create db_volume

# 2. Build images
docker build -t mysql ./mysql
docker build -t app ./app
docker build -t nginx ./nginx  

# 3. Run MySQL
docker run -d \
  --name mysql_container \
  --network db_network \
  --network-alias mysql \
  -v db_volume:/var/lib/mysql \
  -p 5655:5655 \
  -e MYSQL_ROOT_PASSWORD=example \
  -e MYSQL_DATABASE=testdb \
  mysql

# 4. Run App
docker run -d \
  --name app_container \
  --network db_network \
  --network site_network \
  --network-alias app \
  app

# 5. Run Nginx
docker run -d \
  --name nginx_container \
  --network site_network \
  -p 5423:824 \
  -v $(pwd)/nginx/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
  nginx

# 6. Cleanup (commenté)
# docker stop nginx_container app_container mysql_container
# docker rm nginx_container app_container mysql_container
# docker network rm db_network site_network
# docker volume rm db_volume
