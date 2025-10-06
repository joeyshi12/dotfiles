systemctl --user import-environment DISPLAY
feh --no-fehbg \
    --bg-scale ~/.dotfiles/assets/wallpapers/tropic_island_night.jpg &
~/.local/src/dwmstatus/dwmstatus &
exec ~/.local/src/dwm/dwm
