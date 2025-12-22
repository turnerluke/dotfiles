#!/bin/bash
# Format and validate files after Claude writes/edits them
# Exit 0 = success, Exit 2 = blocking error

FILE="$CLAUDE_FILE_PATH"
ERRORS=0

# Check if file exists
if [[ ! -f "$FILE" ]]; then
    exit 0
fi

# Get file extension
EXT="${FILE##*.}"
BASENAME="$(basename "$FILE")"

# ============================================
# PYTHON FILES
# ============================================
if [[ "$EXT" == "py" ]]; then
    # Format with ruff
    if command -v uv &> /dev/null; then
        uv run ruff format "$FILE" 2>/dev/null || true

        # Lint with ruff
        if ! uv run ruff check "$FILE" --quiet 2>/dev/null; then
            echo "⚠️  Ruff linting issues in $FILE" >&2
            uv run ruff check "$FILE" 2>&1 | head -10 >&2
        fi
    fi
fi

# ============================================
# JAVASCRIPT/TYPESCRIPT/JSON/MARKDOWN
# ============================================
if [[ "$EXT" =~ ^(js|ts|jsx|tsx|json|md|markdown)$ ]]; then
    # Format with prettier
    if command -v prettier &> /dev/null; then
        prettier --write "$FILE" 2>/dev/null || true
    fi
fi

# ============================================
# MARKDOWN (additional linting)
# ============================================
if [[ "$EXT" =~ ^(md|markdown)$ ]]; then
    if command -v markdownlint &> /dev/null; then
        if ! markdownlint "$FILE" 2>/dev/null; then
            echo "⚠️  Markdown linting issues in $FILE (non-blocking)" >&2
        fi
    fi
fi

# ============================================
# YAML FILES
# ============================================
if [[ "$EXT" =~ ^(yml|yaml)$ ]]; then
    # Format with prettier
    if command -v prettier &> /dev/null; then
        prettier --write "$FILE" 2>/dev/null || true
    fi

    # Lint with yamllint
    if command -v yamllint &> /dev/null; then
        if ! yamllint "$FILE" 2>/dev/null; then
            echo "⚠️  YAML linting issues in $FILE (non-blocking)" >&2
        fi
    fi
fi

# ============================================
# SHELL SCRIPTS
# ============================================
if [[ "$EXT" == "sh" ]] || [[ "$BASENAME" =~ ^(bash|zsh) ]] || head -1 "$FILE" 2>/dev/null | grep -q '^#!/bin/\(ba\)\?sh'; then
    # Check with shellcheck
    if command -v shellcheck &> /dev/null; then
        if ! shellcheck "$FILE" 2>/dev/null; then
            echo "⚠️  ShellCheck issues in $FILE (non-blocking)" >&2
            shellcheck "$FILE" 2>&1 | head -15 >&2
        fi
    fi

    # Make executable if has shebang
    if head -1 "$FILE" 2>/dev/null | grep -q '^#!'; then
        chmod +x "$FILE" 2>/dev/null || true
    fi
fi

# ============================================
# SQL FILES
# ============================================
if [[ "$EXT" == "sql" ]]; then
    # Format with sqlfluff (if in uv project)
    if command -v uv &> /dev/null && [[ -f "pyproject.toml" ]]; then
        # Only fix, don't block on lint issues
        uv run sqlfluff fix "$FILE" --force 2>/dev/null || true
    fi
fi

# ============================================
# TOML FILES
# ============================================
if [[ "$EXT" == "toml" ]]; then
    # Format with prettier if available
    if command -v prettier &> /dev/null; then
        prettier --write "$FILE" 2>/dev/null || true
    fi
fi

# Always succeed (non-blocking)
exit 0
