# TTY1 starts the Wayland session (dwl managed by uwsm), TTY2 the X session (dwm).
if [ "$XDG_VTNR" = 1 ] && uwsm check may-start; then
  exec uwsm start -e -D dwl:wlroots -N dwl -- ~/.local/bin/start-dwl
elif [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 2 ]; then
  exec startx
fi
