# -*- mode: ruby -*-
# vi: set ft=ruby :
# boxes at https://vagrantcloud.com/search

Vagrant.configure("2") do |config|
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y htop
  # SHELL
  config.vm.provision "shell", inline: "echo 'Setup .bashrc'; cat /vagrant/data/vm.bashrc > /home/vagrant/.bashrc"
  
  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.box_check_update = false
    master.vm.box = "debian/bookworm64"
    master.vm.network "private_network", ip: "10.8.8.1", virtualbox__intnet: "ansible"
    master.vm.provision "shell", inline: <<-SHELL
      (echo "10.8.8.10 node1"
       echo "10.8.8.20 node2"
       echo "10.8.8.30 node3"
       echo "10.8.8.40 node4") >> /etc/hosts
    SHELL
    # master.vm.synced_folder "./data", "/vagrant_data"
    master.vm.provision "shell", inline: <<-SHELL
      apt-get update | echo "Updating apt..."
      apt-get install -y ansible >/dev/null | echo "Installing pkgs..."
    SHELL
  end
  
  config.vm.define "debian" do |debian|
    debian.vm.hostname = "debian"
    debian.vm.box_check_update = false
    debian.vm.box = "debian/bookworm64"
    debian.vm.network "private_network", ip: "10.8.8.10", virtualbox__intnet: "ansible"
    debian.vm.provision "shell", inline: "echo '10.8.8.1 master' >> /etc/hosts"
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.hostname = "ubuntu"
    ubuntu.vm.box_check_update = false
    ubuntu.vm.box = "ubuntu/jammy64"
    ubuntu.vm.network "private_network", ip: "10.8.8.20", virtualbox__intnet: "ansible"
    ubuntu.vm.provision "shell", inline: "echo '10.8.8.1 master' >> /etc/hosts"
  end

  config.vm.define "centos" do |centos|
    centos.vm.hostname = "centos"
    centos.vm.box_check_update = false
    centos.vm.box = "centos/8"
    centos.vm.network "private_network", ip: "10.8.8.30", virtualbox__intnet: "ansible"
    centos.vm.provision "shell", inline: "echo '10.8.8.1 master' >> /etc/hosts"
  end
  

  config.vm.define "rhel" do |rhel|
    rhel.vm.hostname = "rhel"
    rhel.vm.box_check_update = false
    rhel.vm.box = "generic/rhel7"
    rhel.vm.network "private_network", ip: "10.8.8.40", virtualbox__intnet: "ansible"
    rhel.vm.provision "shell", inline: "echo '10.8.8.1 master' >> /etc/hosts"
  end
  
  # host-only 
  # config.vm.network "private_network", type: "dhcp"
  
  # bridged
  # config.vm.network "public_network", bridge: "TP-LINK 802.11ac Network Adapter"
  
  # config.vm.synced_folder "./data", "/vagrant_data"
  
  
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--groups", "/ansible"]
    vb.customize ["modifyvm", :id, "--vram", "16"]
    # vb.gui = true
    vb.memory = 1024
    vb.cpus = 2
  end

end
