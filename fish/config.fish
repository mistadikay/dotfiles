# remove greeting
set fish_greeting

# Set aliases
alias k kubectl
alias c clear
alias b babel-node
alias fi fisher
alias tc itermocil
alias brc "brew cask"
alias brci "brew cask install"
alias brcu "brew cask uninstall"
alias y yarn
alias r yarn
alias gcl "git clone"
alias gs "git status"
alias gp "git push"
alias gpnf "git push --no-verify"
alias gpnff "git push --no-verify --force"
alias git='env LANG=en_US.UTF-8 git'
alias dps='docker ps'
alias ds='docker stop'

function ku --wraps rm --description 'alias kubectl config use-context'
    kubectl config use-context arn:aws:eks:us-east-1:662431652384:cluster/k8s_$argv
end

function ks --wraps rm --description 'alias kubectl config set-context'
    kubectl config set-context --current --namespace=$argv
end

# autocompletion for itermocil
# https://github.com/TomAnthony/itermocil#fish-autocompletion
complete -c itermocil -a "(itermocil --list)"

set --export SECRETS_GPG_COMMAND gpg2

# Go
set --export GOPATH $HOME/go
set --export PATH $GOPATH/bin $PATH
set --export PATH $GOPATH/go_appengine $PATH
set --export PATH $HOME/.local/bin $PATH

# Rust
set --export PATH $HOME/.cargo/bin $PATH

# Kafka
set --export KAFKA_HOME /Applications/kafka_2.13-2.8.0/
set --export PATH $KAFKA_HOME/bin $PATH

# Brew stuff
set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
set --export PATH /usr/local/sbin $PATH

# Set GPG TTY
set -x GPG_TTY (tty)

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. $HOME/.fishmarks/marks.fish

test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

set -g fish_user_paths "/usr/local/opt/tomcat@8/bin" $fish_user_paths
fish_add_path /usr/local/opt/terraform@0.13/bin

starship init fish | source
