#!/bin/sh

set -e

. $(dirname "$0")/scripts/helpers.sh


make_home_symlink ".zshrc"

make_home_symlink ".gitconfig"
