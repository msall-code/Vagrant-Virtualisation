Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "srv-web"

  # On redirige le port 80 de la VM vers le port 86 de ton Windows
  config.vm.network "forwarded_port", guest: 80, host: 86

  # Synchronisation automatique avec Windows
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

end
