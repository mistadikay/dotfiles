#!/usr/bin/env bash

src="$HOME/.dotfiles/psql"
dest="$HOME"
files=(.psqlrc)

echo "Installing psql dotfiles"

echo "└── Linking to $dest:"
mkdir -p $dest
for file in ${files[@]}; do
  echo "│   └── $file"

  rm -f $dest/$file
  ln -s $src/$file $dest/$file
done

printf "\n"
