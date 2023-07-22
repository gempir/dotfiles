export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export EDITOR="nano"
export TERM="xterm-256color"

export WINIT_HIDPI_FACTOR=1
export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=adwaita

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/go/bin:$PATH"
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
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
