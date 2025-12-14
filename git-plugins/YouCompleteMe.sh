#!/bin/bash

set -e

git submodule update --init YouCompleteMe
(
    cd YouCompleteMe
    git submodule update --init --recursive
)
./install.sh --force YouCompleteMe

cd $MY_PROJ_PATH/vim/vim
rm -rf python/ycm python/test_requirements.txt third_party/ycmd
git checkout autoload/youcompleteme.vim

cd $MY_PROJ_PATH/vim/git-plugins/YouCompleteMe/
python3 install.py --clangd-completer --ts-completer

