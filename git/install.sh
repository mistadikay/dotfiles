#!/usr/bin/env bash
#
# Symlink git stuff

src="$HOME/.dotfiles/git"
dest=$HOME
files=(gitignore)

echo "Installing Git dotfiles"

# Handle .gitconfig with OS-specific gpg program path and signingkey
echo "└── Customizing and linking .gitconfig to $dest:"

os=$(uname)
case "$os" in
  "Linux")
    gpg_program="/usr/bin/gpg"
    os_gitconfig="$src/linux.gitconfig"
    ;;
  "Darwin")
    gpg_program="/opt/homebrew/bin/gpg"
    os_gitconfig="$src/mac.gitconfig"
    ;;
  *)
    echo "Unknown os. Cannot configure GPG program."
    exit 1
    ;;
esac
> $os_gitconfig


# Copy .gitconfig to os_gitconfig file and customize
cp "$src/gitconfig" "$os_gitconfig"

# Append the gpg program and signingkey configurations
echo -e "\n[gpg]\n    program = $gpg_program" >> "$os_gitconfig"
echo -e "[user]\n    email = $email" >> "$os_gitconfig"

# Replace existing .gitconfig with customized version
rm -f $dest/.gitconfig
ln -s $os_gitconfig $dest/.gitconfig

# Link other files as before
echo "└── Linking other Git files to $dest:"
for file in ${files[@]}; do
  echo "    └── $file"
  rm -f $dest/.$file
  ln -s $src/$file $dest/.$file
done

git config --global core.excludesfile '~/.gitignore'

printf "\n"
