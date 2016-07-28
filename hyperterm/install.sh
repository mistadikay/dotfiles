#!/usr/bin/env bash
#
# Symlink hyperterm config

src="$HOME/.dotfiles/hyperterm"
dest=$HOME
files=(hyperterm.js)

echo "Installing Hyperterm config"

echo "└── Linking to $dest:"
for file in ${files[@]}; do
  echo "    └── $file"

  rm $dest/.$file
  ln -s $src/$file $dest/.$file
done

printf "\n"
