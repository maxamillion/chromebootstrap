#!/bin/bash

sudo apt update
sudo apt -y full-upgrade
sudo apt -y install \
    htop \
    tmux \
    tmuxinator \
    vim \
    vim-syntastic \
    vim-python-jedi \
    python \
    python-tox \
    python-pip \
    python3 \
    python3-pip \
    bpython \
    bpython3 \
    ipython \
    ipython3 \
    virtualenvwrapper \
    ruby \
    pry \
    golang \
    openssh-client \
    mosh \
    proot \
    strace \
    ltrace \
    iputils-tracepath \
    nmap \
    curl \
    wget \
    krb5-user \
    git

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

