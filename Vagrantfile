# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.network :forwarded_port, guest: 4000, host: 4000
  config.vm.provision :shell, privileged: false, path: 'install-ubuntu12.04.sh'
end
