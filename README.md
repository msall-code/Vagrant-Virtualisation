# DevOps Full Stack Application

**React + Spring Boot + MySQL | Vagrant Infrastructure**

## 📌 Description

Ce projet est une application **Full Stack** réalisée dans le cadre d’un TP DevOps.
L'application est basée sur une **architecture 3-tiers** avec séparation des services :

* **Frontend** : React
* **Backend** : Spring Boot (API REST)
* **Base de données** : MySQL
* **Infrastructure** : Vagrant avec plusieurs machines virtuelles
* **Serveur Web** : Nginx

L'objectif est de comprendre le **déploiement d'une application distribuée sur plusieurs machines virtuelles**.

---

# 🏗 Architecture du projet

```text
Utilisateur (Navigateur)
        │
        ▼
Frontend React (Nginx)
server-front
        │
        ▼
Backend Spring Boot
server-back
        │
        ▼
Base de données MySQL
server-db
```

---

# 📂 Structure du projet

```text
TP3
│
├── Backend
│   ├── src
│   ├── pom.xml
│
├── Frontend
│   ├── src
│   ├── public
│   ├── package.json
│
├── Vagrantfile
└── README.md
```

---

# ⚙️ Technologies utilisées

* Java 17
* Spring Boot
* React
* MySQL
* Node.js
* Nginx
* Vagrant
* VirtualBox

---

# 🚀 Lancer l'infrastructure

Démarrer les machines virtuelles :

```bash
vagrant up
```

Machines créées :

* **server-front** → Frontend React + Nginx
* **server-back** → API Spring Boot
* **server-db** → Base de données MySQL

Accéder aux machines :

```bash
vagrant ssh server-front
vagrant ssh server-back
vagrant ssh server-db
```

---

# 🖥 Développement du frontend

Depuis le dossier **Frontend** :

```bash
npm install
npm start
```

Application accessible sur :

```
http://localhost:3000
```

---

# 📦 Build du frontend pour production

Créer une version optimisée :

```bash
npm run build
```

Les fichiers sont générés dans :

```
Frontend/build
```

---

# 🌐 Déploiement du frontend

Dans la VM **server-front**, copier le build React vers Nginx :

```bash
sudo rm -rf /var/www/html/*
sudo cp -r /home/vagrant/frontend/build/* /var/www/html/
```

Redémarrer Nginx :

```bash
sudo systemctl restart nginx
```

Le frontend est accessible via :

```
http://IP_SERVER_FRONT
```

---

# 🔎 Accès aux services

Frontend :

```
http://IP_SERVER_FRONT
```

Backend API :

```
http://IP_SERVER_BACK:8080
```

---

# 🎯 Objectifs du projet

Ce projet permet de mettre en pratique :

* architecture **3-tiers**
* déploiement **frontend / backend**
* **virtualisation avec Vagrant**
* gestion d'une **infrastructure multi-VM**
* build et déploiement **React production**

---

# 👨‍💻 Auteur

**Mamadou Sall**

Projet DevOps – Application Full Stack
