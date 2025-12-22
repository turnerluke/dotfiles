# Personal Claude Code Memory

## My Preferences

### Code Style
- Use clear, descriptive variable names
- Prefer explicit over implicit
- Add comments for complex logic only
- Follow project-specific conventions when they exist

### Development Tools
- **Editor**: VS Code / Neovim
- **Shell**: Bash
- **Python**: Use `uv` for package management
- **Git**: Conventional commits preferred

### Communication Style
- Be concise and direct
- Show code examples when explaining
- Explain the "why" behind decisions
- Ask clarifying questions when ambiguous

## My Workflow Preferences

### When Writing Code
1. Understand requirements first
2. Plan approach before implementing
3. Write tests for new features
4. Keep commits atomic and well-described

### When Debugging
1. Read error messages carefully
2. Check logs before making changes
3. Verify assumptions with tests
4. Document non-obvious fixes

### Project Standards
- Always run formatters (ruff, prettier, etc.)
- Run tests before committing
- Update documentation when changing APIs
- Follow existing patterns in the codebase

## Common Tasks

### Python Projects
- Use `uv` for dependency management
- Run `uv run ruff format` before committing
- Run `uv run pytest` for testing
- Use type hints (strict mode when possible)

### Git Workflow
- Commit format: `type(scope): message`
- Types: feat, fix, docs, style, refactor, test, chore
- Always review diffs before committing
- Keep branches focused on single changes

## Environment

- **OS**: Linux (WSL2)
- **Shell**: Bash
- **Primary Languages**: Python, TypeScript, JavaScript
- **Common Tools**: git, uv, docker, npm

## Notes to Remember

- I prefer learning by doing - show examples
- I value understanding over quick fixes
- I appreciate explanations of tradeoffs
- I like to see the bigger picture before diving into details

## Common Patterns I Use

### Python
- Use `uv` for all package management
- **CRITICAL**: Always run Python tools via `uv run`:
  - `uv run ruff` (NOT `ruff`)
  - `uv run pytest` (NOT `pytest`)
  - `uv run sqlfluff` (NOT `sqlfluff`)
  - `uv run mypy`, `uv run black`, etc.
- Type hints with `strict` mode when possible
- Pytest for testing with clear test names
- FastAPI for APIs, Click for CLIs
- SQLAlchemy for databases
- Pydantic for data validation

### TypeScript/JavaScript
- Strict TypeScript configuration
- Vitest/Jest for testing
- ESLint + Prettier for quality
- Functional patterns over classes when simple
- Async/await over callbacks
- Named exports over default exports

### SQL
- Always use parameterized queries
- Add indexes for frequently queried columns
- Avoid SELECT * in production
- Use CTEs for complex queries
- Lint/format with `uv run sqlfluff lint` or `uv run sqlfluff fix`
- Run dbt via `uv run dbt [command]`

### Git
- Conventional commits: `type(scope): message`
- Small, focused commits
- Descriptive branch names: `feature/description`
- Rebase to keep history clean
- PR descriptions explain "why"

### Code Review Focus
- Security vulnerabilities first
- Then correctness and edge cases
- Then performance implications
- Then maintainability and style
- Always acknowledge good patterns

### When Stuck
1. Read error messages fully
2. Check logs and traces
3. Verify assumptions with tests
4. Simplify to minimal reproduction
5. Search docs, then issues, then code
