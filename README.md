# Dotfiles

#### Requirements

```
oh-my-zsh
i3
i3blocks
```

#### Install

```
sudo pacman -S yarn zsh alacritty feh xsel imwheel tmux playerctl
yay -S dunst

# Install https://github.com/ohmyzsh/ohmyzsh

# Also install omz-git
sh -c "$(curl -fsSL https://raw.github.com/tnwinc/omz-git/master/install-plugin.sh)"

chsh -s $(which zsh)`
```

#### Learnings

- xwininfo to find window names
