# /research:tech-stack

최신 기술 스택 정보를 조사하고 구조화된 가이드를 생성하는 커맨드입니다.

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

### Phase 2: Research Execution
1. **Comprehensive Context7 Research**:
   - 기본 문서부터 시작하여 의미있는 정보가 발견되는 한 계속 검색
   - 자연어 요구사항에서 관련 토픽 추출하여 targeted search
   - 기술별 common patterns (hooks, routing, state management 등) 자동 검색
   - 중복되거나 의미없는 정보는 필터링
2. **Cross-Technology Integration Search**:
   - 다중 기술 조합의 경우 기술 쌍별 통합 문서 검색
   - 실제 통합 패턴과 best practices 수집
3. **Information Completeness Evaluation**:
   - 단순 커버리지 비율이 아닌 정보의 완전성 평가
   - 요구사항에 대한 답변 가능 여부 확인
4. **Conditional WebSearch**: 정보가 불완전한 경우에만 WebSearch로 보완
5. **Version Compatibility**: 버전 호환성 매트릭스 생성

### Phase 3: Content Generation
1. **Template Selection**: 기술 조합에 적합한 템플릿 선택
2. **Section Population**: 각 섹션을 연구 결과로 채움
3. **Code Examples**: 조합별 실제 코드 예시 생성
4. **Configuration Files**: 통합 설정 파일 템플릿 제공

### Phase 4: File Management
1. **Check Existing**: 동일한 조합의 기존 파일 확인
2. **Create/Update**: 새 파일 생성 또는 기존 파일 업데이트
3. **Cross-Reference**: 관련 기술 가이드 간 상호 참조 링크 추가

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
- **Last Updated**: {YYYY-MM-DD}

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
- **Next Review**: {6-months-from-creation}
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
    
    # 3. Conditional WebSearch - only if Context7 doesn't provide comprehensive coverage
    combination_info = None
    # Evaluate information completeness, not just quantity
    if not has_comprehensive_coverage(individual_docs, normalized_stack, natural_language_requirements):
        combination_info = web_search(f"{normalized_stack} integration tutorial best practices")
    
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

### Research Failures
- Context7 unavailable: Use WebSearch and cached information
- Context7 insufficient coverage: Continue searching with different topics until comprehensive
- Information completeness threshold not met: Supplement with targeted WebSearch
- No integration information found: Generate basic combination guide
- Version conflicts detected: Highlight conflicts in compatibility matrix

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

### CLAUDE.md Integration
자동으로 생성된 가이드를 프로젝트 CLAUDE.md에 참조 추가:
```markdown
## Technology Stack Guidelines
@guides/technology-stacks/react+typescript+vite.md
```