# Function to activate a virtual environment
activate_env() {
    # Use the provided argument as the virtual environment name, or use the default
    local VENV_NAME="${1:-venv}"
    local DIR=$(pwd)
    #env directory
    local VENV_DIR="$DIR/$VENV_NAME"
    

    # Check if the virtual environment directory exists
    if [ -d "$VENV_DIR" ]; then
        # Activate the virtual environment
        source "$VENV_DIR/bin/activate"
        echo "Activated virtual environment: $VENV_DIR"
    else
        echo "Virtual environment '$VENV_DIR' not found!"
        return 1
    fi
}
