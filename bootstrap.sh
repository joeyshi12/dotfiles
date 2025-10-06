#!/bin/sh
set -eu

DOTFILES_DIR="${HOME}/.dotfiles"
REPO_DIR="${HOME}/.local/src"
BASE_GIT_URL="https://github.com/joeyshi12"
#BASE_GIT_URL="git@github.com:joeyshi12"

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
    local target="${REPO_DIR}/${package}"
    if is_git_repo "${target}"; then
        echo "Skipped: ${target} already exists"
    else
        git clone "${BASE_GIT_URL}/${package}.git" "${target}"
        if ! make -C "${target}" >/dev/null; then
            echo "Error: failed to build ${target}" >&2
            exit 1
        fi
        echo "Finished building ${target}"
    fi
}

clone_and_build "dwm"
clone_and_build "dwmstatus"

echo "Finished bootstrapping dotfiles"
