# /research:tech-stack Command Usage Guide

## Command Overview
The `/research:tech-stack` command automatically researches technology stacks and generates comprehensive, structured development guides using intelligent normalization and modern research tools.

## Basic Usage

### Command Syntax
```bash
/research:tech-stack <technology-stack> [--template=<template-type>] [--context=<context-stack>]
```

### Parameters
- `technology-stack`: Technology stack to research (single or combination with + separator)
- `--template`: Template type (optional: spa, fullstack, api, library)
- `--context`: Specific context for usage research (optional)

## Usage Examples

### Single Technology Research
```bash
/research:tech-stack react
/research:tech-stack typescript
/research:tech-stack prisma
```

### Technology Combinations
```bash
# Basic combinations (order independent)
/research:tech-stack react+typescript+vite
/research:tech-stack typescript+vite+react  # produces identical result

# Complex full-stack combinations
/research:tech-stack nextjs+typescript+tailwindcss+shadcn-ui+prisma
/research:tech-stack express+typescript+postgresql+redis
```

### Context-Specific Research
```bash
# Research how to use Zustand specifically with React+TypeScript
/research:tech-stack zustand --context=react+typescript

# Research Prisma usage in Next.js environment
/research:tech-stack prisma --context=nextjs+typescript
```

## Intelligent Normalization System

### Why Normalization Matters
The command automatically normalizes and sorts technology inputs to ensure:
- **Consistency**: Same technology combinations always produce identical results
- **Discoverability**: Generated guides use predictable naming conventions
- **Logical Organization**: Technologies are ordered by their role in the development stack

### Automatic Sorting Priority
Technologies are automatically sorted by semantic importance:

1. **Runtime/Platform**: node, deno, bun
2. **Framework**: react, nextjs, vue, nuxt, svelte, express, fastify
3. **Language**: typescript, javascript
4. **Build Tool**: vite, webpack, rollup, esbuild
5. **State Management**: zustand, redux, jotai, recoil
6. **Styling**: tailwindcss, styled-components, emotion, sass
7. **UI Library**: shadcn-ui, mui, antd, chakra-ui
8. **Testing**: jest, vitest, playwright, cypress
9. **Database**: postgresql, mysql, mongodb, redis
10. **Utility**: lodash, axios, prisma, trpc

### Automatic Alias Resolution
Common aliases are automatically converted to canonical names:
- `next` → `nextjs`
- `ts` → `typescript`
- `js` → `javascript`
- `tailwind` → `tailwindcss`
- `postgres` → `postgresql`
- `mongo` → `mongodb`

### Normalization Examples
```bash
# Input: typescript+react+vite
# Normalized: react+typescript+vite
# Generated: guides/technology-stacks/react+typescript+vite.md

# Input: tailwind+zustand+next+ts+shadcn-ui
# Normalized: nextjs+typescript+zustand+tailwindcss+shadcn-ui
# Generated: guides/technology-stacks/nextjs+typescript+zustand+tailwindcss+shadcn-ui.md
```

## Generated Guide Structure

### File Locations
All generated guides are saved to:
```
guides/technology-stacks/
├── react.md                                    # Single technology
├── react+typescript+vite.md                   # Basic combinations
├── nextjs+typescript+tailwindcss+shadcn-ui.md # Complex combinations
└── zustand+react+typescript.md                # Context-specific
```

### Content Structure
Each generated guide includes:

1. **Stack Overview**: Technology summary, use case, complexity level
2. **Compatibility Matrix**: Version compatibility and conflict information
3. **Quick Start Setup**: Prerequisites, installation, project initialization
4. **Integration Patterns**: How technologies work together
5. **Best Practices**: Optimal patterns for this specific combination
6. **Troubleshooting**: Common issues and solutions
7. **Research Metadata**: Sources, validation status, review schedule

## Advanced Usage Patterns

### Template-Specific Research
```bash
# Generate SPA-focused guide
/research:tech-stack react+typescript+vite --template=spa

# Generate API-focused guide
/research:tech-stack express+typescript+postgresql --template=api

# Generate full-stack guide
/research:tech-stack nextjs+typescript+prisma --template=fullstack
```

### Progressive Stack Building
```bash
# Start with base stack
/research:tech-stack react+typescript

# Add build tooling
/research:tech-stack react+typescript+vite

# Add styling and UI
/research:tech-stack react+typescript+vite+tailwindcss+shadcn-ui

# Add state management
/research:tech-stack react+typescript+vite+tailwindcss+shadcn-ui+zustand
```

## Integration with Development Workflow

### Complement to /setup:detect-stack
```bash
# First, detect existing project stack
/setup:detect-stack  # detects: react+typescript+vite

# Then, generate comprehensive guide
/research:tech-stack react+typescript+vite
```

### Automatic CLAUDE.md Integration
Generated guides are automatically referenced in project CLAUDE.md:
```markdown
## Technology Stack Guidelines
@guides/technology-stacks/react+typescript+vite.md
```

## Research Methodology

### Data Sources
The command leverages multiple authoritative sources:
- **Context7**: Official documentation and API references
- **WebSearch**: Latest community best practices and tutorials
- **Version Analysis**: Compatibility matrices and conflict detection

### Quality Assurance
Generated guides include:
- **Verified Examples**: All code examples are syntax-checked
- **Version Specifications**: Explicit version requirements and compatibility
- **Source Attribution**: Clear citation of research sources
- **Freshness Indicators**: Creation date and review schedule

## Troubleshooting

### Unknown Technologies
```bash
# Command handles unknown technologies gracefully
/research:tech-stack react+unknownframework+typescript
# Result: Warns about 'unknownframework', places it in utility category
```

### Research Failures
- **Context7 unavailable**: Falls back to WebSearch and cached information
- **No integration info**: Generates basic combination guide with warnings
- **Version conflicts**: Highlights conflicts in compatibility matrix

### File Management
- **Existing files**: Offers to update or create variant
- **Similar combinations**: Cross-references related guides
- **Broken references**: Validates and fixes cross-links

## Best Practices for Using the Command

### When to Use
- **New project setup**: Research optimal technology combinations
- **Technology evaluation**: Compare different stack options
- **Integration planning**: Understand how technologies work together
- **Team onboarding**: Generate standardized development guides

### Input Guidelines
- **Use canonical names** when known (typescript vs ts)
- **Order doesn't matter** - let normalization handle it
- **Be specific** about context when researching library usage
- **Start simple** and progressively add technologies

### Guide Maintenance
- **Regular updates**: Re-run command when major versions change
- **Context evolution**: Update guides as project requirements evolve
- **Team feedback**: Incorporate team-specific patterns and preferences

## Integration Examples

### Typical Workflow
```bash
# 1. Detect current project stack
/setup:detect-stack

# 2. Research detected technologies for comprehensive guide
/research:tech-stack react+typescript+vite

# 3. Research additional technologies you're considering
/research:tech-stack react+typescript+vite+zustand
/research:tech-stack react+typescript+vite+redux

# 4. Compare alternatives for informed decision-making
```

### Team Standardization
```bash
# Generate guides for team's standard stacks
/research:tech-stack nextjs+typescript+tailwindcss+shadcn-ui+prisma  # Frontend
/research:tech-stack express+typescript+postgresql+redis            # Backend
/research:tech-stack jest+playwright                                # Testing
```

## Command Output and Results

### Success Indicators
- ✅ Normalized technology stack display
- ✅ Generated file path confirmation
- ✅ Research source summary
- ✅ Integration suggestions

### Generated Artifacts
- **Primary guide**: Comprehensive technology combination guide
- **Cross-references**: Links to related single-technology guides
- **Configuration templates**: Ready-to-use config files
- **CLAUDE.md updates**: Automatic project integration

This command transforms technology research from a time-consuming manual process into an automated, consistent, and comprehensive guide generation system.