alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias v="$EDITOR"
alias sv="sudo -E $EDITOR"
alias m="neomutt"
alias copy="xclip -sel c"
alias diff="diff --color"

# Pacman
alias pacs="sudo pacman -S"
alias pacss="pacman -Ss"
alias pacqs="pacman -Qs"
alias pacsyu="sudo pacman -Syu"
alias pacrsn="sudo pacman -Rsn"
alias pacsc="sudo pacman -Sc"

# Git
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias grm="git rm --cached"
alias gb="git branch"
alias gc="git commit -vm"
alias gca="git commit -vam"
alias gcl="git clone --recurse-submodules"
alias gl="git pull"
alias gup="git pull --rebase"
alias gp="git push"
alias gf="git fetch"
alias gco="git checkout"
alias gst="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias glg="git log --graph"
alias gr="git remote"

# Docker
alias dc='docker-compose'
alias dim='docker image'
alias drmi='docker rmi'
alias dps='docker ps'
alias db='docker build'
alias dr='docker run'
alias dst='docker stop'
alias drm='docker rm'
alias da='docker attach'
alias dlg='docker logs'
alias dv='docker volume'

# Tmux
alias tm="tmux"
alias tma="tmux attach-session"
alias tml="tmux list-sessions"
alias tmk="tmux kill-session"

# Compiles and executes C file and removes binary
# $1 path to the C file
crun() {
    gcc "$1" && ./a.out "${@:2}" && rm a.out
}

# lf with ueberzug image preview
lf() {
    [ ! -d "${XDG_CACHE_HOME}/lf" ] && mkdir -p "${XDG_CACHE_HOME}/lf"
    local target="${XDG_CACHE_HOME}/lf/lfdir"
    /bin/lf -last-dir-path $target
    cd "$(cat $target)"
}
