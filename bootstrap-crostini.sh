#!/bin/bash

sudo apt update
sudo apt -y full-upgrade
sudo apt -y install \
    apt-file \
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
    openssh-client \
    mosh \
    proot \
    strace \
    nmap \
    curl \
    wget \
    krb5-user \
    git \
    tig \
    man-db \
    iputils-{arping,ping,tracepath} \
    virt-manager \
    software-properties-common \
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

sudo apt-add-repository 'deb http://ftp.debian.org/debian stretch-backports main'
sudo apt update
sudo apt -t stretch-backports golang # need golang 1.10+
sudo apt install \
    libdevmapper-dev \
    libglib2.0-dev \
    libgpgme11-dev \
    libseccomp-dev \
    go-md2man \
    libprotobuf-dev \
    libprotobuf-c0-dev \
    libseccomp-dev \
    python3-setuptools

# Build/Install Common
export GOPATH=~/go
mkdir -p $GOPATH
git clone https://github.com/kubernetes-sigs/cri-o $GOPATH/src/github.com/kubernetes-sigs/cri-o
cd $GOPATH/src/github.com/kubernetes-sigs/cri-o
mkdir bin
make bin/conmon
sudo install -D -m 755 bin/conmon /usr/libexec/podman/conmon

# Config files
sudo mkdir -p /etc/containers
sudo curl https://raw.githubusercontent.com/projectatomic/registries/master/registries.fedora -o /etc/containers/registries.conf
sudo curl https://raw.githubusercontent.com/containers/skopeo/master/default-policy.json -o /etc/containers/policy.json

# CNI plugins
git clone https://github.com/containernetworking/plugins.git $GOPATH/src/github.com/containernetworking/plugins
cd $GOPATH/src/github.com/containernetworking/plugins
./build_linux.sh
sudo mkdir -p /usr/libexec/cni
sudo cp bin/* /usr/libexec/cni

# runc
git clone https://github.com/opencontainers/runc.git $GOPATH/src/github.com/opencontainers/runc
cd $GOPATH/src/github.com/opencontainers/runc
make BUILDTAGS="seccomp"
sudo cp runc /usr/bin/runc

# podman
git clone https://github.com/containers/libpod/ $GOPATH/src/github.com/containers/libpod
cd $GOPATH/src/github.com/containers/libpod
make
sudo make install PREFIX=/usr


# END PODMAN
################################################################################

################################################################################
# START KEYBASE

curl -O https://prerelease.keybase.io/keybase_amd64.deb
# if you see an error about missing `libappindicator1`
# from the next command, you can ignore it, as the
# subsequent command corrects it
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f
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

