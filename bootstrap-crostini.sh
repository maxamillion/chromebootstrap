#!/bin/bash

sudo apt update
sudo apt -y full-upgrade
sudo apt -y install \
    apt-file \
    file \
    htop \
    tmux \
    tmuxinator \
    vim \
    vim-syntastic \
    vim-python-jedi \
    python \
    python-pip \
    python3 \
    python3-pip \
    bpython \
    bpython3 \
    ipython \
    ipython3 \
    pyflakes \
    pyflakes3 \
    pylint \
    pylint3 \
    pep8 \
    tox \
    virtualenvwrapper \
    ruby \
    pry \
    golang \
    autoconf \
    make \
    gcc \
    openssh-client \
    mosh \
    proot \
    strace \
    nmap \
    dnsutils \
    curl \
    httpie \
    wget \
    krb5-user \
    git \
    tig \
    man-db \
    iputils-{arping,ping,tracepath} \
    virt-manager \
    software-properties-common \
    mitmproxy \
    pastebinit \
    firefox-esr # for science

pip install --user q
pip install --user pdbpp
pip install --user ptpython
pip install --user pipenv
pip install --user molecule

################################################################################
# BEGIN PODMAN
#
#
# https://github.com/containers/libpod/blob/master/docs/tutorials/podman_tutorial.md#install-podman-on-ubuntu

# FIXME: Have to build from source, currently this is in debian testing and sid
#        but not yet in the version of debian crostini is using
export GOPATH=~/go
mkdir -p $GOPATH
git clone https://github.com/rootless-containers/slirp4netns $GOPATH/src/github.com/rootless-containers/slirp4netns
pushd $GOPATH/src/github.com/rootless-containers/slirp4netns
    ./autogen.sh
    ./configure --prefix=/usr
    make
    sudo make install
popd

# FIXME: This is a bit of a hack for now, hopefully this will land in debian
#        repos later or Fedora will become available in crostini
cat > /etc/apt/sources.list.d/podman.list <<EOF
deb http://ppa.launchpad.net/projectatomic/ppa/ubuntu bionic main
EOF
sudo apt-key adv --recv-key --keyserver keyserver.ubuntu.com 0x018ba5ad9df57a4448f0e6cf8becf1637ad8c79d
sudo apt update
sudo apt -y install podman

# END PODMAN
################################################################################

################################################################################
# START KEYBASE

curl -O https://prerelease.keybase.io/keybase_amd64.deb
# if you see an error about missing `libappindicator1`
# from the next command, you can ignore it, as the
# subsequent command corrects it
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f -y
#run_keybase

# END KEYBASE
################################################################################

# Setup my dotfiles
cd ~/
git clone https://github.com/maxamillion/dotfiles

# Nuke old dirs and resetup (this is apparently needed because Termux does
# something weird)
#
rm -fr ~/.config/{dunst,i3,i3status,fontconfig}
rm -fr ~/.config/fontconfig/conf.d
rm -fr ~/.tmuxinator
rm -fr ~/.ptpython
rm -fr ~/.fonts
rm -fr ~/.vim*
rm -fr ~/vimified
rm -fr ~/.bashrc

# bootstrap dotfiles
bash ~/dotfiles/bootstrap.sh

cd ~/

# bootstrap vim
bash ~/dotfiles/bootstrap-vim.sh

cd ~/

