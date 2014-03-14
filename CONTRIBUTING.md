#Issues

If the machine does not start up correctly, create a issue containing:

- the output of `uname -a`
- the error message given by Vagrant
- error messages if you start the machine from the VirtualBox GUI

#Develop

All tests under:

    /vagrant/check-install.sh

must pass.

We package the machine with

    ./package.sh

and we upload the box with:

    ./upload.sh
