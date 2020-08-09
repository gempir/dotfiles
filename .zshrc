if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git omz-git)

source $ZSH/oh-my-zsh.sh

export MOEBEL_CODE="$HOME/dev/moebel" # Change this to your code path aswell
if [ -f $MOEBEL_CODE/env/misc/zshrc ]; then
     . $MOEBEL_CODE/env/misc/zshrc
fi

export EDITOR="vim"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.cargo/bin:$PATH"
alias loadnvm=". /usr/local/opt/nvm/nvm.sh"

if [ "$(uname)" = "Darwin" ]; then
  . ~/.zshrc_mac
fi

sl () { streamlink twitch.tv/"$@" audio_only --hls-live-edge 1 --twitch-disable-hosting  }
alias ls="ls -l"
alias initsubmodules="git submodule update --init --recursive"
alias restartcompton="killall -USR1 compton"

# ssh autocompletion via config file
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

alias ydl-hq="youtube-dl -f bestvideo+bestaudio"1
