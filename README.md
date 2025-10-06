# dotfiles

Dotfiles for my Arch Linux system running dwm.

![Desktop preview](/assets/preview.webp)

## Getting started

1. Clone dotfiles into `~/.dotfiles`.
2. Install dependencies from `pkglist` with `pacman` and `pkglocallist` with `yay`.
    ```sh
    pacman -S - < pkglist
    yay -S --needed < pkglocallist
    ```
3. Run `./bootstrap.sh` to create dotfile links and install `dwm`.
