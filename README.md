# Project Guidelines

## Inception : 
- VM 
- Files required for config in srcs/
- Makefile (root) + use docker-compose.yml pour les images

### Mandatory :
- Use Docker Compose
- 1 container par service
- Alpine or Debian 
- Dockerfile (1 per ervice) + call by docker-compose.yml

#### Services : 
- NGINX with TLSv1.2 or 1.3
- Wordpress with php-fpm (installed and configured, without nginx)
- MariaDB (without nginx)
- Volume for WP database
- Volume for WP files
- docker-network for connection between containers
- Containers auto restart if crash

#### WP db  : 
2 users - admin (not a direct name like admin, administrator or admin123) and classic user

#### Volumes : 
dispo dans /home/fvastena/data de l host qui utilise docker

#### Domain name to local IP address
==> fvastena.42.fr --> to local address of website



Guilines  :

Creation + set up vm --> rien de special a dire (Max 15gb pour pas se faire wipe du sgoinfre)
Admin user = fvastena + classic mdp

Install Docker & Docker Compose (view docs for use with Debian)
Whats diff between ubuntu and debian ? is it just between linux-windows-macos ?

Main directory for the project 

Subdirectories inside main :

~/inception/
├── Makefile
├── secrets/
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── mariadb/
        │   ├── conf/
        │   └── tools/
        ├── nginx/
        │   ├── conf/
        │   └── tools/
        └── wordpress/
            ├── conf/
            └── tools/

create .env file for login and secrets file for password saving

Install mariadb through Dockerfile and init_db.sh
+ set definition in docker-compose

Install wordpress through Dockerfile and wp-config.sh
+ set definition in docker-compose

Install Nginx through Dockerfile and nginx.conf

Create Makefile and compile project by calling docker-compose and dockerfiles



# Docker Docs
--> Plateforme qui permet d'isoler des processus grâce à des conteneurs 
--> Plus facile et rapide qu'une VM

Dockerfile : Script contenant une série d'instructions pour construire une image Docker

Docker Image : Modèle en lecture seule qui contient les instructions pour céréer un conteneur --> code de l'app, dépendance, bibliothèque, fichier de config...

Docker Container : Instance exécutable d'une image Docker. Ils sont isolé des autres conteneurs et de la machine hôte

Docker Compose : Outil qui définit et gère les applications multiconteneurs permet de configure les services, réseaux et volumes de l'app

Docker Volumes : Mécanmises permettant de stocker des données générées et utilisées par les conteneurs. Les volumes sont indépendant du conteneur et persistent si le conteneur est supprimé (Ici, base de données)

Docker Network : Permet aux conteneur de communiquer entre eux et avec le monde extérieur. Docker Compose en crée un par défaut mais important de le définir explicitement

Env Vars : Permet de configurer les app à l'exécution, on les utilise pour passer des identifiants aux conteneurs sans les avoir en clair dans les images

Docker Secrets : mécanisme + sécurisé pour gérer les données sensibles que les mdp, clefs ssh etc


--> Nouvelle VM :
--> install git, make
--> recup le repo
--> lancer setupVM.sh
--> Verifier si user dans sudoers et docker groups
--> reboot pour appliquer les groupes
--> make
