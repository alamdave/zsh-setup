
# Check if a script name is provided
createScript () {
    if [ -z "$1" ]; then
        echo "Usage: $0 <scriptname>"
        exit 1
    fi

    # Script name without the extension
    SCRIPT_NAME="$1"
    SCRIPT_PATH="$HOME/scripts/${SCRIPT_NAME}"

    # Create the .scripts directory if it doesn't exist
    mkdir -p "$HOME/scripts"

    code ${SCRIPT_PATH}        
}