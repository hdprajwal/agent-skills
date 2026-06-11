---
name: subagent-driven-development
description: Execute a plan with a fresh subagent per task and a two-stage review after each — spec compliance first, then code quality — running continuously until done, then finishing on a branch → PR → merge. Use when you have a plan from writing-plans whose tasks are mostly independent and you want to stay in the current session.
allowed-tools: Read Write Edit Bash Agent Task
---

# Subagent-Driven Development

Execute a plan by dispatching a fresh subagent per task, with a two-stage review
after each: spec compliance first, then code quality.

**Why subagents:** each task goes to an agent with isolated context. You craft
its brief precisely so it stays focused; it never inherits your session history.
This also preserves your own context for coordination.

**Core principle:** fresh subagent per task + two-stage review (spec, then
quality) = high quality, fast iteration.

**Run continuously.** Don't check in between tasks — execute every task without
stopping. This is the autonomous loop you want: keep going until done. Stop only
for a BLOCKED status you can't resolve, genuine ambiguity, or all tasks complete.
"Should I continue?" prompts waste time.

## When to use

You have a plan, tasks are mostly independent, you want to stay in this session.
If tasks are coupled, use executing-plans (run them inline).

Start on a feature branch (or a worktree if you'll run agents in parallel) — see
using-git-worktrees. Never start on `main`/`master`.

## The loop

```
Read plan once → extract ALL tasks with full text + context → create task list
For each task:
  1. Dispatch implementer (implementer-prompt.md) with the full task text
  2. It asks questions? → answer, re-dispatch
  3. It implements (Red-Green TDD), tests, commits, self-reviews
  4. Spec reviewer (spec-reviewer-prompt.md) → issues? implementer fixes → re-review until ✅
  5. Code-quality reviewer (code-quality-reviewer-prompt.md) → issues? fix → re-review until ✅
  6. Mark complete
After all tasks → final reviewer over the whole diff → prove it runs → PR
```

Spec compliance is reviewed **before** code quality, never the reverse.

## Model selection

Least powerful model that can do each role:

- **Mechanical** (1-2 files, complete spec) → fast, cheap model.
- **Integration / judgment / debugging** → standard model.
- **Architecture / design / review** → most capable model.

## Implementer status

- **DONE** → spec review.
- **DONE_WITH_CONCERNS** → read them. Correctness/scope → address before review.
  Observations → note and proceed.
- **NEEDS_CONTEXT** → provide it, re-dispatch.
- **BLOCKED** → context problem → more context, same model; needs reasoning →
  more capable model; too large → split; plan is wrong → escalate to the user.

Never force the same model to retry with no change. If it's stuck, something has
to change.

## Prompt templates

- `implementer-prompt.md` · `spec-reviewer-prompt.md` ·
  `code-quality-reviewer-prompt.md`

Fill the bracketed slots and give the subagent the full task text — don't make it
read the plan file.

## Finish

After the final review, prove it runs (tests green + actually run it / drive the
UI with agent-browser), then your normal loop:

```bash
git push -u origin <branch> && gh pr create --fill
gh pr merge --squash --delete-branch && git switch main && git pull
```

Confirm before the merge unless told to run it through. Working an issue queue?
Repeat from the next issue.

## Never

- Start on `main`/`master` without consent.
- Skip a review, or start code-quality before spec compliance is ✅.
- Move to the next task with either review still open.
- Run multiple implementers in parallel on the same plan (they conflict — that's
  dispatching-parallel-agents, for *independent* domains).
- Make the subagent read the plan file (give it the full task text).
- Skip scene-setting context, ignore the subagent's questions, or let self-review
  replace real review.
- Fix a failed task by hand (context pollution) — dispatch a fix subagent.

## Related

- **writing-plans** (creates the plan) · **using-git-worktrees** (isolation) ·
  **dispatching-parallel-agents** (independent problems) · **executing-plans**
  (inline alternative). Subagents follow incremental-implementation + Red-Green
  TDD per task.
