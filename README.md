# Softcover Vagrant

Ubuntu 12.04 64 bit Vagrant virtual machine for [Softcover](https://github.com/softcover/softcover) usage and development.

**STATUS**:

The `softcover new` template and `softcover_book` build correctly on all formats.

Exactly 3 unit tests fail, all of which are Softcover bugs:

- <https://github.com/softcover/softcover/issues/102>
- <https://github.com/softcover/softcover/pull/103>. Merged but not yet included here.

## I already know Vagrant

    git clone https://github.com/cirosantilli/softcover_vagrant
    cd softcover_vagrant
    vagrant up
    vagrant ssh

In the SSH:

    cd /vagrant/projects
    softcover new example_book
    cd example_book
    softcover build
    softcover serve

Your book is ready under the `projects/example_book` subdirectory in the host, and can be previewed at `localhost:4000`.

Next project?

    cd /vagrant/projects
    softcover new example_book2

## I am new to Vagrant

A virtual machine will install another OS inside of your OS, which you can access via SSH. The main OS is called the *host*, while the one inside it is called the *guest*.

The advantage of using a virtual machine is that it makes it easier to install Softcover for usage and development as all you have to do is to:

- install the virtual machine
- and Softcover will automatically be installed in the guest by a startup script

We feel that installing the virtual machine is easier than installing Softcover.

### Install Vagrant

Install [Vagrant](http://www.vagrantup.com/), which will also require you so install a VM provider. We officially support [Oracle VirtualBox](https://www.virtualbox.org/), which is free and cross platform.

Vagrant is cross platform and easy to install. For example on Ubuntu 12.04 use:

    # VirtualBox
    wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
    sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian raring contrib" >> /etc/apt/sources.list.d/virtualbox.list'
    sudo apt-get update
    sudo apt-get install -y virtualbox-4.2

    # Vagrant
    firefox http://www.vagrantup.com/downloads.html
    # Click on the download for you system.
    cd download_dir
    sudo dpkg -i vagrant_*.deb

Avoid installing Vagrant from the Ubuntu repositories as the versions there are very outdated.

It is recommended that you enable hardware virtualization from your BIOS screen, the first screen that appears then you turn the computer on.

### Usage

Go to the root of this repository and do:

    vagrant up

This starts up the Ubuntu 12.04 guest virtual machine.

The first time you do `vagrant up` the command will take a long time to execute (~30 minutes) since it will download and install the virtual machine.

Once the machine is up, ssh into the guest with:

    vagrant ssh

To create a new book simply to the following from inside the guest:

    cd /vagrant/projects
    softcover new example_book

On the host, you will see that the `projects/` directory of this repository is exactly equal to the `/vagrant/projects` directory in the guest machine.

You can edit your book from your host machine on you favorite editor, and only use the `ssh` when you want to do Softcover commands.

Port forwarding is already configured, so if you do:

    softcover serve

on the guest, then you can visit: `localhost:4000` on the host and your book will be there.

This means that port 4000 must be free or the virtual machine won't boot. If port 4000 is already in use, you can edit the line:

    config.vm.network

in this `Vagrantfile` to set it to another value.

## Develop Softcover

You can also use this repository to develop Softcover itself.

From the host, `cd` to the root of this repository and clone Softcover:

    git clone https://github.com/softcover/softcover

It is already gitignored.

For interactive tests, create the project under `projects` and add following Gemfile to the project's directory:

    cat <<EOF > Gemfile
    source 'https://rubygems.org'
    ruby '2.1.1'
    gem 'softcover', :path => '../../softcover'
    EOF

and don't forget to use `bundle exec` all the time from the guest:

    bundle exec softcover build

Run the unit tests from the guest via:

    cd /vagrant/softcover
    bundle install
    bundle exec rake spec

## Develop this VM

See [CONTRIBUTING.md](CONTRIBUTING.md) for more info on how to contribute to this project.
