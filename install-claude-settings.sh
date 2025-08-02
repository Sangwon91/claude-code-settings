#!/bin/bash

# Claude Code Settings Installation Script
# Copies agents, commands, tech-stacks, and CLAUDE.md to ~/.claude directory

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the correct directory
if [[ ! -f "CLAUDE.md" || ! -d "agents" || ! -d "commands" || ! -d "tech-stacks" ]]; then
    print_error "This script must be run from the claude-code-settings repository root"
    print_error "Required files/directories not found: CLAUDE.md, agents/, commands/, tech-stacks/"
    exit 1
fi

print_status "Installing Claude Code settings to ~/.claude directory..."

# Create ~/.claude directory if it doesn't exist
if [[ ! -d "$HOME/.claude" ]]; then
    print_status "Creating ~/.claude directory..."
    mkdir -p "$HOME/.claude"
else
    print_status "~/.claude directory already exists"
fi

# Function to backup existing files/directories
backup_if_exists() {
    local target="$1"
    local backup_suffix=$(date +"%Y%m%d_%H%M%S")
    
    if [[ -e "$target" ]]; then
        local backup_path="${target}.backup_${backup_suffix}"
        print_warning "Backing up existing $(basename "$target") to $(basename "$backup_path")"
        mv "$target" "$backup_path"
    fi
}

# Backup and copy agents directory
print_status "Installing agents..."
backup_if_exists "$HOME/.claude/agents"
cp -r "agents" "$HOME/.claude/"
print_status "✓ Agents directory copied"

# Backup and copy commands directory
print_status "Installing commands..."
backup_if_exists "$HOME/.claude/commands"
cp -r "commands" "$HOME/.claude/"
print_status "✓ Commands directory copied"

# Backup and copy tech-stacks directory
print_status "Installing tech-stacks..."
backup_if_exists "$HOME/.claude/tech-stacks"
cp -r "tech-stacks" "$HOME/.claude/"
print_status "✓ Tech-stacks directory copied"

# Handle CLAUDE.md - merge or backup
if [[ -f "$HOME/.claude/CLAUDE.md" ]]; then
    backup_if_exists "$HOME/.claude/CLAUDE.md"
    print_warning "Existing CLAUDE.md backed up"
    print_warning "You may want to manually merge the backed up content with the new file"
fi

cp "CLAUDE.md" "$HOME/.claude/"
print_status "✓ CLAUDE.md copied"

# Set appropriate permissions
print_status "Setting appropriate permissions..."
chmod -R 755 "$HOME/.claude/agents"
chmod -R 755 "$HOME/.claude/commands"
chmod -R 644 "$HOME/.claude/tech-stacks"/*.md
chmod 644 "$HOME/.claude/CLAUDE.md"

# Verify installation
print_status "Verifying installation..."
verification_failed=false

check_file() {
    if [[ ! -e "$1" ]]; then
        print_error "Missing: $1"
        verification_failed=true
    fi
}

check_file "$HOME/.claude/CLAUDE.md"
check_file "$HOME/.claude/agents/stack-researcher.md"
check_file "$HOME/.claude/commands/setup/detect-stack.md"
check_file "$HOME/.claude/tech-stacks/env-local.md"
check_file "$HOME/.claude/tech-stacks/testing-strategy.md"
check_file "$HOME/.claude/tech-stacks/stack-instruction-guide.md"

if [[ "$verification_failed" == "true" ]]; then
    print_error "Installation verification failed. Some files are missing."
    exit 1
fi

print_status "Installation completed successfully!"
echo
print_status "Installed components:"
echo "  • Sub-agents: ~/.claude/agents/"
echo "    - stack-researcher: Technology stack instruction generator"
echo "  • Commands: ~/.claude/commands/"
echo "    - /setup:detect-stack: Project technology stack detection"
echo "  • Tech-stacks: ~/.claude/tech-stacks/"
echo "    - env-local.md: Local development environment guidelines"
echo "    - testing-strategy.md: Framework-agnostic testing strategy"
echo "    - stack-instruction-guide.md: Instruction creation methodology"
echo "  • Global guidelines: ~/.claude/CLAUDE.md"
echo
print_status "Usage examples:"
echo "  • \"Create a React development guide\" (uses stack-researcher sub-agent)"
echo "  • \"/setup:detect-stack\" (detects and suggests tech stack imports)"
echo
print_status "Next steps:"
echo "  1. Restart Claude Code to load new settings"
echo "  2. Test the stack-researcher sub-agent in a project directory"
echo "  3. Try the /setup:detect-stack command"
echo
print_warning "Note: If you had existing ~/.claude/CLAUDE.md, check the backup file to merge any custom settings"