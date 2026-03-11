Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"

  # SERVER BACKEND
  config.vm.define "server-back" do |back|
    back.vm.hostname = "server-back"
    back.vm.network "private_network", ip: "192.168.56.10"

    # dossier partagé backend
    back.vm.synced_folder "./backend", "/home/vagrant/backend"
  end


  # SERVER DATABASE
  config.vm.define "server-dba" do |dba|
    dba.vm.hostname = "server-dba"
    dba.vm.network "private_network", ip: "192.168.56.11"
  end


  # SERVER FRONTEND
  config.vm.define "server-front" do |front|
    front.vm.hostname = "server-front"
    front.vm.network "private_network", ip: "192.168.56.12"

    # dossier partagé frontend
    front.vm.synced_folder "./Frontend", "/home/vagrant/frontend"
  end

end