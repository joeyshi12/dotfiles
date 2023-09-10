#!/bin/sh

DOTFILES_DIR="${HOME}/.dotfiles"

# Create links
[ ! -d "${HOME}/.config" ] && mkdir -p "${HOME}/.config"
[ ! -d "${HOME}/.local/bin" ] && mkdir -p "${HOME}/.local/bin"

for file in .config/* .local/bin/* .zprofile .zshrc .xinitrc; do
    rm -f "${HOME}/$file"
    ln -sfn "${DOTFILES_DIR}/${file}" "${HOME}/${file}"
done
