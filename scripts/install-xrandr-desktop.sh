#!/bin/sh

set -e

. $(dirname "$0")/helpers.sh

xrandr --output DP-0 --mode 2560x1440 --pos 5120x0 --rotate normal --output DP-1 --off --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3