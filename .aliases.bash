alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias v='vim'
alias sv='sudo -E vim'

# Docker
alias dc='docker-compose'
alias dim='docker images'
alias drmi='docker rmi'
alias dps='docker ps'
alias db='docker build'
alias dr='docker run'
alias dst='docker stop'
alias drm='docker rm'
alias da='docker attach'
alias dlg='docker logs'
alias dv='docker volume'

dsh() {
    docker exec -it $1 '/bin/sh'
}

# Tmux
alias t="tmux"
alias ta="tmux attach-session"
alias tl="tmux list-sessions"
alias tk="tmux kill-session"

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

lf() {
    [ ! -d ~/.cache/lf ] && mkdir -p ~/.cache/lf
    local target=~/.cache/lf/lfdir
    ~/.local/bin/lf -last-dir-path $target
    cd "$(cat $target)"
}
