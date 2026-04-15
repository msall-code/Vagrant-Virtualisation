Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "srv-web"

  # Redirection du port 80 (VM) vers 86 (Windows)
  config.vm.network "forwarded_port", guest: 80, host: 8085

  # Synchronisation des dossiers
  config.vm.synced_folder ".", "/vagrant"

  # --- INSTALLATION AUTOMATIQUE D'APACHE ---
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y apache2
    # Optionnel : lier le dossier de ton projet au dossier web d'Apache
    sudo rm -rf /var/www/html
    sudo ln -s /vagrant /var/www/html
  SHELL

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

end
