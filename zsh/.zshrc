#
# ~/.zshrc
#
# Zsh configuration for interactive shells.
#

# Exit early if the shell is not interactive
[[ $- != *i* ]] && return

# ---------------------------------------------------------
# Completion
# ---------------------------------------------------------
autoload -Uz compinit
compinit

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
PROMPT='[%n@%m %1~]$ '

# Initialize starship prompt
eval "$(starship init zsh)"

# ---------------------------------------------------------
# Tools
# ---------------------------------------------------------
# zoxide - smarter cd command
eval "$(zoxide init --cmd cd zsh)"

# uv - Python package manager
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
