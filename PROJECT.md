# PROJECT.md

This file defines the project initialization and management framework for agent-driven development. It provides step-by-step workflows for setting up new projects, integrating with Jira and GitHub, and maintaining continuous synchronization between development and project management.

## Quick Start

For new projects, follow this sequence:
1. **Requirements Elicitation** → Gather and document requirements
2. **Jira Setup** → Create project and initial issues
3. **GitHub Setup** → Initialize repository with proper structure
4. **Integration** → Connect Jira, GitHub, and MCP servers
5. **First Sprint** → Start development with full automation

## Project Initialization Workflow

### Phase 1: Requirements Elicitation

**Objective**: Gather comprehensive requirements before any technical setup.

#### Step 1: Stakeholder Identification
```markdown
# Create stakeholder map
- Primary stakeholders (decision makers)
- Secondary stakeholders (users, affected teams)
- Technical stakeholders (architects, platform teams)
- Business stakeholders (product, management)

# Document for each stakeholder:
- Name and role
- Primary concerns/interests
- Communication preferences
- Availability for validation
```

#### Step 2: Initial Discovery Session
Use multi-agent approach with these agent personas:

**Interviewer Agent**: Conducts structured interviews
```
Questions to ask:
1. What problem are we solving?
2. Who are the end users?
3. What are the success criteria?
4. What are the constraints (budget, timeline, technology)?
5. What are the risks?
6. What are the dependencies?
```

**End-User Agent**: Simulates user scenarios
```
Generate user personas:
- Role/job title
- Goals and motivations
- Pain points
- Technical proficiency
- Usage patterns
```

**Analyst Agent**: Analyzes requirements
```
Check for:
- Completeness (all aspects covered?)
- Consistency (no conflicts?)
- Clarity (unambiguous?)
- Feasibility (technically possible?)
- Testability (can be verified?)
```

#### Step 3: Requirements Documentation
Create structured requirements document:

```markdown
# Project Requirements Document

## 1. Executive Summary
- Project name
- Purpose and goals
- Key stakeholders
- Timeline and milestones

## 2. Functional Requirements
### Feature 1: [Name]
- **Description**: What it does
- **User Story**: As a [role], I want [action] so that [benefit]
- **Acceptance Criteria**:
  - [ ] Criterion 1
  - [ ] Criterion 2
- **Priority**: High/Medium/Low
- **Dependencies**: List dependencies

## 3. Non-Functional Requirements
- Performance (response time, throughput)
- Security (authentication, authorization, data protection)
- Scalability (expected growth)
- Reliability (uptime requirements)
- Usability (user experience standards)

## 4. Technical Requirements
- Technology stack
- Infrastructure needs
- Third-party integrations
- Database requirements
- API specifications

## 5. Constraints
- Budget limitations
- Timeline constraints
- Technical constraints
- Resource constraints

## 6. Risks and Assumptions
- Technical risks
- Business risks
- Assumptions made
- Mitigation strategies
```

#### Step 4: Requirements Validation
```
Validation checklist:
1. Review with each stakeholder group
2. Obtain written approval
3. Document feedback and iterations
4. Prioritize features (MoSCoW method)
   - Must have
   - Should have
   - Could have
   - Won't have (this time)
5. Create requirements traceability matrix
```

### Phase 2: Jira Project Setup

**Objective**: Create structured project management environment.

#### Step 1: Create Jira Project
Using Atlassian MCP server:

```python
# Via AI agent with MCP
"""
Create Jira project:
- Project name: [Name]
- Project key: [3-4 letter code, e.g., PROJ]
- Project type: Scrum/Kanban
- Lead: [Your name]
"""

# Configure project settings:
- Set up issue types (Epic, Story, Task, Bug, Sub-task)
- Configure workflows (To Do, In Progress, In Review, Done)
- Set up custom fields if needed
- Configure permissions
```

#### Step 2: Create Project Structure
```
Epic structure:
└── PROJ-1: [Epic Name - High-level feature area]
    ├── PROJ-10: [User Story - Specific functionality]
    │   ├── PROJ-11: [Task - Implementation detail]
    │   ├── PROJ-12: [Task - Implementation detail]
    │   └── PROJ-13: [Task - Testing]
    ├── PROJ-20: [User Story - Specific functionality]
    └── PROJ-30: [Bug - Issue found during development]

Example:
└── PROJ-1: User Authentication System
    ├── PROJ-10: User can register with email
    │   ├── PROJ-11: Create user registration API endpoint
    │   ├── PROJ-12: Build registration form UI
    │   └── PROJ-13: Write integration tests
    ├── PROJ-20: User can login with credentials
    └── PROJ-30: Fix password validation edge case
```

#### Step 3: Populate Issues from Requirements
Agent workflow:

```markdown
For each functional requirement:
1. Create Epic for major feature area
2. Break down into User Stories (As a [role], I want [action]...)
3. Decompose Stories into Tasks (specific implementation steps)
4. Add acceptance criteria to each Story
5. Estimate effort (story points or hours)
6. Set priority based on requirements doc
7. Link related issues
8. Add labels for categorization
```

**Jira Issue Template**:
```markdown
## User Story
As a [user role]
I want [functionality]
So that [benefit/value]

## Acceptance Criteria
- [ ] Given [context], when [action], then [result]
- [ ] Given [context], when [action], then [result]

## Technical Notes
- Dependencies: [List other issues/systems]
- API endpoints needed: [List]
- Database changes: [Describe]

## Definition of Done
- [ ] Code complete and peer reviewed
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Deployed to staging
- [ ] QA approved
```

#### Step 4: Sprint Planning
```
Sprint setup:
1. Create sprint in Jira (2-week cycles recommended)
2. Pull high-priority issues into sprint backlog
3. Assign issues to team members
4. Set sprint goals
5. Estimate capacity
6. Commit to sprint scope
```

### Phase 3: GitHub Repository Setup

**Objective**: Initialize version control with proper structure.

#### Step 1: Repository Initialization
```bash
# Create new repository
git init
# or clone if already exists
git clone [repo-url]

# Set up branch protection rules on GitHub:
# Settings → Branches → Add rule
- Require pull request reviews (minimum 1)
- Require status checks to pass
- Require branches to be up to date
- Include administrators
```

#### Step 2: Repository Structure
```
project-root/
├── .github/
│   ├── workflows/          # GitHub Actions
│   │   ├── ci.yml         # Continuous integration
│   │   ├── deploy-staging.yml
│   │   └── deploy-production.yml
│   ├── CODEOWNERS         # Code review assignments
│   └── pull_request_template.md
├── .husky/                # Git hooks
│   ├── pre-commit        # Lint, format, test
│   └── commit-msg        # Validate commit message
├── docs/                  # Documentation
│   ├── api/              # API documentation
│   ├── architecture/     # System design docs
│   └── guides/           # How-to guides
├── src/                   # Source code
├── tests/                 # Test files
├── .env.example          # Environment variables template
├── .gitignore            # Ignored files
├── AGENTS.md             # AI agent instructions
├── PROJECT.md            # This file
├── README.md             # Project overview
└── package.json          # Dependencies (or equivalent)
```

#### Step 3: Initial Branches
```bash
# Create main branches
git checkout -b main
git push -u origin main

git checkout -b staging
git push -u origin staging

git checkout -b dev
git push -u origin dev

# Set dev as default development branch
# GitHub Settings → Branches → Default branch → dev
```

#### Step 4: GitHub Actions Setup
Create `.github/workflows/ci.yml`:

```yaml
name: Continuous Integration

on:
  pull_request:
    branches: [dev, staging, main]
  push:
    branches: [dev, staging, main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      - name: Install dependencies
        run: npm ci
      - name: Run linter
        run: npm run lint
      - name: Run tests
        run: npm test
      - name: Build
        run: npm run build

  jira-integration:
    runs-on: ubuntu-latest
    steps:
      - name: Update Jira issue
        uses: atlassian/gajira-transition@v3
        with:
          issue: ${{ github.event.head_commit.message }}
          transition: "In Review"
```

### Phase 4: Integration Setup

#### Step 1: Connect GitHub to Jira
```
Jira Settings:
1. Navigate to Jira Settings → Apps → Find new apps
2. Install "GitHub for Jira" app
3. Configure GitHub integration
4. Authenticate with GitHub
5. Select repositories to connect
6. Enable smart commits
7. Configure webhook for real-time updates

Verification:
- Create test branch: feature/PROJ-1-test
- Make test commit with smart commit
- Check Jira issue for automatic update
```

#### Step 2: Configure MCP Servers
Create `mcp-config.json`:

```json
{
  "mcpServers": {
    "atlassian": {
      "type": "remote",
      "url": "https://api.atlassian.com/mcp",
      "auth": {
        "type": "oauth",
        "clientId": "${JIRA_CLIENT_ID}",
        "clientSecret": "${JIRA_CLIENT_SECRET}"
      },
      "tools": [
        "create-issue",
        "update-issue",
        "search-issues",
        "get-issue",
        "add-comment",
        "log-work"
      ]
    },
    "github": {
      "type": "local",
      "command": "npx",
      "args": ["-y", "mcp-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "memory": {
      "type": "local",
      "command": "mcp-memory-server",
      "persistPath": "./.mcp/memory"
    }
  }
}
```

#### Step 3: Set Up Git Hooks
Install pre-commit hooks:

```bash
npm install --save-dev husky lint-staged

# Initialize husky
npx husky init

# Create pre-commit hook
cat > .husky/pre-commit << 'EOF'
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

npm run lint-staged
npm test
EOF

# Create commit-msg hook for smart commit validation
cat > .husky/commit-msg << 'EOF'
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

# Validate smart commit format
node scripts/validate-commit-msg.js $1
EOF

chmod +x .husky/pre-commit
chmod +x .husky/commit-msg
```

Create `scripts/validate-commit-msg.js`:

```javascript
const fs = require('fs');
const msg = fs.readFileSync(process.argv[2], 'utf-8').trim();

// Regex for Jira issue key
const jiraKeyPattern = /[A-Z]+-\d+/;

if (!jiraKeyPattern.test(msg)) {
  console.error('❌ Commit message must include Jira issue key (e.g., PROJ-123)');
  console.error('Format: PROJ-123 #comment Your message here');
  process.exit(1);
}

console.log('✅ Commit message validated');
```

### Phase 5: Development Workflow

#### Daily Development Cycle

**1. Select Issue from Jira**
```bash
# Agent queries Jira via MCP
"Get my assigned issues in current sprint"

# Agent creates feature branch
git checkout dev
git pull origin dev
git checkout -b feature/PROJ-123-implement-auth
```

**2. Development with Smart Commits**
```bash
# Initial commit
git add .
git commit -m "PROJ-123 #comment Started implementation #in-progress"

# Progress commits
git commit -m "PROJ-123 #time 1h 30m Completed user model"
git commit -m "PROJ-123 #time 2h Added authentication middleware #comment 80% complete"

# Final commit
git commit -m "PROJ-123 #done #comment Implementation complete, ready for review"
```

**3. Create Pull Request**
```bash
git push -u origin feature/PROJ-123-implement-auth

# Create PR via GitHub CLI or UI
gh pr create --base dev --head feature/PROJ-123-implement-auth \
  --title "PROJ-123: Implement user authentication" \
  --body "## Changes
- Added user authentication model
- Implemented JWT middleware
- Added login/register endpoints

## Testing
- [x] Unit tests passing
- [x] Integration tests passing
- [x] Manual testing complete

## Jira Issue
https://yourcompany.atlassian.net/browse/PROJ-123

## Screenshots
[Add relevant screenshots]"
```

**4. Code Review Process**
```
PR checklist:
- [ ] All tests passing in CI
- [ ] Code reviewed by at least 1 peer
- [ ] No merge conflicts
- [ ] Jira issue linked and updated
- [ ] Documentation updated if needed
- [ ] Breaking changes documented

Review feedback loop:
1. Reviewer leaves comments
2. Developer makes changes
3. Commit with: PROJ-123 #comment Addressed review feedback
4. Re-request review
5. Repeat until approved
```

**5. Merge and Deploy**
```bash
# After approval, squash and merge
git checkout dev
git pull origin dev
git merge --squash feature/PROJ-123-implement-auth
git commit -m "PROJ-123 #done #comment Merged to dev, deployed to staging"
git push origin dev

# CI/CD automatically deploys to staging

# Delete feature branch
git branch -d feature/PROJ-123-implement-auth
git push origin --delete feature/PROJ-123-implement-auth
```

## Continuous Synchronization

### Automated Jira Updates

**Via Smart Commits**: Every commit automatically updates Jira
```bash
# Status transitions
git commit -m "PROJ-123 #in-progress #comment Starting work"
git commit -m "PROJ-123 #in-review #comment PR created"
git commit -m "PROJ-123 #done #comment Merged and deployed"

# Time tracking
git commit -m "PROJ-123 #time 3h Implemented feature X"

# Comments with context
git commit -m "PROJ-123 #comment Blocked by API rate limit, investigating alternatives"
```

**Via GitHub Actions**: Automated workflows update Jira on PR events
```yaml
# .github/workflows/jira-integration.yml
name: Jira Integration

on:
  pull_request:
    types: [opened, reopened, closed]
  pull_request_review:
    types: [submitted]

jobs:
  update-jira:
    runs-on: ubuntu-latest
    steps:
      - name: Extract Jira Issue Key
        id: extract
        run: |
          BRANCH="${{ github.head_ref }}"
          ISSUE_KEY=$(echo $BRANCH | grep -oE '[A-Z]+-[0-9]+')
          echo "issue_key=$ISSUE_KEY" >> $GITHUB_OUTPUT

      - name: Transition to In Review
        if: github.event.action == 'opened'
        uses: atlassian/gajira-transition@v3
        with:
          issue: ${{ steps.extract.outputs.issue_key }}
          transition: "In Review"

      - name: Add PR Link Comment
        if: github.event.action == 'opened'
        uses: atlassian/gajira-comment@v3
        with:
          issue: ${{ steps.extract.outputs.issue_key }}
          comment: "Pull request created: ${{ github.event.pull_request.html_url }}"

      - name: Transition to Done
        if: github.event.action == 'closed' && github.event.pull_request.merged == true
        uses: atlassian/gajira-transition@v3
        with:
          issue: ${{ steps.extract.outputs.issue_key }}
          transition: "Done"
```

**Via MCP Agent**: Agent actively monitors and updates
```python
# Agent daily workflow
def sync_development_state():
    # Get all in-progress issues
    issues = jira_mcp.search_issues('status = "In Progress"')

    for issue in issues:
        # Check GitHub for corresponding branch
        branch = f"feature/{issue.key}-*"
        if branch_exists(branch):
            # Get latest commit
            last_commit = get_last_commit(branch)
            time_diff = now() - last_commit.time

            # If no activity for 2 days, flag
            if time_diff > 2 days:
                jira_mcp.add_comment(
                    issue.key,
                    "⚠️ No commits in 2 days. Please update status or add blocker comment."
                )
```

### Project State Monitoring

**Daily Standup Report Generation**:
```python
# Agent generates daily standup via MCP
def generate_standup_report(team_members):
    report = []

    for member in team_members:
        # Get yesterday's commits
        commits = github.get_commits(
            author=member,
            since=yesterday()
        )

        # Get today's assigned issues
        issues = jira_mcp.search_issues(
            f'assignee = {member} AND status = "In Progress"'
        )

        # Extract blockers from comments
        blockers = jira_mcp.search_issues(
            f'assignee = {member} AND comment ~ "blocked"'
        )

        report.append({
            'member': member,
            'yesterday': [c.message for c in commits],
            'today': [i.summary for i in issues],
            'blockers': [b.summary for b in blockers]
        })

    return format_standup_report(report)
```

**Sprint Progress Tracking**:
```python
# Agent monitors sprint health
def check_sprint_health():
    sprint = jira_mcp.get_active_sprint()

    metrics = {
        'total_points': sprint.total_story_points,
        'completed_points': sprint.completed_story_points,
        'remaining_days': sprint.days_remaining,
        'velocity': sprint.completed_points / sprint.days_elapsed,
        'projected_completion': calculate_projection(velocity, remaining_points)
    }

    if metrics['projected_completion'] > sprint.end_date:
        alert_team("Sprint at risk of missing completion")
        suggest_scope_adjustments()
```

## Branch Management Strategy

### Branch Lifecycle

```
1. Creation (from dev)
   ↓
2. Development (regular commits with smart commits)
   ↓
3. Push to remote
   ↓
4. Create Pull Request
   ↓
5. Code Review & CI checks
   ↓
6. Approval
   ↓
7. Merge to dev (squash recommended)
   ↓
8. Delete feature branch
   ↓
9. Periodic merge: dev → staging
   ↓
10. QA testing on staging
    ↓
11. Approval
    ↓
12. Merge: staging → main
    ↓
13. Production deployment
```

### Branch Protection Rules

**main branch**:
- Require pull request reviews (2 approvals)
- Require status checks to pass
- Require branches to be up to date before merging
- Include administrators
- Do not allow force pushes
- Do not allow deletions

**staging branch**:
- Require pull request reviews (1 approval)
- Require status checks to pass
- Allow administrators to bypass

**dev branch**:
- Require status checks to pass
- No review required (but recommended)
- Allow direct commits for hotfixes

## Troubleshooting

### Smart Commits Not Working
```
Check:
1. Git email matches Jira user email exactly
2. Jira user has appropriate permissions
3. Smart commits enabled in Jira settings
4. Issue key format is correct (PROJ-123)
5. Transition names match Jira workflow

Test:
git commit -m "PROJ-1 #comment Test smart commit" --allow-empty
git push
# Check Jira issue for new comment
```

### Branch Not Showing in Jira
```
Check:
1. Branch name includes Jira issue key
2. GitHub integration is active
3. Repository is connected in Jira
4. Webhook is configured and firing

Reconnect:
- Jira → Settings → Apps → GitHub → Reauthorize
```

### CI/CD Pipeline Failures
```
Debug:
1. Check GitHub Actions logs
2. Verify environment variables are set
3. Test locally with same commands
4. Check dependency versions
5. Review recent changes

Common issues:
- Missing environment variables
- Test database not seeded
- API keys expired
- Node/Python version mismatch
```

## Best Practices Summary

### For Agents
1. **Always start with requirements** - Don't code before understanding
2. **Update Jira with every commit** - Use smart commits religiously
3. **Create small, focused PRs** - Easier to review, faster to merge
4. **Document as you go** - Don't leave it for later
5. **Monitor project health** - Proactively flag issues

### For Humans
1. **Review agent work promptly** - Don't block agent progress
2. **Provide clear feedback** - Help agents learn project preferences
3. **Validate requirements early** - Prevent rework downstream
4. **Trust but verify** - Agents are powerful but need oversight
5. **Keep Jira as source of truth** - Single source for project state

---

**Last Updated**: 2025-11-08
**Framework Version**: 1.0.0
**Companion Files**: AGENTS.md, README.md
