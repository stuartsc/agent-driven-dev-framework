#!/bin/bash

# Protocol Verification Script
# Run this before committing to verify protocol compliance

set -e

echo "🔍 Verifying protocol compliance..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

# Function to print error
error() {
    echo -e "${RED}❌ ERROR: $1${NC}"
    ((ERRORS++))
}

# Function to print warning
warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
    ((WARNINGS++))
}

# Function to print success
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

echo "Checking protocol compliance..."
echo ""

# Check 1: HISTORY.md exists
if [ ! -f "HISTORY.md" ]; then
    error "HISTORY.md file not found"
else
    success "HISTORY.md exists"
fi

# Check 2: HISTORY.md was updated recently (within last 24 hours)
if [ -f "HISTORY.md" ]; then
    HISTORY_MOD=$(date -r HISTORY.md +%s 2>/dev/null || stat -f%m HISTORY.md 2>/dev/null || stat -c%Y HISTORY.md 2>/dev/null)
    NOW=$(date +%s)
    DIFF=$((NOW - HISTORY_MOD))
    HOURS=$((DIFF / 3600))

    if [ $HOURS -gt 24 ]; then
        warning "HISTORY.md was last updated $HOURS hours ago (should be updated every session)"
    else
        success "HISTORY.md was updated recently ($HOURS hours ago)"
    fi
fi

# Check 3: Current branch name has Jira key format
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)
if [ -z "$CURRENT_BRANCH" ]; then
    warning "Could not determine current branch"
elif [ "$CURRENT_BRANCH" = "main" ] || [ "$CURRENT_BRANCH" = "dev" ] || [ "$CURRENT_BRANCH" = "staging" ]; then
    success "On protected branch: $CURRENT_BRANCH"
elif echo "$CURRENT_BRANCH" | grep -qE '[A-Z]+-[0-9]+'; then
    success "Branch name contains Jira key: $CURRENT_BRANCH"
else
    error "Branch name does not contain Jira key format (e.g., PROJ-123): $CURRENT_BRANCH"
fi

# Check 4: Recent commits have Jira keys
echo ""
echo "Checking recent commits for Jira keys..."
COMMIT_COUNT=0
MISSING_JIRA=0

while IFS= read -r commit_msg; do
    ((COMMIT_COUNT++))
    if ! echo "$commit_msg" | grep -qE '[A-Z]+-[0-9]+'; then
        ((MISSING_JIRA++))
        warning "Commit missing Jira key: $commit_msg"
    fi
done < <(git log --format=%s -n 5 2>/dev/null || echo "")

if [ $COMMIT_COUNT -gt 0 ]; then
    if [ $MISSING_JIRA -eq 0 ]; then
        success "All recent commits ($COMMIT_COUNT) contain Jira keys"
    else
        warning "$MISSING_JIRA out of $COMMIT_COUNT recent commits missing Jira keys"
    fi
fi

# Check 5: No uncommitted changes (except HISTORY.md and this script's output)
if [ -n "$(git status --porcelain | grep -v 'HISTORY.md' | grep -v 'verify-protocol.sh')" ]; then
    warning "You have uncommitted changes (remember to commit and push)"
    git status --short | grep -v 'HISTORY.md' | grep -v 'verify-protocol.sh'
else
    success "No uncommitted changes (or only HISTORY.md)"
fi

# Check 6: Verify required files exist
echo ""
echo "Checking required protocol files..."
for file in "PROTOCOL.md" "AGENTS.md" "PROJECT.md" "WORKFLOWS.md" "README.md"; do
    if [ -f "$file" ]; then
        success "$file exists"
    else
        error "$file is missing"
    fi
done

# Check 7: Verify .claude/prompts/session-start.md exists
if [ -f ".claude/prompts/session-start.md" ]; then
    success "Session start prompt configured"
else
    warning ".claude/prompts/session-start.md not found (session start reminder won't auto-load)"
fi

# Check 8: Verify git remote is configured
if git remote -v | grep -q 'origin'; then
    success "Git remote 'origin' is configured"
else
    error "Git remote 'origin' is not configured"
fi

# Check 9: Verify we're not on main branch for development work
if [ "$CURRENT_BRANCH" = "main" ] && git status --porcelain | grep -q '^[AM]'; then
    error "You have staged changes on the 'main' branch (should work on 'dev' or feature branch)"
fi

# Summary
echo ""
echo "=========================================="
echo "Protocol Verification Summary"
echo "=========================================="

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✅ All checks passed! Protocol compliance verified.${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  $WARNINGS warning(s) found. Review above and fix if needed.${NC}"
    exit 0
else
    echo -e "${RED}❌ $ERRORS error(s) and $WARNINGS warning(s) found.${NC}"
    echo ""
    echo "Please fix the errors above before committing."
    echo "See PROTOCOL.md for guidance."
    exit 1
fi
