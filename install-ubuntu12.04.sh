#!/usr/bin/env bash

# Install Softcover and all its dependencies on a clean Ubuntu 12.04.
# **DO NOT USE** on a non-clean Ubuntu 12.04: may not work or misconfigure your machine.
# The installation must:
#
# - pass all unit tests
# - correctly compile the softcover_book and the `softcover new` project template.

set -euv

sudo apt-get update
sudo apt-get install -y calibre curl git imagemagick inkscape libcurl3-dev maven openjdk-7-jre phantomjs zip

# TeX Live 2013.
# 2009 is not enough because of missing .stys for the softcover_book.
cd /vagrant
if [ ! -f texlive2013.iso ]; then
  wget texlive2013.iso http://mirrors.linsrv.net/tex-archive/systems/texlive/Images/texlive2013.iso
fi
sudo mkdir -p /media/texlive2013
sudo mount -t iso9660 -o ro,loop,noauto texlive2013.iso /media/texlive2013
echo i | sudo /media/texlive2013/install-tl
sudo umount /media/texlive2013
sudo rmdir /media/texlive2013
# If you are done with it for good:
#rm texlive2013.iso
echo '
# Texlive
export PATH=$PATH:/usr/local/texlive/2013/bin/'"$(uname -i)"'-linux
export MANPATH=$MANPATH:/usr/local/texlive/2013/texmf-dist/doc/man
export INFOPATH=$INFOPATH:/usr/local/texlive/2013/texmf-dist/doc/info
' >> ~/.profile
source ~/.profile

# Epubcheck
cd
wget https://github.com/IDPF/epubcheck/releases/download/v3.0/epubcheck-3.0.zip
unzip epubcheck-3.0.zip
rm epubcheck-3.0.zip

# KindleGen
cd /tmp
mkdir kindlegen
cd kindlegen
wget http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz
tar xzf kindlegen_linux_2.6_i386_v2_9.tar.gz
sudo mv kindlegen /usr/local/bin
cd ..
rm -rf kindlegen

# Nodejs. Requires git.
VERSION="0.10.26"
curl https://raw.github.com/creationix/nvm/master/install.sh | sh
source ~/.nvm/nvm.sh
echo "source ~/.nvm/nvm.sh
nvm use "$VERSION" &>/dev/null
" >> ~/.bashrc
nvm install "$VERSION"

# Ruby
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.1.1

gem install softcover

echo '
# Added by Softcover
cd /vagrant/projects' >> ~/.bashrc
