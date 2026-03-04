Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "srv-web"

  # Port 8080 accessible depuis Windows
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Synchronisation automatique avec Windows
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

end