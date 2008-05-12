alias l='ls -lahG'
alias ll='ls -lGarth'
alias ..='cd ..'
alias ...='cd ../..'

HISTFILESIZE=3000
export PATH=$PATH:~/bin:/opt/local/lib/mysql5/bin:/opt/local/bin:/usr/local/apache2/bin
export LSCOLORS="ExfxcxdxBxegedabagacad"
export EDITOR="vim"
export HISTSIZE=5000

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="[\t]\e[1;34m[\u@\e[1;32m\h\e[m:\w]\e[1;31m\$(parse_git_branch)\e[m\\$"

bind '"\e[5~"':history-search-backward
bind '"\e[6~"':history-search-forward
