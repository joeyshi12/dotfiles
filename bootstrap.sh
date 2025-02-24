#!/bin/bash
DOTFILES_DIR=~/.dotfiles
for file in .config/* .bash_profile .bashrc .bash_logout .vimrc; do
    rm -f "${HOME}/$file"
    ln -sfn "${DOTFILES_DIR}/${file}" "${HOME}/${file}"
done
