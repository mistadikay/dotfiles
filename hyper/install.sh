#!/usr/bin/env bash
#
# Symlink hyperterm config

src="$HOME/.dotfiles/hyper"
dest=$HOME
files=(hyper.js)

echo "Installing Hyperterm config"

echo "└── Linking to $dest:"
for file in ${files[@]}; do
  echo "    └── $file"

  rm -f $dest/.$file
  ln -s $src/$file $dest/.$file
done

printf "\n"
