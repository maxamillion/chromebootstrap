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
    python3-setuptools \
    uidmap

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
