#!/bin/sh

export BASH_SILENCE_DEPRECATION_WARNING=1

set -o vi

export PS1="\u@\h:\w \\$ "
export VISUAL=vim
export EDITOR=$VISUAL

