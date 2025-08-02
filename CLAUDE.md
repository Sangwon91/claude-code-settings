# Claude Code Development Guidelines

## Core Principles

### Essential Guidelines for Safe AI-Assisted Development
- **Plan First**: Always use TodoWrite to decompose complex tasks into verifiable steps
- **Verify Continuously**: Review and test each change before proceeding to the next
- **Seek Approval**: Consult with users before executing any git state changes or complex modifications
- **Document Intent**: Write self-explanatory code with comments that explain the reasoning behind decisions
- **Preserve Control**: Maintain human oversight throughout the development process

## 1. Preventing Massive Code Modifications Without Verification

### Core Problem
Modifying too large amounts of code makes it impossible to track how the code is actually structured, gradually turning it into a black box program and making it impossible to guarantee proper operation.

### Root Cause Analysis
- **Loss of Control**: When AI modifies hundreds of lines across multiple files simultaneously, humans lose the ability to understand and verify changes
- **Accumulating Technical Debt**: Unverified changes compound, creating unstable foundations for future development
- **Debugging Nightmare**: When issues arise, it becomes nearly impossible to trace back to the specific change that caused the problem
- **Knowledge Gap**: The gap between what the AI "knows" and what the human developer understands widens dangerously

### Mandatory Implementation Methods

#### 1. Strategic Planning and Task Decomposition
**Before any code modification:**
- Create a comprehensive plan using TodoWrite tool
- Break down complex tasks into small, human-comprehensible subtasks
- Each subtask should modify no more than 20-30 lines of code at once
- Ensure each step has a clear, verifiable outcome

**Example Task Breakdown:**
```
Large Task: "Implement user authentication system"
→ Subtask 1: Create user model schema
→ Subtask 2: Implement password hashing utility
→ Subtask 3: Create login endpoint
→ Subtask 4: Add authentication middleware
→ Subtask 5: Write unit tests for each component
```

#### 2. Step-by-Step Verification Protocol
**For every code modification:**
- Review each change immediately after implementation
- Ask clarifying questions about any unclear modifications
- Transform insights from Q&A discussions into clear, informational comments that help future readers understand the code's purpose and context
- Request explicit human verification for complex or critical modifications

**Verification Checklist:**
- [ ] Can I explain what this change does?
- [ ] Do I understand why this change was necessary?
- [ ] Does this change follow the existing code patterns?
- [ ] Are there any potential side effects?
- [ ] Is this change properly tested?

#### 3. Self-Documenting Code Principles
**Primary Goal:** Enable any coding agent to fully understand the codebase by reading only the code and comments, without external documentation dependencies.

**Code Structure Standards:**
- Use descriptive, intention-revealing names for variables, functions, and classes
- Structure code flow to mirror business logic flow
- Break complex operations into well-named, single-purpose functions
- Use consistent patterns and conventions throughout the codebase
- Make code dependencies and relationships explicit and traceable

**Comment Quality Standards:**
- Focus on **WHY** rather than **WHAT** the code does
- Explain business logic, algorithms, and decision rationale
- Document trade-offs and alternative approaches considered
- Include context about external constraints or requirements
- Reference specifications, RFCs, or business rules when relevant
- Avoid comments that merely restate what the code obviously does

**Bad Comment Example:**
```javascript
// Increment counter by 1
counter++;
```

**Good Comment Example:**
```javascript
// Incrementing retry counter to track failed API attempts
// This helps implement exponential backoff strategy per RFC 7231
counter++;
```

**Self-Documentation Checklist:**
- [ ] Can a new agent understand the purpose without external docs?
- [ ] Are variable/function names self-explanatory?
- [ ] Is the business logic flow clear from code structure?
- [ ] Do comments explain the reasoning, not just the mechanics?
- [ ] Are complex algorithms explained with their rationale?

### Claude Code Specific Implementation

#### Complete Workflow Example
**Scenario: Adding a new feature to an existing project**

**Step 1: Planning Phase**
```
1. TodoWrite → Create task breakdown
2. Read/Glob → Explore codebase structure 
3. Grep → Find similar implementations for reference
4. TodoWrite → Update plan with discovered information
```

**Step 2: Implementation Phase**
```
1. Read → Understand target files before modification
2. Edit/MultiEdit → Make incremental changes (20-30 lines max)
3. git diff → Review changes immediately
4. Bash → Run tests after each logical unit
5. TodoWrite → Mark subtask complete, move to next
```

**Step 3: Verification Phase**
```
1. Bash → Run full test suite
2. git status → Check all changes are tracked
3. git diff → Final review before commit
4. git commit → Commit with descriptive message
5. TodoWrite → Mark main task complete
```

#### Tool Usage Patterns
- **Batch operations**: Read multiple files simultaneously when exploring
- **MultiEdit over Edit**: Combine related changes to same file
- **Progress tracking**: Update TodoWrite status immediately after each completion

#### Testing and Verification Strategy
**Testing Workflow:**
- **Before starting**: Run existing tests to establish baseline
- **During development**: Test each logical unit after implementation
- **Before committing**: Execute full test suite to ensure no regressions
- **On test failures**: Analyze, fix, and re-test before proceeding

**Code Review Protocol:**
- Use `git diff` to review changes before proceeding to next steps
- Verify changes follow existing code patterns and conventions
- Ensure modifications align with project goals

#### Git Workflow Integration
**Branch Strategy:**
- Create feature branches for any non-trivial changes
- Use descriptive branch names that reflect the feature or fix

**Commit Strategy:**
- Commit after completing each logical subtask (maintains granular history)
- Use descriptive commit messages that explain the "why" behind changes
- Each commit should represent a working, testable state

#### Error Recovery Procedures
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

### Performance Optimization Notes
**For improved Claude Code performance:**
- **Use batch tool calls when reading multiple files**: Execute multiple Read/Grep operations simultaneously rather than sequentially to reduce total response time
- **Pre-plan file modifications to minimize back-and-forth**: Use MultiEdit for multiple changes to the same file instead of separate Edit calls to reduce context switching overhead
- **Cache understanding of codebase structure in memory**: Remember project architecture, file locations, and patterns discovered during the session to avoid redundant exploration
- **Use specific file paths rather than broad searches when possible**: Target exact files when you know the location instead of using Grep across entire project to reduce processing time

### Quality Gates
**Never proceed without:**
- [ ] Clear understanding of the change being made
- [ ] Verification that tests still pass
- [ ] Human-readable explanation of the modification
- [ ] Self-documenting code that explains its purpose and rationale
- [ ] Confirmation that the change aligns with project goals

### Emergency Protocols
**If you find yourself:**
- Making changes you don't fully understand → STOP and ask questions
- Modifying more than 30 lines without verification → Break into smaller tasks
- Getting test failures you can't explain → Use git recovery protocol to revert
- Feeling lost in the codebase → Use TodoWrite to reorganize and refocus

**Note**: The 30-line limit aligns with the subtask sizing guideline for consistent change management.

This approach ensures that AI-assisted development remains transparent, verifiable, and maintainable while maximizing the benefits of AI acceleration.