feh --no-fehbg \
    --bg-scale ~/.dotfiles/assets/wallpapers/tropic_island_night.jpg &
picom --experimental-backends --config ~/.config/picom/picom.conf &
~/.local/src/dwmstatus/dwmstatus &
exec ~/.local/src/dwm/dwm
