#!/bin/sh

# creates list of all installed packages
# reinstall with pacman -S $(cat pkglist)

# Export list of native packages
pacman -Qqen > ~/.dotfiles/pkglist

# Export list of foreign packages (includes AUR and locally installed)
pacman -Qqem > ~/.dotfiles/pkglocallist
