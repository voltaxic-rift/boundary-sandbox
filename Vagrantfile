# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1", "--ioapic", "on"]
  end

  config.vm.box = "centos/8"
  config.vm.box_version = "1905.1"

  config.vm.define "boundary" do |n|
    n.vm.hostname = "boundary"
    n.vm.network "forwarded_port", guest: 9200, host: 9200
    n.vm.network "forwarded_port", guest: 9201, host: 9201
    n.vm.network "forwarded_port", guest: 9202, host: 9202
    n.vm.network "private_network", ip: "192.168.33.10"
    n.vm.network "private_network", ip: "172.31.0.10", virtualbox__intnet: "internal"
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "1", "--ioapic", "on"]
    end
    n.vm.provision "shell", path: "provision/boundary.sh"
  end

  config.vm.define "postgres" do |n|
    n.vm.hostname = "postgres"
    n.vm.network "private_network", ip: "172.31.0.11", virtualbox__intnet: "internal"
    n.vm.provision "shell", path: "provision/postgres.sh"
  end

  config.vm.define "redis" do |n|
    n.vm.hostname = "redis"
    n.vm.network "private_network", ip: "172.31.0.21", virtualbox__intnet: "internal"
    n.vm.provision "shell", path: "provision/redis.sh"
  end
end