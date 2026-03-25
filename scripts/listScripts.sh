SCRIPT_DIR="$HOME/scripts"

# Extract function names from a file
_list_functions_from_file() {
    local file="$1"
    grep -E '^[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*\(\)[[:space:]]*\{' "$file" | \
    sed -E 's/^[[:space:]]*([a-zA-Z_][a-zA-Z0-9_]*)[[:space:]]*\(\)[[:space:]]*\{/\1/'
}

# List all available scripts and functions
listScripts() {
    if [ ! -d "$SCRIPT_DIR" ]; then
        echo "Error: Scripts directory not found: $SCRIPT_DIR" >&2
        return 1
    fi

    local sh_files=("$SCRIPT_DIR"/*.sh)
    if [ ! -e "${sh_files[0]}" ]; then
        echo "No scripts found in $SCRIPT_DIR"
        return 0
    fi

    echo "Available Scripts & Functions"
    echo "============================="
    echo ""

    for script_file in "${sh_files[@]}"; do
        local filename=$(basename "$script_file")
        local functions=$(_list_functions_from_file "$script_file")

        if [ -n "$functions" ]; then
            echo "$filename:"
            while IFS= read -r func; do
                echo "  → $func"
            done <<< "$functions"
            echo ""
        fi
    done
}
