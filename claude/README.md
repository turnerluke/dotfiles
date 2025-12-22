# Claude Code Configuration

Personal Claude Code settings managed with GNU Stow.

## Structure

```
claude/
└── .claude/
    ├── settings.json      # Main configuration with hooks
    ├── CLAUDE.md          # Personal memory/preferences
    ├── commands/          # Custom slash commands
    │   ├── review        # Code review
    │   ├── explain       # Explain concepts
    │   ├── test          # Generate tests
    │   ├── commit        # Git commits
    │   └── docs          # Generate docs
    └── hooks/            # Hook scripts
        └── validate-python.sh
```

## Installation

From your dotfiles directory:

```bash
cd ~/dotfiles
stow claude
```

This creates symlink: `~/.claude -> dotfiles/claude/.claude`

## Features

### Hooks (Automatic)

**PostToolUse** - Auto-format after writing files:
- Python: `ruff format`
- JS/TS/JSON/MD: `prettier`

**PreToolUse** - Audit bash commands:
- Logs all commands to `~/.claude/command-audit.log`

**SessionStart** - Session tracking:
- Logs sessions to `~/.claude/session.log`

### Commands (Manual)

```bash
/review <file>      # Review code quality
/explain <topic>    # Explain concept or code
/test <file>        # Generate tests
/commit             # Create git commit
/docs <file>        # Generate documentation
```

### Memory

Personal preferences in `CLAUDE.md`:
- Code style preferences
- Workflow patterns
- Development tools
- Communication style

Auto-loaded in every session via `memory.include` setting.

## Command Policies

**Always Allow**:
- Read-only: `ls`, `cat`, `grep`, `find`, etc.
- Git read: `git status`, `git log`, `git diff`
- Formatters: `ruff`, `prettier`, `pre-commit`

**Always Ask**:
- Destructive: `rm`, `mv`, `git push`
- Installation: `uv add`, `npm install`
- System: `sudo`, `systemctl`

**Always Deny**:
- Dangerous: `rm -rf /`, `chmod 777`, `curl | sh`

## Usage

### Check Current Config
```bash
cat ~/.claude/settings.json  # Via symlink
```

### Update Config
```bash
cd ~/dotfiles/claude/.claude
vim settings.json
# Changes apply immediately (symlinked)
```

### List Available Commands
```bash
/commands
```

### View Memory
```bash
/memory
```

### Add Custom Commands

Create new file in `dotfiles/claude/.claude/commands/`:

```markdown
---
description: "My custom command"
---

Your prompt here with {{$1}} variables.
```

Changes apply immediately (symlinked).

## Customization

### Add Project-Specific Commands

For project-local commands, create `.claude/commands/` in your project:

```bash
cd ~/my-project
mkdir -p .claude/commands
```

These override/extend global commands.

### Add More Hooks

Edit `settings.json` and add to the `hooks` object:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "your-script.sh"
          }
        ]
      }
    ]
  }
}
```

### Disable Hooks Temporarily

Set environment variable:
```bash
export CLAUDE_DISABLE_HOOKS=1
claude
```

## Syncing Across Machines

Since this is in your dotfiles repo:

1. **New machine**: `git clone` dotfiles, then `stow claude`
2. **Updates**: `git pull` in dotfiles directory
3. **Changes**: Commit and push from any machine

All your Claude Code settings stay in sync!

## Logs

- **Command audit**: `~/.claude/command-audit.log`
- **Session log**: `~/.claude/session.log`

Review these to understand what Claude Code is doing.

## Advanced

### Hook Debugging

Enable verbose mode:
```bash
claude --verbose
```

Or toggle in session: `Ctrl+O`

### Test Hook Scripts

```bash
export CLAUDE_FILE_PATH="/path/to/test.py"
bash ~/.claude/hooks/validate-python.sh
```

### Background Tasks

Long-running commands: `Ctrl+B`
Check output: `/bash-output <id>`

## Resources

- Full guides: `~/projects/notes/ai/claude/`
- Official docs: https://code.claude.com/docs/
- Feedback: `/feedback` in Claude Code

## Notes

- Hooks run with your shell environment
- Commands have no file extension
- Memory is auto-loaded every session
- Settings changes apply immediately (symlinked)
- Project `.claude/` overrides global `~/.claude/`
