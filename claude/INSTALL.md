# Installing Claude Code Configuration with Stow

## Quick Install

From your dotfiles directory:

```bash
cd ~/dotfiles
stow claude
```

This creates symlinks from `~/.claude/` to `~/dotfiles/claude/.claude/`.

## What Gets Linked

```
~/.claude/settings.json -> ~/dotfiles/claude/.claude/settings.json
~/.claude/CLAUDE.md -> ~/dotfiles/claude/.claude/CLAUDE.md
~/.claude/commands/ -> ~/dotfiles/claude/.claude/commands/
~/.claude/hooks/ -> ~/dotfiles/claude/.claude/hooks/
```

## Verify Installation

```bash
# Check symlinks
ls -la ~/.claude/

# Should see symlinks pointing to dotfiles/claude/.claude/

# Test a command
claude
/commands
# Should list: review, explain, test, commit, docs
```

## Updating Configuration

Since files are symlinked, just edit in dotfiles:

```bash
cd ~/dotfiles/claude/.claude
vim settings.json
# Changes apply immediately!
```

Then commit and push:

```bash
cd ~/dotfiles
git add claude/
git commit -m "feat(claude): update configuration"
git push
```

## Installing on New Machine

```bash
# Clone dotfiles
git clone <your-dotfiles-repo> ~/dotfiles

# Stow claude config
cd ~/dotfiles
stow claude

# Done! All settings synced
```

## Uninstalling

```bash
cd ~/dotfiles
stow -D claude
# Removes all symlinks
```

## Restowing (After Updates)

If you add/remove files:

```bash
cd ~/dotfiles
stow -R claude  # Re-stow
```

## Troubleshooting

**Conflict with existing files?**

If `~/.claude/` already has non-symlinked files:

```bash
# Backup existing
mv ~/.claude ~/.claude.backup

# Then stow
cd ~/dotfiles
stow claude

# Merge any custom settings from backup if needed
```

**Symlink broken?**

```bash
cd ~/dotfiles
stow -D claude  # Remove
stow claude     # Re-create
```

**Commands not showing up?**

```bash
# Verify symlink
ls -la ~/.claude/commands

# Should point to dotfiles/claude/.claude/commands
```

## Notes

- Stow creates symlinks relative to `$HOME`
- Changes in dotfiles immediately affect `~/.claude/`
- Perfect for version control and syncing across machines
- Project-local `.claude/` still overrides global settings
