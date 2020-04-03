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
alias gcl "git clone"
alias gs "git status"
alias gp "git push"
alias gpnf "git push --no-verify"
alias gpnff "git push --no-verify --force"
alias git='env LANG=en_US.UTF-8 git'
alias dps='docker ps'
alias ds='docker stop'

# autocompletion for itermocil
# https://github.com/TomAnthony/itermocil#fish-autocompletion
complete -c itermocil -a "(itermocil --list)"

set --export SECRETS_GPG_COMMAND gpg2

# Go
set --export GOPATH $HOME/go
set --export PATH $GOPATH/bin $PATH
set --export PATH $GOPATH/go_appengine $PATH
set --export PATH $HOME/.local/bin $PATH

# Google Cloud SDK
set --export PATH $HOME/google-cloud-sdk/bin $PATH

# Rust
set --export PATH $HOME/.cargo/bin $PATH

# Brew stuff
set --export PATH /usr/local/sbin $PATH

# Anaconda
set --export PATH $HOME/opt/anaconda3/bin $PATH

# pgloader (built from source because see link below)
# https://github.com/Homebrew/homebrew-core/issues/31591
set --export PATH /Applications/pgloader/build/bin $PATH

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. $HOME/.fishmarks/marks.fish

test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/yes/google-cloud-sdk/path.fish.inc ]
    echo "stuff"
    . $HOME/yes/google-cloud-sdk/path.fish.inc
end
set -g fish_user_paths "/usr/local/opt/tomcat@8/bin" $fish_user_paths

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/denis.koltsov/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

