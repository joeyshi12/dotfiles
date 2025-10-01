#!/bin/sh

cpu() {
    cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)
    printf "  CPU  $cpu_val  "
}

mem() {
    printf "     $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)  "
}

wlan() {
    network=$(nmcli -t -f NAME,TYPE connection show --active | head -n1 | cut -d ':' -f1)
    if [ -z "$network" ]; then
        printf "  󰤭  Disconnected  "
    else
        printf "  󰤨  $network  "
    fi
}

clock() {
    printf "  󱑆  $(date "+%a %b %d %I:%M %p")  "
}

while true; do
    sleep 1 && xsetroot -name "$(cpu) $(mem) $(wlan) $(clock)"
done

