#!/usr/bin/env bash
#
# Symlink git stuff

dotfiles="$HOME/.dotfiles"
dir="$dotfiles/git"
files=(.gitconfig .gitignore)

echo "Installing Git dotfiles"
for file in ${files[@]}; do
  echo "└── Linking $file to $HOME"

  rm $HOME/$file
  ln -s $dir/$file $HOME/$file
done

printf "\n"
