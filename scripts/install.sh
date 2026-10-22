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

require_cmd git
require_cmd sudo
require_cmd pacman
require_cmd yay

mkdir -p "${HOME}/.config" "${HOME}/.local/bin" "${HOME}/.local/share"
clone_repo "https://github.com/joeyshi12/dotfiles.git" "${DOTFILES_DIR}"

# The desktop's hard dependencies, including base-devel for make and rust for cargo
install_packages
require_cmd make
require_cmd cargo

clone_repo "https://github.com/joeyshi12/nvim.git" "${HOME}/.config/nvim"
clone_repo "https://github.com/joeyshi12/dwl.git" "${REPO_DIR}/dwl"

"${DOTFILES_DIR}/scripts/theme.sh"

if ! make -C "${REPO_DIR}/dwl" || ! sudo make -C "${REPO_DIR}/dwl" install; then
    echo "Error: failed to install ${REPO_DIR}/dwl" >&2
    exit 1
fi

# The desktop shell and the lock screen, installed to ~/.cargo/bin
for repo in wakeshell wakelock; do
    if ! cargo install --locked --git "https://github.com/joeyshi12/${repo}"; then
        echo "Error: failed to install ${repo}" >&2
        exit 1
    fi
done

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

# wakeshell runs as a user service that starts with the graphical session
mkdir -p "${HOME}/.config/systemd/user"
ln -sfn "${DOTFILES_DIR}/systemd/wakeshell.service" "${HOME}/.config/systemd/user/wakeshell.service"
systemctl --user daemon-reload
systemctl --user enable wakeshell.service
echo "Finished installing dotfiles"
