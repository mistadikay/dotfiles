#!/usr/bin/env bash
#
# Symlink bash stuff

dotfiles="$HOME/.dotfiles"
dir="$dotfiles/bash"
files=(.bashrc .bash_profile)

echo "Installing Bash dotfiles"
for file in ${files[@]}; do
  echo "└── Linking $file to $HOME"

  rm $HOME/$file
  ln -s $dir/$file $HOME/$file
done

printf "\n"
