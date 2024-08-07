# Directory containing the script files
SCRIPT_DIR="$HOME/scripts"

# Function to list all functions in a given .sh file
list_custom_functions() {
    local file="$1"
    # Use grep to find function definitions and extract their names
    grep -E '^[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*\(\)[[:space:]]*\{' "$file" | \
    sed -E 's/^[[:space:]]*([a-zA-Z_][a-zA-Z0-9_]*)[[:space:]]*\(\)[[:space:]]*\{/\1/'
}

# Function to list all functions in all .sh files in the directory
listScripts() {
    # Check if the directory exists
    if [ ! -d "$SCRIPT_DIR" ]; then
        echo "Directory $SCRIPT_DIR does not exist."
        exit 1
    fi

    # Check if there are any .sh files in the directory
    sh_files=("$SCRIPT_DIR"/*.sh)
    if [ "${#sh_files[@]}" -eq 0 ]; then
        echo "No .sh files found in $SCRIPT_DIR."
        exit 0
    fi

    # Iterate over all .sh files in the directory
    for script_file in "${sh_files[@]}"; do
        echo "Functions in $script_file:"
        list_custom_functions "$script_file"
        echo ""
    done
}
