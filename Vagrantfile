# -*- mode: ruby -*-
# vi: set ft=ruby :

# WARNING: if you use more than one CPU, you must
# enable hardware virtualization from your BIOS
cpus = '1'
hostname = 'softcover'
memory = '512'

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.hostname = hostname
  config.vm.network :forwarded_port, guest: 4000, host: 4000
  config.vm.provider "virtualbox" do |v|
    v.customize [
      'modifyvm', :id,
      '--cpus', cpus,
      '--memory', memory,
      '--name', hostname + '_vagrant'
    ]
    if cpus.to_i > 1
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end
  end
  config.vm.provision :shell, privileged: false, path: 'install-ubuntu12.04.sh'
end
