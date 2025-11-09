#!/bin/bash

# Setup script for protocol enforcement
# Run this after cloning the repository to install git hooks

echo "🔧 Setting up protocol enforcement..."
echo ""

# Install pre-commit hook
if [ -f "hooks/pre-commit" ]; then
    cp hooks/pre-commit .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
    echo "✅ Pre-commit hook installed"
else
    echo "❌ hooks/pre-commit not found"
    exit 1
fi

# Make verify-protocol.sh executable
if [ -f "verify-protocol.sh" ]; then
    chmod +x verify-protocol.sh
    echo "✅ verify-protocol.sh made executable"
else
    echo "❌ verify-protocol.sh not found"
    exit 1
fi

# Verify required files exist
echo ""
echo "Verifying protocol files..."
MISSING=0

for file in "PROTOCOL.md" "HISTORY.md" "AGENTS.md" "PROJECT.md" "WORKFLOWS.md"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file missing"
        ((MISSING++))
    fi
done

if [ $MISSING -gt 0 ]; then
    echo ""
    echo "⚠️  Warning: $MISSING required file(s) missing"
fi

# Check if on dev branch
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)
if [ "$CURRENT_BRANCH" != "dev" ] && [ "$CURRENT_BRANCH" != "main" ]; then
    echo ""
    echo "⚠️  Note: You're on branch '$CURRENT_BRANCH'"
    echo "    Consider switching to 'dev' for development work"
fi

echo ""
echo "=========================================="
echo "Protocol enforcement setup complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Read PROTOCOL.md to understand the workflow"
echo "  2. Read HISTORY.md to see current project status"
echo "  3. Run ./verify-protocol.sh to check compliance"
echo ""
echo "The pre-commit hook will now check protocol compliance"
echo "before allowing commits."
echo ""
