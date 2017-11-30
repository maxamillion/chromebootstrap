#!/data/data/com.termux/files/usr/bin/bash

apt update
apt -y install bash-completion vim-python python python2 ruby clang golang git htop fontconfig fontconfig-utils tmux openssh mosh proot strace ltrace tracepath nmap termux-api termux-tools curl python2-dev python-dev libgmp libgmp-dev make libev-dev c-ares-dev libffi libffi-dev openssl openssl-dev openssl-tool man dnsutils

termux-setup-storage

pip install virtualenv
pip install ptpython
pip install httpie

# Unfortunately, ChromeOS Android App support doesn't support sem_open which
# means that ansible doesn't work from Termux
#   https://github.com/termux/termux-packages/issues/570
# Uncomment this stuff if/when that changes
#pip install PyYAML
#pip install jinja2
#CONFIG_SHELL=$PREFIX/bin/sh pip install pycrypto
#EMBED=0 pip install gevent
#pip install bcrypt
#pip install paramiko
#pip install ansible

gem install tmuxinator

# Setup termux specific bashrc stuff (imported into ~/.bashrc by dotfiles)
ln -s ~/chromebootstrap/bashrc_termux ~/.bashrc_termux

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

