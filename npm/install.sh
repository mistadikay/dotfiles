#!/usr/bin/env bash
#
# Symlink npm stuff

src="$HOME/.dotfiles/npm"
dest=$HOME
files=(.npmrc)

echo "Installing NPM dotfiles"

echo "└── Linking to $dest:"
for file in ${files[@]}; do
  echo "    └── $file"

  rm $dest/$file
  ln -s $src/$file $dest/$file
done

printf "\n"
