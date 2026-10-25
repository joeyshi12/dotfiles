# dotfiles

Dotfiles for my Arch Linux system running [dwl](https://codeberg.org/dwl/dwl), a Wayland compositor,
built from [my fork](https://github.com/joeyshi12/dwl).

![Desktop preview](/assets/preview.webp)

## Getting started

1. Verify that your system has `git`, `sudo`, and [`yay`](https://github.com/Jguer/yay?tab=readme-ov-file#installation) installed.
2. Clone the repository.
    ```sh
    git clone https://github.com/joeyshi12/dotfiles.git ~/.dotfiles
    ```
3. Install the dotfiles. This first installs core packages for the desktop
   and builds dwl in `~/.local/src/dwl`
    ```sh
    ~/.dotfiles/scripts/install.sh
    ```
4. Optionally, install the applications I use on top of it: Brave,
   Obsidian, KeePassXC, VLC, zathura, tldr and fastfetch.
    ```sh
    sudo pacman -S --needed - < ~/.dotfiles/extra_pkglist.txt
    yay -S --needed - < ~/.dotfiles/extra_aur_pkglist.txt
    ```
5. In `nwg-look`, choose the `adw-gtk3-dark` GTK theme, the `breeze-dark` icons and the `Adwaita`
   cursor at size 24 (all installed from `pkglist.txt`), then run `scripts/theme.sh` again: nwg-look
   links `~/.config/gtk-4.0/gtk.css` to adw-gtk3's, and theme.sh replaces that link. It writes the
   palette colours into `~/.config/gtk-3.0/gtk.css` and `~/.config/gtk-4.0/gtk.css`, which adw-gtk3
   and libadwaita apps read.

## Session

Logging in on TTY1 starts dwl through uwsm. The desktop shell is wakeshell, configured in
`.config/wakeshell`: the wallpaper, the bar, the launcher, notifications, the volume popup, the
power menu, the polkit password dialog and the screen-share picker. The lock screen is wakelock, a
separate program. The bar reads dwl's tags and window titles over dwl's ipc protocol. The power
menu, polkit dialog and lock screen show a blurred copy of the screen behind them.

The look borrows one thing from The Wind Waker's cel shading: windows and cards have a thick dark
outline and a hard shadow offset down and right. dwl draws the window shadows, which show around
floating windows.

In the bar, clicking a tag views it and right-clicking adds it to or removes it from the view.
Clicking the layout symbol switches to the previous layout, and right-clicking it to monocle.
Middle-clicking the title zooms the focused window, and middle-clicking the status opens a terminal.

| Key | Action |
|---|---|
| Alt+p | Launcher |
| Alt+Shift+Return | Terminal (ghostty) |
| Print | Screenshot a region in Flameshot; Ctrl+c copies it, Ctrl+s saves it to `~/Pictures/Screenshots` |
| Alt+Shift+l | Lock |
| Alt+Shift+q | Power menu (lock, log out, suspend, reboot, shut down) |

## Colours

The colour palette is defined once in `theme/palette.sh`. After editing it, run
`~/.dotfiles/scripts/theme.sh` to regenerate the colour files for ghostty, tmux,
swayimg, dwl (`colors.h` in `~/.local/src/dwl`; afterwards run `make && sudo make install` there),
the GTK 3 and 4 colours (the GTK 4 file also holds the `--wakenight-*` variables that wakeshell and
wakelock use), Flameshot's colours and save folder, and the WakeNight colour scheme for Qt (qt6ct) and KDE apps such as Dolphin.
The templates for those files are in `theme/templates`.
