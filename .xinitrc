

# Disable screen saver
xset s off

# Turn off monitor after 25 minuters
xset dpms 0 0 1500

xrandr --output DP-0 --mode 2560x1440 --pos 5120x0 --rotate normal --output DP-1 --off --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off --output DP-4 --primary --mode 2560x1440 --pos 2560x0 --rotate normal --output DP-5 --off --output USB-C-0 --off

exec i3
