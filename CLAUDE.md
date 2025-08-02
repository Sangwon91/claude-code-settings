# Claude Code Development Guidelines

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
- Test functionality after each meaningful change
- Use `git diff` to review changes before proceeding to next steps
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

#### Mandatory Tool Usage Patterns
```
1. TodoWrite → Plan all complex tasks
2. Read → Understand existing code before modification  
3. Edit/MultiEdit → Make small, focused changes
4. Bash → Run tests after each meaningful change
5. TodoWrite → Update progress immediately
```

#### Git Workflow Integration
- Create feature branches for any non-trivial changes
- Commit after completing each subtask (not just at the end)
- Use descriptive commit messages that explain the "why"
- Run tests before each commit
- Use `git diff` to review changes before committing

#### Error Recovery Procedures
**When things go wrong:**
1. Stop immediately - don't try to "fix forward" blindly
2. Use `git status` and `git diff` to understand current state
3. Ask specific questions about the problematic changes
4. Consider reverting to last known good state
5. Re-plan the approach with smaller steps

### Performance Optimization Notes
**For improved Claude Code performance:**
- Use batch tool calls when reading multiple files
- Pre-plan file modifications to minimize back-and-forth
- Cache understanding of codebase structure in memory
- Use specific file paths rather than broad searches when possible

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
- Modifying more than 50 lines without verification → Break into smaller tasks
- Getting test failures you can't explain → Revert and re-approach
- Feeling lost in the codebase → Use TodoWrite to reorganize and refocus

This approach ensures that AI-assisted development remains transparent, verifiable, and maintainable while maximizing the benefits of AI acceleration.