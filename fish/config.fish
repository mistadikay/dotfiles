# gvm
# https://github.com/moovweb/gvm
bass [[ -s "$HOME/.gvm/scripts/gvm" ]]
bass source "$HOME/.gvm/scripts/gvm"

# remove greeting
set fish_greeting

# Set aliases
alias k "kubectl"
alias c "clear"
alias b "babel-node"
alias fi "fisher"
alias tc "itermocil"
alias brc "brew cask"
alias brci "brew cask install"
alias brcu "brew cask uninstall"
alias y "yarn"
alias r "yarn"
alias gs "git status"
alias gpnf "git push --no-verify"
alias gpnff "git push --no-verify --force"

# autocompletion for itermocil
# https://github.com/TomAnthony/itermocil#fish-autocompletion
complete -c itermocil -a "(itermocil --list)"

# Go
set --export GOPATH $HOME/go
set --export PATH $GOPATH/bin $PATH
set --export PATH $GOPATH/go_appengine $PATH

# Brew stuff
set --export PATH /usr/local/sbin $PATH

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. $HOME/.fishmarks/marks.fish

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
