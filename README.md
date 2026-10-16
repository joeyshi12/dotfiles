# dotfiles

Dotfiles for my Arch Linux system running [dwl](https://github.com/joeyshi12/dwl), a Wayland compositor.

![Desktop preview](/assets/preview.webp)

## Getting started

1. Verify that your system has `git`, `make`, and [`yay`](https://github.com/Jguer/yay?tab=readme-ov-file#installation) installed.
2. Clone the repository.
    ```sh
    git clone https://github.com/joeyshi12/dotfiles.git ~/.dotfiles
    ```
3. Install the packages the desktop needs.
    ```sh
    sudo pacman -S --needed - < ~/.dotfiles/pkglist.txt
    yay -S --needed - < ~/.dotfiles/aur_pkglist.txt
    ```
    Optionally, install the applications I use on top of it: Brave, Vesktop (Discord), OBS,
    Obsidian, KeePassXC, VLC, zathura, bat, tldr and fastfetch.
    ```sh
    sudo pacman -S --needed - < ~/.dotfiles/extra_pkglist.txt
    yay -S --needed - < ~/.dotfiles/extra_aur_pkglist.txt
    ```
4. Install the dotfiles.
    ```sh
    ~/.dotfiles/scripts/install.sh
    ```
5. Unpack any custom themes and icons to `~/.local/share/themes` and `~/.local/share/icons` respectively
    - Theme: https://www.gnome-look.org/p/1318133
    - Icons: [breeze-icons](https://archlinux.org/packages/extra/x86_64/breeze-icons/)
        - Should already be installed from `pkglist`.
6. Apply themes and icons with `nwg-look`.

## Session

Logging in on TTY1 starts dwl through uwsm. The status bar text comes from
[dwmstatus](https://github.com/joeyshi12/dwmstatus).

| Key | Action |
|---|---|
| Alt+p | Launcher (rofi) |
| Alt+Shift+Return | Terminal (ghostty) |
| Print | Screenshot a region; Ctrl+c in satty copies it, Ctrl+s saves it to `~/Pictures/Screenshots` |
| Alt+Shift+l | Lock |
| Alt+Shift+q | Power menu (lock, log out, suspend, reboot, shut down) |

In swayimg, Ctrl+c copies the image, Ctrl+w sets it as the wallpaper, Ctrl+comma, Ctrl+period and
Ctrl+slash rotate the file on disk, and Shift+Delete deletes the file.

## Colours

The colour palette is defined once in `theme/palette.sh`. After editing it, run
`~/.dotfiles/scripts/theme.sh` to regenerate the colour files for rofi, dunst, ghostty, tmux,
swaylock, swayimg and dwl (`~/.local/src/dwl/colors.h`; rebuild dwl afterwards). The templates for those files are in `theme/templates`.
