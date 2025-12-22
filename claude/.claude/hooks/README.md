# Hooks Documentation

## enforce-uv.sh

Ensures Python tools are run via `uv run` for consistency.

### What It Does

Checks commands before execution and warns if Python tools should use `uv run`:

**Enforced Tools:**
- `ruff` → `uv run ruff`
- `pytest` → `uv run pytest`
- `sqlfluff` → `uv run sqlfluff`
- `black`, `isort`, `mypy`, `pylint`, `flake8`
- `dbt`, `dagster`
- `coverage`, `bandit`, `vulture`

**Smart Detection:**
- Only enforces in Python projects (checks for `pyproject.toml`, `uv.lock`, or `requirements.txt`)
- Skips if already using `uv run`
- Shows helpful message: `→ Enforcing uv: ruff → uv run ruff`

### Adding New Tools

Edit the `UV_TOOLS` array in `enforce-uv.sh`:

```bash
UV_TOOLS=(
    "ruff"
    "pytest"
    "your-tool-here"  # Add here
)
```

Or use the command: `/add-uv-tool your-tool-name`

### How It Works

```
Claude runs: pytest tests/
    ↓
Hook detects: Python project + pytest command
    ↓
Warning: → Enforcing uv: pytest → uv run pytest
    ↓
Claude sees warning and follows CLAUDE.md guidance
```

**Note**: PreToolUse hooks can't rewrite commands directly, but this hook:
1. Warns when bare commands are used (in verbose mode)
2. Works with CLAUDE.md memory to guide Claude's behavior
3. Serves as documentation of the uv enforcement policy

---

## format-and-validate.sh

Comprehensive hook that automatically formats and validates files after Claude writes or edits them.

### What It Does

**Formats (Auto-fix):**
- Python → `ruff format`
- JS/TS/JSON/MD → `prettier --write`
- YAML → `prettier --write`
- SQL → `sqlfluff fix` (if in uv project)
- TOML → `prettier --write`
- Shell scripts → Make executable if has shebang

**Validates (Warns only):**
- Python → `ruff check`
- Markdown → `markdownlint`
- YAML → `yamllint`
- Shell → `shellcheck`

### Required Tools

Install these for full functionality:

```bash
# Python tools (via uv)
uv add --dev ruff

# Node tools (global)
npm install -g prettier markdownlint-cli

# System tools
sudo apt install yamllint shellcheck  # Debian/Ubuntu
brew install yamllint shellcheck      # macOS
```

### Behavior

- **Exit 0**: Always succeeds (non-blocking)
- **Warnings**: Shown in verbose mode (`Ctrl+O`)
- **Formatting**: Happens silently
- **Validation**: Errors shown but don't block

### Customization

Edit `/home/turner/dotfiles/claude/.claude/hooks/format-and-validate.sh`:

**Make validation blocking** (fail on errors):
```bash
# Change this:
exit 0

# To this:
exit $ERRORS  # Will block if ERRORS > 0
```

**Disable specific validators:**
```bash
# Comment out sections you don't want:
# if command -v yamllint &> /dev/null; then
#     ...
# fi
```

**Add custom formatters:**
```bash
# Add at the end before exit 0:
if [[ "$EXT" == "go" ]]; then
    gofmt -w "$FILE" 2>/dev/null || true
fi
```

### Testing

Test the hook manually:

```bash
export CLAUDE_FILE_PATH="/path/to/test.py"
bash ~/.claude/hooks/format-and-validate.sh
```

### Debugging

Enable verbose mode in Claude Code:
```bash
claude --verbose
```

Or toggle during session: `Ctrl+O`

This shows all hook output including warnings.

### File Type Detection

The hook detects file types by:
1. Extension (`.py`, `.js`, `.md`, etc.)
2. Filename pattern (`bash`, `zsh`)
3. Shebang line (`#!/bin/bash`)

### Performance

- Fast: Most formatters run in <100ms
- Parallel-safe: Each file processed independently
- Graceful degradation: Missing tools are skipped

### Integration with Git

For pre-commit integration, add to `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: local
    hooks:
      - id: format-and-validate
        name: Format and Validate
        entry: bash ~/.claude/hooks/format-and-validate.sh
        language: system
        pass_filenames: true
```

### Troubleshooting

**Hook not running?**
- Check settings.json has the hook configured
- Verify hook script is executable: `ls -la ~/.claude/hooks/`
- Enable verbose mode to see output

**Formatter not found?**
- Install missing tools (see Required Tools above)
- Check tool is in PATH: `which prettier`
- Hook gracefully skips missing tools

**Validation always passes?**
- Hook is non-blocking by default
- Change `exit 0` to `exit $ERRORS` to block on errors
- Or review warnings in verbose mode
