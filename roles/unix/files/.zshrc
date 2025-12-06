# XDG Base Directory specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Editor and terminal
export EDITOR="nano"
export TERM="xterm-256color"

# Display/theme settings
export WINIT_HIDPI_FACTOR=1
export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=adwaita

# PATH: Build it once efficiently
typeset -U path  # Ensure unique entries
path=(
    $HOME/.local/bin
    $HOME/.cargo/bin
    /opt/homebrew/bin(N)  # N flag: only add if exists
    /usr/local/go/bin
    $path
)

source "$XDG_CONFIG_HOME/zsh/git.sh"

# setup zsh
PROMPT='%F{cyan}%B%1~%f $(git_prompt) %F{green}➜%f%b '

# Initialize autocompletion (cached for performance)
autoload -Uz compinit
# Only regenerate completion dump once per day
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'

# SSH hosts completion (optimized)
if [[ -f ~/.ssh/config ]]; then
    zstyle ':completion:*:(ssh|scp|sftp):*' hosts $(awk '/^Host [^*]/ {print $2}' ~/.ssh/config)
fi

# Source additional config files
[[ -f $HOME/.profile ]] && . $HOME/.profile

# Project-specific settings
export MOEBEL_CODE="$HOME/dev/furniture"
[[ -f $MOEBEL_CODE/env/misc/zshrc ]] && . $MOEBEL_CODE/env/misc/zshrc

# Aliases
alias ls="ls -l"
alias initsubmodules="git submodule update --init --recursive"
alias tm="tmux attach || tmux"
alias tmn="tmux new"
alias ktm="killall -9 tmux"
alias dev="cd ~/dev"
alias dcom="docker compose"
alias doc="docker compose"
alias bssh="mkdir -p ~/.ssh/config.d && echo -e '\nHost *\n    IdentityFile \"~/.ssh/id_ed25519_sk_backup\"\n    IdentityFile \"~/.ssh/id_rsa\"\n' >> ~/.ssh/config.d/backup"
alias nssh="rm ~/.ssh/config.d/backup"
alias drink="brew update && brew upgrade && brew cleanup"
alias pn="pnpm"
(( ${+aliases[gjca]} )) || alias gjca='git add -A && gc'

alias bambu="__GLX_VENDOR_LIBRARY_NAME=mesa __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_amber.json bambu-studio"

# Keybindings
bindkey -e  # Emacs mode
bindkey "^[[1;5C" forward-word    # Ctrl+Right
bindkey "^[[1;5D" backward-word   # Ctrl+Left

# Terraform completion (lazy-load if needed)
if command -v terraform &> /dev/null; then
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C /usr/local/bin/terraform terraform
fi

# Additional local config
[[ -f "$HOME/.config/local/bin/env" ]] && . "$HOME/.config/local/bin/env"
