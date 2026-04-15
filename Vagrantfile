# VM Application (Serveur Web)
  config.vm.define "srv-app" do |app|
    app.vm.hostname = "srv-app"
    
    # Réseau privé pour communiquer avec la DB
    app.vm.network "private_network", ip: "192.168.56.10"
    
    # Pont vers Windows : http://localhost:8092 -> Tomcat:8080
    app.vm.network "forwarded_port", guest: 8080, host: 8092, auto_correct: true

    # Synchronisation du dossier de l'app
    app.vm.synced_folder "./tp2-app", "/home/vagrant/tp2-app",
      owner: "vagrant",
      group: "vagrant",
      create: true

    app.vm.provider "virtualbox" do |vb|
      vb.name   = "srv-app-tp2"
      vb.memory = 2048
      vb.cpus   = 2
    end

    # Provisioning pour installer Java et Tomcat
    app.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y openjdk-11-jdk tomcat9
      
      # Nettoyage et lien vers ton code pour l'accès direct via /
      sudo rm -rf /var/lib/tomcat9/webapps/ROOT
      sudo ln -s /home/vagrant/tp2-app /var/lib/tomcat9/webapps/ROOT
      
      # Permissions pour que Tomcat puisse lire ton dossier
      sudo gpasswd -a tomcat vagrant
      sudo systemctl restart tomcat9
    SHELL
  end
