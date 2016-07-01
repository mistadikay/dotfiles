#!/usr/bin/env bash
#
# Synchronization
#
# 1. synchornize everything that is not symlinked
# 2. push changes to .dotfiles repo

dotfiles="$HOME/.dotfiles"
brew="$(brew --prefix)/bin/brew"

bash $dotfiles/homebrew/sync.sh

echo "Syncing changes to the repo"
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

printf "\n"
echo "Synchronization complete."
printf "\n"
