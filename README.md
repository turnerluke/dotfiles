# dotfiles

Personal dotfiles managed with GNU Stow.

## Install

```bash
# Install everything (platform-aware)
./install.sh --all

# Or specific packages
./install.sh nvim tmux zsh

# Remove symlinks
./install.sh --uninstall
```

Requires `stow` (`brew install stow` / `pacman -S stow` / `apt install stow`).

## What's included

| Package | Description |
|---------|-------------|
| nvim | Neovim config (NvChad-based) |
| tmux | tmux with catppuccin, vim-tmux-navigator |
| zsh, bash | Shell configs with starship, zoxide, uv |
| ghostty, kitty, alacritty | Terminal emulators |
| starship | Cross-shell prompt |
| lazygit | Git TUI |
| claude | Claude Code CLI settings |
| hyprland, dwm, gnome | Window managers (Linux) |
| waybar, polybar, rofi, wofi | Bars and launchers (Linux) |
