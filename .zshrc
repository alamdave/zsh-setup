# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source all custom scripts
if [[ -d ~/scripts ]]; then
  for script in ~/scripts/*.sh; do
    source "$script"
  done
fi


# General aliases
alias ..='cd ..'              # Go up one directory
alias ...='cd ../..'          # Go up two directories
alias ....='cd ../../..'      # Go up three directories
alias ~='cd ~'                # Go to home directory

alias rm='rm -i'              # Prompt before removing files
alias rmdir='rmdir -p'        # Remove directories and their parents
alias cp='cp -i'              # Prompt before overwriting files
alias mv='mv -i'              # Prompt before moving files

alias gs='git status'         # Show the status of the working directory
alias gl='git log --oneline --graph --decorate' # Displays a compact view of commit history
alias ga='git add'            # Add files to staging area
alias gc='git commit'         # Commit changes
alias gp='git push'           # Push changes to remote repository
alias gpl='git pull'          # Pull changes from remote repository
alias gco='git checkout'      # Switch branches or restore files
alias gb='git branch'         # List, create, or delete branches
alias gd='git diff'           # Show changes between commits

alias gcm='git commit -m'     # Commit with a message
alias gca='git commit --amend'# Amend the last commit

alias update='sudo apt update && sudo apt upgrade -y' # Update system packages

alias czsh='code ~/.zshrc'
alias reload='source ~/.zshrc'

# Load Znap
# Download Znap, if it's not there yet.
[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap
        
source ~/Repos/znap/znap.zsh  # Start Znap

# Load plugins using Znap
znap source zdharma-continuum/fast-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-completions
znap source olivierverdier/zsh-git-prompt
znap source zsh-users/zsh-history-substring-search


# Load Powerlevel10k theme
if [[ -f ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme
else
    znap source romkatv/powerlevel10k
    source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme
fi

# Custom Zsh options
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Set Zsh options
setopt auto_cd
setopt append_history
setopt share_history

# Set prompt (this can be overridden by Powerlevel10k)
export PROMPT='%n@%m %1~ %# '

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# End of .zshrc
