#!/bin/bash

cd $( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cp .bashrc ~
cp .clang-format ~
cp .gitcommitmsg ~
cp .gitconfig ~
cp .gitignore ~
cp .inputrc ~
cp .tmux.conf ~
cp .vimrc ~

mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim
cp colors.vim ~/.config/nvim

