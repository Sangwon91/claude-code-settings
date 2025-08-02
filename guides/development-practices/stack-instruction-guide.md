# Technology Stack Instruction Creation Guide

## Core Purpose
Enable agents to generate up-to-date, project-specific technology stack instructions using modern research tools like Context7 and WebSearch, while maintaining freshness and relevance over time.

## Instruction Creation Methodology

### 1. Research and Information Gathering
**Leverage modern AI research capabilities:**
- Use Context7 to access current library documentation and best practices
- Employ WebSearch for latest trends, security updates, and community insights
- Cross-reference multiple sources to ensure accuracy and completeness
- Focus on official documentation and authoritative community resources

**Research Checklist:**
- [ ] Latest stable version and release notes
- [ ] Breaking changes from previous versions
- [ ] Current best practices and recommended patterns
- [ ] Security considerations and known vulnerabilities
- [ ] Performance optimization guidelines
- [ ] Integration patterns with other common tools

### 2. Instruction Template Structure
**Standardized format for technology stack instructions:**

```markdown
# [Technology Name] Development Guidelines

## Version Information
- **Current Version**: [X.Y.Z] (as of [date])
- **Supported Versions**: [range]
- **Last Updated**: [YYYY-MM-DD]

## Setup and Configuration
[Environment setup, installation, basic configuration]

## Development Patterns
[Common patterns, best practices, code organization]

## Integration Guidelines
[How it works with other tools in the stack]

## Testing Strategy
[Framework-specific testing approaches]

## Performance Considerations
[Optimization techniques and common pitfalls]

## Security Guidelines
[Security best practices and common vulnerabilities]

## Troubleshooting
[Common issues and solutions]

## References
- Official documentation: [URL]
- Community resources: [URLs]
- Research date: [YYYY-MM-DD]
```

### 3. Context-Aware Content Generation
**Tailor instructions to project context:**
- Analyze existing project structure and dependencies
- Identify integration requirements with current stack
- Consider team size and experience level indicators
- Adapt complexity and detail level appropriately

**Contextual Factors:**
- Project type (library, application, microservice)
- Existing technology dependencies
- Development environment constraints
- Team conventions and coding standards

### 4. Freshness and Validation
**Ensure instruction relevance over time:**
- Include creation timestamp and source references
- Document research methodology and sources used
- Provide version-specific guidance with upgrade paths
- Flag deprecated patterns and migration strategies

## Automated Instruction Generation Process

### Phase 1: Context Analysis
```bash
1. Scan current directory for project indicators
2. Identify technology stack from package files
3. Determine appropriate instruction scope and detail
4. Check for existing instructions and their age
```

### Phase 2: Research Execution
```bash
1. Query Context7 for official documentation
2. Search for recent updates and security advisories
3. Gather community best practices and patterns
4. Validate information across multiple sources
```

### Phase 3: Content Synthesis
```bash
1. Generate instruction content using research findings
2. Adapt to detected project context and requirements
3. Include specific version information and timestamps
4. Add integration guidance for detected technologies
```

### Phase 4: Integration and Validation
```bash
1. Determine appropriate storage location (global vs project-specific)
2. Save instruction file with consistent naming convention
3. Update relevant CLAUDE.md with import reference if needed
4. Provide summary of created instruction with key highlights
```

## File Management Strategy

### Location Selection Logic
All technology stack instructions should be saved to:
- `~/.claude/tech-stacks/` (global instructions accessible to all projects)

### Naming Conventions
**Consistent file naming for easy discovery:**
- `[technology]-[category].md` format
- Examples: `react-framework.md`, `python-testing-pytest.md`, `docker-environment.md`
- Use lowercase with hyphens for separation
- Include version info in content, not filename

## Quality Assurance Guidelines

### Content Quality Checks
**Ensure instruction effectiveness:**
- All code examples are syntactically correct
- Versions and dependencies are explicitly specified
- Instructions are testable and verifiable
- Common edge cases and errors are addressed

### Information Accuracy
**Maintain reliable and current information:**
- Cross-reference facts with official sources
- Include uncertainty indicators for rapidly changing information
- Provide fallback approaches for version incompatibilities
- Document assumptions and prerequisites clearly

### Maintainability Standards
**Design for long-term usefulness:**
- Use clear, descriptive headings and organization
- Include searchable keywords and concepts
- Provide links to authoritative external resources
- Structure content for easy updates and modifications

## Freshness Monitoring Strategy

### Automatic Staleness Detection
**Identify when instructions need updates:**
- Compare project dependency versions with instruction versions
- Monitor for security vulnerabilities in documented versions
- Track major version releases of documented technologies
- Flag instructions older than configurable thresholds (default: 6 months)

### Update Triggers
**Conditions that should prompt instruction updates:**
- Major version releases of core technologies
- Security vulnerabilities in documented versions
- Significant changes in best practices or patterns
- User-reported issues with current instructions

### Gradual Degradation Warnings
**Provide context-aware freshness indicators:**
```
⚠️  Warning: React instructions based on v18.2, current stable is v18.3
💡 Suggestion: Consider updating this instruction file
🔒 Security: No known vulnerabilities in documented versions
📅 Last updated: 3 months ago
```

## Integration with Development Workflow

### Natural Language Interface Examples
```bash
"Create a React development guide for this project"
"Generate TypeScript best practices instruction"
"Make a testing guide for Jest and React Testing Library"
"Update the existing Python guide with latest FastAPI patterns"
```

### Contextual Awareness
**Instructions should reflect:**
- Existing project dependencies and versions
- Team coding conventions and patterns
- Development environment constraints
- Integration requirements with other stack components

## Best Practices for Instruction Authors

### Research Methodology
1. Start with official documentation from Context7
2. Supplement with community resources and recent discussions
3. Verify information through multiple authoritative sources
4. Test recommendations in realistic development scenarios

### Content Organization
1. Structure information from general to specific
2. Provide working examples for all major concepts
3. Include both "what to do" and "what to avoid" guidance
4. Cross-reference related technologies and patterns

### Version Management
1. Always specify exact versions in examples
2. Provide migration guidance for version upgrades
3. Document breaking changes and compatibility issues
4. Include fallback approaches for different version ranges

## Error Handling and Recovery

### Common Issues and Solutions
**Research failures:**
- Context7 unavailable → Use cached documentation and WebSearch
- Conflicting information → Document uncertainty and provide options
- Outdated sources → Flag with warnings and research dates

**Generation failures:**
- Template errors → Use fallback simplified structure
- Content validation failures → Generate with warnings and manual review needed
- File system errors → Provide content for manual saving

### Validation and Feedback
**Ensure generated instructions are valuable:**
- Include self-assessment checklist in generated content
- Provide clear next steps for testing and validation
- Enable easy feedback mechanism for improvement
- Document generation process for transparency

## Remember
Effective technology stack instructions bridge the gap between generic documentation and project-specific requirements. They should enable agents to make informed decisions while providing enough context for humans to understand and verify the guidance.

The goal is to create living documentation that evolves with both the technology landscape and project requirements, maintaining relevance through proactive research and community engagement.