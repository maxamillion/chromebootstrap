#!/data/data/com.termux/files/usr/bin/bash

apt update
apt -y install vim-python python python2 ruby clang golang git htop fontconfig fontconfig-util tmux openssh proot strace ltrace tracepath nmap

termux-storage-setup

cd ~/
git clone https://github.com/maxamillion/dotfiles

# Ensure the needed dirs exist
mkdir -p ~/.config/{dunst,i3,i3status,fontconfig}
mkdir -p ~/.config/fontconfig/conf.d
mkdir ~/.tmuxinator
mkdir ~/.ptpython
mkdir ~/.fonts

# Symlink the conf files
ln -s ~/dotfiles/dunstrc ~/.config/dunst/dunstrc
ln -s ~/dotfiles/i3-config ~/.config/i3/config
ln -s ~/dotfiles/i3status-config ~/.config/i3status/config
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmuxinator-wm.yml ~/.tmuxinator/wm.yml
ln -s ~/dotfiles/screenrc ~/.screenrc
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/inputrc ~/.inputrc
ln -s ~/dotfiles/ptpython_config.py ~/.ptpython/config.py
ln -s ~/dotfiles/bashrc ~/.bashrc

cd ~/

git clone git://github.com/zaiste/vimified.git
ln -sfn vimified/ ~/.vim
ln -sfn vimified/vimrc ~/.vimrc
cd ~/vimified
mkdir bundle
mkdir -p tmp/backup tmp/swap tmp/undo
git clone https://github.com/gmarik/vundle.git bundle/vundle
ln -s ~/dotfiles/local.vimrc ~/vimified/local.vimrc
ln -s ~/dotfiles/after.vimrc ~/vimified/after.vimrc
vim +BundleInstall +qall

cd ~/

fontdir=$(mktemp -d)
pushd $fontdir
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts/
mkdir -p ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
popd

rm -fr ${fontdir}
