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
- **Technology Stack Guide Creation**: @guides/development-practices/stack-instruction-guide.md

### Utilities
- **Project Stack Detection**: @commands/setup/detect-stack.md

---

**This approach ensures that AI-assisted development remains transparent, verifiable, and maintainable while maximizing the benefits of AI acceleration.**