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
    ltrace \
    nmap \
    curl \
    wget \
    krb5-user \
    git \
    man-db \
    iputils-{arping,ping,tracepath} \
    virt-manager

pip install --user q
pip install --user pdbpp
pip install --user ptpython

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

