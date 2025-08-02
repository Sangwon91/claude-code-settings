# /setup:detect-stack

Detects project technology stack and updates existing CLAUDE.md with appropriate tech-stack imports.

## Usage
```
/setup:detect-stack
```

## Workflow

1. **Detect Current Stack**
   - Analyze package manager files (package.json, requirements.txt, etc.)
   - Identify frameworks and libraries from dependencies
   - Check for testing and build tools
   - Scan for development environment configs

2. **Check Existing Configuration**
   - Read current project's CLAUDE.md if exists
   - Identify already imported tech-stacks
   - Avoid duplicate imports

3. **Update CLAUDE.md**
   - Append new tech-stack imports at the end
   - Preserve all existing content
   - Add section marker for clarity

## Example Execution

**Before (existing CLAUDE.md):**
```markdown
# Project Guidelines

## Code Style
- Use consistent naming conventions
- Write self-documenting code
```

**After running /setup:detect-stack:**
```markdown
# Project Guidelines

## Code Style
- Use consistent naming conventions
- Write self-documenting code

## Technology Stack Guidelines
@~/.claude/tech-stacks/javascript-react.md
@~/.claude/tech-stacks/javascript-testing-jest.md
@~/.claude/tech-stacks/env-docker.md
```

## Detection Patterns

### JavaScript/Node.js
- Files: `package.json`, `yarn.lock`, `package-lock.json`
- React: Check for "react" in dependencies
- Vue: Check for "vue" in dependencies
- Testing: jest, vitest, mocha, playwright

### Python
- Files: `requirements.txt`, `pyproject.toml`, `Pipfile`
- Django: Check for "django" in dependencies
- FastAPI: Check for "fastapi" in dependencies
- Testing: pytest, unittest

### Environment
- Docker: `Dockerfile`, `docker-compose.yml`
- Kubernetes: `*.yaml`, `*.yml` with apiVersion fields
- CI/CD: `.github/workflows/`, `.gitlab-ci.yml`

## Integration with /init

This command complements Claude Code's built-in `/init`:
- Run `/init` first to create basic CLAUDE.md
- Then run `/setup:detect-stack` to add tech-specific guidelines
- Can be run multiple times as project evolves

## Notes
- Only suggests imports for existing files in ~/.claude/tech-stacks/
- Won't duplicate existing imports
- Preserves manual edits to CLAUDE.md