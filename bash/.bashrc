#
# ~/.bashrc
#
# Bash configuration for interactive shells.
#

# Exit early if the shell is not interactive
[[ $- != *i* ]] && return

# ---------------------------------------------------------
# Aliases
# ---------------------------------------------------------
# Enable colored output for ls (cross-platform)
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias grep='grep --color=auto'

# ---------------------------------------------------------
# Environment
# ---------------------------------------------------------
# Set Neovim as the default editor
export EDITOR=$(which nvim)
export SYSTEM_EDITOR=$EDITOR

# Add user-local binaries to PATH
export PATH="$HOME/.local/bin:$PATH"

# ---------------------------------------------------------
# Prompt
# ---------------------------------------------------------
# Fallback prompt (overridden by starship)
PS1='[\u@\h \W]\$ '

# Initialize starship prompt
eval "$(starship init bash)"

# ---------------------------------------------------------
# Tools
# ---------------------------------------------------------
# zoxide - smarter cd command
eval "$(zoxide init --cmd cd bash)"

# uv - Python package manager
eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"
