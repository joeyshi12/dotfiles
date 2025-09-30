#!/bin/sh

DOTFILES_DIR="${HOME}/.dotfiles"
[ ! -d "${HOME}/.config" ] && mkdir -p "${HOME}/.config"

# Create links
for file in .config/* .xinitrc .zprofile .zshrc; do
    rm -f "${HOME}/$file"
    ln -sfn "${DOTFILES_DIR}/${file}" "${HOME}/${file}"
done
