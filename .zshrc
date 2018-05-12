# zmodload zsh/zprof
# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

#
# Configure the shell depending on whatever is set
# zsh :: Configure oh-my-zsh
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zsh/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# Don't set anything, I'm using pure

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history docker archlinux fasd vi-mode)

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh

if [[ "Darwin" == $OS_NAME ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Aliases
source ~/.aliases


# Fasd configuration
# eval "$(/usr/local/bin/fasd --init auto)"
eval "$(/usr/local/bin/fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Pet
# https://github.com/knqyf263/pet
function prev() {
   PREV=$(fc -lrn | head -n 1)
   sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
   BUFFER=$(pet search --query "$LBUFFER")
   CURSOR=$#BUFFER
   zle redisplay
}

zle -N pet-select
stty -ixon
bindkey '^s' pet-select

# The fuck
eval $(thefuck --alias)


# iTerm2 Integration
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Fzf
# https://github.com/junegunn/fzf
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export FZF_DEFAULT_OPTS="--reverse --inline-info"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Gopass
# Insecure directories: compaudit | xargs chmod g-w
# http://www.wezm.net/technical/2008/09/zsh-cygwin-and-insecure-directories/
# source <(gopass completion zsh)
eval $(gopass completion zsh)

# Pure Prompt
fpath=( $ZSH_CUSTOM/pure $fpath )
autoload -U promptinit; promptinit
prompt pure

