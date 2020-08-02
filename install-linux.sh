#!/bin/sh

set -e

. $(dirname "$0")/scripts/helpers.sh


# i3
mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status

make_home_symlink ".config/i3/config"
make_home_symlink ".config/i3status/config"
make_home_symlink ".xinitrc"
make_home_symlink ".config/compton.conf"
