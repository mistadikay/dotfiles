#!/usr/bin/env bash
#
# Symlink vim stuff

src="$HOME/.dotfiles/vim"
dest=$HOME
files=(.vim .vimrc)

echo "Installing Vim dotfiles"

echo "└── Linking to $dest:"
for file in ${files[@]}; do
  echo "    └── $file"

  rm -rf $dest/$file
  ln -s $src/$file $dest/$file
done

printf "\n"
