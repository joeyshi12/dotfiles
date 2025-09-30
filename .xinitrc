systemctl --user import-environment DISPLAY
feh --no-fehbg \
    --bg-scale ~/.dotfiles/assets/wallpapers/tropic_island_night.jpg &
~/.dotfiles/scripts/dwmbar.sh &
exec dwm
