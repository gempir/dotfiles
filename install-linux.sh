#!/bin/sh

set -e

. $(dirname "$0")/scripts/helpers.sh


make_home_symlink ".config"
make_home_symlink ".xinitrc"
make_home_symlink ".Xresources"
make_home_symlink ".local"
make_home_symlink ".urxvt"

xrdb ~/.Xresources
fc-cache -f