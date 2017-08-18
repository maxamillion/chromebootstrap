#!/data/data/com.termux/files/usr/bin/bash

termux-chroot

mkdir -p /storage/emulated/0/Download/devbox/ssh
ln -s /storage/emulated/0/Download/devbox /home/devbox
ssh-keygen -t rsa -b 4096 -C "maxamillion@fedoraproject.org"

cat ~/devbox/ssh/id_rsa.pub >> ~/.ssh/authorized_keys

username=$(whoami)
ipaddr=$(ifconfig arc0 | awk '/inet /{print $2}')

printf "Login: ${username}@${ipaddr}"
