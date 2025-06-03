export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export EDITOR="nano"
export TERM="xterm-256color"

export WINIT_HIDPI_FACTOR=1
export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=adwaita

export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export ELECTRON_OZONE_PLATFORM_HINT=auto

. "$HOME/.local/bin/env"

