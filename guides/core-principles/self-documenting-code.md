# Self-Documenting Code Principles

**Primary Goal:** Enable any coding agent to fully understand the codebase by reading only the code and comments, without external documentation dependencies.

## Code Structure Standards

- Use descriptive, intention-revealing names for variables, functions, and classes
- Structure code flow to mirror business logic flow
- Break complex operations into well-named, single-purpose functions
- Use consistent patterns and conventions throughout the codebase
- Make code dependencies and relationships explicit and traceable

## Comment Quality Standards

- Focus on **WHY** rather than **WHAT** the code does
- Explain business logic, algorithms, and decision rationale
- Document trade-offs and alternative approaches considered
- Include context about external constraints or requirements
- Reference specifications, RFCs, or business rules when relevant
- Avoid comments that merely restate what the code obviously does

## Examples

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

## Self-Documentation Checklist

- [ ] Can a new agent understand the purpose without external docs?
- [ ] Are variable/function names self-explanatory?
- [ ] Is the business logic flow clear from code structure?
- [ ] Do comments explain the reasoning, not just the mechanics?
- [ ] Are complex algorithms explained with their rationale?