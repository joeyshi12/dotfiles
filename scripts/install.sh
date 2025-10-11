#!/bin/sh
set -eu

DOTFILES_DIR="${HOME}/.dotfiles"
REPO_DIR="${HOME}/.local/src"
TMUX_PLUGINS_DIR="${DOTFILES_DIR}/.config/tmux/plugins"

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

build_source() {
    local target="$1"
    if ! make -C "${target}"; then
        echo "Error: failed to build ${target}" >&2
        exit 1
    fi
    echo "Built ${target}"
}

require_cmd git
require_cmd make

clone_repo "https://github.com/joeyshi12/dotfiles.git" "${DOTFILES_DIR}"
clone_repo "https://github.com/tmux-plugins/tpm.git" "${TMUX_PLUGINS_DIR}/tpm"
clone_repo "https://github.com/joeyshi12/dwm.git" "${REPO_DIR}/dwm"
clone_repo "https://github.com/joeyshi12/dwmstatus.git" "${REPO_DIR}/dwmstatus"

build_source "${REPO_DIR}/dwm"
build_source "${REPO_DIR}/dwmstatus"

mkdir -p "${HOME}/.config" "${REPO_DIR}" "${TMUX_PLUGINS_DIR}"

# Create softlinks
pushd "${DOTFILES_DIR}"
for file in .config/* .xinitrc .zprofile .zshrc; do
    ln -sfn "${DOTFILES_DIR}/${file}" "${HOME}/${file}"
    echo "Linked ${HOME}/${file}"
done
popd
echo "Finished bootstrapping dotfiles"
