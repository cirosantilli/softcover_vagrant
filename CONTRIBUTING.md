# Contributing

## Issues

If the machine does not start up correctly, create a issue containing:

- the output of `uname -a`
- the error message given by Vagrant
- error messages if you start the machine from the VirtualBox GUI

## Develop

Start the development box with:

    SOFTCOVER_VAGRANT_DEV=true vagrant up

This will use a separate box from the common usage box, named `softcover_vagrant_dev` instead of `softcover_vagrant`.

TODO: this is broken: find the correct way to generate two separate machines, maybe <https://docs.vagrantup.com/v2/multi-machine/>.

All tests under:

    /vagrant/check-install.sh

must pass in the guest.

Package the machine into a `.box` with:

    ./package.sh

Packaged machines must be provisioned from scratch to avoid hard to fix bugs.

Upload the box with:

    ./upload.sh

This takes a very long time (~20 hours).

Changes which must be applied on top of the currently packaged machine are kept under:

    ./provision-prepackaged.sh

This file exists because uploading the box takes a very long time. Once the machine is stable again we will re-upload it.
