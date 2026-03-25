createScript() {
    if [ -z "$1" ]; then
        echo "Usage: createScript <script_name>" >&2
        return 1
    fi

    local SCRIPT_NAME="$1"
    local SCRIPT_PATH="$HOME/scripts/$SCRIPT_NAME"
    mkdir -p "$HOME/scripts"

    # Choose editor based on what's available
    local EDITOR="${EDITOR:-code}"
    if ! command -v "$EDITOR" &>/dev/null; then
        EDITOR="vim"
    fi

    if ! command -v "$EDITOR" &>/dev/null; then
        echo "Error: No editor found (tried $EDITOR, vim)" >&2
        return 1
    fi

    "$EDITOR" "$SCRIPT_PATH"
    echo "Created/edited: $SCRIPT_PATH"
}