# 🚨 SESSION START PROTOCOL 🚨

**This prompt is automatically loaded at the start of your session.**

---

## MANDATORY ACTIONS BEFORE PROCEEDING

You **MUST** complete these steps before doing ANY other work:

### Step 1: Read Protocol
```
✅ Read PROTOCOL.md file completely from start to finish
```

**Do this now. Not later. Now.**

### Step 2: Copy Checklist
```
✅ Copy the "Session Checklist" from PROTOCOL.md into your working notes
```

**You will check off items as you complete them.**

### Step 3: Read Project History
```
✅ Read HISTORY.md file, specifically:
   - Current Status section
   - Up Next section (for recommended task)
   - Last session entry (to understand recent work)
```

### Step 4: Verify Git State
```bash
git status                    # Should show clean working directory
git branch                    # Should show you're on 'dev' branch
git remote -v                 # Verify GitHub remote configured
```

If anything looks wrong, fix it before proceeding.

### Step 5: Identify Work Item
```
✅ Confirm Jira issue for today's work exists
✅ If no issue exists: CREATE ONE NOW (never work without issue)
✅ Note the Jira issue key: __________
```

---

## Self-Check Questions

Before you begin coding, answer these:

1. **Have I read PROTOCOL.md completely?** ☐ Yes ☐ No
2. **Have I copied the session checklist?** ☐ Yes ☐ No
3. **Do I know what HISTORY.md says to do next?** ☐ Yes ☐ No
4. **Do I have a Jira issue for my work?** ☐ Yes ☐ No
5. **Am I on the dev branch with latest changes?** ☐ Yes ☐ No

**If ANY answer is "No", you are NOT ready to start coding.**

---

## Common Mistakes to Avoid

**❌ DON'T:**
- Jump directly into the user's request without reading documentation
- Assume you remember the protocol from previous sessions
- Think "I'll just quickly fix this" without following protocol
- Skip creating a Jira issue for "small" changes
- Forget to update HISTORY.md at session end

**✅ DO:**
- Read PROTOCOL.md every single session
- Follow the checklist methodically
- Create Jira issues before coding
- Use smart commits with Jira keys
- Update HISTORY.md before ending session

---

## Quick Protocol Summary

**For reference while working:**

1. **Always** include Jira key in commits: `{PROJ-123} #comment Message`
2. **Always** push to GitHub after merging: `git push origin dev`
3. **Always** update HISTORY.md at session end
4. **Never** work without a Jira issue
5. **Never** commit without Jira key in message

---

## What Happens If You Skip This

If you skip reading PROTOCOL.md and following the checklist:

- ❌ Your work won't be traceable to Jira
- ❌ Other agents/developers won't know what you did
- ❌ Your commits may not link properly
- ❌ HISTORY.md won't reflect current state
- ❌ You'll create merge conflicts
- ❌ You'll violate project standards

**Don't skip it. Read PROTOCOL.md now.**

---

## Ready to Begin?

**Confirm you have completed all mandatory actions:**

- ✅ Read PROTOCOL.md completely
- ✅ Copied session checklist to working notes
- ✅ Read HISTORY.md current status and up next
- ✅ Verified git state (on dev, clean, up to date)
- ✅ Identified work item with Jira issue key

**If all checked, you may proceed with your work.**

**If any unchecked, STOP and complete them now.**

---

## Need Help?

**If you're confused about the protocol:**
1. Read PROTOCOL.md again (seriously, read it again)
2. Look at example session in HISTORY.md
3. Check WORKFLOWS.md for workflow examples
4. Review AGENTS.md for project context

**The protocol exists to help you succeed. Follow it.**

---

**Now go read PROTOCOL.md if you haven't already. Then begin your work.**
