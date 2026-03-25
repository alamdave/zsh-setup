# Function to activate a virtual environment
activateEnv() {
    local VENV_NAME="${1:-venv}"
    local VENV_DIR="$(pwd)/$VENV_NAME"

    if [ ! -d "$VENV_DIR" ]; then
        echo "Error: Virtual environment not found at $VENV_DIR" >&2
        return 1
    fi

    if [ ! -f "$VENV_DIR/bin/activate" ]; then
        echo "Error: Invalid virtual environment (missing bin/activate)" >&2
        return 1
    fi

    source "$VENV_DIR/bin/activate"
    echo "Activated: $VENV_DIR"
}
