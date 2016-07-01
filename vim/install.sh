#!/usr/bin/env bash
#
# Symlink vim stuff

dotfiles="$HOME/.dotfiles"
dir="$dotfiles/vim"
files=(.vim .vimrc)

echo "Installing Vim dotfiles"
for file in ${files[@]}; do
  echo "└── Linking $file to $HOME"

  rm -rf $HOME/$file
  ln -s $dir/$file $HOME/$file
done

printf "\n"
