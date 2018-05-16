# Used for executing user's commands at start, will be sourced when starting as a login shell.

export LC_ALL=C

export OS_NAME=$(uname)
[ -f $HOME/.localrc ] && source $HOME/.localrc

export EDITOR=/usr/local/bin/nvim

# Go environment
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Brew
# See https://gist.github.com/christopheranderton/8644744
# Define this in ~/.localrc
# export HOMEBREW_GITHUB_API_TOKEN

brewup() {
  brew update && brew upgrade && brew cleanup && brew cask cleanup
}


# AWS Configuration
# TODO move this to a specific config
export AWS_DEFAULT_REGION=eu-west-1


# SDKMAN configuration
# See http://sdkman.io/
if [ -f "${HOME}/.sdkman/bin/sdkman-init.sh" ]; then
    export SDKMAN_DIR="${HOME}/.sdkman"
    source "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi


# Python binaries, specially virtualenv
export PATH=$PATH:$(python -m site --user-base)/bin
