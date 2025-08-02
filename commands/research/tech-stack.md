# /research:tech-stack

Command to research latest technology stack information and generate structured guides.

**🔍 RESEARCH PRIORITY**: Context7 Primary → WebSearch Last Resort
**📝 MANDATORY STEPS**: TODO Generation → Guide Creation → CLAUDE.md Update → Verification
**⚠️ QUALITY CONTROL**: Latest Version Verification Required

## Usage
```
/research:tech-stack <technology-stack> [--template=<template-type>] [--context=<context-stack>] [additional natural language requirements]
```

## Parameters
- `technology-stack`: 조사할 기술 스택 (단일 또는 조합, + 구분자 사용)
- `--template`: 템플릿 타입 (선택: spa, fullstack, api, library)
- `--context`: 특정 컨텍스트에서의 사용법 조사 (선택)
- `additional natural language requirements`: 자연어로 추가 요구사항 명시 (선택)

## Examples
```bash
# 단일 기술 조사
/research:tech-stack react

# 조합 스택 조사 (순서 무관)
/research:tech-stack react+typescript+vite
/research:tech-stack typescript+vite+react  # 동일한 결과

# 복잡한 조합
/research:tech-stack nextjs+typescript+tailwindcss+shadcn-ui+prisma

# 특정 컨텍스트에서의 사용법
/research:tech-stack zustand --context=react+typescript

# 자연어 추가 요구사항
/research:tech-stack react+typescript+vite focus on testing strategies and CI/CD integration
/research:tech-stack nextjs+prisma --template=fullstack include deployment to Vercel and database migrations
/research:tech-stack vue+typescript emphasize component composition patterns and performance optimization
```

## Technology Normalization

### Automatic Sorting Algorithm
입력된 기술 스택은 다음 우선순위에 따라 자동으로 정렬됩니다:

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

### Alias Resolution
다음 별칭들이 자동으로 정규화됩니다:
- `next` → `nextjs`
- `ts` → `typescript`
- `js` → `javascript`
- `tailwind` → `tailwindcss`
- `postgres` → `postgresql`
- `mongo` → `mongodb`

### Normalization Examples
```bash
# 입력: typescript+react+vite
# 정규화: react+typescript+vite

# 입력: tailwind+zustand+next+ts+shadcn-ui
# 정규화: nextjs+typescript+zustand+tailwindcss+shadcn-ui
```

## Implementation Workflow

### Phase 1: Input Normalization
1. **Parse Input**: 기술 스택을 + 구분자로 분리
2. **Resolve Aliases**: 별칭을 정식 이름으로 변환
3. **Categorize Technologies**: 각 기술을 카테고리별로 분류
4. **Sort by Priority**: 의미론적 우선순위에 따라 정렬
5. **Generate Filename**: 정규화된 순서로 파일명 생성

### Phase 2: Research Execution (⚠️ Context7 Priority Policy)
**🔍 CRITICAL**: Use Context7 as primary source, WebSearch as last resort only

1. **Mandatory TodoWrite Generation**: Generate required TODOs before research begins
   - "Research [tech-stack] using Context7 as primary source"
   - "Generate comprehensive guide for [tech-stack] combination"
   - "Update CLAUDE.md with [tech-stack] guide reference"
   - "Verify all versions, examples, and compatibility information"
   - "Re-validate Context7 information and test configurations"

2. **Comprehensive Context7 Research (PRIMARY)**:
   - Complete investigation of all tech stack components via Context7
   - Start with basic documentation, continue until meaningful information discovered
   - Extract relevant topics from natural language requirements for targeted search
   - Auto-search technology-specific common patterns (hooks, routing, state management, etc.)
   - Filter out duplicate or meaningless information
   - Achieve 80%+ Context7 coverage through persistent searching

3. **Cross-Technology Integration Search (Context7 ONLY)**:
   - For multi-tech combinations, search integration docs for tech pairs via Context7
   - Collect actual integration patterns and best practices from Context7
   - Perform additional Context7 searches with "integration" keyword

4. **Information Completeness Evaluation**:
   - Evaluate information completeness, not just coverage percentage
   - Verify ability to answer requirements
   - Assess feasibility of creating complete guide with Context7 info only

5. **WebSearch (LAST RESORT ONLY)**: Only when absolutely impossible with Context7
   - Use only when Context7 coverage < 70%
   - When using WebSearch, explicitly state reason and Context7 deficiencies
   - Validate WebSearch results against Context7 information

6. **Version Compatibility**: Generate latest version compatibility matrix

### Phase 3: Content Generation
1. **Template Selection**: 기술 조합에 적합한 템플릿 선택
2. **Section Population**: 각 섹션을 연구 결과로 채움
3. **Code Examples**: 조합별 실제 코드 예시 생성
4. **Configuration Files**: 통합 설정 파일 템플릿 제공

### Phase 4: File Management
1. **Check Existing**: Check for existing file with same technology combination
   - If existing file found: Prompt user with options
     - **Update**: Update existing file with latest information
     - **Skip**: Stop research and keep existing file
     - **Create Variant**: Create new file with date/version suffix
2. **Create/Update**: Create new file or update existing file
3. **Cross-Reference**: Add cross-reference links between related technology guides

### Phase 5: CLAUDE.md Integration (🚨 MANDATORY STEP)
**⚠️ CRITICAL REQUIREMENT**: CLAUDE.md update required after every guide generation

**Execution Protocol:**
1. **Pre-Integration Backup**: Create backup before modifying CLAUDE.md
2. **Check CLAUDE.md**: Verify CLAUDE.md file exists in project root
3. **Section Creation**: Verify/create Technology Stack Guidelines section
4. **Duplicate Check**: Check for existing guide reference duplicates
5. **Auto-Update**: Automatically add reference if no duplicates found
   ```markdown
   ## Technology Stack Guidelines
   @guides/technology-stacks/{normalized-stack}.md
   ```
6. **Content Preservation**: Maintain all existing content and formatting
7. **Validation**: Verify added reference path is correct and accessible
8. **Completion Notification**: Notify user of CLAUDE.md update completion

**Error Handling:**
- CLAUDE.md doesn't exist: Create new file with basic structure
- Write permission denied: Provide manual addition guidance to user
- Reference path error: Fix path or regenerate guide

### Phase 6: Verification and Validation Phase (🔍 CRITICAL QUALITY CONTROL)
**⚠️ MANDATORY FINAL STEP**: Re-verify completeness and accuracy of generated guide

**Version Verification Protocol:**
1. **Latest Version Cross-Check**: Re-verify current stable versions of all technologies
   - Re-query Context7 for most recent stable versions of each technology
   - Compare guide-specified versions with actual current versions
   - Update guide if version mismatches discovered

2. **Compatibility Matrix Validation**: Re-verify compatibility matrix
   - Re-confirm inter-technology version compatibility
   - Re-investigate known conflicts or issues
   - Identify and reflect breaking changes

3. **Code Example Verification**: Validate code example validity
   - Check all code examples for syntax errors
   - Verify configuration file syntax validity
   - Test executability where possible

4. **Context7 Information Re-validation**: Re-verify Context7 information
   - Check for changed APIs or deprecated features
   - Reflect new best practices
   - Confirm documented configurations are still valid

5. **Integration Pattern Verification**: Re-verify integration patterns
   - Confirm technology integration methods are still recommended
   - Search for new integration options or improved methods
   - Identify deprecated patterns and suggest alternatives

**Quality Assurance Checklist:**
- [ ] Are all version information based on current latest standards?
- [ ] Do code examples work with current versions?
- [ ] Do configuration files follow latest formats?
- [ ] Are integration patterns current recommended methods?
- [ ] Is Context7 coverage 80% or higher?
- [ ] Was CLAUDE.md successfully updated?

**Cost vs Quality Statement:**
This verification process incurs additional time and computational costs, but is essential to prevent development issues from inaccurate or outdated technical guides.

## Generated File Structure

### Single Technology
```
guides/technology-stacks/react.md
guides/technology-stacks/typescript.md
```

### Technology Combinations
```
guides/technology-stacks/react+typescript+vite.md
guides/technology-stacks/nextjs+typescript+tailwindcss+shadcn-ui.md
```

### Context-Specific Usage
```
guides/technology-stacks/zustand+react+typescript.md
```

## Content Template

각 생성된 가이드는 다음 구조를 따릅니다:

```markdown
# {Normalized Stack Name} Development Guide

## Stack Overview
- **Technologies**: {tech1} + {tech2} + {tech3}
- **Use Case**: {template-type}
- **Complexity**: {beginner|intermediate|advanced}
- **Last Updated**: {current-date}

## Compatibility Matrix
| Technology | Version | Notes | Conflicts |
|------------|---------|-------|-----------|
| {tech1} | {version} | {notes} | {conflicts} |

## Quick Start Setup

### Prerequisites
{system requirements and global dependencies}

### Installation
```bash
{installation commands specific to this combination}
```

### Project Initialization
```bash
{project setup commands}
```

### Configuration Files
{generated config files for this specific combination}

## Integration Patterns

### {Tech1} + {Tech2} Integration
{specific integration setup and configuration}

### {Tech2} + {Tech3} Integration
{specific integration setup and configuration}

## Best Practices for This Combination

### Project Structure
{recommended folder structure for this stack}

### Development Workflow
{optimal development process for this combination}

### Common Patterns
{patterns specific to this technology combination}

## Troubleshooting This Stack

### Common Integration Issues
{issues specific to this combination and solutions}

### Version Conflicts
{known version compatibility issues and resolutions}

## Alternative Combinations
{suggested alternative stacks for similar use cases}

## Migration Paths
{how to migrate from/to other similar stacks}

## Research Metadata
- **Research Sources**: Context7, Official Docs, Community
- **Validation Status**: {verified|partial|unverified}
- **Next Review**: {6-months-from-creation-date}
```

## Execution Logic

### Technology Categorization Function
```python
def categorize_and_sort_technologies(tech_string):
    CATEGORIES = {
        'runtime': ['node', 'deno', 'bun'],
        'framework': ['react', 'nextjs', 'vue', 'nuxt', 'svelte', 'express', 'fastify'],
        'language': ['typescript', 'javascript'],
        'build': ['vite', 'webpack', 'rollup', 'esbuild'],
        'state': ['zustand', 'redux', 'jotai', 'recoil'],
        'styling': ['tailwindcss', 'styled-components', 'emotion', 'sass'],
        'ui': ['shadcn-ui', 'mui', 'antd', 'chakra-ui'],
        'testing': ['jest', 'vitest', 'playwright', 'cypress'],
        'database': ['postgresql', 'mysql', 'mongodb', 'redis'],
        'utility': ['lodash', 'axios', 'prisma', 'trpc']
    }
    
    ALIASES = {
        'next': 'nextjs', 'ts': 'typescript', 'js': 'javascript',
        'tailwind': 'tailwindcss', 'postgres': 'postgresql', 'mongo': 'mongodb'
    }
    
    PRIORITY_ORDER = ['runtime', 'framework', 'language', 'build', 'state', 'styling', 'ui', 'testing', 'database', 'utility']
    
    # 1. Parse and normalize
    techs = [tech.strip().lower() for tech in tech_string.split('+')]
    
    # 2. Resolve aliases
    normalized_techs = [ALIASES.get(tech, tech) for tech in techs]
    
    # 3. Categorize
    categorized = {}
    for tech in normalized_techs:
        for category, tech_list in CATEGORIES.items():
            if tech in tech_list:
                if category not in categorized:
                    categorized[category] = []
                categorized[category].append(tech)
                break
        else:
            # Unknown technology goes to utility
            if 'utility' not in categorized:
                categorized['utility'] = []
            categorized['utility'].append(tech)
    
    # 4. Sort within categories and by priority
    result = []
    for category in PRIORITY_ORDER:
        if category in categorized:
            result.extend(sorted(categorized[category]))
    
    return '+'.join(result)
```

### Research and Content Generation
```python
def generate_tech_stack_guide(normalized_stack, natural_language_requirements=None):
    # 1. Comprehensive Context7 research - continue until sufficient information is found
    individual_docs = []
    context7_coverage = 0
    
    for tech in normalized_stack.split('+'):
        # Keep searching until we have meaningful documentation
        explored_topics = set()
        
        # Start with basic documentation
        doc = context7_get_library_docs(tech)
        if doc and doc.quality_score > 0.7:
            individual_docs.append(doc)
            context7_coverage += 1
        
        # Extract relevant topics from natural language requirements
        if natural_language_requirements:
            relevant_topics = extract_relevant_topics(natural_language_requirements, tech)
            
            # Search for each relevant topic until we have comprehensive coverage
            for topic in relevant_topics:
                if topic not in explored_topics:
                    topic_doc = context7_get_library_docs(tech, topic=topic)
                    if topic_doc and topic_doc.quality_score > 0.6 and topic_doc.adds_new_information(individual_docs):
                        individual_docs.append(topic_doc)
                        explored_topics.add(topic)
        
        # For common integration patterns, search additional contexts
        if tech in ['react', 'vue', 'angular']:
            for pattern in ['hooks', 'components', 'state management', 'routing']:
                if pattern not in explored_topics:
                    pattern_doc = context7_get_library_docs(tech, topic=pattern)
                    if pattern_doc and pattern_doc.quality_score > 0.6:
                        individual_docs.append(pattern_doc)
                        explored_topics.add(pattern)
    
    # 2. Search for cross-technology integration patterns
    if len(normalized_stack.split('+')) > 1:
        # Search for specific integration documentation
        tech_pairs = generate_tech_pairs(normalized_stack.split('+'))
        for tech1, tech2 in tech_pairs:
            integration_doc = context7_get_library_docs(
                f"{tech1} {tech2}", 
                topic="integration"
            )
            if integration_doc and integration_doc.quality_score > 0.6:
                individual_docs.append(integration_doc)
    
    # 3. Context7 Coverage Evaluation - Target 80%+ achievement
    context7_coverage = calculate_context7_coverage(individual_docs, normalized_stack)
    
    # 4. Conditional WebSearch - Use minimally only when Context7 coverage < 70%
    combination_info = None
    websearch_reason = ""
    
    if context7_coverage < 0.7 or not has_comprehensive_coverage(individual_docs, normalized_stack, natural_language_requirements):
        websearch_reason = f"Context7 coverage: {context7_coverage:.1%}, insufficient for comprehensive guide"
        combination_info = web_search(f"{normalized_stack} integration tutorial best practices")
        # Validate WebSearch results with Context7 information
        combination_info = validate_with_context7(combination_info, individual_docs)
    
    # 3. Generate compatibility matrix
    compatibility = analyze_version_compatibility(normalized_stack.split('+'))
    
    # 4. Create structured content
    content = generate_markdown_content(
        stack=normalized_stack,
        individual_docs=individual_docs,
        combination_info=combination_info,
        compatibility=compatibility,
        context7_only=combination_info is None
    )
    
    # 5. Save to appropriate location
    filename = f"guides/technology-stacks/{normalized_stack}.md"
    save_file(filename, content)
    
    return filename
```

## Usage Examples

### Basic Usage
```bash
# User input: /research:tech-stack react+typescript+vite
# Normalization: react+typescript+vite
# Generated: guides/technology-stacks/react+typescript+vite.md
```

### Complex Stack
```bash
# User input: /research:tech-stack tailwind+zustand+next+ts+shadcn-ui
# Normalization: nextjs+typescript+zustand+tailwindcss+shadcn-ui
# Generated: guides/technology-stacks/nextjs+typescript+zustand+tailwindcss+shadcn-ui.md
```

### Context-Specific
```bash
# User input: /research:tech-stack prisma --context=nextjs+typescript
# Normalization: prisma+nextjs+typescript
# Generated: guides/technology-stacks/prisma+nextjs+typescript.md
```

## Error Handling

### Unknown Technologies
- Warn user about unrecognized technologies
- Suggest similar or commonly confused alternatives
- Place unknown technologies in 'utility' category

### Research Failures (Context7 Priority Policy)
- **Context7 unavailable**: Retry then use WebSearch minimally
- **Context7 insufficient coverage**: Continue Context7 searching with various topics
- **Information completeness threshold not met**: Additional Context7 search then WebSearch if unavoidable
- **Insufficient integration info in Context7**: Generate basic combination guide then minimal WebSearch supplement
- **Version conflicts detected**: Highlight conflicts in compatibility matrix
- **When using WebSearch**: Always specify Context7 deficiency reason and limit usage scope

### File Conflicts
- Existing file: Offer to update or create variant
- Similar combinations: Cross-reference related guides
- Broken links: Validate and fix cross-references

## Integration with Existing Commands

### Complement to /setup:detect-stack
```bash
# After detecting project stack
/setup:detect-stack  # detects: react+typescript+vite
/research:tech-stack react+typescript+vite  # generates comprehensive guide
```

### CLAUDE.md Integration (MANDATORY)
**⚠️ REQUIRED EXECUTION**: Automatically add reference to project CLAUDE.md after every guide generation

**Execution Procedure:**
1. Check for existence of CLAUDE.md file in project root
2. Verify/create Technology Stack Guidelines section
3. Check existing references to prevent duplicates
4. Automatically add new guide reference:
   ```markdown
   ## Technology Stack Guidelines
   @guides/technology-stacks/{normalized-stack}.md
   ```
5. Display completion confirmation message to user

**Exception Handling:**
- If CLAUDE.md doesn't exist: Create new file
- If reference already exists: Do not add duplicate  
- If file modification permission denied: Guide user for manual addition

## TODO Generation Template (MANDATORY)

Every `/research:tech-stack` execution must generate the following TODO list:

```markdown
### Technology Stack Research TODOs
1. **Research Phase**: "Research {tech-stack} using Context7 as primary source (target: 80%+ coverage)"
2. **Guide Generation**: "Generate comprehensive guide for {tech-stack} combination"
3. **CLAUDE.md Integration**: "Update CLAUDE.md with {tech-stack} guide reference (MANDATORY)"
4. **Version Verification**: "Verify all versions against current latest releases"
5. **Quality Validation**: "Re-validate Context7 information and test all configurations"
6. **Final Review**: "Complete verification checklist and ensure guide accuracy"
```

**Cost vs Quality Commitment:**
This process requires additional computational cost and time, but is essential for providing accurate and up-to-date technical information.
- Context7 priority usage ensures official documentation-based accuracy
- Latest version verification ensures development environment compatibility
- Automatic CLAUDE.md updates maintain project consistency
- Re-verification phase ensures guide quality