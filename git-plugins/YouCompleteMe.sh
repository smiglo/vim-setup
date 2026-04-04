#!/bin/bash

set -e

git submodule update --init YouCompleteMe
(
  cd YouCompleteMe
  git clean -dxf
  git submodule update --init --recursive
)
./install.sh --force YouCompleteMe

cd $ENV_PATH/vim/vim
rm -rf python/ycm python/test_requirements.txt third_party/ycmd
git checkout autoload/youcompleteme.vim

ycmDir="YouCompleteMe"
if $IS_DOCKER; then
  ycmDir+=".docker"
  rm -rf $ycmDir
  cp -r YouCompleteMe $ycmDir
fi

cd $ENV_PATH/vim/git-plugins/$ycmDir
python3 install.py --clangd-completer --ts-completer
