# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -C -d "${HOME}/.cache/zsh/zcompdump-${ZSH_VERSION}"
_comp_options+=(globdots) # Include hidden files.

# History configuration
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="${XDG_STATE_HOME}/zsh_history"
setopt HIST_IGNORE_ALL_DUPS # Remove older duplicate entries
setopt HIST_FIND_NO_DUPS    # Don't show duplicates in search
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks
setopt SHARE_HISTORY        # Share history between sessions
setopt INC_APPEND_HISTORY   # Write to history immediately
setopt AUTO_CD              # Type directory name to cd
setopt AUTO_PUSHD           # Make cd push to directory stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
setopt CORRECT              # Command correction

# Vim-like key-bindings
bindkey -v
export KEYTIMEOUT=1
bindkey -v '^?' backward-delete-char
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh

# User configuration files
[[ -f "${ZDOTDIR}/.aliases.zsh" ]] && source "${ZDOTDIR}/.aliases.zsh"
[[ -f "${ZDOTDIR}/.p10k.zsh" ]] && source "${ZDOTDIR}/.p10k.zsh"
