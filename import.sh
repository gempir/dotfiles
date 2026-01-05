#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS
detect_os() {
    case "$(uname -s)" in
        Darwin)
            echo "macos"
            ;;
        Linux)
            echo "linux"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

OS=$(detect_os)

# Define source paths based on OS
case "$OS" in
    macos)
        CHATTERINO_DIR="$HOME/Library/Application Support/chatterino/Settings"
        ZED_DIR="$HOME/.config/zed"
        ;;
    linux)
        CHATTERINO_DIR="$HOME/.local/share/chatterino/Settings"
        ZED_DIR="$HOME/.config/zed"
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

# Define destination paths in the repository
REPO_CHATTERINO_DIR="$SCRIPT_DIR/files/chatterino"
REPO_ZED_DIR="$SCRIPT_DIR/files/zed"

# Filter JSON function - removes specified keys and replaces with {}
# Usage: filter_json <input_file> <output_file> <key1> [key2] ...
filter_json() {
    local input="$1"
    local output="$2"
    shift 2
    local keys=("$@")
    
    if [ ! -f "$input" ]; then
        echo "Warning: Source file not found: $input"
        return 1
    fi
    
    # Build jq filter to replace specified keys with {}
    local jq_filter="."
    for key in "${keys[@]}"; do
        jq_filter="$jq_filter | .${key} = {}"
    done
    
    jq "$jq_filter" "$input" > "$output"
    echo "Imported: $input -> $output (filtered keys: ${keys[*]})"
}

# Copy JSON function - copies without filtering
copy_json() {
    local input="$1"
    local output="$2"
    
    if [ ! -f "$input" ]; then
        echo "Warning: Source file not found: $input"
        return 1
    fi
    
    cp "$input" "$output"
    echo "Imported: $input -> $output"
}

# Ensure destination directories exist
mkdir -p "$REPO_CHATTERINO_DIR"
mkdir -p "$REPO_ZED_DIR"

echo "Importing configuration files for $OS..."
echo ""

# Import Chatterino files
copy_json "$CHATTERINO_DIR/commands.json" "$REPO_CHATTERINO_DIR/commands.json"
copy_json "$CHATTERINO_DIR/window-layout.json" "$REPO_CHATTERINO_DIR/window-layout.json"

# Import Chatterino settings.json with accounts filtered out
filter_json "$CHATTERINO_DIR/settings.json" "$REPO_CHATTERINO_DIR/settings.json" "accounts"

# Import Zed settings.json (no filtering needed currently)
copy_json "$ZED_DIR/settings.json" "$REPO_ZED_DIR/settings.json"

echo ""
echo "Import complete!"
