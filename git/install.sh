#!/usr/bin/env bash
#
# Symlink git stuff

src="$HOME/.dotfiles/git"
dest=$HOME
files=(gitconfig gitignore)

echo "Installing Git dotfiles"

echo "└── Linking to $dest:"
for file in ${files[@]}; do
  echo "    └── $file"

  rm -f $dest/.$file
  ln -s $src/$file $dest/.$file
done

printf "\n"
