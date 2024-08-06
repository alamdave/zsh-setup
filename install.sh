#!/bin/bash

# Save this script as install.sh and make it executable with chmod +x install.sh

echo "Setting up your Zsh environment..."

# Install Zsh if not installed
if ! command -v zsh &> /dev/null; then
  echo "Zsh is not installed. Installing Zsh..."
  sudo apt update && sudo apt install zsh -y
fi

# Install Git if not installed
if ! command -v git &> /dev/null; then
  echo "Git is not installed. Installing Git..."
  sudo apt install git -y
fi

# Install Zinit if not already installed
if [ ! -d "$HOME/.local/share/zinit" ]; then
  echo "Installing Zinit..."
  mkdir -p "$HOME/.local/share/zinit" && chmod g-rwX "$HOME/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi

# Create symlinks for Zsh configuration
echo "Creating symlinks for configuration files..."
ln -sf ~/.zsh-configs/zsh-setup/.zshrc ~/.zshrc
ln -sf ~/.zsh-configs/zsh-setup/.p10k.zsh ~/.p10k.zsh

# Create directory for scripts if not exists
mkdir -p ~/scripts

# Copy custom scripts to the scripts directory
cp -r ~/.zsh-configs/zsh-setup/scripts/* ~/scripts/

# Source scripts
echo "Sourcing custom scripts..."
for script in ~/scripts/*.sh; do
  source "$script"
done

# Install Powerlevel10k if not already installed
if [ ! -d "$HOME/.local/share/zsh/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/powerlevel10k
fi

# Load Powerlevel10k theme
if ! grep -q 'source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme' ~/.zshrc; then
  echo "source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
fi

# Install and load plugins using Zinit
echo "Installing plugins using Zinit..."
source ~/.local/share/zinit/zinit.git/zinit.zsh

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light olivierverdier/zsh-git-prompt
zinit light zsh-users/zsh-history-substring-search

# Load annexes
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

echo "Zsh environment setup complete!"

# Change default shell to Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Changing default shell to Zsh..."
  chsh -s $(which zsh)
fi

echo "Please restart your terminal session for changes to take effect."
echo "please also install the correct font if not done so already: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k"
