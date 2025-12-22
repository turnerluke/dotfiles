#!/bin/bash
# Validate Python files after write/edit

FILE="$CLAUDE_FILE_PATH"

# Only process Python files
if [[ ! "$FILE" =~ \.py$ ]]; then
    exit 0
fi

# Check if file exists
if [[ ! -f "$FILE" ]]; then
    exit 0
fi

# Run ruff check (linting)
if command -v uv &> /dev/null; then
    if ! uv run ruff check "$FILE" 2>&1 | head -10; then
        echo "⚠️  Ruff found issues (non-blocking)" >&2
    fi
fi

exit 0
