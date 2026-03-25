updateZsh() {
    local REPO_DIR="${ZSH_SETUP_DIR:-$HOME/code/zsh-repo}"
    local HOME_SCRIPTS_DIR="$HOME/scripts"
    local REPO_SCRIPTS_DIR="$REPO_DIR/scripts"
    local HOME_BIN_DIR="$HOME/.local/bin"
    local REPO_BIN_DIR="$REPO_DIR/bin"
    local LEGACY_SCRIPTS=(
        "$HOME_SCRIPTS_DIR/bootstrap-zsh.sh"
        "$HOME_SCRIPTS_DIR/updateGitZsh.sh"
        "$HOME_SCRIPTS_DIR/gitstatus.sh"
    )

    _link_zsh_file() {
        local source_path="$1"
        local target_path="$2"

        mkdir -p "$(dirname "$target_path")"

        if [[ -L "$target_path" && "$(readlink "$target_path")" == "$source_path" ]]; then
            echo "Already linked: $target_path -> $source_path"
            return 0
        fi

        if [[ -e "$target_path" && ! -L "$target_path" ]]; then
            local backup_path="${target_path}.bak.$(date +%Y%m%d%H%M%S)"
            mv "$target_path" "$backup_path"
            echo "Backed up $target_path -> $backup_path"
        else
            rm -f "$target_path"
        fi

        ln -s "$source_path" "$target_path"
        echo "Linked $target_path -> $source_path"
    }

    if [[ ! -d "$REPO_DIR" ]]; then
        echo "Error: repo not found at $REPO_DIR" >&2
        return 1
    fi

    mkdir -p "$HOME_SCRIPTS_DIR" "$HOME_BIN_DIR"

    _link_zsh_file "$REPO_DIR/.zshrc" "$HOME/.zshrc"
    _link_zsh_file "$REPO_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

    if [[ -d "$REPO_SCRIPTS_DIR" ]]; then
        local script
        for script in "$REPO_SCRIPTS_DIR"/*.sh; do
            [[ -e "$script" ]] || continue
            _link_zsh_file "$script" "$HOME_SCRIPTS_DIR/$(basename "$script")"
        done
    fi

    local legacy_path
    for legacy_path in "${LEGACY_SCRIPTS[@]}"; do
        rm -f "$legacy_path" "$legacy_path.zwc"
    done

    rm -f "$HOME_SCRIPTS_DIR"/*.zwc

    if [[ -x "$REPO_BIN_DIR/bootstrap-zsh" ]]; then
        _link_zsh_file "$REPO_BIN_DIR/bootstrap-zsh" "$HOME_BIN_DIR/bootstrap-zsh"
    fi
}
