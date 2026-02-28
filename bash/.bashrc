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

# ---------------------------------------------------------
# Functions
# ---------------------------------------------------------
# lazygit wrapper with bare repo worktree support
lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
    if [ -f .git ] && [ -d .bare ]; then
        local wt
        wt=$(git worktree list --porcelain | awk '/^worktree / && !/\.bare$/ {print $2; exit}')
        if [ -n "$wt" ]; then
            lazygit -p "$wt"
        else
            echo "No linked worktrees found. Create one with: git worktree add <name>"
        fi
    else
        lazygit "$@"
    fi
    if [ -f "$LAZYGIT_NEW_DIR_FILE" ]; then
        cd "$(cat "$LAZYGIT_NEW_DIR_FILE")"
        rm -f "$LAZYGIT_NEW_DIR_FILE"
    fi
}
