#!/bin/bash

cd $( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cp .bashrc ~
cp .clang-format ~
cp .gitcommitmsg ~
cp .gitconfig ~
cp .inputrc ~
cp .tmux.conf ~
cp .vimrc ~

