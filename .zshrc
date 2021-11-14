# dotfiles
source $HOME/.zshenv.machine

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
#export ZSH=$HOME/src/zsh_related/oh-my-zsh


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.nodebrew/current/bin

# pyenv
# export PYENV_ROOT=~/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
zstyle ':completion:*:default' menu select=1

#. /usr/local/etc/profile.d/z.sh
. $Z_CMD_DIR/z.sh
# function _Z_precmd {
#  z --add "$(pwd -P)" 61 }
#precmd_functions=($precmd_functions _Z_precmd)

# homebrew
export PATH=$PATH:$BREW_DIR/bin

eval "$(rbenv init -)"
eval "(hub alias -s)"
# . `brew --prefix`/etc/profile.d/z.sh


# 以下、「zshで範囲選択・削除・コピー・切り取りする」より
# http://qiita.com/takc923/items/35d9fe81f61436c867a8

function delete-region() {
    zle kill-region
    CUTBUFFER=$killring[1]
    shift killring
}
zle -N delete-region

function backward-delete-char-or-region() {
    if [ $REGION_ACTIVE -eq 0 ]; then
        zle backward-delete-char
    else
        zle delete-region
    fi
}
zle -N backward-delete-char-or-region

function delete-char-or-list-or-region() {
    if [ $REGION_ACTIVE -eq 0 ]; then
        zle delete-char-or-list
    else
        zle delete-region
    fi
}
zle -N delete-char-or-list-or-region

bindkey "^h" backward-delete-char-or-region
bindkey "^d" delete-char-or-list-or-region

function backward-kill-word-or-region() {
    if [ $REGION_ACTIVE -eq 0 ]; then
        zle backward-kill-word
    else
        zle kill-region
    fi
}
zle -N backward-kill-word-or-region
bindkey "^w" backward-kill-word-or-region

eval "$(direnv hook zsh)"

# for AWS CLI
# source /usr/local/share/zsh/site-functions/_aws
source $SITE_FUNCTIONS_DIR/_aws


# for pet
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

# Colorize
alias ccat='ccat -G Keyword="*glay*" -G Decimal="glay" -G Plaintext="glay" -G Punctuation="red"'

# use keychain for SSH
keychain -q ~/.ssh/id_rsa
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"

# zplug settings
source $ZPLUG_HOME/init.zsh

# settigs for zplug: zsh-syntax-highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main line brackets pattern cursor)
typeset -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_STYLES[line]='bold'

# plugins
zplug "plugins/git", from:oh-my-zsh
# zplug "plugins/kubectl", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# jenv
export JENV_ROOT="$HOME/.jenv"
if [ -d "${JENV_ROOT}" ]; then
  export PATH="$JENV_ROOT/bin:$PATH"
  eval "$(jenv init -)"
fi
