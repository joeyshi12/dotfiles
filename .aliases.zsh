alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias v="$EDITOR"
alias sv="sudo -E $EDITOR"
alias copy="xclip -sel c"
alias diff="diff --color"
alias open="xdg-open"
alias ff="fastfetch"

# Pacman
alias pacs="sudo pacman --color=auto -S"
alias pacss="pacman --color=auto -Ss"
alias pacqs="pacman --color=auto -Qs"
alias pacqe="pacman --color=auto -Qe"
alias pacsyu="sudo pacman --color=auto -Syu"
alias pacrsn="sudo pacman --color=auto -Rsn"
alias pacsc="sudo pacman --color=auto -Sc"

# yay
alias yays="yay --color=auto -S"
alias yayss="yay --color=auto -Ss"
alias yayqs="yay --color=auto -Qs"
alias yayqe="yay --color=auto -Qe"
alias yaysyu="yay --color=auto -Syu"
alias yayrsn="yay --color=auto -Rsn"
alias yaysc="yay --color=auto -Sc"

# Git
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias grm="git rm --cached"
alias gb="git branch"
alias gc="git commit -vm"
alias gca="git commit -vam"
alias gcl="git clone --recurse-submodules"
alias gm="git merge"
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

# lf with ueberzug image preview
lf() {
    [ ! -d "${XDG_CACHE_HOME}/lf" ] && mkdir -p "${XDG_CACHE_HOME}/lf"
    local target="${XDG_CACHE_HOME}/lf/lfdir"
    /bin/lf -last-dir-path $target
    cd "$(cat $target)"
}
