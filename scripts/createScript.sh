createScript() {
    if [ -z "$1" ]; then
        echo "Usage: createScript <script_name>" >&2
        return 1
    fi

    local SCRIPT_NAME="$1"
    local REPO_DIR="${ZSH_SETUP_DIR:-$HOME/code/zsh-repo}"
    local REPO_SCRIPTS_DIR="$REPO_DIR/scripts"
    local HOME_SCRIPTS_DIR="$HOME/scripts"
    local SCRIPT_PATH="$REPO_SCRIPTS_DIR/$SCRIPT_NAME"
    mkdir -p "$HOME/scripts"
    mkdir -p "$REPO_SCRIPTS_DIR"

    # Choose editor based on what's available
    local EDITOR="${EDITOR:-code}"
    if ! command -v "$EDITOR" &>/dev/null; then
        EDITOR="vim"
    fi

    if ! command -v "$EDITOR" &>/dev/null; then
        echo "Error: No editor found (tried $EDITOR, vim)" >&2
        return 1
    fi

    if [[ ! -e "$HOME_SCRIPTS_DIR/$SCRIPT_NAME" ]]; then
        ln -s "$SCRIPT_PATH" "$HOME_SCRIPTS_DIR/$SCRIPT_NAME" 2>/dev/null || true
    fi

    "$EDITOR" "$SCRIPT_PATH"
    echo "Created/edited: $SCRIPT_PATH"
}
