#!/data/data/com.termux/files/usr/bin/bash

apt update
apt -y install vim-python python python2 ruby clang golang git htop fontconfig fontconfig-utils tmux openssh mosh proot strace ltrace tracepath nmap

pip install virtualenv
pip install ptpython
pip install httpie

termux-storage-setup

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

bash ~/dotfiles/bootstrap.sh

cd ~/

bash ~/dotfiles/bootstrap-vim.sh

cd ~/

