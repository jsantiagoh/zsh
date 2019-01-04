export ZSH_CACHE_DIR=$HOME/.zsh/tmp
source ~/.zsh/antigen.zsh

# Bundle from the default repo
antigen bundle git

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Fish like autosuggestions
antigen bundle zsh-users/zsh-autosuggestions

# antigen bundle zsh-users/zsh-completions

antigen bundle common-aliases
antigen bundle brew
antigen bundle pyenv
antigen bundle python
antigen bundle pylint
antigen bundle kubectl

# antigen bundle  mafredri/zsh-async

# antigen theme refined
antigen theme denysdovhan/spaceship-prompt
# antigen theme ~/.zsh/theme puro

antigen apply

# Spaceship configuration
# https://denysdovhan.com/spaceship-prompt/
SPACESHIP_GIT_STATUS_COLOR=green
SPACESHIP_KUBECONTEXT_SYMBOL="⎈ "
SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  golang        # Go section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
  )
SPACESHIP_RPROMPT_ORDER=(kubecontext)

# Command completion
autoload -Uz compinit
compinit

# Allow completion to work on aliases
setopt NO_COMPLETE_ALIASES

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

# Fasd
# https://github.com/clvv/fasd
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache


# FZF
# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pet
# https://github.com/knqyf263/pet
if [ "$(command -v pet)" ]; then
    function pet-select() {
        BUFFER=$(pet search --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle redisplay

    }

    zle -N pet-select
    stty -ixon
    bindkey '^s' pet-select
fi

# Aliases
alias ls='gls --color'
alias ll='ls -lh'
alias la='ls -a'

export EDITOR=/usr/local/bin/nvim
alias nv='nvim'
# alias nvf="$EDITOR $(fzf)"

export KUBECONFIG=$HOME/.kube/config:$HOME/.kube/config-prod:$HOME/.kube/config-acceptance:$HOME/.kube/config-ci-ie

[ -d $HOME/bin ] && export PATH=$HOME/bin:$PATH

[ -e $HOME/.localrc] && source $HOME/.localrc
