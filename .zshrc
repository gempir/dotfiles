# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git omz-git)

source $ZSH/oh-my-zsh.sh

export MOEBEL_CODE="$HOME/dev/moebel" # Change this to your code path aswell
if [ -f $MOEBEL_CODE/env/misc/zshrc ]; then
     . $MOEBEL_CODE/env/misc/zshrc
fi

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

if [ "$(uname)" == "Darwin" ]; then
  . .zshrc_mac
fi

sl () { streamlink twitch.tv/"$@" audio_only --hls-live-edge 1 --twitch-disable-hosting  }
alias ls="ls -l"

