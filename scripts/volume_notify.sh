#!/bin/sh
#
# Usage:
# ./volume.sh up
# ./volume.sh down
# ./volume.sh mute

send_notification() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | head -n1 | awk '{ print $2 }')
    width=$(bc <<< "$volume * 20 + 0.5" | cut -d "." -f1)
    progress=$(seq -s "=" 0 $width | sed 's/[0-9]//g')
    bar=$(printf '[%-20s]' $progress)
    dunstify -I ~/.dotfiles/assets/icons/audio-speakers.svg -t 1600 -r 2593 -u low "$bar"
}

case $1 in
    up)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 2>/dev/null
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1 2>/dev/null
        send_notification
        ;;
    down)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 2>/dev/null
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- 2>/dev/null
        send_notification
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle 2>/dev/null
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -q "\[MUTED\]"; then
            dunstify -I ~/.dotfiles/assets/icons/audio-speakers.svg -t 1600 -r 2593 -u normal "Muted"
        else
            send_notification
        fi
        ;;
esac

