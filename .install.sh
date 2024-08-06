echo "Setting up your Zsh environment..."

# Check if Zsh is installed
if ! command -v zsh &> /dev/null; then
  echo "Zsh is not installed. Installing Zsh..."
  sudo apt update && sudo apt install zsh -y
fi

# Check if Git is installed
if ! command -v git &> /dev/null; then
  echo "Git is not installed. Installing Git..."
  sudo apt install git -y
fi

# Install Zinit
if [ ! -d "$HOME/.local/share/zinit" ]; then
  echo "Installing Zinit..."
  sh -c "$(curl -fsSL https://git.io/zinit-install)"
fi

# Create symlinks for Zsh configuration
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/.dotfiles/.zsh-configs ~/ 

# Source scripts
for script in ~/.dotfiles/scripts/*.sh; do
  source "$script"
done

echo "Zsh environment setup complete!"

# Change default shell to Zsh
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Changing default shell to Zsh..."
  chsh -s $(which zsh)
fi

echo "Please restart your terminal session for changes to take effect."