#!/usr/bin/env bash
set -euv

# Only for 32 bit machines: compile TRALICS from source because Linux only has a 64 bit precompiled one.
# Waiting for the Softcover Team to decide what should be done about it at: <https://github.com/softcover/polytexnic/issues/100>
#cd /tmp
#git clone https://github.com/mhartl/tralics
#cd tralics/src
#make
#cp -bS ".bak" tralics ~/.rvm/gems/ruby-2.1.1/gems/polytexnic-0.9.2/precompiled_binaries/tralics-linux
#cd ../..
#rm -rf tralics
