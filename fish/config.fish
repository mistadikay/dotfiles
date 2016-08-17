# remove greeting
set fish_greeting

# autoload nvm
bass source $HOME/.nvm/nvm.sh >/dev/null ^&1

# Set aliases
alias c "clear"
alias b "babel-node"
alias fi "fisher"


# Go
set --export GOPATH $HOME/Go
set --export PATH $GOPATH/bin $PATH
set --export PATH $GOPATH/go_appengine $PATH
set --export GO15VENDOREXPERIMENT 1

# for homebrew
set --export PATH /usr/local/sbin $PATH

# https://github.com/rgcr/m-cli
set --export PATH /usr/local/m-cli $PATH

# fisher stuff
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. $HOME/.fishmarks/marks.fish

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
