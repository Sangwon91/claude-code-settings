# Complete Workflow Example

**Scenario: Adding a new feature to an existing project**

## Step 1: Planning Phase

```
1. TodoWrite → Create task breakdown
2. Read/Glob → Explore codebase structure 
3. Grep → Find similar implementations for reference
4. TodoWrite → Update plan with discovered information
```

## Step 2: Implementation Phase

```
1. Read → Understand target files before modification
2. Edit/MultiEdit → Make incremental changes (20-30 lines max)
3. git diff → Review changes immediately
4. Bash → Run tests after each logical unit
5. TodoWrite → Mark subtask complete, move to next
```

## Step 3: Verification Phase

```
1. Bash → Run full test suite
2. git status → Check all changes are tracked
3. git diff → Final review before commit
4. git commit → Commit with descriptive message
5. TodoWrite → Mark main task complete
```

## Tool Usage Patterns

- **Batch operations**: Read multiple files simultaneously when exploring
- **MultiEdit over Edit**: Combine related changes to same file
- **Progress tracking**: Update TodoWrite status immediately after each completion