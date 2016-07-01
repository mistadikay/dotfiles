#!/usr/bin/env bash
#
# Symlink git stuff

dotfiles="$HOME/.dotfiles"
dir="$dotfiles/git"
files=(.gitconfig .gitignore)

echo "Installing Git dotfiles"
for file in ${files[@]}; do
  echo "└── Linking $file to $HOME"

  if [ -e $HOME/$file ]; then
      rm -rf $HOME/$file
  fi
  ln -s $dir/$file $HOME/$file
done

printf "\n"
