---
name: session-handoff
description: >-
  Write or restore a handoff note when pausing or switching between projects, so
  the next session (you, another agent, or the user) resumes without re-deriving
  context. Use when wrapping up for now, context is getting long, switching to
  another repo, or starting back up on a project left mid-task. Captures state +
  next step, not a transcript.
allowed-tools: Read Write Edit Bash
---

# Session Handoff

Across many parallel projects, the expensive part of resuming is rebuilding
context. A handoff note fixes that: a short, current snapshot of where things
stand and what's next — written when you stop, read when you start.

## Writing a handoff (when pausing / switching)

Save to `docs/HANDOFF.md` in the repo (or update it if it exists). Keep it short
and current — overwrite stale parts, don't append forever.

```markdown
# Handoff — <project> — <YYYY-MM-DD>

## Goal
<the task in one or two sentences>

## State
- Done: <what's working and verified>
- In progress: <what's half-built, and where exactly>
- Branch: <current branch> · last commit: <sha + subject>

## Next step
<the single concrete next action — specific enough to start cold>

## Open questions / decisions pending
- <thing you or the user still needs to decide>

## Key files / commands
- `path/to/file.rs` — <why it matters>
- run: `pnpm dev` / `cargo run` / test: `…`

## Watch out for
- <gotcha, flaky test, half-done migration, anything that'll bite>
```

Before writing it, capture real state, don't guess:

```bash
git branch --show-current
git log --oneline -5
git status --short
```

Rules: state the **next step concretely** (the whole point); record **decisions
pending** so they're not silently re-made; note **what's broken or half-done**;
keep it to a screen. It's a snapshot, not a changelog.

## Restoring from a handoff (when starting back up)

1. Read `docs/HANDOFF.md`.
2. Verify it against reality — `git status`, `git log`, run the build/tests. The
   repo is the source of truth; the note can be stale.
3. Confirm the branch and that the baseline still passes before continuing.
4. Pick up at "Next step." If reality and the note disagree, trust the repo and
   say so.

## Notes

- A handoff is for resuming work; a **plan** (writing-plans) is for specifying
  it, and a **PRD** for defining it. Don't duplicate those here — link to them.
- For a quick same-day pause a few lines is enough; scale the detail to how cold
  the restart will be.
