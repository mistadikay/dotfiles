#!/usr/bin/env bash
#
# Set up GPG

src="$HOME/.dotfiles/gnupg"
dest=$HOME/.gnupg
files=(gpg.conf gpg-agent.conf)

echo "Installing NPM dotfiles"

echo "└── Linking to $dest:"
for file in ${files[@]}; do
  echo "    └── $file"

  rm -f $dest/$file
  ln -s $src/$file $dest/$file
done

gpgconf --kill gpg-agent
gpgconf --launch gpg-agent

printf "\n"
