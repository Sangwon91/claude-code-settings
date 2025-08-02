# Performance Optimization Notes

**For improved Claude Code performance:**

## Batch Operations
- **Use batch tool calls when reading multiple files**: Execute multiple Read/Grep operations simultaneously rather than sequentially to reduce total response time

## File Modification Strategy
- **Pre-plan file modifications to minimize back-and-forth**: Use MultiEdit for multiple changes to the same file instead of separate Edit calls to reduce context switching overhead

## Memory Management
- **Cache understanding of codebase structure in memory**: Remember project architecture, file locations, and patterns discovered during the session to avoid redundant exploration

## Search Optimization
- **Use specific file paths rather than broad searches when possible**: Target exact files when you know the location instead of using Grep across entire project to reduce processing time