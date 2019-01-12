# zmodload zsh/zprof
# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

export EDITOR=/usr/local/bin/nvim

export ZSH_CACHE_DIR=$HOME/.zsh/tmp

# Spaceship configuration
# https://denysdovhan.com/spaceship-prompt/
# SPACESHIP_DIR_TRUNC=1
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_STATUS_COLOR=green
SPACESHIP_KUBECONTEXT_PREFIX=""
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
  kubecontext
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
  )
SPACESHIP_RPROMPT_ORDER=(
  )

# Command completion
autoload -Uz compinit
compinit

# Allow completion to work on aliases
setopt NO_COMPLETE_ALIASES

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history



source <(antibody init)
antibody bundle < ~/.zsh/plugins.txt


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

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


[[ -f ~/.aliases ]] && source ~/.aliases

[[ -f ~/.localrc ]] && source ~/.localrc
