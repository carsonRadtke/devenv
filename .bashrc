#!/bin/sh

set -o vi

export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH=$PATH:~/bin
export PS1="\u@\h:\W \\$ "
export VISUAL=vim
export EDITOR=$VISUAL

alias blyat='git commit -a --amend --no-edit && git push --force'
alias patch='git diff > /tmp/p.patch && vim /tmp/p.patch'
