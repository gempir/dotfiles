PROMPT='%F{cyan}%B%1~%f %F{green}➜%f%b '

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
export PATH="$PATH:$(yarn global bin)"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

source "$XDG_CONFIG_HOME/zsh/git.sh"

zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'

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


# ssh autocompletion via config file
# h=()
# if [[ -r ~/.ssh/config ]]; then
#   h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
# fi
# if [[ -r ~/.ssh/known_hosts ]]; then
#   h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
# fi
# if [[ $#h -gt 0 ]]; then
#   zstyle ':completion:*:ssh:*' hosts $h
#   zstyle ':completion:*:slogin:*' hosts $h
# fi


