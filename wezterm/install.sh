#!/usr/bin/env bash
#
# Install wezterm config

echo "Installing wezterm dotfiles"


src="$HOME/.dotfiles/wezterm"
dest="$HOME/.config/wezterm"

files=(wezterm.lua)
echo "└── Linking to $dest:"
mkdir -p $dest
for file in ${files[@]}; do
  echo "│   └── $file"

  rm -f $dest/$file
  ln -s $src/$file $dest/$file
done

printf "\n"
