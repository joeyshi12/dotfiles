#!/bin/bash
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
REPO_DIR="${HOME}/.local/src"

require_cmd() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Error: $1 is not installed." >&2
        exit 1
    fi
}

is_git_repo() {
    git -C "$1" rev-parse --git-dir >/dev/null 2>&1
}

clone_repo() {
    local repo="$1"
    local target="$2"
    if is_git_repo "${target}"; then
        echo "Skipped: ${target} already exists"
        return 0
    fi
    if ! git clone "${repo}" "${target}"; then
        echo "Error: failed to clone ${repo}" >&2
        exit 1
    fi
    echo "Cloned ${repo} -> ${target}"
}

# Prints the package names in a package list, skipping blank lines and comments
read_pkglist() {
    sed -e 's/#.*//' -e 's/[[:space:]]//g' -e '/^$/d' "$1"
}

install_packages() {
    local pkgs aur_pkgs
    mapfile -t pkgs < <(read_pkglist "${DOTFILES_DIR}/pkglist.txt")
    mapfile -t aur_pkgs < <(read_pkglist "${DOTFILES_DIR}/aur_pkglist.txt")
    if ! sudo pacman -S --needed "${pkgs[@]}"; then
        echo "Error: failed to install the packages in pkglist.txt" >&2
        exit 1
    fi
    if [ "${#aur_pkgs[@]}" -gt 0 ] && ! yay -S --needed "${aur_pkgs[@]}"; then
        echo "Error: failed to install the packages in aur_pkglist.txt" >&2
        exit 1
    fi
    echo "Installed the packages in pkglist.txt and aur_pkglist.txt"
}

build_source() {
    local target="$1"
    if ! make -C "${target}"; then
        echo "Error: failed to build ${target}" >&2
        exit 1
    fi
    echo "Built ${target}"
}

require_cmd git
require_cmd sudo
require_cmd pacman
require_cmd yay

mkdir -p "${HOME}/.config" "${HOME}/.local/bin" "${HOME}/.local/share"
clone_repo "https://github.com/joeyshi12/dotfiles.git" "${DOTFILES_DIR}"

# The desktop's hard dependencies, including base-devel for make and makepkg
install_packages
require_cmd make
require_cmd makepkg

clone_repo "https://github.com/tmux-plugins/tpm.git" "${DOTFILES_DIR}/.config/tmux/plugins/tpm"
clone_repo "https://github.com/joeyshi12/nvim.git" "${HOME}/.config/nvim"
clone_repo "https://github.com/joeyshi12/dwl-wake-patches.git" "${REPO_DIR}/dwl-wake-patches"
clone_repo "https://github.com/joeyshi12/wakebar.git" "${REPO_DIR}/wakebar"

"${DOTFILES_DIR}/scripts/theme.sh"

# dwl is built as the dwl-wake package so pacman tracks it and keeps wlroots0.20 installed
(cd "${REPO_DIR}/dwl-wake-patches" && makepkg -si --needed --noconfirm)
build_source "${REPO_DIR}/wakebar"

# Create softlinks
pushd "${DOTFILES_DIR}"
for file in .config/* .zshenv; do
    ln -sfn "${DOTFILES_DIR}/${file}" "${HOME}/${file}"
    echo "Linked ${HOME}/${file}"
done
for file in .local/bin/* .local/share/*; do
    ln -sfn "${DOTFILES_DIR}/${file}" "${HOME}/${file}"
    echo "Linked ${HOME}/${file}"
done
popd
echo "Finished installing dotfiles"
