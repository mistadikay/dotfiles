#!/usr/bin/env bash
#
# Install zsh stuff

src="$HOME/.dotfiles/zsh"
dest="$HOME"
files=(.zshrc)

echo "Installing zsh dotfiles"

echo "└── Linking to $dest:"
mkdir -p $dest
for file in ${files[@]}; do
  echo "│   └── $file"

  rm -f $dest/$file
  ln -s $src/$file $dest/$file
done

printf "\n"
