# dotfiles

Dotfiles for my Arch Linux system running dwm.

![Desktop preview](/assets/preview.webp)

## Getting started

1. Verify that your system has `git` and `make` installed.
2. Install dotfiles with
    ```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/joeyshi12/dotfiles/refs/heads/main/scripts/install.sh)"
    ```
3. Install packages with
    ```sh
    pacman -S - < ~/.dotfiles/pkglist
    yay -S --needed < ~/.dotfiles/pkglocallist
    ```
4. Download themes and icons to `~/.local/share/themes` and `~/.local/share/icons` respectively
    - Theme: https://www.gnome-look.org/p/1318133
    - Icons: https://www.gnome-look.org/p/1333828
