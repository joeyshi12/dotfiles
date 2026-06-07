systemctl --user import-environment DISPLAY

xrdb -merge ~/.Xresources
xrandr --output DisplayPort-1 --mode 2560x1440 --rate 165

feh --no-fehbg \
    --bg-scale ~/.dotfiles/assets/wallpapers/tropic_island_night.png &

picom --config ~/.config/picom/picom.conf &
~/.local/src/dwmstatus/dwmstatus &
exec ~/.local/src/dwm/dwm
