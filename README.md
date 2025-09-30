# dotfiles

Dotfiles for my Arch Linux system running dwm.

![Desktop preview](/assets/preview.webp)

## Getting started

### Install dotfiles

1. Clone dotfiles into `~/.dotfiles`.
2. Run `./bootstrap.sh` to create soft links for dotfiles.
3. Install dependencies from `pkglist` with `pacman` and `pkglocallist` with `yay`.
    ```sh
    pacman -S - < pkglist
    yay -S --needed < pkglocallist
    ```

### Install dwm

1. Verify the commands section of `src/dwm/config.h` contains valid paths to shell scripts in the repo.
2. In `src/dwm`, run `sudo make install`.
3. Start dwm by running `startx`.
