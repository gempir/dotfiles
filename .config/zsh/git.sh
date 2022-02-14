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

if ! type "pbcopy" > /dev/null; then
    alias pbpaste='xsel --clipboard --output'
    alias pbcopy='xsel --clipboard --input'
fi

alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gb='git symbolic-ref --short HEAD'
alias gst='git status'
alias gc='git commit -v'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout $(git_develop_branch)'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gl='git pull'
alias gp='git push'
alias cb="git symbolic-ref --short HEAD | pbcopy" # copy current branch name into clipboard
