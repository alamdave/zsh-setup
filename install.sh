echo "Setting up your Zsh environment..."

# Function to check and install Homebrew on macOS
install_homebrew() {
  if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

# Function to install a package if it's not already installed
install_package() {
  package_name="$1"
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if ! dpkg -s "$package_name" &> /dev/null; then
      echo "$package_name is not installed. Installing $package_name..."
      sudo apt update && sudo apt install "$package_name" -y
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_homebrew
    if ! brew list "$package_name" &> /dev/null; then
      echo "$package_name is not installed. Installing $package_name..."
      brew install "$package_name"
    fi
  else
    echo "Unsupported OS type: $OSTYPE"
    exit 1
  fi
}

# Install Zsh if not installed
install_package "zsh"

# Install Git if not installed
install_package "git"


# Ensure .zshrc and .p10k.zsh files exist
echo "Copying Zsh configuration files to the home directory..."
mkdir -p ~/zsh-setup



# This is a basic .zshrc file.
# Add your Zsh configuration settings here.

if [ ! -f ~/zsh-setup/.zshrc ]; then
  echo ".zshrc config not found."
fi

if [ -f ~/zsh-setup/.zshrc ]; then
  cp -f ~/zsh-setup/.zshrc ~/.zshrc
fi

if [ ! -f ~/zsh-setup/.p10k.zsh ]; then
  echo "Powerlevel10k config not found. You might need to run 'p10k configure' to create ~/.p10k.zsh"
fi

if [ -f ~/zsh-setup/.p10k.zsh ]; then
  cp -f ~/zsh-setup/.p10k.zsh ~/.p10k.zsh
fi

# Create directory for scripts if it doesn't exist and copy scripts
mkdir -p ~/scripts
if [ -d ~/zsh-setup/scripts ]; then
  echo "Copying custom scripts to ~/scripts..."
  cp -rf ~/zsh-setup/scripts/* ~/scripts/
else
  echo "No custom scripts directory found. Skipping script copying."
fi

# Install Powerlevel10k if not already installed
if [ ! -d "$HOME/.local/share/zsh/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/powerlevel10k
fi

# Ensure Powerlevel10k is sourced in .zshrc
if ! grep -q 'source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme' ~/.zshrc; then
  echo "source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
fi


# Ensure Zsh is listed as a valid shell
if [[ "$OSTYPE" == "darwin"* ]]; then
  if ! grep -q "/usr/local/bin/zsh" /etc/shells; then
    echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
  fi

  # On M1 Macs, Homebrew installs to a different location
  if ! grep -q "/opt/homebrew/bin/zsh" /etc/shells; then
    echo "/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells
  fi
fi

# Change default shell to Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Changing default shell to Zsh..."
  chsh -s $(which zsh)
fi

echo "Please restart your terminal session for changes to take effect."
echo "Please also install the correct font if not done so already: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k"
