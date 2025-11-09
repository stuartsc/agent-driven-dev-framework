# 🚨 PROTOCOL - MANDATORY FOR ALL AGENTS 🚨

**THIS FILE MUST BE READ AT THE START OF EVERY SESSION**

**STATUS**: MANDATORY - NOT OPTIONAL - NOT NEGOTIABLE

---

## ⚠️ CRITICAL: Session Initialization

**BEFORE doing ANYTHING else, you MUST:**

1. ✅ Read this PROTOCOL.md file completely
2. ✅ Copy the [Session Checklist](#session-checklist) below into your working notes
3. ✅ Check off each item as you complete it
4. ✅ Run `./verify-protocol.sh` before committing (if available)

**If you skip this protocol, you WILL:**
- ❌ Break traceability between code and Jira
- ❌ Create merge conflicts for other developers
- ❌ Lose work history and context
- ❌ Block other agents from continuing your work
- ❌ Violate project standards

---

## Why Agents Forget This Protocol

**Common failure patterns:**
1. Agent jumps directly into coding without reading documentation
2. Agent assumes familiarity with project from previous sessions
3. Agent treats checklists as "suggestions" rather than requirements
4. Agent focuses on user request and ignores protocol overhead

**THIS IS WRONG. PROTOCOL IS NOT OVERHEAD. PROTOCOL IS THE WORK.**

---

## Enforcement Mechanisms

### 1. This File is Listed First
This PROTOCOL.md intentionally comes alphabetically before other docs to be seen first.

### 2. AGENTS.md References This Protocol
The AGENTS.md file's FIRST section points here.

### 3. Session Start Prompt
The `.claude/prompts/session-start.md` file auto-loads this protocol.

### 4. Pre-commit Hooks
Git hooks verify protocol compliance before allowing commits.

### 5. Verification Script
Run `./verify-protocol.sh` to check protocol compliance before committing.

---

## Session Checklist

**COPY THIS CHECKLIST INTO YOUR WORKING NOTES FOR EVERY SESSION:**

```markdown
# Session Protocol Checklist - [Date] - [Agent Name]

## 📋 BEFORE STARTING WORK

### Phase 1: Read Documentation
- [ ] Read PROTOCOL.md completely (this file)
- [ ] Read AGENTS.md for project context
- [ ] Read HISTORY.md for current status and "Up Next" tasks
- [ ] Review PROJECT.md if unfamiliar with setup
- [ ] Note recommended next task from HISTORY.md

### Phase 2: Verify Jira Issue
- [ ] Confirm Jira issue exists for planned work
- [ ] If no issue: CREATE one now (never work without issue)
- [ ] Note Jira issue key: ____________
- [ ] Verify issue is in correct status
- [ ] Check issue is assigned properly
- [ ] Review acceptance criteria

### Phase 3: Git Setup
- [ ] Verify on `dev` branch: `git branch`
- [ ] Pull latest: `git pull origin dev`
- [ ] Verify remote configured: `git remote -v`
- [ ] Check clean state: `git status`

## 💻 DURING DEVELOPMENT

### Phase 4: Create Feature Branch
- [ ] Branch from `dev` (not main!)
- [ ] Use correct naming: `<type>/{PROJ-KEY}-<description>`
- [ ] Branch name includes Jira key: ____________
- [ ] Verify: `git branch` shows new branch

### Phase 5: Implementation
- [ ] Follow code standards from AGENTS.md
- [ ] Add type hints/docstrings where appropriate
- [ ] Test changes before committing
- [ ] Keep commits focused and atomic

### Phase 6: Commit with Smart Commits
- [ ] Every commit includes Jira key
- [ ] Use format: `{PROJ-KEY} #comment <message>`
- [ ] Add time tracking: `#time Xh Ym`
- [ ] Update status: `#in-progress`, `#in-review`, `#done`
- [ ] Commit messages are descriptive (not "fix" or "update")

### Phase 7: Update Jira
- [ ] Add comment documenting progress
- [ ] Transition issue status as appropriate
- [ ] Link related issues if dependencies found
- [ ] Update story points/estimates if changed

## ✅ AFTER COMPLETING WORK

### Phase 8: Documentation
- [ ] **CRITICAL**: Update HISTORY.md with:
  - [ ] What was completed (with Jira keys)
  - [ ] Key decisions made
  - [ ] New files created
  - [ ] Blockers encountered
  - [ ] Next recommended tasks
- [ ] Update README.md if user-facing changes
- [ ] Update PROJECT.md if architecture changed
- [ ] Create/update technical docs if needed

### Phase 9: Testing
- [ ] Run automated tests if they exist
- [ ] Manual testing with sample data
- [ ] Test edge cases
- [ ] Verify no regressions

### Phase 10: Merge to Dev
- [ ] Switch to dev: `git checkout dev`
- [ ] Pull latest: `git pull origin dev`
- [ ] Merge feature: `git merge feature/{PROJ-KEY}-description`
- [ ] Resolve conflicts if any
- [ ] Verify clean merge

### Phase 11: Push Everything (CRITICAL!)
- [ ] Push dev: `git push origin dev`
- [ ] Push feature branch: `git push origin feature/{PROJ-KEY}-description`
- [ ] Verify branches on GitHub web interface
- [ ] Check Jira for automatic commit links

### Phase 12: Jira Verification
- [ ] Verify commits linked in Jira issue
- [ ] Confirm status updated correctly
- [ ] Add manual comment if auto-link failed

## 🎯 SESSION COMPLETION

### Phase 13: Final Verification
- [ ] All changes committed: `git status` clean
- [ ] All branches pushed to GitHub
- [ ] HISTORY.md updated with session summary
- [ ] Jira issues updated and transitioned
- [ ] No uncommitted or unpushed work

### Phase 14: Handoff Documentation
- [ ] Updated "Up Next" section in HISTORY.md
- [ ] Documented any blockers
- [ ] Listed recommended next tasks (with Jira keys)
- [ ] Flagged urgent issues
- [ ] Noted technical debt created

### Phase 15: Self-Verification
- [ ] ✅ Is there a Jira issue for this work?
- [ ] ✅ Are all commits pushed to GitHub?
- [ ] ✅ Does HISTORY.md reflect what I did?
- [ ] ✅ Are Jira issues updated?
- [ ] ✅ Did I test my changes?
- [ ] ✅ Can someone else continue from here?

**If ANY checkbox above is unchecked, you are NOT done with this session.**
```

---

## Standard Git Workflow

**MEMORIZE THIS SEQUENCE:**

```bash
# 1. Start from dev
git checkout dev
git pull origin dev

# 2. Create feature branch with Jira key
git checkout -b feature/{PROJ-123}-description

# 3. Do work, commit with smart commits
git add <files>
git commit -m "{PROJ-123} #time 1h #comment Implemented feature X"

# 4. More commits as needed...
git commit -m "{PROJ-123} #time 30m #comment Added tests"
git commit -m "{PROJ-123} #in-review #comment Ready for review"

# 5. Merge to dev
git checkout dev
git pull origin dev
git merge feature/{PROJ-123}-description

# 6. Push EVERYTHING
git push origin dev
git push origin feature/{PROJ-123}-description

# 7. Update HISTORY.md
# ... edit HISTORY.md ...
git commit -am "Update HISTORY.md with session progress"
git push origin dev
```

---

## Smart Commit Reference

**ALWAYS include Jira key in EVERY commit:**

```bash
# Basic format
{PROJ-KEY} #<command> <arguments>

# Status transitions
{PROJ-123} #in-progress #comment Starting implementation
{PROJ-123} #in-review #comment Ready for code review
{PROJ-123} #done #comment Completed and tested

# Time tracking
{PROJ-123} #time 2h 30m Completed user authentication
{PROJ-123} #time 1h 15m Fixed bugs and added tests

# Combined
{PROJ-123} #time 1h #in-review #comment Feature complete, needs review

# Comments only
{PROJ-123} #comment Blocked waiting for API documentation
```

---

## Common Failure Modes & Recovery

### ❌ FORGOT TO CREATE JIRA ISSUE

**Recovery:**
1. STOP all work immediately
2. Create Jira issue NOW
3. Create new feature branch with correct issue key
4. Cherry-pick commits to new branch OR redo commits
5. Delete incorrect branch
6. Update HISTORY.md to document this mistake

### ❌ FORGOT TO PUSH TO GITHUB

**Recovery:**
1. Push immediately: `git push origin --all`
2. Verify in GitHub web interface
3. Check Jira for commit links
4. Add manual Jira comment if links missing
5. Update HISTORY.md noting this was corrected

### ❌ FORGOT TO UPDATE HISTORY.MD

**Recovery:**
1. Update HISTORY.md immediately
2. Commit: `git commit -am "Update HISTORY.md with recent progress"`
3. Push: `git push origin dev`
4. Add Jira comment noting documentation updated

### ❌ WRONG BRANCH NAME (NO JIRA KEY)

**Recovery:**
1. Rename: `git branch -m old-name feature/{PROJ-123}-new-name`
2. Delete old remote: `git push origin :old-name`
3. Push new: `git push origin feature/{PROJ-123}-new-name`
4. Update any PRs or references

### ❌ WORKED ON MAIN INSTEAD OF DEV

**Recovery:**
1. Create feature branch from current position
2. Reset main to match origin: `git reset --hard origin/main`
3. Cherry-pick commits to feature branch
4. Follow normal merge to dev workflow
5. Document mistake in HISTORY.md

### ❌ COMMIT WITHOUT JIRA KEY

**Recovery:**
1. Amend last commit: `git commit --amend -m "{PROJ-123} Original message"`
2. For older commits: Use interactive rebase `git rebase -i`
3. Force push if not yet shared: `git push --force-with-lease`
4. If already pushed: Add follow-up commit referencing issue

---

## Why This Protocol Exists

### Traceability
Every line of code must trace back to a business requirement (Jira issue). This enables:
- Audit trails for compliance
- Understanding why code exists
- Impact analysis for changes
- Prioritization of technical debt

### Collaboration
Multiple agents/developers work on the same codebase:
- HISTORY.md enables seamless handoffs
- Jira integration keeps everyone informed
- GitHub branches prevent conflicts
- Documentation prevents duplicate work

### Quality
Following protocol ensures:
- Code is tested before merging
- Changes are reviewed
- Documentation stays current
- Technical debt is tracked

### Continuity
When you end a session, others must continue:
- HISTORY.md shows current state
- Jira shows what's next
- Git shows what changed
- Documentation shows how it works

---

## The Non-Negotiables

**ALWAYS DO:**
- ✅ Read PROTOCOL.md at session start
- ✅ Create Jira issue BEFORE coding
- ✅ Use Jira key in branch names
- ✅ Use smart commits for EVERY commit
- ✅ Push to GitHub after EVERY merge
- ✅ Update HISTORY.md with EVERY session
- ✅ Complete the session checklist

**NEVER DO:**
- ❌ Start work without reading PROTOCOL.md
- ❌ Work without a Jira issue
- ❌ Commit without Jira key
- ❌ Forget to push to GitHub
- ❌ Skip HISTORY.md updates
- ❌ Leave work in broken/incomplete state
- ❌ Assume you remember from last session

---

## Escalation Procedure

**If you CANNOT complete a checklist item:**

1. **Document in Jira**: Add comment explaining blocker
2. **Update HISTORY.md**: Note blocker in current status
3. **Flag for user**: Create clear summary of issue
4. **Do NOT proceed**: Stop work on this task
5. **Check alternatives**: Review "Alternative tasks" in HISTORY.md

**Never move forward hoping the issue resolves itself.**

---

## Protocol Verification Command

Before committing, run:

```bash
./verify-protocol.sh
```

This checks:
- [ ] HISTORY.md updated today
- [ ] Current branch has Jira key
- [ ] Recent commits have Jira keys
- [ ] No uncommitted changes (except HISTORY.md)
- [ ] Remote branches are pushed

---

## Session Start Reminder

**When starting a new session, you should see:**

```
🚨 PROTOCOL REMINDER 🚨

Before proceeding, ensure you have:
1. ✅ Read PROTOCOL.md completely
2. ✅ Copied session checklist to working notes
3. ✅ Read HISTORY.md for current status
4. ✅ Identified next task with Jira issue
5. ✅ Verified git state (on dev, pulled latest)

If you haven't done these, STOP and do them now.
```

---

## Anti-Pattern Recognition

**If you catch yourself thinking:**
- "I'll just quickly fix this without creating an issue" → ❌ WRONG
- "I'll update HISTORY.md later" → ❌ WRONG
- "I remember what to do from last time" → ❌ WRONG
- "This is too small to need a checklist" → ❌ WRONG
- "I'll push to GitHub when I'm done with everything" → ❌ WRONG

**STOP. Read PROTOCOL.md again. Follow the checklist.**

---

## Success Metrics

**A protocol-compliant session has:**
- ✅ All work linked to Jira issues
- ✅ All commits on GitHub with smart commit messages
- ✅ HISTORY.md updated with clear next steps
- ✅ Clean git state (no uncommitted work)
- ✅ Jira issues in correct status
- ✅ Documentation current and accurate

---

## Version Control

**This PROTOCOL.md file:**
- **Last Updated**: 2025-11-08
- **Version**: 2.0.0
- **Status**: MANDATORY
- **Enforcement**: STRICT
- **Applies to**: ALL agents, ALL sessions, ALL projects using this framework

---

## Emergency Protocol Override

**The ONLY acceptable reason to skip protocol:**

**NONE. THERE ARE NO EXCEPTIONS.**

Even for:
- "Quick fixes" → NO, create issue and follow protocol
- "Urgent bugs" → NO, follow hotfix protocol in WORKFLOWS.md
- "Documentation updates" → NO, still need issue and tracking
- "Tiny changes" → NO, if it's worth changing, it's worth tracking

---

## Final Warning

**If you are reading this and thinking "I'll just skip the checklist this one time":**

**STOP. GO BACK. READ FROM THE TOP.**

The protocol exists because agents (including you) forget. The checklist exists because memory is unreliable. The enforcement exists because good intentions aren't enough.

**FOLLOW THE PROTOCOL. EVERY TIME. NO EXCEPTIONS.**

---

**🚨 NOW COPY THE SESSION CHECKLIST AND BEGIN YOUR WORK 🚨**
