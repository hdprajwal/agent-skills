---
name: executing-plans
description: >-
  Run a written plan inline in the current session with review checkpoints: load
  it, review it critically, run each task exactly with its verifications, prove
  it actually runs, then finish on a branch → PR → merge. Use when you have a
  plan from writing-plans and tasks are coupled enough to keep in one session.
  Stops and asks when blocked.
allowed-tools: Read Write Edit Bash
---

# Executing Plans

Load the plan, review it critically, run every task, finish with a PR.

**Say at the start:** "Using the executing-plans skill to implement this plan."

Use this when tasks are coupled or you just want one context. If tasks are
independent and subagents are available, subagent-driven-development gives
cleaner results (fresh context per task).

## 1. Load and review

Read the plan. Review it critically and note concerns. If you have concerns,
raise them before starting — consult, don't guess. Otherwise create a task list
and go. Never start on `main`/`master`: cut a feature branch first (or set up a
worktree via using-git-worktrees if you want full isolation).

## 2. Execute

For each task: mark it in progress → follow each step exactly → run the
verifications the plan specifies → mark it complete. Work in thin slices —
implement, test, verify, commit. If a task feels too big, the
incremental-implementation skill covers slicing.

## 3. Prove it runs

Tests passing isn't the same as working. Before claiming done, prove the change
actually runs the way the user would hit it:

- Run the full test suite — green.
- Actually run it: start the app / call the endpoint / exercise the CLI. For UI,
  drive it with agent-browser and confirm the behavior.
- Paste the real output. Don't claim "it works" without showing it.

## 4. Finish

This is your normal loop — don't merge or push until the work is done and proven:

```bash
git push -u origin <branch>
gh pr create --fill
# review, then:
gh pr merge --squash --delete-branch
git switch main && git pull
```

Confirm with the user before the merge unless they've said to run it through.
If you're working an issue queue, repeat from the next issue.

## Stop and ask when

Blocked (missing dep, failing test, unclear step), the plan has a gap, you don't
understand a step, or a verification keeps failing. Ask rather than guess. Don't
force through a blocker.

## Go back to review when

The user updates the plan after your feedback, or the approach needs rethinking.

## Remember

- Review critically first; raise concerns before starting.
- Follow steps exactly; don't skip verifications.
- Prove it runs, don't just claim it.
- Never start on `main`/`master` without consent.

## Related

- **writing-plans** — creates the plan.
- **subagent-driven-development** — the fresh-subagent-per-task alternative.
- **using-git-worktrees** — full isolation when you want it.
- **incremental-implementation** — slice discipline within a task.
