# Used for executing user's commands at start, will be sourced when starting as a login shell.

export LANG=C

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

# SDKMAN configuration
# See http://sdkman.io/
if [ -f "${HOME}/.sdkman/bin/sdkman-init.sh" ]; then
    export SDKMAN_DIR="${HOME}/.sdkman"
    source "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin":"$PATH"
export PYENV_VERSION='3.7.1'

# Kubectl configuration
# [[ -d ~/.kube ]] && export KUBECONFIG=$HOME/.kube/config:$HOME/.kube/config-prod:$HOME/.kube/config-acceptance:$HOME/.kube/config-ci-ie

# Python binaries, specially virtualenv
# export PATH=$PATH:$(python -m site --user-base)/bin

# Don't generate .pyc files
export PYTHONDONTWRITEBYTECODE=1

export AWS_DEFAULT_REGION=eu-west-1

[ -d ~/opt/flutter/bin ] && PATH=$HOME/opt/flutter/bin:$PATH

[[ -d ~/bin ]] && export PATH=$HOME/bin:$PATH
