#!/data/data/com.termux/files/usr/bin/bash

termux-chroot

username=$(whoami)
ipaddr=$(ifconfig arc0 | awk '/inet /{print $2}')

printf "Login: ${username}@${ipaddr}"

sshd
