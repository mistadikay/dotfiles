#!/usr/bin/env bash
#
# Install fish stuff

echo "Installing Fish dotfiles"

FISH_PATH=$(command -v fish)
if [ -z "$FISH_PATH" ]; then
  echo "Fish shell is not installed. Please install Fish shell and try again."
  exit 1
fi

echo $FISH_PATH | sudo tee -a /etc/shells
chsh -s $FISH_PATH

# install fishmarks
curl -L https://github.com/techwizrd/fishmarks/raw/master/install.fish | fish

# install fisherman
curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
fisher

src="$HOME/.dotfiles/fish"
dest="$HOME/.config/fish"
files=(config.fish fishfile)
echo "└── Linking to $dest:"
mkdir -p $dest
for file in ${files[@]}; do
  echo "│   └── $file"

  rm -f $dest/$file
  ln -s $src/$file $dest/$file
done

src="$HOME/.dotfiles/fish/functions/*"
dest="$HOME/.config/fish/functions"
echo "└── Linking to $dest:"
mkdir -p $dest
for file in $src; do
  echo "│   └── $file"

  filename="$(basename -- $file)"
  destpath=$dest/$filename

  rm -f $destpath
  ln -s $file $destpath
done

printf "\n"
