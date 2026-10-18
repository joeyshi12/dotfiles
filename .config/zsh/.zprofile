# Start dwl when logging in on TTY1, but not from shells inside the running session (e.g. tmux)
if [ "$XDG_VTNR" = 1 ] && [ -z "$WAYLAND_DISPLAY" ] && uwsm check may-start; then
  exec uwsm start -e -D dwl:wlroots -N dwl -- ~/.local/bin/start-dwl
fi
