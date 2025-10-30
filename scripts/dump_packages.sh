#!/bin/sh

# Creates list of all manually installed Arch Linux packages
pacman -Qqen > ${HOME}/.dotfiles/pkglist.txt
pacman -Qqem > ${HOME}/.dotfiles/aur_pkglist.txt
