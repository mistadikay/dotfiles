#!/usr/bin/env bash
#
# Set up GPG

src="$HOME/.dotfiles/gnupg"
dest=$HOME/.gnupg

echo "Installing GPG dotfiles"

echo "└── Linking to $dest:"
echo "    └── gpg.conf"
rm -f "$dest"/gpg.conf
ln -s "$src"/gpg.conf "$dest"/gpg.conf

case "$(uname)" in
  "Linux")
    os=linux
    ;;
  "Darwin")
    os=mac
    ;;
  *)
  echo "Unknown OS. Cannot configure GPG program."
  exit 1
  ;;
esac

echo "    └── gpg-agent.conf"
rm -f "$dest"/gpg-agent.conf
ln -s "$src"/gpg-agent-"$os".conf "$dest"/gpg-agent.conf

gpgconf --kill gpg-agent
gpgconf --launch gpg-agent

printf "\n"
