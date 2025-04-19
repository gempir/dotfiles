#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
CYAN='\033[0;36m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

print_notice() {
    echo -e "${CYAN}${@}${NC}"
}

detect_os() {
    if [[ "$(uname)" == "Darwin"* ]]; then
        echo "macos"
    elif [[ "$(uname)" == "Linux"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

if [ -n "$1" ]; then
    OS="$1"
    print_notice "Using provided OS: ${OS}"
else
    OS=$(detect_os)
    print_notice "Detected OS: ${OS}"
fi

# Install Python and uv
install_python() {    
    if [[ "$OS" == "macos" ]]; then
        if ! command -v brew &> /dev/null; then
            print_notice "Homebrew not found. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        
        if ! command -v curl &> /dev/null; then
            print_notice "Installing curl using Homebrew"
            brew install curl
        fi
    elif [[ "$OS" == "linux" ]]; then
        if ! command -v curl &> /dev/null; then
             # Detect package manager
            if command -v apt-get &> /dev/null; then
                print_notice "Using apt package manager"
                sudo apt-get update
                sudo apt-get install -y curl
            elif command -v dnf &> /dev/null; then
                print_notice "Using dnf package manager"
                sudo dnf install -y curl
            elif command -v pacman &> /dev/null; then
                print_notice "Using pacman package manager"
                sudo pacman -Syu --noconfirm curl
            else
                echo -e "${RED}Unsupported Linux distribution. Please install curl manually.${NC}"
                exit 1
            fi
        fi
    else
        echo -e "${RED}Unsupported OS. This script supports macOS and Linux.${NC}"
        echo -e "${RED}For Windows, please run bootstrap_windows.ps1 instead.${NC}"
        exit 1
    fi

    if ! command -v uv &> /dev/null; then
        print_notice "Installing uv"
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi

    uv venv --python 3.12
    uv pip install ansible
} 

run_playbook() {
    source .venv/bin/activate

    ansible-vault decrypt files/ssh/id_ed25519_ansible_gempir.vault --output files/ssh/id_ed25519_ansible_gempir

    ansible-playbook --limit "$OS" playbook.yml
}

if [ ! -f ".venv/bin/ansible" ]; then
    install_python
fi

if [[ "$OS" == "install" ]]; then
    source .venv/bin/activate

    ansible-galaxy collection install -r requirements.yml -p ./collections
    exit 0
fi

run_playbook
