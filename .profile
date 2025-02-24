export VISUAL="nvim"
export EDITOR="${VISUAL}"

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html#introduction
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node_repl_history"
export MARIADB_HISTFILE="${XDG_STATE_HOME}/mariadb_history"

export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
export GOPATH=$HOME/go

export PATH="${HOME}/.local/bin:$GOPATH/bin:${PATH}"
