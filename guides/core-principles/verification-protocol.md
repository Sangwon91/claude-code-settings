# Step-by-Step Verification Protocol

**For every code modification:**
- Review each change immediately after implementation
- Ask clarifying questions about any unclear modifications
- Transform insights from Q&A discussions into clear, informational comments that help future readers understand the code's purpose and context
- Request explicit human verification for complex or critical modifications

## Verification Checklist

- [ ] Can I explain what this change does?
- [ ] Do I understand why this change was necessary?
- [ ] Does this change follow the existing code patterns?
- [ ] Are there any potential side effects?
- [ ] Is this change properly tested?

## Code Review Protocol

- Use `git diff` to review changes before proceeding to next steps
- Verify changes follow existing code patterns and conventions
- Ensure modifications align with project goals

## Quality Gates

**Never proceed without:**
- [ ] Clear understanding of the change being made
- [ ] Verification that tests still pass
- [ ] Human-readable explanation of the modification
- [ ] Self-documenting code that explains its purpose and rationale
- [ ] Confirmation that the change aligns with project goals

## Emergency Protocols

**If you find yourself:**
- Making changes you don't fully understand → STOP and ask questions
- Modifying more than 30 lines without verification → Break into smaller tasks
- Getting test failures you can't explain → Use git recovery protocol to revert
- Feeling lost in the codebase → Use TodoWrite to reorganize and refocus