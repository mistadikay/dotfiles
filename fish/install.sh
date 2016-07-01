#!/usr/bin/env bash
#
# Symlink fish stuff

src="$HOME/.dotfiles/fish"
dest="$HOME/.config/fish"
files=(config.fish fishfile)
functions=(cho.fish dsync.fish findp.fish run.fish up.fish)

echo "Installing Fish dotfiles"

echo "└── Linking to $dest:"
mkdir -p $dest
for file in ${files[@]}; do
  echo "│   └── $file"

  rm $dest/$file
  ln -s $src/$file $dest/$file
done
echo "│"

echo "└── Linking to $dest/functions:"
mkdir -p $dest/functions
for file in ${functions[@]}; do
  echo "    └── $file"

  rm $dest/functions/$file
  ln -s $src/functions/$file $dest/functions/$file
done

printf "\n"
