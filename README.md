# TP2 — Architecture 2-Tiers : Spring Boot + MySQL + Vagrant

## 📋 Description

Application web Java de gestion d'étudiants déployée sur une architecture 2-tiers :
- **srv-app** : Serveur applicatif (Java 17 + Tomcat 10 + Spring Boot 3.5.11)
- **srv-db** : Serveur base de données (MySQL 8)

## 🏗️ Architecture

```
[ Navigateur ]
      │  HTTP :8080
      ▼
[ srv-app — 192.168.56.10 ]
  Java 17 + Tomcat 10
  Spring Boot 3.5.11
      │  JDBC :3306
      ▼
[ srv-db — 192.168.56.11 ]
  MySQL 8
  Base : tp2db
```

## 📁 Structure du projet

```
TP2/
├── Vagrantfile                          <- Configuration des 2 VMs
├── README.md
└── tp2-app/                             <- Projet Spring Boot
    ├── pom.xml
    ├── mvnw / mvnw.cmd
    └── src/main/
        ├── java/com/tp2/tpapp/
        │   ├── Tp2AppApplication.java
        │   ├── ServletInitializer.java
        │   ├── entity/
        │   │   └── Etudiant.java
        │   ├── repository/
        │   │   └── EtudiantRepository.java
        │   ├── service/
        │   │   └── EtudiantService.java
        │   └── controller/
        │       └── EtudiantController.java
        └── resources/
            ├── application.properties
            ├── application-local.properties
            ├── application-prod.properties
            └── templates/
                └── index.html
```

## 🛠️ Technologies utilisées

| Technologie | Version | Role |
|-------------|---------|------|
| Spring Boot | 3.5.11 | Framework principal |
| Spring Data JPA | 3.5.11 | Persistance des donnees |
| Thymeleaf | 3.5.11 | Moteur de templates |
| MySQL | 8.0 | Base de donnees |
| H2 | - | Base en memoire (test local) |
| Lombok | 1.18.30 | Reduction du code |
| Tomcat | 10.1.34 | Serveur applicatif |
| Java | 17 | Langage |
| Maven | 3.x | Gestionnaire de build |
| Vagrant | 2.x | Virtualisation |
| VirtualBox | - | Hyperviseur |

## ⚙️ Fonctionnalites

- ✅ Lister tous les etudiants
- ✅ Ajouter un etudiant avec validation des champs
- ✅ Modifier un etudiant existant
- ✅ Supprimer un etudiant
- ✅ Verification des emails en double
- ✅ Badges colores par filiere

## 🚀 Installation et demarrage

### Prerequis

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
- [Java 17](https://adoptium.net/)
- [IntelliJ IDEA](https://www.jetbrains.com/idea/)

### 1. Cloner le projet

```bash
git clone https://github.com/msall-code/Vagrant-Virtualisation.git
cd Vagrant-Virtualisation
git checkout tp2
```

### 2. Demarrer les VMs

```bash
vagrant up
vagrant status
```

### 3. Configurer srv-db

```bash
vagrant ssh srv-db

# Installer MySQL
sudo apt update
sudo apt install mysql-server -y

# Autoriser connexions distantes
sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# Creer la base et l'utilisateur
sudo mysql
```

```sql
CREATE DATABASE tp2db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'tpuser'@'%' IDENTIFIED BY 'tp123';
GRANT ALL PRIVILEGES ON tp2db.* TO 'tpuser'@'%';
FLUSH PRIVILEGES;
EXIT;
```

### 4. Configurer srv-app

```bash
vagrant ssh srv-app

# Installer Java 17
sudo apt update
sudo apt install openjdk-17-jdk -y

# Telecharger et installer Tomcat 10
cd /tmp
wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.34/bin/apache-tomcat-10.1.34.tar.gz
sudo tar xzf apache-tomcat-10.1.34.tar.gz -C /opt
sudo mv /opt/apache-tomcat-10.1.34 /opt/tomcat10
sudo useradd -r -m -U -d /opt/tomcat10 -s /bin/false tomcat
sudo chown -R tomcat:tomcat /opt/tomcat10
sudo chmod -R 755 /opt/tomcat10

# Creer le service systemd
sudo nano /etc/systemd/system/tomcat10.service
```

Contenu du fichier `tomcat10.service` :

```ini
[Unit]
Description=Apache Tomcat 10
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
Environment="CATALINA_HOME=/opt/tomcat10"
ExecStart=/opt/tomcat10/bin/startup.sh
ExecStop=/opt/tomcat10/bin/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl start tomcat10
sudo systemctl enable tomcat10
```

### 5. Builder et deployer l'application

**Sur ton poste Windows — changer le profil en prod :**

Dans `tp2-app/src/main/resources/application.properties` :
```properties
spring.profiles.active=prod
```

**Builder le WAR :**
```powershell
cd tp2-app
.\mvnw.cmd clean package -DskipTests
```

**Deployer sur srv-app :**
```bash
vagrant ssh srv-app
sudo cp /home/vagrant/tp2-app/target/tp2-app-0.0.1-SNAPSHOT.war /opt/tomcat10/webapps/tp2-app.war
sudo chown tomcat:tomcat /opt/tomcat10/webapps/tp2-app.war
sudo tail -f /opt/tomcat10/logs/catalina.out
```

### 6. Tester l'application

```
http://192.168.56.10:8080/tp2-app/etudiants
```

## 💻 Developpement en local

Pour tester en local sans les VMs, utiliser le profil `local` qui utilise H2 en memoire :

```properties
# application.properties
spring.profiles.active=local
```

```bash
cd tp2-app
.\mvnw.cmd spring-boot:run
```

- Application : `http://localhost:8080/etudiants`
- Console H2 : `http://localhost:8080/h2-console`
  - JDBC URL : `jdbc:h2:mem:tp2db`
  - Username : `sa`
  - Password : (vide)

## 🔄 Workflow de developpement

```
1. Coder dans IntelliJ    profil local  -> H2 en memoire
                          mvn spring-boot:run
                          http://localhost:8080/etudiants

2. Builder le WAR         profil prod   -> MySQL srv-db
                          mvnw.cmd clean package -DskipTests

3. Deployer sur srv-app   copier WAR dans Tomcat 10
                          http://192.168.56.10:8080/tp2-app/etudiants
```

## 🧪 Tests

### Tester la connexion depuis srv-app vers srv-db

```bash
mysql -h 192.168.56.11 -u tpuser -ptp123 tp2db -e "SELECT 'OK' AS test;"
```

### Verifier les donnees sur srv-db

```bash
vagrant ssh srv-db
mysql -u tpuser -ptp123 tp2db

SHOW TABLES;
DESCRIBE etudiants;
SELECT * FROM etudiants;
```

### Verifier les logs Tomcat

```bash
vagrant ssh srv-app
sudo tail -f /opt/tomcat10/logs/catalina.out
```

## 🔧 Commandes utiles

```bash
# Demarrer les VMs
vagrant up

# Arreter les VMs
vagrant halt

# Statut des VMs
vagrant status

# Se connecter a srv-app
vagrant ssh srv-app

# Se connecter a srv-db
vagrant ssh srv-db

# Redemarrer Tomcat
sudo systemctl restart tomcat10

# Statut Tomcat
sudo systemctl status tomcat10

# Statut MySQL
sudo systemctl status mysql
```

## 👤 Auteur

- **GitHub** : [msall-code](https://github.com/msall-code)
