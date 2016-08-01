#!/usr/bin/env bash
#
# Symlink tmux config

src="$HOME/.dotfiles/tmux"
dest=$HOME
files=(.tmux.conf)

echo "Installing Tmux Plugin Manager"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

echo "Installing Tmux config"

echo "└── Linking to $dest:"
for file in ${files[@]}; do
  echo "    └── $file"

  rm $dest/$file
  ln -s $src/$file $dest/$file
done

tmux source-file $HOME/.tmux.conf

printf "\n"
