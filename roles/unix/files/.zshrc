export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export EDITOR="nano"
export TERM="xterm-256color"

export WINIT_HIDPI_FACTOR=1
export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=adwaita

export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

source "$XDG_CONFIG_HOME/zsh/git.sh"

# setup zsh
PROMPT='%F{cyan}%B%1~%f $(git_prompt) %F{green}➜%f%b '

# Initialize the autocompletion
autoload -Uz compinit && compinit -i

zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'
host_list=($(cat ~/.ssh/config | grep 'Host '  | awk '{s = s $2 " "} END {print s}'))
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $host_list

if [ -f $HOME/.profile ]; then
     . $HOME/.profile
fi

export MOEBEL_CODE="$HOME/dev/furniture" # Change this to your code path aswell
if [ -f $MOEBEL_CODE/env/misc/zshrc ]; then
     . $MOEBEL_CODE/env/misc/zshrc
fi


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

alias bambu="__GLX_VENDOR_LIBRARY_NAME=mesa  __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_amber.json bambu-studio"

bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

[[ -f "$HOME/.config/local/share/../bin/env" ]] && . "$HOME/.config/local/share/../bin/env"
