#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# neovim as defaullt editor
export EDITOR=$(which nvim)
export SYSTEM_EDITOR=$EDITOR
export SYSTEM_EDITOR=$EDITOR

# starship
eval "$(starship init bash)"

# virtualenv wrapper config
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

