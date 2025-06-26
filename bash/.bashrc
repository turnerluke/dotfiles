#
# ~/.bashrc
#

# Exit early if the shell is not interactive
[[ $- != *i* ]] && return

# Enable colored output for ls and grep
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Customize the shell prompt to show: [user@host current-directory]$
PS1='[\u@\h \W]\$ '

# Set Neovim as the default editor
export EDITOR=$(which nvim)
export SYSTEM_EDITOR=$EDITOR

# starship
eval "$(starship init bash)"

# zoxide
eval "$(zoxide init --cmd cd bash)"

# Add user-local binaries to PATH
export PATH="/home/turner/.local/bin:$PATH"

# Enable shell autocompletion for uv
eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"
