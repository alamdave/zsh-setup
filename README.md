# Zsh Setup

This repository contains a portable Zsh setup for Linux and WSL with a fast, deterministic startup path.

The goal is simple:

- no plugin manager at shell startup
- no runtime `git clone` or `git pull`
- no network calls from `.zshrc`
- only source plugins and themes that are already installed locally

Plugin installation and updates are handled through `install.sh` and the `bootstrap-zsh` helper.

Quick commands:

- first-time setup: `./install.sh`
- update plugins later: `bootstrap-zsh`

## What This Repo Gives You

- A clean [`.zshrc`](/home/alam/zsh-setup/.zshrc) that only sources local files
- A Powerlevel10k prompt via [`.p10k.zsh`](/home/alam/zsh-setup/.p10k.zsh)
- A bootstrap command for cloning and updating required plugins
- A small collection of sourced helper functions under [`scripts/`](/home/alam/zsh-setup/scripts)
- A small `bin/` directory for executable commands
- Aliases, history tuning, completion setup, and Python/`pyenv` integration

## Design Principles

- Fast startup: no runtime plugin manager
- Deterministic behavior: fixed local paths for plugins
- Portable setup: keep config in Git, install dependencies separately
- Maintainable config: simple shell scripting over clever abstractions

## Directory Structure

```text
~/code/zsh-repo/
├── bin/
│   └── bootstrap-zsh
├── .zshrc
├── .p10k.zsh
├── install.sh
├── README.md
└── scripts/
    ├── activateEnv.sh
    ├── createScript.sh
    ├── listScripts.sh
    ├── speedtest.sh
    ├── sysinfo.sh
    └── updateZsh.sh
```

## `scripts/` vs `bin/`

Both are valid names, but they serve different purposes.

- `scripts/`
  Best for shell snippets and function libraries that you want to `source` into your interactive shell.

- `bin/`
  Best for executable commands you want to run from `PATH`.

For user-level executables on Linux and WSL, the most common default location is:

```text
~/.local/bin
```

That is the conventional place for personal commands. In this repo:

- `scripts/` contains sourced helper functions
- `bin/` contains executable commands

This separation avoids accidental startup side effects from sourcing executable scripts.

## Runtime Plugin Layout

The live shell config expects these local paths:

- `~/code/zsh-users/zsh-autosuggestions`
- `~/code/zsh-users/zsh-completions`
- `~/code/zsh-users/zsh-history-substring-search`
- `~/code/marlonrichert/zsh-autocomplete`
- `~/.local/share/zsh/powerlevel10k`

`.zshrc` only sources from those locations. If a plugin is missing, it is simply skipped.

## Plugins In Use

- `zsh-autosuggestions`
  Gives inline command suggestions based on history.

- `zsh-completions`
  Adds extra completion definitions beyond stock Zsh.

- `zsh-history-substring-search`
  Lets the up/down arrows search history by the currently typed prefix.

- `zsh-autocomplete`
  Restores command and completion suggestions while you type, including menu-style completion flow.

- `powerlevel10k`
  Provides the prompt theme and Git-aware prompt segments.

## Install On a New Machine

### 1. Clone the repo

```bash
git clone https://github.com/alamdave/zsh-setup.git ~/code/zsh-repo
cd ~/code/zsh-repo
```

### 2. Run the installer

```bash
./install.sh
```

The installer will:

- install `zsh` and `git` if needed
- symlink `~/.zshrc` and `~/.p10k.zsh` to the repo copies
- symlink sourced helper functions into `~/scripts`
- symlink `bin/bootstrap-zsh` into `~/.local/bin/bootstrap-zsh`
- clone or update the required plugins and theme
- optionally switch your default shell to Zsh

If the installer finds an existing regular file where it needs to place a symlink, it creates a timestamped backup first.

### 3. Start a new shell

```bash
exec zsh
```

## Updating Plugins Later

To update the locally installed plugins and theme:

```bash
~/.local/bin/bootstrap-zsh
```

This keeps all plugin update logic out of `.zshrc`.

## Linking the Repo to Your Home Directory

If you want edits in your home directory and repo to stay in sync, use the `updateZsh` helper after installation:

```bash
source ~/.zshrc
updateZsh
```

What `updateZsh` does:

- symlinks `~/.zshrc` to the repo copy
- symlinks `~/.p10k.zsh` to the repo copy
- symlinks repo helper functions into `~/scripts`
- symlinks `bin/bootstrap-zsh` into `~/.local/bin/bootstrap-zsh`
- creates timestamped backups before replacing non-symlink files

After that, editing either the home path or the repo path updates the same file because they are linked together.

## User Guide

### Prompt and Theme

Powerlevel10k is loaded from:

```text
~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme
```

Prompt appearance is configured in [`.p10k.zsh`](/home/alam/zsh-setup/.p10k.zsh).

What it currently gives you:

- a two-line prompt
- Git branch and repo state in the prompt
- command status and execution time
- current directory shortening for long paths
- transient prompt support
- instant prompt support

If you want to change the look:

- edit [`.p10k.zsh`](/home/alam/zsh-setup/.p10k.zsh) directly
- or run `p10k configure` and review the generated changes

### Completion

Completion is configured in [`.zshrc`](/home/alam/zsh-setup/.zshrc) with:

- `fpath` extended to include `zsh-completions`
- `compinit -C` for a faster cached completion startup
- `zsh-autocomplete` for live command and completion suggestions
- menu selection enabled
- case-insensitive matching enabled

This gives you:

- broader completion support
- better interactive completion menus
- quicker shell startup than a full uncached `compinit`

### History Behavior

The history configuration in [`.zshrc`](/home/alam/zsh-setup/.zshrc) enables:

- large history file size
- deduplication
- reduced blank entries
- incremental append
- shared history across shells

This means:

- repeated commands are cleaned up more aggressively
- multiple terminals can share history
- new commands are available in other sessions sooner

### Python and `pyenv`

The config adds:

- `~/.local/bin` to `PATH`
- `~/.pyenv/bin` to `PATH` when available
- lazy `pyenv` initialization

The lazy-loading function means `pyenv` only initializes when you actually use it, which helps keep startup faster.

### Aliases

The repo includes convenience aliases for:

- directory navigation: `..`, `...`, `....`
- listing files: `l`, `la`, `ll`
- terminal cleanup: `cls`
- safer file operations: `rm -i`, `cp -i`, `mv -i`
- Git shortcuts: `gs`, `ga`, `gc`, `gp`, `gpl`, `gco`, `gb`, `gd`, `gcm`, `gca`
- config reload/edit helpers: `reload`, `czsh`

### Script Auto-Sourcing

Every `*.sh` file in `~/scripts` is sourced automatically by `.zshrc`.

This allows you to keep personal shell functions in one directory and have them available in every session.

Current helper functions include:

- `activateEnv`
  Activates a local Python virtual environment in the current directory. Default folder name is `venv`.

- `createScript`
  Opens or creates a script inside `~/scripts` using `$EDITOR`, `code`, or `vim`.

- `listScripts`
  Lists available sourced helper functions from files in `~/scripts`.

- `speedtest`
  Runs `speedtest-cli --simple` if installed.

- `sysinfo`
  Prints a compact system summary for Linux or macOS.

- `updateZsh`
  Replaces copy-based syncing with symlinks so your home config and repo stay aligned.

### Keybindings

Current keybindings include:

- `Tab`
  Complete and cycle through menu suggestions again

- `Ctrl-Y`
  Accept the current autosuggestion

- `Ctrl-R`
  Start incremental reverse history search

- Up/Down arrows
  Search command history by the text already typed on the command line

## Common Customizations

### Add a new alias

Edit [`.zshrc`](/home/alam/zsh-setup/.zshrc) and add it to the aliases section:

```zsh
alias k='kubectl'
```

Reload your shell:

```bash
source ~/.zshrc
```

### Add a new helper function

Create a new helper function file:

```bash
createScript myhelper.sh
```

This creates the file in the repo `scripts/` directory and links it into `~/scripts` when possible.

Add a shell function to that file, then reload Zsh:

```bash
source ~/.zshrc
```

### Remove `zsh-history-substring-search`

If you prefer a simpler setup and do not care about history-prefix navigation on arrow keys:

1. Remove the `source` block for `zsh-history-substring-search` in [`.zshrc`](/home/alam/zsh-setup/.zshrc)
2. Remove the Up/Down `bindkey` lines that depend on it
3. Delete `~/code/zsh-users/zsh-history-substring-search`

This slightly reduces prompt startup work and plugin surface area.

### Change plugin install paths

If you want to use different local directories, update the path variables near the top of [`.zshrc`](/home/alam/zsh-setup/.zshrc) and keep [`bin/bootstrap-zsh`](/home/alam/zsh-setup/bin/bootstrap-zsh) in sync.

## Troubleshooting

### A plugin is missing

Run:

```bash
~/.local/bin/bootstrap-zsh
```

### Zsh loads but a feature does not work

Reload the shell and check for syntax errors:

```bash
source ~/.zshrc
zsh -n ~/.zshrc
```

### Completion seems stale

Delete the completion dump and restart the shell:

```bash
rm -f ~/.zcompdump*
exec zsh
```

### A helper function is not available

Make sure the script is in `~/scripts` and ends with `.sh`, then reload:

```bash
source ~/.zshrc
```

### Prompt looks wrong

Make sure your terminal uses a Nerd Font compatible with Powerlevel10k.

## Notes

- [`install.sh`](/home/alam/zsh-setup/install.sh) is the recommended setup path
- this repo now prefers direct local sourcing over plugin manager abstractions

## Acknowledgments

- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)
- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
