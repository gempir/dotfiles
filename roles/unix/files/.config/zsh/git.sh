# Enable substitution in the prompt.
setopt prompt_subst

function git_prompt() {
  branch=$(git symbolic-ref HEAD 2>/dev/null)
  if [ -z "$branch" ]; then
    return
  fi

  name=""
  branch=$(echo $branch | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == *"SHOP"* ]]; then
    name="${branch:5}"
  else
    name="${branch}"
  fi

  # Truncate branch name to a maximum of 20 characters
  if [ ${#name} -gt 15 ]; then
    name="${name:0:15}»"
  fi

  if [[ -z "$(git status --porcelain 2>/dev/null)" ]]; then
    echo "%F{green}${name}%f"
  else
    echo "%F{yellow}${name}%f"
  fi
}

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

# Check for develop and similarly named branches
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo develop
}

if ! type "pbcopy" >/dev/null; then
  alias pbpaste='xsel --clipboard --output'
  alias pbcopy='xsel --clipboard --input'
fi

alias g='git'

alias cb="git symbolic-ref --short HEAD | pbcopy" # copy current branch name into clipboard

alias ga='git add'
alias gaa='git add --all'
alias gb='git symbolic-ref --short HEAD'
alias gcd='git checkout $(git_develop_branch)'
alias gcm='git checkout $(git_main_branch)'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gl='git pull'
alias gm='git merge'
alias gp='git push'
alias gr='git restore'
alias gs='git status'
alias gst='git status'
alias ghead='git reset HEAD^'
alias ghard='git reset --hard'
alias gc='_gc() { git commit -m "$*" }; _gc'
alias gca='git add -A && gc'
