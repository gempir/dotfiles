#!/usr/bin/env bash

set -e

RED='\033[0;31m'
CYAN='\033[0;36m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Usage: make_home_symlink path_to_file name_of_file_in_home_to_symlink_to
make_home_symlink() {
    if [ -z "$1" ]; then
        >&2 echo -e "${RED}make_home_symlink: missing first argument: path to file${NC}"
        exit 1
    fi

    THIS_DOTFILE_PATH="$PWD/$1"
    if [ -z "$2" ]; then
        HOME_DOTFILE_PATH="$HOME/$1"
    else
        HOME_DOTFILE_PATH="$HOME/$2"
    fi

    printf "%s -> %s" "$1" "$HOME_DOTFILE_PATH"

    if [ -L "$HOME_DOTFILE_PATH" ]; then
        echo -e " ${ORANGE}skipping, already a symlink${NC}"
        return
    fi

    if [ -f "$HOME_DOTFILE_PATH" ] && [ ! -L "$HOME_DOTFILE_PATH" ]; then
        printf " You already have a regular file at %s. Do you want to remove it? (y/n) " "$HOME_DOTFILE_PATH"
        read -r response
        if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
            rm "$HOME_DOTFILE_PATH"
        else
            return
        fi
    fi

    ln -s "$THIS_DOTFILE_PATH" "$HOME_DOTFILE_PATH" 2>/dev/null
    echo -e " ${GREEN}done!${NC}"
}

print_big_notice() {
    echo -e "${CYAN}==================${NC}"
    echo -e "${CYAN}${@}${NC}"
    echo -e "${CYAN}==================${NC}"
}


make_home_symlink ".gitconfig"
make_home_symlink ".vimrc"
make_home_symlink ".zshrc"
make_home_symlink ".config/alacritty"
make_home_symlink ".config/streamlink"
make_home_symlink ".tmux.conf"

if [ "$(uname)" == "Darwin" ]; then
    print_big_notice "Detected macOS"
    make_home_symlink ".zshrc_mac"
    make_home_symlink ".hushlogin"

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    print_big_notice "Detected Linux"

    make_home_symlink ".config/i3"
    make_home_symlink ".config/i3blocks"
    make_home_symlink ".config/compton.conf"
    make_home_symlink ".config/wallpaper.jpg"

    make_home_symlink ".config/Code/User/settings.json"

    make_home_symlink ".local/share/chatterino/Settings/commands.json"

    make_home_symlink ".local/share/fonts"
    make_home_symlink ".imwheelrc"
    make_home_symlink ".sharenix.json"

    fc-cache -f
fi

