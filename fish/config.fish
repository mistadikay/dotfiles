# Set aliases
alias c "clear"
alias b "babel-node"
alias fi "fisher"

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. ~/.fishmarks/marks.fish

# Go
set --export GOPATH $HOME/Go
set --export PATH $GOPATH/bin $PATH
set --export PATH $GOPATH/go_appengine $PATH
set --export GO15VENDOREXPERIMENT 1

set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish
