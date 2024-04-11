#!/usr/bin/env bash
#
# Install asdf stuff

echo "Installing asdf dotfiles"

src="$HOME/.dotfiles/asdf"
dest="$HOME"
files=(.asdfrc)
echo "└── Linking to $dest:"
mkdir -p $dest
for file in ${files[@]}; do
  echo "│   └── $file"

  rm -f $dest/$file
  ln -s $src/$file $dest/$file
done


printf "\n"cat
