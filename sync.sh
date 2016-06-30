#!/bin/sh
#
# Run to symlink / sync dotfiles to remote repo.

dotfiles="$HOME/.dotfiles"
atom="$HOME/.atom"
isotopes=(config.cson keymap.cson)
files=(gitconfig gitignore vim vimrc bashrc bash_profile)

# Dotfiles, .vim .gitconfig, .bashrc, etc.
for file in ${files[@]}; do
  if [ ! -e $HOME/.$file ]; then
    echo "Linking $file to $HOME"
    ln -s $dotfiles/$file $HOME/.$file
  fi
done

# Atom's configuration.
if [ -d "$atom" ]; then
  echo "Syncing Atom"
  for isotope in ${isotopes[@]}; do
    echo "isotope: $isotope"
    # Target should exist and not be a symlink
    if [ -e $atom/$isotope -a ! -h $atom/$isotope ]; then
      isotope_old=$(mktemp $atom/$isotope.XXXX)
      mv $atom/$isotope $isotope_old
    fi
    # Create new symlinks if there isn't any already.
    if [ ! -h $atom/$isotope ]; then
      echo "Linking $isotope to $atom"
      ln -s $dotfiles/atom/$isotope $atom/$isotope
    fi
  done
fi

# Repository sync.
if [ -d "$dotfiles" -a -d "$dotfiles"/.git ]; then
  cd "$dotfiles"
  # Use OS X default git build in case of stupidity.
  type git >/dev/null 2>&1 || { alias git='xcrun git'; }

  message=":arrows_counterclockwise:"
  [ -n "$1" ] && message="$1"

  if (git status --porcelain  | grep -q "^[ MADRC]"); then
    git add -A
    git commit -m "$message"
  fi

  echo "$message"
  # git pull --rebase origin master
  # git push origin master
  cd ..
fi

echo "dotfiles synced."
