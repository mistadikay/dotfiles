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
    ;;
  "Darwin")
    gpg_program="/opt/homebrew/bin/gpg"
    ;;
  *)
    echo "Unknown os. Cannot configure GPG program."
    exit 1
    ;;
esac

hostname=$(hostname)
case "$hostname" in
    "deniskoltsov")
        signingkey="3C9D9D280118ED0A"
        ;;
    "Deniss-MBP")
        signingkey="3C9D9D280118ED0A"
        ;;
    "linux-hostname")
        signingkey="EE5EC460D5BF2118"
        ;;
    *)
        echo "Unknown machine. Cannot configure GPG signing key automatically."
        exit 1
        ;;
esac


# Copy .gitconfig to temporary file and customize
tmp_gitconfig=$(mktemp)
cp "$src/gitconfig" "$tmp_gitconfig"

# Append the gpg program and signingkey configurations
echo -e "\n[gpg]\n    program = $gpg_program" >> "$tmp_gitconfig"
echo -e "[user]\n    signingkey = $signingkey" >> "$tmp_gitconfig"

# Replace existing .gitconfig with customized version
rm -f $dest/.gitconfig
ln -s $tmp_gitconfig $dest/.gitconfig

# Link other files as before
echo "└── Linking other Git files to $dest:"
for file in ${files[@]}; do
  echo "    └── $file"

  rm -f $dest/.$file
  ln -s $src/$file $dest/.$file
done

git config --global core.excludesfile '~/.gitignore'

printf "\n"
