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

asdf plugin add python
asdf install python latest
asdf global python latest

asdf plugin add golang
asdf install golang latest
asdf global golang latest

asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

printf "\n"cat
