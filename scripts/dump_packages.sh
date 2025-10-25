#!/bin/sh

# Creates list of all manually installed Arch Linux packages
pacman -Qqe > ${HOME}/.dotfiles/pkglist.txt
pacman -Qqm > ${HOME}/.dotfiles/aur_pkglist.txt
