# -*- mode: ruby -*-
# vi: set ft=ruby :

# WARNING: if you use more than one CPU, you must
# enable hardware virtualization from your BIOS
cpus = '1'
memory = '1024'

hostname = 'softcover'
suffix = ''
Vagrant.configure('2') do |config|
  if ENV['VAGRANT_NEW_BOX'] == 'true'
    config.vm.box = 'precise32'
    config.vm.box_url = 'http://files.vagrantup.com/precise32.box'
    config.vm.provision :shell, privileged: false, path: 'provision.sh'
    suffix = '_dev'
  else
    config.vm.box = 'softcover_vagrant'
    config.vm.box_url = 'http://downloads.sourceforge.net/project/softcovervagrant/precise32_softcover.box'
  end
  config.vm.hostname = hostname
  config.vm.network :forwarded_port, guest: 4000, host: 4001
  config.vm.provider "virtualbox" do |v|
    v.customize [
      'modifyvm', :id,
      '--cpus', cpus,
      '--memory', memory,
      '--name', (hostname + '_vagrant' + suffix)
    ]
    if cpus.to_i > 1
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end
  end
  config.vm.provision :shell, privileged: false, path: 'provision-prepackaged.sh'
end
