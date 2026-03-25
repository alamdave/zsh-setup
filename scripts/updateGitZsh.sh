# Function to update the git repo with your Zsh setup
updateGitZsh() {
    # Define the source files and directories
    ZSHRC="$HOME/.zshrc"
    P10K="$HOME/.p10k.zsh"
    SCRIPTS_DIR="$HOME/scripts"

    # Define the destination directory
    DEST_DIR="$HOME/zsh-setup"

    # Create the destination directory if it doesn't exist
    mkdir -p "$DEST_DIR"

    # Check if .zshrc exists and copy it
    if [ -f "$ZSHRC" ]; then
        cp -r "$ZSHRC" "$DEST_DIR/"
        echo "Copied .zshrc to $DEST_DIR"
    else
        echo ".zshrc not found."
    fi

    # Check if .p10k.zsh exists and copy it
    if [ -f "$P10K" ]; then
        cp -r "$P10K" "$DEST_DIR/"
        echo "Copied .p10k.zsh to $DEST_DIR"
    else
        echo ".p10k.zsh not found."
    fi

    # Check if the scripts directory exists and copy it
    if [ -d "$SCRIPTS_DIR" ]; then
        # Remove existing scripts directory in DEST_DIR if it exists
        rm -rf "$DEST_DIR/scripts"
        
        # Copy the entire scripts directory
        cp -r "$SCRIPTS_DIR" "$DEST_DIR/"
        echo "Copied scripts directory to $DEST_DIR"
    else
        echo "Scripts directory not found."
    fi

    # Git operations
    cd "$DEST_DIR" || exit

    # Initialize a git repository if it doesn't exist
    if [ ! -d ".git" ]; then
        git init
        echo "Initialized a new git repository."
    fi

    # Set or update remote URL (idempotent)
    if ! git remote get-url origin &>/dev/null; then
        git remote add origin git@github.com:alamdave/zsh-setup.git
    else
        git remote set-url origin git@github.com:alamdave/zsh-setup.git
    fi

    # Add changes and commit
    git add .
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    if git diff-index --quiet HEAD --; then
        echo "No changes to commit."
    else
        git commit -m "Update: $TIMESTAMP"
        echo "Committed changes with timestamp $TIMESTAMP."
    fi

    # Push to remote
    if git rev-parse --verify main >/dev/null 2>&1; then
        git push origin main
        echo "Pushed to remote."
    else
        echo "No commits to push or main branch doesn't exist."
    fi

    echo "Backup and update completed."
}
