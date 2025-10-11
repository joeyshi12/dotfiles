# dotfiles

Dotfiles for my Arch Linux system running dwm.

![Desktop preview](/assets/preview.webp)

## Getting started

1. Verify that your system has `git` and `make` installed.
2. Install dotfiles with
    ```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/joeyshi12/dotfiles/refs/heads/main/scripts/install.sh)"
    ```
3. Install package dependencies with
    ```sh
    pacman -S - < pkglist
    yay -S --needed < pkglocallist
    ```
