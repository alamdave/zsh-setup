# -----------------------------
# Profiling (optional, can comment out)
# -----------------------------
zmodload zsh/zprof

# -----------------------------
# Powerlevel10k instant prompt
# Should stay at the top for instant loading
# -----------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fixed local install paths for plugins and theme.
export ZSH_SETUP_DIR="${ZSH_SETUP_DIR:-$HOME/code/zsh-repo}"
ZSH_USERS_REPO_DIR="${HOME}/code/zsh-users"
ZSH_AUTOSUGGESTIONS_DIR="${ZSH_USERS_REPO_DIR}/zsh-autosuggestions"
ZSH_COMPLETIONS_DIR="${ZSH_USERS_REPO_DIR}/zsh-completions"
ZSH_AUTOCOMPLETE_DIR="${HOME}/code/marlonrichert/zsh-autocomplete"
ZSH_HISTORY_SUBSTRING_SEARCH_DIR="${ZSH_USERS_REPO_DIR}/zsh-history-substring-search"
POWERLEVEL10K_DIR="${HOME}/.local/share/zsh/powerlevel10k"

# -----------------------------
# Source all custom scripts safely
# -----------------------------
if [[ -d ~/scripts ]]; then
  for script in ~/scripts/*.sh(N); do
    source "$script"
  done
fi

# -----------------------------
# General aliases
# -----------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'

alias rm='rm -i'
alias rmdir='rmdir -p'
alias cp='cp -i'
alias mv='mv -i'

# Git shortcuts
alias gs='git status'
alias gl='git log --graph --pretty=format:"%C(auto)%h %d %s %C(black)%C(bold)%cr"'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gcm='git commit -m'
alias gca='git commit --amend'

# System and config shortcuts
alias update='sudo apt update -y'
alias czsh='code ~/.zshrc'
alias reload='source ~/.zshrc'

# -----------------------------
# Powerlevel10k theme
# -----------------------------
if [[ -r "${POWERLEVEL10K_DIR}/powerlevel10k.zsh-theme" ]]; then
  source "${POWERLEVEL10K_DIR}/powerlevel10k.zsh-theme"
fi

# Load Powerlevel10k config if present
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -----------------------------
# History settings
# -----------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt append_history
setopt share_history

# -----------------------------
# Directory navigation
# -----------------------------
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt auto_cd

# -----------------------------
# Globbing / safety
# -----------------------------
setopt EXTENDED_GLOB
setopt GLOB_DOTS
setopt NO_CLOBBER
setopt APPEND_CREATE

# -----------------------------
# Path & Python environment
# -----------------------------
export PATH="$HOME/.local/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

pyenv() {
  unset -f pyenv
  eval "$(command pyenv init - zsh)"
  eval "$(command pyenv virtualenv-init -)"
  pyenv "$@"
}

# -----------------------------
# Completion system
# -----------------------------
typeset -gU fpath
if [[ -d "${ZSH_COMPLETIONS_DIR}/src" ]]; then
  fpath=("${ZSH_COMPLETIONS_DIR}/src" $fpath)
fi

zmodload zsh/complist
autoload -Uz compinit
compinit -C

# Case-insensitive completion and selectable menu
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# -----------------------------
# Plugins
# -----------------------------
if [[ -r "${ZSH_AUTOCOMPLETE_DIR}/zsh-autocomplete.plugin.zsh" ]]; then
  source "${ZSH_AUTOCOMPLETE_DIR}/zsh-autocomplete.plugin.zsh"
fi

if [[ -r "${ZSH_AUTOSUGGESTIONS_DIR}/zsh-autosuggestions.zsh" ]]; then
  source "${ZSH_AUTOSUGGESTIONS_DIR}/zsh-autosuggestions.zsh"
fi

if [[ -r "${ZSH_HISTORY_SUBSTRING_SEARCH_DIR}/zsh-history-substring-search.zsh" ]]; then
  source "${ZSH_HISTORY_SUBSTRING_SEARCH_DIR}/zsh-history-substring-search.zsh"
fi

# -----------------------------
# Keybindings
# -----------------------------
bindkey '^I' menu-complete
bindkey -M menuselect '^I' menu-complete
bindkey '^Y' autosuggest-accept
bindkey '^R' history-incremental-search-backward
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
if [[ -n ${terminfo[kcbt]-} ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M menuselect "${terminfo[kcbt]}" reverse-menu-complete
fi

# -----------------------------
# End of .zshrc
# -----------------------------
