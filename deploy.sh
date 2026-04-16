Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "srv-web-tp1"

  # On mappe le port 8080 de Tomcat vers le 8091 de ton Windows
  config.vm.network "forwarded_port", guest: 8080, host: 8091, auto_correct: true

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.name   = "srv-tp1"
    vb.memory = 2048
    vb.cpus = 2
  end

  # Installation automatique des prérequis
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y tomcat9 tomcat9-admin

    # 1. Supprimer le dossier ROOT physique pour éviter les conflits
    sudo rm -rf /var/lib/tomcat9/webapps/ROOT

    # 2. Créer le fichier de configuration pour rediriger l'accueil vers ton dossier
    # On crée un fichier ROOT.xml dans le dossier de configuration de Tomcat
    sudo mkdir -p /etc/tomcat9/Catalina/localhost
    sudo tee /etc/tomcat9/Catalina/localhost/ROOT.xml <<EOF
<Context docBase="/vagrant/webapp/src/main/webapp" reloadable="true">
</Context>
EOF

    # 3. Autoriser Tomcat à lire le dossier /vagrant (problème de permissions classique)
    sudo gpasswd -a tomcat vagrant
    
    # 4. Redémarrer pour appliquer
    sudo systemctl restart tomcat9
  SHELL
end
