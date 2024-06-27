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
      (echo "10.8.8.10 deb"
       echo "10.8.8.20 ubu"
       echo "10.8.8.30 cent"
       echo "10.8.8.40 rhel") >> /etc/hosts
    SHELL
    # master.vm.synced_folder "./data", "/vagrant_data"
    master.vm.provision "shell", inline: <<-SHELL
      apt-get update | echo "Updating apt..."
      apt-get install -y ansible >/dev/null | echo "Installing pkgs..."
    SHELL
  end
  
  config.vm.define "deb" do |deb|
    deb.vm.hostname = "deb"
    deb.vm.box_check_update = false
    deb.vm.box = "debian/bookworm64"
    deb.vm.network "private_network", ip: "10.8.8.10", virtualbox__intnet: "ansible"
    deb.vm.provision "shell", inline: "echo '10.8.8.1 master' >> /etc/hosts"
  end

  config.vm.define "ubu" do |ubu|
    ubu.vm.hostname = "ubu"
    ubu.vm.box_check_update = false
    ubu.vm.box = "ubuntu/jammy64"
    ubu.vm.network "private_network", ip: "10.8.8.20", virtualbox__intnet: "ansible"
    ubu.vm.provision "shell", inline: "echo '10.8.8.1 master' >> /etc/hosts"
  end

  config.vm.define "cent" do |cent|
    cent.vm.hostname = "cent"
    cent.vm.box_check_update = false
    cent.vm.box = "centos/8"
    cent.vm.network "private_network", ip: "10.8.8.30", virtualbox__intnet: "ansible"
    cent.vm.provision "shell", inline: "echo '10.8.8.1 master' >> /etc/hosts"
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
