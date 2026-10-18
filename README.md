# dotfiles

Dotfiles for my Arch Linux system running [dwl](https://codeberg.org/dwl/dwl), a Wayland compositor,
built from [dwl-wake-patches](https://github.com/joeyshi12/dwl-wake-patches).

![Desktop preview](/assets/preview.webp)

## Getting started

1. Verify that your system has `git`, `sudo`, and [`yay`](https://github.com/Jguer/yay?tab=readme-ov-file#installation) installed.
2. Clone the repository.
    ```sh
    git clone https://github.com/joeyshi12/dotfiles.git ~/.dotfiles
    ```
3. Install the dotfiles. This first installs the packages the desktop needs from `pkglist.txt` and
   `aur_pkglist.txt`, then builds dwl and wakebar.
    ```sh
    ~/.dotfiles/scripts/install.sh
    ```
4. Optionally, install the applications I use on top of it: Brave,
   Obsidian, KeePassXC, VLC, zathura, tldr and fastfetch.
    ```sh
    sudo pacman -S --needed - < ~/.dotfiles/extra_pkglist.txt
    yay -S --needed - < ~/.dotfiles/extra_aur_pkglist.txt
    ```
5. Unpack any custom themes and icons to `~/.local/share/themes` and `~/.local/share/icons` respectively
    - Theme: https://www.gnome-look.org/p/1318133
    - Icons: [breeze-icons](https://archlinux.org/packages/extra/x86_64/breeze-icons/)
        - Should already be installed from `pkglist`.
6. Apply themes and icons with `nwg-look`.

## Session

Logging in on TTY1 starts dwl through uwsm. The bar is
[wakebar](https://github.com/joeyshi12/wakebar).

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
swaylock, swayimg, dwl and wakebar (`colors.h` in `~/.local/src/dwl-wake-patches` and
`~/.local/src/wakebar`; afterwards run `makepkg -si` in the first and `make` in the second),
and the WakeNight colour scheme for Qt (qt6ct) and KDE apps such as Dolphin.
The templates for those files are in `theme/templates`.
