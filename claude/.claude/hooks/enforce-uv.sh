#!/bin/bash
# Automatically enforce uv for Python tools
# Ensures project dependencies are run via 'uv run' for consistency

COMMAND="$CLAUDE_COMMAND"

# List of tools that should always use 'uv run'
# Add more tools here as needed
UV_TOOLS=(
    "ruff"
    "pytest"
    "sqlfluff"
    "black"
    "isort"
    "mypy"
    "pylint"
    "flake8"
    "dbt"
    "dagster"
    "coverage"
    "bandit"
    "vulture"
)

# Check if we're in a Python project (has pyproject.toml or uv.lock)
is_python_project() {
    [[ -f "pyproject.toml" ]] || [[ -f "uv.lock" ]] || [[ -f "requirements.txt" ]]
}

# Check if command starts with any of the UV_TOOLS
should_use_uv() {
    local cmd="$1"

    # Already using uv? Skip
    if [[ "$cmd" =~ ^uv\ run ]]; then
        return 1
    fi

    # Check each tool
    for tool in "${UV_TOOLS[@]}"; do
        if [[ "$cmd" =~ ^${tool}[[:space:]] ]] || [[ "$cmd" == "$tool" ]]; then
            return 0
        fi
    done

    return 1
}

# Only enforce in Python projects
if is_python_project; then
    if should_use_uv "$COMMAND"; then
        # Extract the tool name for better messaging
        TOOL=$(echo "$COMMAND" | awk '{print $1}')

        # Rewrite command to use uv run
        NEW_COMMAND="uv run $COMMAND"

        # Inform user (shown in verbose mode)
        echo "→ Enforcing uv: $TOOL → uv run $TOOL" >&2

        # Note: This sets the variable but PreToolUse hooks can't actually
        # rewrite commands. This serves as documentation and warning.
        # The real enforcement comes from CLAUDE.md memory.
        export CLAUDE_COMMAND="$NEW_COMMAND"
    fi
fi

exit 0
