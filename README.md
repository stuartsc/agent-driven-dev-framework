# Agent-Driven Development Framework

A comprehensive framework for AI agent-driven software development with integrated Jira project management and GitHub workflows.

## Overview

This framework enables AI coding agents (Claude Code, Cursor, Windsurf, etc.) to autonomously:
- Elicit and document requirements from stakeholders
- Set up and manage Jira projects via Atlassian MCP
- Create and manage GitHub branches tied to Jira issues
- Commit with smart commits for automatic Jira updates
- Maintain traceability across the entire development lifecycle
- Manage deployments across dev, staging, and production branches

## Framework Components

### 🚨 [PROTOCOL.md](./PROTOCOL.md) - **READ THIS FIRST**
**MANDATORY** session protocol and checklist for all agents.

**Critical requirements:**
- Session checklist that MUST be followed every time
- Enforcement mechanisms to prevent common failures
- Recovery procedures for protocol violations
- Git workflow with smart commits reference
- Integration with HISTORY.md for session continuity

**Why it exists:** Agents consistently forget protocols. This file uses multiple enforcement layers to make compliance automatic.

### 📜 [HISTORY.md](./HISTORY.md)
Living document tracking all development sessions and project evolution.

**Contains:**
- Current project status and active work
- "Up Next" section with recommended tasks
- Session-by-session log of all work done
- Blockers, technical debt, and key decisions
- Handoff documentation between agents/developers

**Critical for:** Session continuity, agent handoffs, understanding project evolution.

### 📋 [AGENTS.md](./AGENTS.md)
Universal AI agent configuration file following the AGENTS.md standard (adopted by 40,000+ projects).

**Key sections:**
- **MANDATORY PROTOCOL REFERENCE** (first section - points to PROTOCOL.md)
- Agentic workflow patterns (Sequential, Planning, Parallelization, Orchestrator-Worker)
- Requirements elicitation process with multi-agent collaboration
- Jira integration via Model Context Protocol (MCP)
- Git workflows with smart commits syntax
- Code conventions and architectural patterns

### 🚀 [PROJECT.md](./PROJECT.md)
Complete project initialization and management framework.

**Covers:**
- 5-phase project initialization (Requirements → Jira → GitHub → Integration → Development)
- Requirements elicitation templates and workflows
- Jira project setup with issue templates
- GitHub repository structure and branch protection
- Continuous synchronization between Jira and GitHub
- Daily development workflows from issue to deployment

### 🔧 [WORKFLOWS.md](./WORKFLOWS.md)
Practical, copy-paste ready workflow templates and examples.

**Includes:**
- Agent prompt templates for common tasks
- Complete workflow examples (feature, bug fix, hotfix, refactoring)
- Smart commit cheat sheet with all syntax patterns
- GitHub Actions templates for CI/CD and Jira integration
- Agent automation scripts (morning sync, evening cleanup)
- MCP agent workflows for bulk operations
- Troubleshooting guides

## Quick Start

### 1. Clone and Setup
```bash
# Clone the repository
git clone https://github.com/stuartsc/agent-driven-dev-framework.git
cd agent-driven-dev-framework

# Run protocol setup (installs git hooks)
./setup-protocol.sh
```

### 2. Copy Framework Files to Your Project
```bash
# Copy these files to your project root
AGENTS.md
PROJECT.md
WORKFLOWS.md
PROTOCOL.md
HISTORY.md
verify-protocol.sh
setup-protocol.sh
hooks/pre-commit
.claude/prompts/session-start.md
```

### 3. Configure for Your Project
Update the following in each file:
- Replace `PROJ` with your Jira project key
- Update team names and member lists
- Adjust workflow state names to match your Jira workflow
- Customize branch naming conventions if needed

### 4. Set Up Integrations

**Jira Setup:**
1. Create Jira project with your project key
2. Install GitHub for Jira app
3. Enable smart commits
4. Configure MCP server (optional but recommended)

**GitHub Setup:**
1. Create repository
2. Set up branch protection rules
3. Add GitHub Actions workflows from WORKFLOWS.md
4. Configure secrets for Jira integration

**MCP Configuration:**
1. Install Atlassian MCP server
2. Configure authentication
3. Test integration with sample commands

### 5. Start Development
**IMPORTANT:** Before coding, EVERY agent must:
1. Read PROTOCOL.md completely
2. Copy session checklist to working notes
3. Read HISTORY.md for current status and "Up Next" tasks
4. Follow daily workflows in PROJECT.md Phase 5

## Protocol Enforcement

**The #1 problem with AI agents: They forget to follow protocols.**

This framework solves that with **multiple enforcement layers**:

### Layer 1: File Naming & Discovery
- **PROTOCOL.md** comes alphabetically first
- **AGENTS.md** first section points to PROTOCOL.md
- Impossible to miss when listing files

### Layer 2: Session Start Prompt
- `.claude/prompts/session-start.md` auto-loads on session start (Claude Code)
- Forces protocol awareness before any work begins
- Provides checklist reminder

### Layer 3: Git Hooks
```bash
# Pre-commit hook verifies:
- Jira key in branch name
- Jira key in commit message
- HISTORY.md recently updated
- No uncommitted work

# Install hooks:
./setup-protocol.sh
```

### Layer 4: Verification Script
```bash
# Run before committing to verify compliance:
./verify-protocol.sh

# Checks:
✅ HISTORY.md updated
✅ Branch name has Jira key
✅ Recent commits have Jira keys
✅ No uncommitted changes
✅ Required files exist
```

### Layer 5: HISTORY.md Integration
- "Up Next" section tells agents what to work on
- Session log provides continuity
- Blockers are visible immediately
- Technical debt is tracked

### Why Multiple Layers?

**Single reminders don't work.** Agents need:
- **Visual cues** (file naming, emoji markers)
- **Automatic prompts** (session-start.md)
- **Forced compliance** (git hooks)
- **Easy verification** (verify-protocol.sh)
- **Context persistence** (HISTORY.md)

Together, these make protocol compliance **automatic**, not optional.

## Key Features

### Agent-Driven Requirements Engineering
- Multi-agent approach with specialized roles (Interviewer, Analyst, Reviewer)
- Automated Jira issue creation from requirements
- Validation loops with stakeholder feedback
- Requirements traceability matrix

### Smart Git Workflows
- Standardized branch naming: `<type>/<JIRA-KEY>-<description>`
- Smart commits for automatic Jira updates
- Branching strategy: `main` ← `staging` ← `dev` ← feature branches
- Automated CI/CD pipelines

### Jira Integration
- Real-time synchronization via smart commits
- MCP-powered bulk operations
- Automated sprint health monitoring
- Daily standup report generation

### GitHub Automation
- Automated Jira transitions on PR events
- CI/CD pipelines with Jira integration
- Branch cleanup automation
- Release notes generation

## Smart Commits Syntax

```bash
# Basic format
<JIRA-KEY> #<command> <arguments>

# Examples
git commit -m "PROJ-123 #comment Implemented user authentication"
git commit -m "PROJ-123 #time 2h 30m Completed feature"
git commit -m "PROJ-123 #in-review #comment Ready for code review"
git commit -m "PROJ-123 #done #comment Deployed to production"
```

See [WORKFLOWS.md](./WORKFLOWS.md#smart-commit-cheat-sheet) for complete syntax reference.

## Workflow Patterns

### New Feature Development
1. Agent selects issue from Jira sprint
2. Creates feature branch: `feature/PROJ-123-feature-name`
3. Implements with regular smart commits
4. Creates PR when complete
5. After review, merges to `dev`
6. Jira automatically updated throughout

### Bug Fixes
1. Create fix branch: `fix/PROJ-456-bug-description`
2. Reproduce and diagnose
3. Implement fix with tests
4. Smart commit to update Jira
5. Merge to `dev` after review

### Hotfixes
1. Branch from `main`: `hotfix/PROJ-789-critical-issue`
2. Quick fix with minimal changes
3. Fast-track review
4. Merge to `main`, then backport to `staging` and `dev`

## Requirements

### Tools
- Git 2.30+
- GitHub CLI (optional, recommended)
- Jira Cloud or Server
- Claude Code, Cursor, or compatible AI coding agent

### Integrations
- GitHub for Jira app
- Atlassian MCP server (optional)
- GitHub Actions for automation

### Permissions
- Jira: Create/edit issues, transition workflows, log time
- GitHub: Create repos, manage branches, deploy workflows

## Best Practices

1. **Always include Jira key in branch names** - Enables automatic linking
2. **Use smart commits for every commit** - Keeps Jira in sync
3. **Create small, focused PRs** - Easier review, faster merge
4. **Update Jira with blockers immediately** - Transparency for team
5. **Let agents handle routine updates** - Focus human time on decisions

## Troubleshooting

### Smart Commits Not Working
- Verify Git email matches Jira user email exactly
- Check smart commits are enabled in Jira settings
- Ensure issue key format is correct (PROJ-123)
- Verify user has appropriate Jira permissions

### Branch Not Linking to Jira
- Check branch name includes issue key
- Verify GitHub integration is active
- Reconnect GitHub for Jira app if needed

See [WORKFLOWS.md](./WORKFLOWS.md#troubleshooting-workflows) for more solutions.

## Contributing

This framework is designed to evolve with your team's needs. When you discover improvements:

1. Update the relevant markdown file
2. Document the change in commit message
3. Share learnings with the team
4. Consider contributing back to the community

## License

MIT License - feel free to adapt for your organization's needs.

## Resources

- [AGENTS.md Standard](https://layer5.io/blog/ai/agentsmd-one-file-to-guide-them-all)
- [Atlassian MCP Server](https://www.atlassian.com/blog/announcements/remote-mcp-server)
- [Jira Smart Commits](https://support.atlassian.com/jira-software-cloud/docs/process-issues-with-smart-commits/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Model Context Protocol](https://modelcontextprotocol.io)

---

**Framework Version**: 1.0.0
**Last Updated**: 2025-11-08
**Maintained by**: Stuart Bond
