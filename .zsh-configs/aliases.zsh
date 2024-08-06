# ~/.zsh-configs/aliases/aliases.zsh

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
alias gl='git log --oneline --graph --decorate' #Displays a compact view of commit history.
alias ga='git add'            # Add files to staging area
alias gc='git commit'         # Commit changes
alias gp='git push'           # Push changes to remote repository
alias gl='git pull'           # Pull changes from remote repository
alias gco='git checkout'      # Switch branches or restore files
alias gb='git branch'         # List, create, or delete branches
alias gd='git diff'           # Show changes between commits

alias gcm='git commit -m'     # Commit with a message
alias gca='git commit --amend' # Amend the

alias update='sudo apt update && sudo apt upgrade -y' #Update system packages.


# Add more aliases as needed

alias eplugins='code ~/.zsh-configs/plugins.zsh'
alias ealiases='code ~/.zsh-configs/aliases.zsh'
alias etheme='code ~/.zsh-configs/theme.zsh'
alias zsh='code ~/.zshrc'
alias reload='source ~/.zshrc'