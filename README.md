# Zsh Configuration Setup

This repository contains my custom Zsh configuration, including the Powerlevel10k theme, Zsh plugins, and custom scripts. The setup is designed to enhance productivity and streamline the terminal workflow across multiple machines.

## Features

- **Powerlevel10k Theme**: A fast and highly customizable theme for Zsh.
- **Zinit Plugin Manager**: Easily manage and load plugins to extend Zsh functionality.
- **Custom Scripts**: Handy scripts to automate common tasks.
- **Aliases and Configurations**: Useful aliases and Zsh options for improved usability.

## Directory Structure

```
~/zsh-setup/
├── .zshrc                     # Zsh configuration
├── .p10k.zsh                  # Powerlevel10k configuration
├── scripts/                   # Custom scripts
│   ├── gitstatus.sh           # Detailed Git status
│   ├── speedtest.sh           # Test internet Speed connection
│   ├── updateGitZsh.sh        # Copy current .zshrc/.p10k.zsh and scripts to local git repo and push to remote
│   ├── sysinfo.sh             # Display system information
│   ├── createScript.sh        # creates or edit script in the ~/scripts/
│   ├── activateEnv.sh         # Activate local python ENV, can enter customer VENV folder
│   └── listScripts.sh         # List custom functions and files in ~/scripts/
└── install.sh                 # Setup script
```

## Installation

To set up this configuration on a new machine, follow these steps:

### Prerequisites

- **Zsh**: Ensure Zsh is installed. If not, install it using the following command:

  ```bash
  sudo apt update && sudo apt install zsh -y
  ```

- **Git**: Ensure Git is installed. If not, install it using the following command:

  ```bash
  sudo apt install git -y
  ```

### Setup Instructions

1. **Clone the Repository**

   Clone this repository into your home directory:

   ```bash
   git clone https://github.com/alamdave/zsh-setup.git ~/zsh-setup
   ```

2. **Run the Install Script**

   Navigate to the `zsh-setup` directory and run the setup script:

   ```bash
   cd ~/zsh-setup
   ./install.sh
   ```

   This script will:

   - Install Zinit for managing plugins.
   - Create symlinks for your Zsh configuration files.
   - Source custom scripts.

3. **Change Default Shell to Zsh**

   Change your default shell to Zsh if it isn't already:

   ```bash
   chsh -s $(which zsh)
   ```

   **Note:** You may need to restart your terminal session for changes to take effect.

### Manual Configuration

If the `install.sh` script doesn't automatically complete the setup, you can manually configure the environment as follows:

- **Install Zinit**

  ```bash
  sh -c "$(curl -fsSL https://git.io/zinit-install)"
  ```

- **Create Symlinks**

  ```bash
  ln -sf ~/zsh-setup/.zshrc ~/.zshrc
  ln -sf ~/zsh-setup/.p10k.zsh ~/.p10k.zsh
  ```

- **Source Scripts**

  Add the following line to your `.zshrc`:

  ```zsh
  for script in ~/zsh-setup/scripts/*.sh; do
    source "$script"
  done
  ```

## Usage

- **Zsh Configuration**: Your Zsh configuration is loaded from `.zshrc`, and your custom settings are loaded from `.zsh-configs`.

- **Custom Scripts**: You can run any of the scripts located in the `scripts/` directory directly from the command line.

- **Aliases**: Additional useful aliases are defined in `.zshrc`.

## Troubleshooting

### Common Issues

- **Permission Denied**: If you encounter permission issues, ensure your scripts are executable:

  ```bash
  chmod +x ~/zsh-setup/scripts/*.sh
  ```

- **Zsh Not Default Shell**: Make sure to change your default shell to Zsh with the `chsh` command.

### Helpful Commands

- **Reload Zsh Configuration**: After making changes, run:

  ```bash
  source ~/.zshrc
  ```

- **Check Git Configuration**: Verify your Git configuration with:

  ```bash
  git config --global --list
  ```

## Contributing

If you have suggestions or improvements, feel free to open a pull request or submit an issue.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Acknowledgments

- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) for the amazing prompt theme.
- [Zinit](https://github.com/zdharma-continuum/zinit) for plugin management.

## Plugins

- [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) by marlonrichert
- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) by zdharma-continuum
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) by zsh-users
- [zsh-completions](https://github.com/zsh-users/zsh-completions) by zsh-users
- [zsh-git-prompt](https://github.com/olivierverdier/zsh-git-prompt) by olivierverdier
- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) by zsh-users

Feel free to modify and expand this `README.md` to suit your specific setup and preferences. If you have any questions or need further assistance, please let me know!
