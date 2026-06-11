---
name: using-git-worktrees
description: Make sure work happens in an isolated workspace before a feature or plan. A feature branch is the default and is enough for most work; reach for a worktree only when you need a second checkout at once (parallel agents, comparing branches, long build running). Detects existing isolation, prefers the harness's native worktree tool, falls back to git, verifies a clean baseline.
allowed-tools: Read Bash
---

# Isolated Workspaces (Branches & Worktrees)

Work should never land directly on `main`. The default is a **feature branch** —
that's what fits the usual loop (branch → fix → PR → merge → delete →
next). A **worktree** is for when you genuinely need two checkouts at once:
running parallel agents on independent tasks, comparing branches side by side, or
keeping a long build/test going while you work elsewhere. If you don't need a
second checkout, a branch is simpler — don't over-engineer it.

**Say at the start:** "Setting up an isolated workspace."

## Branch (default)

```bash
git switch -c <feature-branch>     # never start on main/master
```

That's it for most work. Skip the rest unless you actually need a second
checkout.

## Worktree (when you need a second checkout)

### Step 0 — detect existing isolation

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
```

`GIT_DIR != GIT_COMMON` is also true inside a submodule, so guard:

```bash
git rev-parse --show-superproject-working-tree 2>/dev/null  # path = submodule
```

- **`GIT_DIR != GIT_COMMON`, not a submodule:** already in a worktree — skip to
  Setup. Don't nest another.
- **Otherwise:** normal checkout. If the user hasn't stated a preference, ask
  before creating one.

### Step 1 — create it

**Native tool first.** If the harness has a worktree tool (something like
`EnterWorktree`, a `/worktree` command, or a `--worktree` flag), use it — it
handles placement, branch, and cleanup, and the harness can track it. Using
`git worktree add` when a native tool exists creates phantom state it can't see.

**Git fallback** (only if no native tool). Default dir `.worktrees/` (else
`worktrees/`; if both, `.worktrees/`). Project-local dirs MUST be git-ignored
first or their contents get committed:

```bash
git check-ignore -q .worktrees || { echo ".worktrees/" >> .gitignore && git add .gitignore && git commit -m "chore: ignore worktrees"; }
git worktree add ".worktrees/<branch>" -b "<branch>"
cd ".worktrees/<branch>"
```

If `git worktree add` fails on a sandbox permission error, tell the user and
work in place.

## Setup

Auto-detect and run:

```bash
[ -f pnpm-lock.yaml ]   && pnpm install
[ -f package.json ]     && [ ! -f pnpm-lock.yaml ] && npm install
[ -f Cargo.toml ]       && cargo build
[ -f go.mod ]           && go mod download
[ -f pyproject.toml ]   && (poetry install || pip install -e .)
```

## Verify a clean baseline

Run the test command (`pnpm test` / `cargo test` / `go test ./...`).

- **Fail:** report and ask whether to proceed — otherwise you can't tell new bugs
  from pre-existing ones.
- **Pass:** report ready.

## Never

- Start work on `main`/`master`.
- Spin up a worktree when a branch is all you need.
- Use `git worktree add` when a native worktree tool exists.
- Create a project-local worktree without verifying it's ignored.
- Skip the baseline test, or push through failures without asking.
