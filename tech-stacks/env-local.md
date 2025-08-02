# Local Development Environment Guidelines

## Core Principle
Establish a stable, reproducible development environment as the foundation for all code development. Environment decisions fundamentally impact how dependencies are managed, tests are executed, and applications are deployed.

## Environment Strategy Framework

### 1. Assessment Phase
**Understand the existing landscape:**
- Identify project requirements and constraints
- Analyze team size and collaboration needs
- Evaluate deployment targets and production parity requirements
- Consider existing tooling and team expertise

### 2. Environment Selection Criteria
```
Complexity vs Isolation Trade-off
├── Minimal complexity → Direct local development
├── Team consistency → Containerized environments
├── Service dependencies → Orchestration tools
└── Cloud deployment → Cloud-native development
```

### 3. Dependency Management Principles

#### Version Control
**Maintain reproducibility through:**
- Explicit version specifications in configuration files
- Lock files for exact dependency resolution
- Regular dependency audits and updates
- Clear documentation of system requirements

#### Isolation Strategy
**Create boundaries between projects:**
- Use project-specific virtual environments
- Leverage modern package managers with built-in isolation
- Document environment activation procedures
- Maintain clean global system state

### 4. Configuration Management

#### Environment Variables
**Secure and flexible configuration:**
- Separate configuration from code
- Use example files to document required variables
- Implement validation for critical settings
- Support multiple environment profiles (dev, test, prod)

#### Secrets Handling
**Protect sensitive information:**
- Store secrets outside version control
- Use dedicated secret management tools when available
- Document secret requirements without exposing values
- Implement access controls appropriate to team size

### 5. Verification and Testing

#### Environment Health Checks
**Ensure readiness before development:**
- Verify all dependencies are correctly installed
- Confirm configuration is properly loaded
- Test basic functionality before complex operations
- Document troubleshooting procedures

#### Continuous Validation
**Maintain environment integrity:**
- Include environment checks in CI/CD pipelines
- Regular testing across target platforms
- Monitor for dependency vulnerabilities
- Update documentation as environment evolves

## Modern Tool Integration Examples

### Package Management Evolution
Traditional approach often involved multiple tools and manual steps. Modern package managers consolidate these workflows:

```bash
# Example with modern Python tooling (uv)
# Instead of: python -m venv .venv && source .venv/bin/activate && pip install
# Simply: uv sync

# Example with Node.js
# Instead of: npm install && npm audit fix
# Consider: pnpm install (with built-in optimization)
```

### Development Workflow Optimization
Focus on reducing context switches and cognitive load:
- Single command environment setup
- Integrated dependency and script management
- Automatic environment activation
- Built-in security scanning

## Documentation Template

### Essential Documentation Structure
```markdown
## Prerequisites
- Required system tools and versions
- Platform-specific requirements
- Access requirements (if applicable)

## Quick Start
1. Clone repository
2. Install dependencies: [single command]
3. Configure environment: [minimal steps]
4. Verify setup: [health check command]
5. Start development: [run command]

## Common Issues
- Symptom → Solution format
- Platform-specific gotchas
- Dependency conflict resolution
```

## Key Questions for Environment Setup

**When joining a project:**
1. "What are the minimum system requirements?"
2. "Is there a preferred package manager or toolchain?"
3. "Are there any platform-specific considerations?"
4. "What external services does this project depend on?"

**When creating a project:**
1. "Who will be contributing to this project?"
2. "What are the deployment targets?"
3. "What level of isolation is needed?"
4. "How will the project scale over time?"

## Remember
The best environment setup is one that:
- Minimizes setup friction for new contributors
- Maintains consistency across different machines
- Scales with project complexity
- Integrates smoothly with existing workflows

Choose simplicity when possible, add complexity when necessary.