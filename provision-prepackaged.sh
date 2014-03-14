#!/usr/bin/env bash
set -euv

# Steps which have to be done on the prepackaged box.
# Those steps are not in `provision.sh` either because:
#
# - they are still being tested
# - we are waiting to have more steps before packaging, since it is a time consuming process

# Compile TRALICS from source because the precompiled one fails, and place it in the precompiled_binaries folder.
# Waiting for Softcover team to decide what should be done about it at: https://github.com/softcover/polytexnic/issues/100
cd /tmp
git clone https://github.com/mhartl/tralics
cd tralics/src
make
cp -bS ".bak" tralics ~/.rvm/gems/ruby-2.1.1/gems/polytexnic-0.9.2/precompiled_binaries/tralics-linux
cd ../..
rm -rf tralics
