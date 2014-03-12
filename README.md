**STATUS**: Once TRALICS is compiled locally, this is almost usable. Waiting for Softcover team to decide what should be done about it before adding solution here. Discussion at: https://github.com/softcover/polytexnic/issues/100 

- template book builds correctly.
- softcover_book builds correctly on all formats except PDF where there are encoding errors.
- only 5 unit tests fail

Tests that must pass are placed under `check-install.sh`, to be run in the guest. Failing tests are marked with `FAIL` and where it fails will be noted in the comments.

Once all tests pass, we will:

- provide a ready `.box` download for end users
- remove this message

---

Install [Softcover](https://github.com/softcover/softcover) easily for usage and development via a Vagrant virtual machine.

# I already know Vagrant

    git clone https://github.com/cirosantilli/softcover_vagrant
    cd softcover_vagrant
    # OPTIONAL BUT MUCH FASTER: download Tex Live ISO by torrent
    # and put it in the current directory with exact name: texlive2013.iso
    #wget -O texlive2013.iso.torrent https://www.tug.org/texlive/files/texlive2013.iso.torrent
    vagrant up
    vagrant ssh

In the SSH:

    cd /vagrant/projects
    softcover new example_book
    cd example_book
    softcover build

Your book is ready under the `projects/` subdirectory in the host.

# I am new to Vagrant

A virtual machine will install another OS inside of your OS, which you can access via SSH. The main OS is called the *host*, while the one inside it is called the *guest*.

The advantage of using a virtual machine is that it makes it easier to install Softcover for usage and development as all you have to do is to:

- install the virtual machine
- and Softcover will automatically be installed in the guest by a startup script

We feel that installing the virtual machine is easier than installing Softcover.

# Install Vagrant

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

# Decide How to Install TeX Live

Once Vagrant is installed, you have to decide between:

- downloading TeX Live via torrent on the host.

    Not automated because of torrent availability fluctuations, but potentially *much* faster than a CTAN download (20 minutes vs 4 hours).

    Just put the ISO on the root of this repository and rename it to *exactly*: `texlive2013.iso`

    The `.torrent` can be found at:

        wget -O texlive2013.iso.torrent https://www.tug.org/texlive/files/texlive2013.iso.torrent

- downloading TeX Live from a CTAN mirror.

    Surefire, but will take around 4 hours.

    Fully automated: you don't have to do anything for now.

# Develop Books

Go to the root of this repository and do:

    vagrant up

This starts up the Ubuntu 12.04 guest virtual machine.

The first time you do `vagrant up` the command will take a long time to execute since it is installing Softcover and all of its dependencies.

If the installation fails because of Internet connection problems, try again via: `vagrant provision`.

Once the machine is up, ssh into the guest with:

    vagrant ssh

First check that everything is installed correctly:

    /vagrant/check-install.sh

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

# Develop Softcover

You can also use this repository to develop Softcover itself.

`cd` to the root of this repository and clone Softcover:

    git clone https://github.com/softcover/softcover

It is already gitignored.

For interactive tests, add the following Gemfile to your `project/NAME` directory:

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
