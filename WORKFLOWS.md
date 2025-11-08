# WORKFLOWS.md

Practical workflow templates and automation patterns for agent-driven development. This file provides copy-paste ready examples and templates.

## Quick Reference

| Workflow | Use Case | Files Needed |
|----------|----------|--------------|
| [New Feature](#new-feature-workflow) | Implement new functionality | Jira ticket, feature branch |
| [Bug Fix](#bug-fix-workflow) | Fix defects | Bug ticket, fix branch |
| [Hotfix](#hotfix-workflow) | Critical production fix | Hotfix branch, fast-track |
| [Refactoring](#refactoring-workflow) | Code improvements | Refactor branch |
| [Requirements to Deployment](#requirements-to-deployment) | Complete lifecycle | All |

## Agent Prompt Templates

### Requirements Elicitation Prompt

```markdown
## Task: Elicit Requirements for New Project

### Context
Project name: [Name]
Domain: [Industry/Domain]
Primary stakeholder: [Name/Role]

### Instructions
1. Conduct structured interview using these phases:
   - Discovery (understand the problem)
   - Exploration (identify users and use cases)
   - Specification (detail functional requirements)
   - Validation (confirm understanding)

2. Create multi-agent team:
   - Interviewer: Ask clarifying questions
   - Analyst: Check completeness and consistency
   - Archivist: Document requirements
   - Reviewer: Validate quality

3. Deliverables:
   - Requirements document (use template in PROJECT.md)
   - User stories with acceptance criteria
   - Use case diagrams (text descriptions)
   - Prioritized feature list

4. Create Jira issues:
   - Use MCP to connect to Jira
   - Create Epic for each major feature
   - Break down into Stories and Tasks
   - Set priorities based on MoSCoW

### Expected Output
- Structured requirements document
- List of Jira issues created (with keys)
- Summary of stakeholder validation
```

### Project Setup Prompt

```markdown
## Task: Initialize New Project with Full Integration

### Instructions
1. **Jira Setup**
   - Create project: [Project Key]
   - Configure issue types and workflows
   - Import issues from requirements doc
   - Set up first sprint

2. **GitHub Setup**
   - Initialize repository
   - Create branch structure (main/staging/dev)
   - Set up branch protection rules
   - Configure GitHub Actions for CI/CD

3. **Integration**
   - Install GitHub for Jira app
   - Configure smart commits
   - Set up MCP servers (Atlassian, GitHub)
   - Test integration with dummy commit

4. **Documentation**
   - Create README.md
   - Ensure AGENTS.md exists
   - Ensure PROJECT.md exists
   - Create API documentation structure

5. **Validation**
   - Create test branch: feature/[KEY]-1-test
   - Make test commit with smart commit
   - Verify Jira update
   - Create and merge test PR

### Expected Output
- Repository URL
- Jira project URL
- Integration test results
- Documentation links
```

## Complete Workflow Examples

### New Feature Workflow

```bash
# 1. Agent selects issue from Jira
# Via MCP: "Get highest priority unassigned story in current sprint"

# 2. Agent creates branch
git checkout dev
git pull origin dev
git checkout -b feature/PROJ-123-user-profile

# 3. Agent implements feature with regular commits
git add src/models/user-profile.ts
git commit -m "PROJ-123 #comment Created user profile model #in-progress #time 45m"

git add src/api/profile.ts
git commit -m "PROJ-123 #comment Added profile API endpoints #time 1h 30m"

git add src/components/ProfileView.tsx
git commit -m "PROJ-123 #comment Implemented profile UI component #time 2h"

git add tests/profile.test.ts
git commit -m "PROJ-123 #comment Added comprehensive tests #time 1h 15m"

# 4. Final commit with review request
git commit -m "PROJ-123 #in-review #comment Feature complete, ready for review"

# 5. Push and create PR
git push -u origin feature/PROJ-123-user-profile

gh pr create --base dev \
  --title "PROJ-123: Implement user profile feature" \
  --body "## Summary
Implemented user profile viewing and editing functionality.

## Changes
- Added UserProfile model with validation
- Created REST API endpoints (GET, PUT /api/profile)
- Built ProfileView React component
- Added comprehensive unit and integration tests

## Testing
- [x] Unit tests (15 new tests, all passing)
- [x] Integration tests (API endpoints verified)
- [x] Manual testing (screenshots attached)
- [x] Accessibility checks (WCAG AA compliant)

## Jira
https://yourcompany.atlassian.net/browse/PROJ-123

## Screenshots
![Profile View](./docs/screenshots/profile-view.png)
![Profile Edit](./docs/screenshots/profile-edit.png)"

# 6. After approval and merge
git checkout dev
git pull origin dev
git branch -d feature/PROJ-123-user-profile

# Agent updates Jira
# Via MCP: Add comment "Merged to dev, deployed to staging for QA"
```

### Bug Fix Workflow

```bash
# 1. Agent identifies critical bug
# Via Jira: "Search issues with label:critical AND status:Open"

# 2. Create fix branch
git checkout dev
git pull origin dev
git checkout -b fix/PROJ-456-login-redirect

# 3. Reproduce and diagnose
git commit -m "PROJ-456 #comment Reproduced issue, root cause identified #in-progress" --allow-empty

# 4. Implement fix
git add src/auth/redirect.ts
git commit -m "PROJ-456 #time 30m Fixed redirect logic after login"

# 5. Add regression test
git add tests/auth.test.ts
git commit -m "PROJ-456 #time 45m Added regression test for redirect bug"

# 6. Complete and request review
git commit -m "PROJ-456 #in-review #comment Bug fixed with test coverage, ready for review" --allow-empty

# 7. Push and create PR with bug details
git push -u origin fix/PROJ-456-login-redirect

gh pr create --base dev \
  --title "PROJ-456: Fix login redirect bug" \
  --body "## Bug Description
Users were redirected to homepage instead of their intended destination after login.

## Root Cause
Redirect URL was not persisted in session storage during OAuth flow.

## Fix
- Persist redirect URL before OAuth redirect
- Restore and navigate to URL after successful login
- Added fallback to homepage if no redirect URL

## Testing
- [x] Manual testing with multiple redirect scenarios
- [x] Regression test added
- [x] No other auth flows affected

## Jira
https://yourcompany.atlassian.net/browse/PROJ-456"
```

### Hotfix Workflow

```bash
# CRITICAL: Production is down or severely impacted

# 1. Agent identifies critical production issue
# Trigger: PagerDuty alert, user reports, monitoring

# 2. Create hotfix branch from main (not dev!)
git checkout main
git pull origin main
git checkout -b hotfix/PROJ-789-payment-processing

# 3. Quick fix with urgency markers
git add src/payment/processor.ts
git commit -m "PROJ-789 #comment HOTFIX: Fixed null pointer in payment processing #in-progress"

# 4. Minimal testing (automated + quick manual)
git add tests/payment.test.ts
git commit -m "PROJ-789 #time 20m Added critical path test"

# 5. Fast-track review
git push -u origin hotfix/PROJ-789-payment-processing

gh pr create --base main \
  --title "🚨 HOTFIX PROJ-789: Fix payment processing crash" \
  --body "## CRITICAL ISSUE
Payment processing failing with null pointer exception.

## Impact
- All payment transactions failing
- Revenue loss: ~$XXX/hour
- Customer support backlog

## Fix
Single line fix: Null check before processing payment object

## Testing
- [x] Critical path test added and passing
- [x] Manual test with live payment
- [x] No regression in happy path

## Deployment Plan
1. Merge to main immediately after review
2. Deploy to production
3. Monitor for 1 hour
4. Backport to staging and dev

## Jira
https://yourcompany.atlassian.net/browse/PROJ-789"

# 6. After urgent approval, merge to main
git checkout main
git merge --no-ff hotfix/PROJ-789-payment-processing
git push origin main

# 7. Immediately backport to other branches
git checkout staging
git merge main
git push origin staging

git checkout dev
git merge main
git push origin dev

# 8. Update Jira with resolution
git commit -m "PROJ-789 #done #comment Hotfix deployed to production, monitoring" --allow-empty
```

### Refactoring Workflow

```bash
# 1. Create refactoring task in Jira
# Usually child of a larger Epic

# 2. Create refactor branch
git checkout dev
git checkout -b refactor/PROJ-234-extract-api-client

# 3. Refactor in small, testable steps
git add src/api/base-client.ts
git commit -m "PROJ-234 #time 1h Created base API client class #in-progress"

git add src/api/user-client.ts
git commit -m "PROJ-234 #time 45m Extracted user API to dedicated client"

git add src/api/auth-client.ts
git commit -m "PROJ-234 #time 45m Extracted auth API to dedicated client"

# 4. Update all call sites
git add src/components/**/*.tsx
git commit -m "PROJ-234 #time 2h Updated all components to use new API clients"

# 5. Ensure tests still pass
git add tests/api/*.test.ts
git commit -m "PROJ-234 #time 1h 30m Updated and expanded API tests"

# 6. Documentation
git add docs/api/client-architecture.md
git commit -m "PROJ-234 #time 30m Documented new API client architecture"

# 7. Complete refactor
git commit -m "PROJ-234 #in-review #comment Refactoring complete, all tests passing" --allow-empty

# 8. Create PR emphasizing safety
gh pr create --base dev \
  --title "PROJ-234: Extract API client logic" \
  --body "## Refactoring Summary
Extracted scattered API logic into dedicated client classes.

## Benefits
- Centralized error handling
- Consistent request/response formatting
- Easier to mock for testing
- Better type safety

## Changes
- Created BaseApiClient with common functionality
- Extracted UserApiClient, AuthApiClient, PaymentApiClient
- Updated all call sites (47 files)
- Maintained 100% backward compatibility

## Safety
- [x] All existing tests passing (0 changes needed)
- [x] No behavioral changes
- [x] Added 23 new unit tests for clients
- [x] Coverage increased from 72% to 85%

## Migration
No migration needed - changes are internal only.

## Jira
https://yourcompany.atlassian.net/browse/PROJ-234"
```

## Requirements to Deployment

Complete end-to-end workflow:

```markdown
### Phase 1: Requirements (Week 1)

**Day 1-2: Elicitation**
- Agent: "Conduct requirements interview for [Project Name]"
- Agent creates requirements document
- Human: Review and provide feedback
- Agent: Iterate based on feedback

**Day 3-4: Jira Setup**
- Agent: "Create Jira project [KEY] and populate with requirements"
- Agent creates Epic structure
- Agent breaks down into Stories and Tasks
- Human: Review and adjust priorities

**Day 5: Planning**
- Agent: "Plan first sprint for project [KEY]"
- Agent pulls high-priority items into sprint
- Team: Sprint planning meeting
- Agent: Document sprint goals

### Phase 2: Development (Weeks 2-3)

**Daily Cycle** (repeat for each issue):
1. Agent: "Get my highest priority issue in current sprint"
2. Agent: Create feature branch
3. Agent: Implement with regular smart commits
4. Agent: Create PR when complete
5. Human: Code review
6. Agent: Address feedback
7. Human: Approve
8. Agent: Merge and update Jira

**Continuous:**
- CI/CD runs on every push
- Jira updated via smart commits
- Staging environment auto-deploys from dev branch
- Agent monitors sprint progress daily

### Phase 3: QA (Week 4)

**Staging Testing**
- Dev branch merged to staging
- QA team tests on staging environment
- Bugs reported as Jira issues
- Agent: Fixes bugs using bug fix workflow

**Regression Testing**
- Automated tests run on staging
- Manual regression checklist
- Performance testing
- Security scanning

### Phase 4: Production (Week 5)

**Release Preparation**
- Staging merged to main
- Release notes generated from commit messages
- Version bump
- Final smoke tests

**Deployment**
- Production deployment via CI/CD
- Monitoring and alerting active
- Rollback plan ready
- Post-deployment verification

**Closure**
- All sprint issues marked Done
- Retrospective conducted
- Agent: Generate sprint report
- Plan next sprint
```

## Smart Commit Cheat Sheet

```bash
# Basic syntax
<JIRA-KEY> #<command> <arguments>

# --- COMMON PATTERNS ---

# Start work on issue
git commit -m "PROJ-123 #in-progress #comment Starting implementation"

# Log time spent
git commit -m "PROJ-123 #time 2h 30m Completed user authentication"

# Add detailed comment
git commit -m "PROJ-123 #comment Implemented OAuth flow with Google and GitHub providers"

# Mark for review
git commit -m "PROJ-123 #in-review #comment Implementation complete, needs code review"

# Mark as done
git commit -m "PROJ-123 #done #comment Feature deployed to staging"

# --- COMBINATIONS ---

# Work with time tracking
git commit -m "PROJ-123 #time 1h 45m #comment Fixed validation bug"

# Progress with review
git commit -m "PROJ-123 #time 3h #in-review #comment Feature complete, tests passing"

# Complete with time
git commit -m "PROJ-123 #done #time 30m #comment Final fixes merged"

# --- WORKFLOW TRANSITIONS ---

# Common workflow states (adjust to your Jira workflow)
#to-do         → Ready to start
#in-progress   → Currently working
#in-review     → Waiting for code review
#in-qa         → Ready for QA testing
#blocked       → Cannot proceed
#done          → Completed

# Example workflow
git commit -m "PROJ-123 #in-progress #comment Started work"
# ... development ...
git commit -m "PROJ-123 #in-review #comment PR created"
# ... code review ...
git commit -m "PROJ-123 #in-qa #comment Merged to staging"
# ... QA testing ...
git commit -m "PROJ-123 #done #comment Deployed to production"

# --- TIME FORMATS ---

# Time units (combine as needed)
#time 1w        → 1 week
#time 2d        → 2 days
#time 3h        → 3 hours
#time 30m       → 30 minutes

# Combined
#time 1d 4h 30m → 1 day, 4 hours, 30 minutes

# Decimal values
#time 2.5h      → 2 hours 30 minutes

# --- SPECIAL CASES ---

# Multiple issues in one commit
git commit -m "PROJ-123 PROJ-456 #comment Fixed related issues"

# Blocked issue
git commit -m "PROJ-123 #blocked #comment Waiting for API documentation"

# Link to other issue
git commit -m "PROJ-123 #comment Related to PROJ-456, depends on completion"

# Assign issue
git commit -m "PROJ-123 #assign john.doe #comment Reassigning for review"
```

## GitHub Actions Templates

### Basic CI Pipeline

```yaml
# .github/workflows/ci.yml
name: CI Pipeline

on:
  push:
    branches: [dev, staging, main]
  pull_request:
    branches: [dev, staging, main]

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [18, 20]

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Lint
        run: npm run lint

      - name: Type check
        run: npm run type-check

      - name: Run tests
        run: npm test -- --coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage/coverage-final.json

      - name: Build
        run: npm run build
```

### Jira Integration Pipeline

```yaml
# .github/workflows/jira-integration.yml
name: Jira Integration

on:
  pull_request:
    types: [opened, reopened, closed, ready_for_review]
  pull_request_review:
    types: [submitted, dismissed]

jobs:
  jira-transition:
    runs-on: ubuntu-latest

    steps:
      - name: Extract Jira Issue Key
        id: extract
        run: |
          BRANCH="${{ github.head_ref }}"
          ISSUE_KEY=$(echo "$BRANCH" | grep -oE '[A-Z]+-[0-9]+' | head -1)
          echo "issue_key=$ISSUE_KEY" >> $GITHUB_OUTPUT
          echo "Extracted issue key: $ISSUE_KEY"

      - name: Transition to In Review (PR opened)
        if: |
          github.event.action == 'opened' ||
          github.event.action == 'ready_for_review'
        uses: atlassian/gajira-transition@v3
        env:
          JIRA_BASE_URL: ${{ secrets.JIRA_BASE_URL }}
          JIRA_USER_EMAIL: ${{ secrets.JIRA_USER_EMAIL }}
          JIRA_API_TOKEN: ${{ secrets.JIRA_API_TOKEN }}
        with:
          issue: ${{ steps.extract.outputs.issue_key }}
          transition: "In Review"

      - name: Add PR Link to Jira
        if: github.event.action == 'opened'
        uses: atlassian/gajira-comment@v3
        env:
          JIRA_BASE_URL: ${{ secrets.JIRA_BASE_URL }}
          JIRA_USER_EMAIL: ${{ secrets.JIRA_USER_EMAIL }}
          JIRA_API_TOKEN: ${{ secrets.JIRA_API_TOKEN }}
        with:
          issue: ${{ steps.extract.outputs.issue_key }}
          comment: |
            Pull Request created: ${{ github.event.pull_request.html_url }}

            **Title:** ${{ github.event.pull_request.title }}
            **Author:** @${{ github.event.pull_request.user.login }}

      - name: Transition to Done (PR merged)
        if: |
          github.event.action == 'closed' &&
          github.event.pull_request.merged == true
        uses: atlassian/gajira-transition@v3
        env:
          JIRA_BASE_URL: ${{ secrets.JIRA_BASE_URL }}
          JIRA_USER_EMAIL: ${{ secrets.JIRA_USER_EMAIL }}
          JIRA_API_TOKEN: ${{ secrets.JIRA_API_TOKEN }}
        with:
          issue: ${{ steps.extract.outputs.issue_key }}
          transition: "Done"

      - name: Add Merge Comment
        if: |
          github.event.action == 'closed' &&
          github.event.pull_request.merged == true
        uses: atlassian/gajira-comment@v3
        env:
          JIRA_BASE_URL: ${{ secrets.JIRA_BASE_URL }}
          JIRA_USER_EMAIL: ${{ secrets.JIRA_USER_EMAIL }}
          JIRA_API_TOKEN: ${{ secrets.JIRA_API_TOKEN }}
        with:
          issue: ${{ steps.extract.outputs.issue_key }}
          comment: |
            ✅ Pull Request merged by @${{ github.event.pull_request.merged_by.login }}

            Merged into: `${{ github.event.pull_request.base.ref }}`
            Commit: ${{ github.event.pull_request.merge_commit_sha }}
```

### Deployment Pipeline

```yaml
# .github/workflows/deploy-staging.yml
name: Deploy to Staging

on:
  push:
    branches: [staging]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build
        env:
          NODE_ENV: staging
          NEXT_PUBLIC_API_URL: ${{ secrets.STAGING_API_URL }}

      - name: Run database migrations
        run: npm run migrate
        env:
          DATABASE_URL: ${{ secrets.STAGING_DATABASE_URL }}

      - name: Deploy to Staging
        run: |
          # Deploy using your preferred method
          # Examples: Vercel, AWS, Docker, etc.
          vercel deploy --prod --token=${{ secrets.VERCEL_TOKEN }}

      - name: Run smoke tests
        run: npm run test:e2e
        env:
          BASE_URL: https://staging.example.com

      - name: Notify team
        if: always()
        uses: slackapi/slack-github-action@v1
        with:
          webhook-url: ${{ secrets.SLACK_WEBHOOK }}
          payload: |
            {
              "text": "Staging deployment ${{ job.status }}",
              "blocks": [
                {
                  "type": "section",
                  "text": {
                    "type": "mrkdwn",
                    "text": "🚀 Staging deployment *${{ job.status }}*\n\nCommit: ${{ github.event.head_commit.message }}\nAuthor: ${{ github.event.head_commit.author.name }}"
                  }
                }
              ]
            }
```

## Agent Daily Automation Scripts

### Morning Sync

```markdown
## Agent Task: Morning Development Sync

Execute daily at 9:00 AM local time.

### 1. Sprint Health Check
- Query Jira for active sprint
- Calculate completion percentage
- Identify at-risk issues (no activity in 2 days)
- Generate sprint burndown data

### 2. Individual Developer Check-in
For each team member:
- Get assigned issues in "In Progress"
- Check for recent GitHub activity
- Flag stale issues (no commits in 2 days)
- Identify blockers (issues with "blocked" label/comment)

### 3. Generate Daily Standup Report
Format:
```
## Daily Standup - [Date]

### Sprint Progress
- Completed: X/Y story points (Z%)
- Remaining: X story points
- Days left: X
- On track: Yes/No

### Team Status

**[Developer 1]**
Yesterday:
- PROJ-123: Completed user authentication
- PROJ-124: Fixed login bug

Today:
- PROJ-125: Implement profile page

Blockers:
- None

**[Developer 2]**
...
```

### 4. Flag Issues
- Create summary of at-risk items
- Notify team in Slack/email
- Suggest corrective actions
```

### Evening Cleanup

```markdown
## Agent Task: Evening Cleanup

Execute daily at 6:00 PM local time.

### 1. Update Jira from GitHub
- Scan all PRs created today
- Ensure Jira issues are in correct state
- Add PR links to issues if missing
- Update issue fields (commits, branches)

### 2. Branch Cleanup
- Identify merged branches
- Delete remote branches older than 7 days
- Notify owners of stale branches (30+ days)

### 3. Generate Daily Report
```
## Daily Development Report - [Date]

### Commits Today: XX
- feature/: XX commits
- fix/: XX commits
- refactor/: XX commits

### Pull Requests
- Created: X
- Merged: X
- Open: X (avg age: X days)

### Jira Updates
- Issues completed: X
- Issues started: X
- Blockers added: X

### Code Quality
- Tests added: X
- Coverage: XX%
- Lint issues: X
```

### 4. Prepare Next Day
- Generate prioritized task list for each developer
- Identify dependencies blocking progress
- Flag issues needing review/approval
```

## MCP Agent Workflows

### Create Multiple Issues from Requirements

```python
# Agent workflow via MCP
def create_issues_from_requirements(requirements_doc):
    """
    Parse requirements document and create structured Jira issues.
    """
    # 1. Parse requirements
    requirements = parse_markdown(requirements_doc)

    # 2. Create Epic for each major feature
    for feature in requirements.features:
        epic = jira_mcp.create_issue({
            'project': 'PROJ',
            'type': 'Epic',
            'summary': feature.name,
            'description': feature.description,
            'priority': feature.priority,
            'labels': ['requirements', f'release-{feature.release}']
        })

        # 3. Create Stories for each user story
        for story in feature.user_stories:
            jira_story = jira_mcp.create_issue({
                'project': 'PROJ',
                'type': 'Story',
                'summary': story.summary,
                'description': f"""
## User Story
{story.user_story}

## Acceptance Criteria
{format_acceptance_criteria(story.criteria)}

## Technical Notes
{story.technical_notes}
                """,
                'parent': epic.key,
                'story_points': estimate_story_points(story),
                'labels': story.labels
            })

            # 4. Create Tasks for implementation steps
            for task in story.tasks:
                jira_mcp.create_issue({
                    'project': 'PROJ',
                    'type': 'Task',
                    'summary': task.summary,
                    'description': task.description,
                    'parent': jira_story.key,
                    'estimate': task.hours
                })

    return f"Created {len(requirements.features)} Epics with Stories and Tasks"
```

### Auto-Triage New Issues

```python
# Agent monitors new issues and auto-assigns
def auto_triage_issues():
    """
    Monitor new Jira issues and automatically triage.
    """
    # Get unassigned issues
    issues = jira_mcp.search_issues(
        'project = PROJ AND assignee is EMPTY AND created >= -1d'
    )

    for issue in issues:
        # Analyze issue content
        analysis = analyze_issue_content(issue.description)

        # Auto-assign based on expertise
        assignee = match_to_expert(analysis.domain, analysis.skills_needed)

        # Set priority based on keywords
        priority = determine_priority(issue.summary, issue.description)

        # Add appropriate labels
        labels = generate_labels(analysis)

        # Update issue
        jira_mcp.update_issue(issue.key, {
            'assignee': assignee,
            'priority': priority,
            'labels': labels,
            'comment': f"""
Auto-triaged by AI Agent:
- Assigned to {assignee} based on {analysis.domain} expertise
- Priority set to {priority} based on content analysis
- Labels added: {', '.join(labels)}

Please review and adjust if needed.
            """
        })
```

## Troubleshooting Workflows

### Fix Broken CI/CD

```bash
# 1. Identify failure
gh run list --limit 5

# 2. View logs
gh run view [run-id] --log

# 3. Reproduce locally
npm ci
npm run lint
npm test
npm run build

# 4. Fix issues
git add .
git commit -m "PROJ-XXX #comment Fixed CI/CD pipeline"

# 5. Re-run workflow
git push
```

### Sync Jira and GitHub

```bash
# If Jira and GitHub are out of sync

# 1. List all open PRs
gh pr list --state open

# 2. For each PR, extract Jira key and update
for pr in $(gh pr list --state open --json number,headRefName -q '.[] | .number'); do
  branch=$(gh pr view $pr --json headRefName -q '.headRefName')
  jira_key=$(echo $branch | grep -oE '[A-Z]+-[0-9]+')

  # Update Jira with PR link
  # Use Jira API or MCP
  echo "Sync $jira_key with PR #$pr"
done
```

---

**Last Updated**: 2025-11-08
**Framework Version**: 1.0.0
**Related Files**: AGENTS.md, PROJECT.md
