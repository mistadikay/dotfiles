# remove greeting
set fish_greeting

# Set aliases
alias k kubectl
alias k0 "k0s kubectl"
alias c clear
alias pn pnpm
alias fi fisher
alias tc itermocil
alias brc "brew cask"
alias brci "brew cask install"
alias brcu "brew cask uninstall"
alias gcl "git clone"
alias gs "git status"
alias gp "git push"
alias git='env LANG=en_US.UTF-8 git'
alias dps='docker ps'
alias ds='docker stop'
alias f='fzf'
alias ls='eza'
alias ll='eza -alh'
alias tree='eza --tree'

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
if command -v asdf > /dev/null
    set -gx PATH (asdf where nodejs)/bin $PATH
end

if test -f /etc/debian_version
    alias cat='batcat'
else
    alias cat='bat'
end

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
set -x ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY latest_installed

# Go
set --export GOPATH $HOME/go
set --export PATH $GOPATH/bin $PATH
set --export PATH $GOPATH/go_appengine $PATH
set --export PATH $HOME/.local/bin $PATH
set --export PATH /usr/lib/docker/cli-plugins $PATH

# Android development
set --export ANDROID_HOME $HOME/Library/Android/sdk

# Krew
set -gx PATH $PATH $HOME/.krew/bin

# Rust
set --export PATH $HOME/.cargo/bin $PATH

# Brew stuff
set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
set --export PATH /usr/local/sbin $PATH

# Set GPG TTY
set -x GPG_TTY (tty)

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. $HOME/.fishmarks/marks.fish

# Kubernetes
set --export KUBECONFIG $HOME/.kube/config

set --export EDITOR vim

starship init fish | source
