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


# For now we have to install from source
sudo apt-get -y install golang libseccomp-dev
export GOPATH=~/go
go get github.com/opencontainers/runc
pushd ~/go/src/github.com/opencontainers/runc

    # fetch the unmerged PR with the fix
    git remote add tmp https://github.com/AkihiroSuda/runc.git
    git fetch tmp
    git merge tmp/decompose-rootless-pr

    # build & install!
    make
    sudo cp runc /usr/local/sbin/runc-chromeos
    sudo chmod +x /usr/local/sbin/runc-chromeos
    sudo service docker restart
    docker run hello-world
popd

# END DOCKER
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

