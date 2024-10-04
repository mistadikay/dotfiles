#!/usr/bin/env bash
#
# Symlink bash stuff

src="$HOME/.dotfiles/bash"
dest="$HOME"
files=(.bashrc .bash_profile .profile)

echo "Installing Bash dotfiles"

echo "└── Linking to $dest:"
for file in ${files[@]}; do
  echo "    └── $file"

  rm -f $dest/$file
  ln -s $src/$file $dest/$file
done

printf "\n"
