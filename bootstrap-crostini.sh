#!/bin/bash

sudo apt update
sudo apt -y upgrade
sudo apt -y install \
    fontconfig \
    fontconfig-utils \
    htop \
    tmux \
    vim \
    vim-syntastic \
    vim-python-jedi \
    vim-python \
    python \
    python-tox \
    python-pip \
    python3 \
    python3-pip \
    bpython \
    bpython3 \
    ipython \
    ipython3 \
    ruby \
    pry \
    golang \
    openssh \
    mosh \
    proot \
    strace \
    ltrace \
    tracepath \
    nmap \
    curl \
    wget \
    mkvirtualenv \
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

# bootstrap dotfiles
bash ~/dotfiles/bootstrap.sh

cd ~/

# bootstrap vim
bash ~/dotfiles/bootstrap-vim.sh

cd ~/

