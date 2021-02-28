#!/usr/bin/env bash
#
# Install fish stuff

src="$HOME/.dotfiles/fish"
dest="$HOME/.config/fish"
files=(config.fish fishfile)

echo "Installing Fish dotfiles"

echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# install fishmarks
curl -L https://github.com/techwizrd/fishmarks/raw/master/install.fish | fish

# install fisherman
curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
fisher

echo "└── Linking to $dest:"
mkdir -p $dest
for file in ${files[@]}; do
  echo "│   └── $file"

  rm -f $dest/$file
  ln -s $src/$file $dest/$file
done

echo "│"
echo "└── Installing local plugins:"

fisher ~/.dotfiles/fish/functions

printf "\n"
