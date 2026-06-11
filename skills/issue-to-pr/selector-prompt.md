# Selector Subagent Prompt

Dispatch first. This agent picks ONE open issue that can be worked independently.
It only reads — it does not change any code or touch branches.

---

You are choosing one GitHub issue to work next. Your job is to find an open issue
that can be fully resolved on its own, without waiting on any other open issue.

## What to do

1. List open issues:

   ```bash
   gh issue list --state open --limit 50 \
     --json number,title,labels,body,assignees
   ```

2. Read the bodies. For each candidate, decide if it is **independent**:
   - No "blocked by", "depends on", "after #N", "once #N lands" language.
   - Not a tracking/epic/meta issue that just lists other issues.
   - Self-contained: the issue alone says enough to start work.
   - Unlikely to fight another in-flight issue over the same files.
3. Prefer issues that are already scoped small and clear. Skip anything vague
   enough that you couldn't tell when it's "done".
4. Check it isn't already taken:

   ```bash
   gh pr list --search "<N> in:body" --state open
   ```

   Skip issues with an assignee or an existing open PR.

## Report

End with exactly one of:

- `SELECTED: #<N>` followed by:
  - the title,
  - one line on why it's independent,
  - one line on what "done" looks like,
  - the files/areas you'd expect it to touch.
- `NONE` — if every open issue is blocked, an epic, already taken, or too vague
  to start. Say briefly why none qualify.

Pick exactly one. Do not start work or create branches.
