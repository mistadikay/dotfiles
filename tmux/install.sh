#!/usr/bin/env bash
#
# Install tmux config

echo "Installing tmux dotfiles"


src="$HOME/.dotfiles/tmux"
dest="$HOME"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

files=(.tmux.conf)
echo "└── Linking to $dest:"
mkdir -p $dest
for file in ${files[@]}; do
  echo "│   └── $file"

  rm -f $dest/$file
  ln -s $src/$file $dest/$file
done

tmux source $HOME/.tmux.conf

printf "\n"
