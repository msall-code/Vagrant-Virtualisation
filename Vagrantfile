Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "srv-web"

  # On passe sur le port 8090 pour éviter tout conflit Windows
  config.vm.network "forwarded_port", guest: 80, host: 8090, auto_correct: true

  # Synchronisation des dossiers (Windows <-> VM)
  config.vm.synced_folder ".", "/vagrant"

  # --- AUTOMATISATION ---
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y apache2
    # On lie le dossier du projet au serveur web
    sudo rm -rf /var/www/html
    sudo ln -s /vagrant /var/www/html
  SHELL

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

end
