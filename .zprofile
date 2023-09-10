export PATH="${HOME}/.local/bin:${PATH}"

export VISUAL="nvim"
export EDITOR="${VISUAL}"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"

export SSB_HOME="${XDG_DATA_HOME}"
export NVM_DIR="${XDG_DATA_HOME}/nvm"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"

export BAT_THEME="Catppuccin-mocha"
export _JAVA_AWT_WM_NONREPARENTING=1 # Fix for Java applications in dwm
