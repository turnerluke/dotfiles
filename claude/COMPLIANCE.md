# Code Compliance Setup

Automatic formatting and validation for all code written by Claude Code.

## How It Works

Every time Claude **writes** or **edits** a file, the `format-and-validate.sh` hook runs automatically:

```
Claude writes file.py
    ↓
Hook runs automatically
    ↓
1. Format with ruff
2. Validate with ruff check
3. Show warnings (non-blocking)
    ↓
File is formatted and validated
```

## Supported Languages

| Language | Formatter | Validator | Status |
|----------|-----------|-----------|--------|
| **Python** | ruff format | ruff check | ✅ Active |
| **JavaScript/TypeScript** | prettier | - | ✅ Active |
| **JSON** | prettier | - | ✅ Active |
| **Markdown** | prettier | markdownlint | ✅ Active |
| **YAML** | prettier | yamllint | ✅ Active |
| **Shell** | - | shellcheck | ✅ Active |
| **SQL** | sqlfluff fix | - | ✅ Active |
| **TOML** | prettier | - | ✅ Active |

## Installation

### 1. Required Tools

```bash
# Python tools (in your projects with uv)
uv add --dev ruff sqlfluff

# Node tools (global)
npm install -g prettier markdownlint-cli

# System tools
sudo apt install yamllint shellcheck  # Debian/Ubuntu
brew install yamllint shellcheck      # macOS
```

### 2. Verify Hook is Active

```bash
# Check symlink
ls -la ~/.claude/hooks/format-and-validate.sh

# Should point to: ../dotfiles/claude/.claude/hooks/format-and-validate.sh
```

### 3. Test It

```bash
# Enable verbose mode to see hook output
claude --verbose

# Or toggle during session
Ctrl+O
```

## Examples

### Python File

```python
# Claude writes this (poorly formatted):
def hello(  name  ):
  print(  f"Hello {name}"  )
```

**Hook automatically formats to:**
```python
# Formatted by ruff
def hello(name):
    print(f"Hello {name}")
```

**And validates:**
```
✅ Formatted with ruff
⚠️  Line too long (E501) - shown in verbose mode
```

### Markdown File

```markdown
# Claude writes this
##Bad heading spacing
- list item
-another item
```

**Hook automatically formats to:**
```markdown
# Formatted by prettier

## Bad heading spacing

- list item
- another item
```

**And validates:**
```
✅ Formatted with prettier
⚠️  MD022/blanks-around-headings - shown in verbose mode
```

### Shell Script

```bash
# Claude writes this
#!/bin/bash
echo "hello"
```

**Hook automatically:**
1. Makes file executable (`chmod +x`)
2. Validates with shellcheck
3. Shows any issues in verbose mode

## Configuration

### Make Validation Blocking

By default, validation warnings don't stop Claude. To block on errors:

Edit `~/.claude/hooks/format-and-validate.sh`:

```bash
# Change last line from:
exit 0

# To:
exit $ERRORS
```

Now Claude will be notified of validation errors and can fix them.

### Disable Specific Validators

Comment out sections you don't want:

```bash
# Disable yamllint
# if command -v yamllint &> /dev/null; then
#     yamllint "$FILE"
# fi
```

### Add Custom Tools

Add new formatters/validators:

```bash
# Add Go support
if [[ "$EXT" == "go" ]]; then
    gofmt -w "$FILE" 2>/dev/null || true
    golangci-lint run "$FILE" 2>/dev/null || true
fi
```

## Verbose Mode

See hook output in real-time:

```bash
# Start with verbose
claude --verbose

# Or toggle during session
Ctrl+O
```

Output shows:
```
✅ Formatted test.py with ruff
⚠️  Ruff linting issues:
    line 42: E501 line too long
✅ File saved
```

## Integration with Git

### Pre-commit Hooks

Already using pre-commit? Add:

```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: claude-format
        name: Format with Claude hook
        entry: bash ~/.claude/hooks/format-and-validate.sh
        language: system
        pass_filenames: true
```

### Manual Validation

Run the hook manually on any file:

```bash
export CLAUDE_FILE_PATH="./src/api.py"
bash ~/.claude/hooks/format-and-validate.sh
```

## Troubleshooting

### Hook Not Running

**Check settings.json:**
```bash
grep -A5 "PostToolUse" ~/.claude/settings.json
```

Should show:
```json
"PostToolUse": [
  {
    "matcher": "Write|Edit",
    "hooks": [
      {
        "type": "command",
        "command": "bash ~/.claude/hooks/format-and-validate.sh"
      }
    ]
  }
]
```

**Check hook is executable:**
```bash
ls -la ~/.claude/hooks/format-and-validate.sh
```

Should show: `-rwxr-xr-x`

### Formatter Not Found

**Check if tool is installed:**
```bash
which prettier
which ruff
which yamllint
which shellcheck
```

**Install missing tools** (see Installation section above)

### Validation Always Passes

The hook is **non-blocking by default** - it shows warnings but doesn't stop Claude.

To make it blocking, edit the hook and change `exit 0` to `exit $ERRORS`.

### Slow Performance

Formatters are fast (<100ms), but if slow:

1. **Check tool versions** - Newer versions are faster
2. **Disable unused validators** - Comment out sections
3. **Use project-specific config** - Limit scope

## Advanced

### Project-Specific Overrides

Create `.claude/hooks/` in your project to override global hooks:

```bash
cd ~/my-project
mkdir -p .claude/hooks
cp ~/.claude/hooks/format-and-validate.sh .claude/hooks/
# Edit for project-specific needs
```

Project hooks take precedence over global.

### Conditional Formatting

Only format in certain directories:

```bash
# In format-and-validate.sh
if [[ "$FILE" =~ ^./src/ ]]; then
    # Only format files in src/
    ruff format "$FILE"
fi
```

### Multiple Hooks

Run multiple hooks in sequence:

```json
"hooks": [
  {
    "type": "command",
    "command": "bash ~/.claude/hooks/format-and-validate.sh"
  },
  {
    "type": "command",
    "command": "bash ~/.claude/hooks/custom-check.sh"
  }
]
```

## What Gets Logged

The hook logs to:
- **Audit log**: `~/.claude/command-audit.log` (all bash commands)
- **Session log**: `~/.claude/session.log` (session starts)
- **Hook output**: Shown in verbose mode only

Review logs:
```bash
tail -f ~/.claude/command-audit.log
```

## Benefits

✅ **Consistent formatting** - All code follows standards
✅ **Automatic validation** - Catch issues immediately
✅ **No manual work** - Happens automatically
✅ **Language-aware** - Different tools for different languages
✅ **Non-intrusive** - Warnings don't block (by default)
✅ **Fast** - <100ms overhead per file
✅ **Customizable** - Easy to modify or extend

## Next Steps

1. **Install required tools** (see Installation)
2. **Enable verbose mode** to see it working
3. **Customize validators** if needed
4. **Commit to dotfiles** so it syncs across machines

```bash
cd ~/dotfiles
git add claude/.claude/hooks/
git commit -m "feat(claude): add comprehensive formatting and validation hooks"
git push
```

Now all your machines will have the same compliance setup! 🎉
