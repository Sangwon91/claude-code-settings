# Git Workflow Integration

## Branch Strategy

- Create feature branches for any non-trivial changes
- Use descriptive branch names that reflect the feature or fix

## Commit Strategy

- Commit after completing each logical subtask (maintains granular history)
- Use descriptive commit messages that explain the "why" behind changes
- Each commit should represent a working, testable state

## Error Recovery Procedures

**When things go wrong:**
1. Stop immediately - don't try to "fix forward" blindly
2. Use `git status` and `git diff` to understand current state
3. Ask specific questions about the problematic changes
4. **Git State Recovery Protocol:**
   - Identify the last known good commit using `git log --pretty=format:"%h %s%n%b" -10`
   - Analyze commit messages to understand the change history and potential recovery points
   - Present current state and proposed recovery options to user
   - **Consult with user to determine what constitutes a "good state" for recovery**
   - **NEVER execute git reset, revert, or checkout without explicit user approval**
   - Clearly explain what will be lost and what will be preserved for each option
   - Offer multiple recovery options (stash, branch, reset soft/hard, selective revert)
   - Wait for user confirmation before any destructive git operations
5. Re-plan the approach with smaller steps after recovery