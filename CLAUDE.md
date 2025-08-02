# Claude Code Development Guidelines

## Core Principles

### Essential Guidelines for Safe AI-Assisted Development
- **Plan First**: Always use TodoWrite to decompose complex tasks into verifiable steps
- **Verify Continuously**: Review and test each change before proceeding to the next
- **Seek Approval**: Consult with users before executing any git state changes or complex modifications
- **Document Intent**: Write self-explanatory code with comments that explain the reasoning behind decisions
- **Preserve Control**: Maintain human oversight throughout the development process

## 🚨 Preventing Massive Code Modifications Without Verification

### Core Problem
Modifying too large amounts of code makes it impossible to track how the code is actually structured, gradually turning it into a black box program and making it impossible to guarantee proper operation.

### Root Cause Analysis
- **Loss of Control**: When AI modifies hundreds of lines across multiple files simultaneously, humans lose the ability to understand and verify changes
- **Accumulating Technical Debt**: Unverified changes compound, creating unstable foundations for future development
- **Debugging Nightmare**: When issues arise, it becomes nearly impossible to trace back to the specific change that caused the problem
- **Knowledge Gap**: The gap between what the AI "knows" and what the human developer understands widens dangerously

## 🔧 Mandatory Implementation Methods

**⚠️ CRITICAL**: The following principles must be applied in ALL coding sessions without exception.

### Core Implementation Principles
- **Strategic Planning**: @guides/core-principles/task-decomposition.md
- **Step-by-Step Verification**: @guides/core-principles/verification-protocol.md  
- **Self-Documenting Code**: @guides/core-principles/self-documenting-code.md
- **Git Workflow Management**: @guides/core-principles/git-workflow.md
- **Performance Optimization**: @guides/core-principles/performance-optimization.md

### Development Workflows
- **Complete Development Cycle**: @guides/workflows/development-cycle.md

### Development Practices
- **Environment Setup**: @guides/development-practices/env-local.md
- **Testing Strategy**: @guides/development-practices/testing-strategy.md
- **Technology Stack Command Guide**: @guides/development-practices/tech-stack-command-guide.md

### Utilities
- **Project Stack Detection**: @commands/setup/detect-stack.md

### Technology Stack Guidelines
- **React + TypeScript + Vite**: @guides/technology-stacks/react+typescript+vite.md
- **React + TypeScript + Vite + shadcn/ui**: @guides/technology-stacks/react+typescript+vite+shadcn-ui.md
- **uv + pytest**: @guides/technology-stacks/uv+pytest.md

## 🛠️ Technology Stack Management

### Current Technology Information Requirements
**⚠️ CRITICAL**: When working with any technology stack, always verify you're using the latest compatible versions and best practices.

#### Context7 Integration for Latest Documentation
- **Always check latest documentation** using context7 tools before implementing any technology-specific patterns
- **Verify compatibility matrices** between different technologies in your stack
- **Cross-reference** official documentation with community best practices

#### Version Management Protocol
When detecting version mismatches between project dependencies and latest available versions:

1. **Identify the mismatch**: Compare project versions against latest stable releases
2. **Assess impact**: Determine if the version difference affects functionality, security, or performance
3. **Consult with user**: Present clear options and implications
   - **Option A**: Update project to latest versions (requires testing and potential refactoring)
   - **Option B**: Continue with current versions (document any limitations or security considerations)
   - **Option C**: Selective updates (update only critical components)

#### Technology Information Validation
- **Use context7** to fetch latest official documentation for any technology in your stack
- **Verify breaking changes** between versions before suggesting updates
- **Document dependencies** and their version constraints clearly
- **Test compatibility** before committing to version updates

#### Project Technology Alignment
Before implementing any feature:
- [ ] Check if project uses latest stable versions
- [ ] Identify any deprecated patterns or outdated practices
- [ ] Propose updates when beneficial for security, performance, or maintainability
- [ ] Respect user preferences for maintaining current versions when explicitly requested

---

**This approach ensures that AI-assisted development remains transparent, verifiable, and maintainable while maximizing the benefits of AI acceleration.**