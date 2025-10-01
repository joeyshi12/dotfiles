#!/bin/bash
#
# Usage:
# ./volume.sh up
# ./volume.sh down
# ./volume.sh mute

function send_notification {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | head -n1 | awk '{ print $2 }')
    width=$(bc <<< "$volume * 20 + 0.5" | cut -d "." -f1)
    progress=$(seq -s "=" 0 $width | sed 's/[0-9]//g')
    bar=$(printf '[%-20s]' $progress)
    dunstify -I ~/.dotfiles/assets/icons/audio-speakers.svg -t 1600 -r 2593 -u normal "$bar"
}

case $1 in
    up)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1
        send_notification
        ;;
    down)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        send_notification
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "\[MUTED\]"; then
            dunstify -I ~/.dotfiles/assets/icons/audio-speakers.svg -t 1600 -r 2593 -u normal "Muted"
        else
            send_notification
        fi
        ;;
esac

