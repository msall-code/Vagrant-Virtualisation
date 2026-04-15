Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "srv-web"

  # Utilisation du port 8091 pour éviter le conflit avec Kafka
  config.vm.network "forwarded_port", guest: 80, host: 8091, auto_correct: true

  # Synchronisation du dossier courant (Windows) avec le dossier /vagrant (VM)
  config.vm.synced_folder ".", "/vagrant"

  # Installation et configuration automatique
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y apache2
    # On remplace le dossier par défaut d'Apache par notre dossier partagé
    sudo rm -rf /var/www/html
    sudo ln -s /vagrant /var/www/html
  SHELL

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

end
