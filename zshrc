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
SPACESHIP_GIT_STATUS_PREFIX=' '
SPACESHIP_GIT_STATUS_SUFFIX=''
SPACESHIP_GIT_STATUS_STASHED=''

# SPACESHIP_KUBECONTEXT_COLOR=grey
SPACESHIP_KUBECONTEXT_PREFIX=""
SPACESHIP_KUBECONTEXT_SYMBOL="⎈ "
SPACESHIP_KUBECONTEXT_COLOR_GROUPS=(
    magenta acceptance
    green   ci
    red     production
)
SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_DOCKER_SHOW=false

SPACESHIP_PYENV_SHOW=false
SPACESHIP_VENV_SYMBOL='Ⓟ '
SPACESHIP_VENV_PREFIX=''

SPACESHIP_EXEC_TIME_PREFIX='⏱  '
SPACESHIP_EXEC_TIME_ELAPSED=5

SPACESHIP_AWS_SYMBOL='☁ '
SPACESHIP_AWS_PREFIX=''


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
SPACESHIP_RPROMPT_ORDER=(
  kubecontext   # Kubectl context
  )

# Command completion
autoload -Uz compinit
compinit

# Allow completion to work on aliases
setopt NO_COMPLETE_ALIASES

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
# setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.


# Antibody configuration
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

# Bat
if command -v bat 1>/dev/null 2>&1 ; then
    export BAT_THEME="TwoDark"
    alias cat=bat
fi

# direnv
if command -v direnv 1>/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

# fuck
if command -v fuck 1>/dev/null 2>&1; then
    eval "$(thefuck --alias)"
fi

# Pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  # eval "$(pyenv virtualenv-init -)"
fi


[[ -f ~/.aliases ]] && source ~/.aliases

[[ -f ~/.localrc ]] && source ~/.localrc

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
