if [ "$XDG_VTNR" = 1 ] && uwsm check may-start; then
  exec uwsm start -e -D dwl:wlroots -N dwl -- ~/.local/bin/start-dwl
fi
