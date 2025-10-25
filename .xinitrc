systemctl --user import-environment DISPLAY
feh --no-fehbg --bg-scale ~/.dotfiles/assets/wallpapers/tropic_island_night.png &
picom --config ~/.config/picom/picom.conf &
~/.local/src/dwmstatus/dwmstatus &
exec ~/.local/src/dwm/dwm
