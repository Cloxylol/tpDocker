# --- Création des réseaux ---
docker network create db_network
docker network create site_network

# --- Création du volume ---
docker volume create db_volume

# --- Build des images ---
docker build -t mysql ./mysql
docker build -t app ./app
docker build -t nginx ./nginx

# --- Lancement du conteneur MySQL ---
docker run -d \
  --name mysql_container \
  --network db_network \
  --network-alias mysql \
  -v db_volume:/var/lib/mysql \
  -p 5655:5655 \
  -e MYSQL_ROOT_PASSWORD=example \
  -e MYSQL_DATABASE=testdb \
  mysql

# --- Lancement du conteneur app ---
docker run -d \
  --name tpdocker-app-1 \
  --network db_network \
  app

# Connecter le conteneur app au site_network
docker network connect --alias app site_network tpdocker-app-1

# --- Lancement du conteneur nginx ---
docker run -d \
  --name nginx_container \
  --network site_network \
  -p 5423:824 \
  -v "$(pwd)/nginx/conf/nginx.conf":/etc/nginx/conf/nginx.conf:ro \
  nginx

# --- CLEANUP ---
# docker rm -f nginx_container tpdocker-app-1 mysql_container
# docker network rm db_network site_network
# docker volume rm db_volume
