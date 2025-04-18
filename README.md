# TP Docker – Architecture Web à 3 Conteneurs

Ce projet met en place une architecture Docker composée de 3 conteneurs : une application web, une base de données MySQL, et un serveur Nginx en reverse proxy.

## Structure du projet

```
./
├── app/
│   ├── Dockerfile
│   ├── requirements.txt
│   └── src/
├── mysql/
│   ├── Dockerfile
│   └── conf/
├── nginx/
│   ├── Dockerfile
│   └── conf/nginx.conf
├── compose.yaml
└── setup_manual.sh
```

## Objectif

Déployer l'architecture suivante :

- **MySQL** : Base de données sur le port interne 5655 (avec volume `db_volume`).
- **App** : Application Python Flask (port interne 4743) avec 2 routes :
  - `/health` → retourne `{"status": "healthy"}`
  - `/data` → retourne les données de la base `test_table`
- **Nginx** : Reverse proxy qui écoute sur `localhost:5423` et redirige vers l'app.

---

## Part 1 : Setup Manuel

Lance manuellement toute l’architecture avec :

```bash
chmod +x setup_manual.sh
./setup_manual.sh
```

Puis accède à l'app :

- [http://localhost:5423/health](http://localhost:5423/health)
- [http://localhost:5423/data](http://localhost:5423/data)


---

## Part 2 : Docker Compose

Lance tout automatiquement avec :

```bash
docker compose up --build -d
```

Tu peux ensuite accéder aux mêmes routes via :

- [http://localhost:5423/health](http://localhost:5423/health)
- [http://localhost:5423/data](http://localhost:5423/data)

Pour arrêter :

```bash
docker compose down
```

---

## Fonctionnalités implémentées

- [x] Communication entre conteneurs via deux réseaux Docker (`db_network`, `site_network`)
- [x] Volume Docker (`db_volume`) pour la persistance des données MySQL
- [x] Healthchecks (MySQL via Dockerfile, App via /health)
- [x] Reverse proxy Nginx configuré pour rediriger les requêtes
- [x] App web minimaliste Flask (Python) avec accès DB


---

## Par Florian Dardy & Cloé Petetin 
