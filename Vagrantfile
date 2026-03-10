Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"

  # VM Application
  config.vm.define "srv-app" do |app|
    app.vm.hostname = "srv-app"
    app.vm.network "private_network", ip: "192.168.56.10"
    app.vm.synced_folder "./tp2-app", "/home/vagrant/tp2-app",
      owner: "vagrant",
      group: "vagrant",
      create: true
    app.vm.provider "virtualbox" do |vb|
      vb.name   = "srv-app"
      vb.memory = 2048
      vb.cpus   = 2
    end
  end

  # VM Database
  config.vm.define "srv-db" do |db|
    db.vm.hostname = "srv-db"
    db.vm.network "private_network", ip: "192.168.56.11"
    db.vm.provider "virtualbox" do |vb|
      vb.name   = "srv-db"
      vb.memory = 1024
      vb.cpus   = 1
    end
  end

end