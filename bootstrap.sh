#!/bin/sh
set -eu

DOTFILES_DIR="${HOME}/.dotfiles"
REPO_DIR="${HOME}/.local/src"
BASE_GIT_URL="git@github.com:joeyshi12"

require_cmd() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Error: $1 is not installed." >&2
        exit 1
    fi
}

require_cmd git
require_cmd make

is_git_repo() {
    git -C "$1" rev-parse --git-dir >/dev/null 2>&1
}

mkdir -p "${HOME}/.config" "${REPO_DIR}"

# Create links
for file in .config/* .xinitrc .zprofile .zshrc; do
    ln -sfn "${DOTFILES_DIR}/${file}" "${HOME}/${file}"
    echo "Linked ${HOME}/${file}"
done

clone_and_build() {
    local package="$1"
    if is_git_repo "${REPO_DIR}/${package}"; then
        echo "Skipped: ${REPO_DIR}/${package} already exists"
    else
        git clone "${BASE_GIT_URL}/${package}" "${REPO_DIR}/${package}"
        if ! make -C "${target}" >/dev/null; then
            echo "Error: failed to build ${package}" >&2
            exit 1
        fi
        echo "Finished building ${package}"
    fi
}

clone_and_build "dwm"
clone_and_build "dwmstatus"

echo "Finished bootstrapping dotfiles"
