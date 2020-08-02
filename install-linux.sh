#!/bin/sh

set -e

. $(dirname "$0")/scripts/helpers.sh


make_home_symlink ".config/i3"
make_home_symlink ".config/i3blocks"
make_home_symlink ".config/compton.conf"
make_home_symlink ".config/wallpaper.jpg"

make_home_symlink ".config/Code/User/settings.json"

make_home_symlink ".local/share/chatterino/Settings/commands.json"

make_home_symlink ".local/share/fonts"
make_home_symlink ".urxvt"

make_home_symlink ".Xresources"

xrdb ~/.Xresources
fc-cache -f