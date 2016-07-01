#!/bin/sh
#
# Run to symlink / sync dotfiles to remote repo.

dotfiles="$HOME/.dotfiles"
atom="$HOME/.atom"
brew="$(brew --prefix)/bin/brew"
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

# Homebrew
# from https://gist.github.com/witt3rd/894c9e0b9ca4e24e5574

echo "Syncing Homebrew..."
echo "Reading local settings..."
rm -f /tmp/brew-sync.*
$brew tap > /tmp/brew-sync.taps
$brew leaves > /tmp/brew-sync.installed
$brew cask list -1 > /tmp/brew-sync.casks

echo "Reading settings from dotfiles repo..."
[ -e $dotfiles/homebrew/brew-sync.taps ] && cat $dotfiles/homebrew/brew-sync.taps >> /tmp/brew-sync.taps
[ -e $dotfiles/homebrew/brew-sync.installed ] && cat $dotfiles/homebrew/brew-sync.installed >> /tmp/brew-sync.installed
[ -e $dotfiles/homebrew/brew-sync.casks ] && cat $dotfiles/homebrew/brew-sync.casks >> /tmp/brew-sync.casks

echo "Syncing to dotfiles repo..."
mkdir -p $dotfiles/homebrew
cat /tmp/brew-sync.taps | sort | uniq > $dotfiles/homebrew/brew-sync.taps
cat /tmp/brew-sync.installed | sort | uniq > $dotfiles/homebrew/brew-sync.installed
cat /tmp/brew-sync.casks | sort | uniq > $dotfiles/homebrew/brew-sync.casks

echo "Enabling taps ..."
for TAP in `cat $dotfiles/homebrew/brew-sync.taps`; do
	$brew tap ${TAP} >/dev/null
done

echo "Install missing packages..."
for PACKAGE in `cat $dotfiles/homebrew/brew-sync.installed`; do
	$brew leaves ${PACKAGE} >/dev/null
	[ "$?" != "0" ] && $brew install ${PACKAGE}
done

echo "Install missing casks..."
for CASK in `cat $dotfiles/homebrew/brew-sync.casks`; do
	$brew cask list -1 ${CASK} >/dev/null
	[ "$?" != "0" ] && $brew cask install ${CASK}
done

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
  git pull --rebase origin master
  git push origin master
  cd ..
fi

echo "dotfiles synced."
