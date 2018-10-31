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
    virt-manager

pip install --user q
pip install --user pdbpp
pip install --user ptpython
pip install --user pipenv

################################################################################
# BEGIN DOCKER
#
# Setup docker, becuase $reasons
##
## Once docker goes stable with the fixes in, switch to using the official repo
## https://docs.docker.com/install/linux/docker-ce/debian/#install-using-the-repository
#sudo apt -y install \
#    apt-transport-https \
#    ca-certificates \
#    curl \
#    gnupg2 \
#    btrfs-progs \
#    software-properties-common
#curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#sudo add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
#sudo apt update
#sudo apt -y install docker-ce


# For now we have to install from this guide
#   https://www.reddit.com/r/Crostini/comments/9jabhq/docker_now_working/
sudo apt -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    btrfs-progs \
    software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) nightly"
sudo apt update
sudo apt -y install docker-ce
wget https://www.dropbox.com/s/332lj9d1zkp9t84/runc-chromeos?dl=1 -O /tmp/runc-chromeos
sudo mv /tmp/runc-chromeos /usr/local/sbin/
sudo chmod +x /usr/local/sbin/runc-chromeos
wget https://www.dropbox.com/s/us4zhl2v6rx3l08/daemon.json?dl=1 -O /tmp/daemon.json
sudo mv /tmp/daemon.json /etc/docker/
sudo service docker restart
docker run hello-world

# END DOCKER
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

