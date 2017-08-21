#!/usr/bin/env bash
#
# Symlink atom stuff

src="$HOME/.dotfiles/atom"
dest="$HOME/.atom"
files=(config.cson keymap.cson snippets.cson styles.less)

if [ -d "$dest" ]; then
  echo "Installing Atom config"

  echo "└── Linking to $dest:"
  for file in ${files[@]}; do
    echo "    └── $file"

    # TODO should we do backup of the old files?
    # # Target should exist and not be a symlink
    # if [ -e $dest/$file -a ! -h $dest/$file ]; then
    #   file_old=$(mktemp $dest/$file.XXXX)
    #   mv $dest/$file $file_old
    # fi

    rm $dest/$file
    ln -s $src/$file $dest/$file
  done
else
  echo "Atom is not installed"
fi

printf "\n"
