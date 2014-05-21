# -*- mode: ruby -*-
# vi: set ft=ruby :

# WARNING: if you use more than one CPU, you must
# enable hardware virtualization from your BIOS
cpus = '1'
memory = '1024'

box = 'cirosantilli/precise64_softcover'
hostname = 'softcover'
Vagrant.configure('2') do |config|
  if ENV['SOFTCOVER_VAGRANT_DEV'] == 'true'
    box += '_dev'
    config.vm.box = box
    config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
    config.vm.provision :shell, privileged: false, path: 'provision.sh'
    suffix = '_dev'
  else
    config.vm.box = box
    suffix = ''
  end
  config.vm.hostname = hostname
  config.vm.network :forwarded_port, guest: 4000, host: 4000
  config.vm.provider "virtualbox" do |v|
    v.customize [
      'modifyvm', :id,
      '--cpus',   cpus,
      '--memory', memory,
      '--name',   box
    ]
    if cpus.to_i > 1
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end
  end
  config.vm.provision :shell, privileged: false, path: 'provision-prepackaged.sh'
end
