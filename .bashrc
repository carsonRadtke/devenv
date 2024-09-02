#!/bin/sh

set -o vi

export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH=$PATH:~/bin
export PS1="\u@\h:\W \\$ "
export VISUAL=vim
export EDITOR=$VISUAL
export TRUNK=main

uname_out=$(uname -s)
case "${uname_out}" in
    Linux*)  brewpath=~/.linuxbrew;;
    Darwin*) brewpath=/opt/homebrew;;
    *)       brewpath=/unknown;;
esac

eval "$($brewpath/bin/brew shellenv)"
unset uname_out

bashrc_extra=$HOME/.bashrc.extra
if [ -f $bashrc_extra ]; then
    source $bashrc_extra
fi
unset bashrc_extra
