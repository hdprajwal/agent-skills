---
name: issue-to-pr
description: "Take one independent open GitHub issue from the queue to an open PR by composing skills you already have — isolation, implementation, and review — then stop at the PR for your merge approval. Use to clear a GitHub issue queue one issue at a time (\"take issue #42 to a PR\", \"work the next issue\", \"grab an issue\"). One issue per run; never merges to main on its own."
allowed-tools: Read Bash Agent Task Skill
---

# Issue to PR

Take one open GitHub issue from queue to PR. This skill is **glue, not
re-implementation** — it picks an independent issue, then hands each step to the
skill that already does it well, and stops before the merge.

**Say at the start:** "Using issue-to-pr — select → isolate → implement →
review loop → PR, stopping before merge."

**Scope: one issue per run.** Do the whole pipeline for a single issue, open the
PR, stop. To clear the queue, re-invoke (or wrap in `/loop`).

**Never merge to `main`.** The run ends at an open PR. The user merges.

## What this skill reuses

The only thing unique here is **selecting an independent issue** and **ordering
the steps**. Everything else is an existing skill — don't restate their content,
invoke them:

| Step | Delegate to |
|------|-------------|
| Isolation (branch off main) | **using-git-worktrees** — branch is the default |
| Implement the fix | **incremental-implementation** — slices, green gate, commits |
| Dispatch fresh subagents | **subagent-driven-development** / **dispatching-parallel-agents** |
| Review the diff + apply fixes | **code-review** skill (reviews current diff; `--fix` applies) |

## The pipeline

```
Preflight → Select issue → Isolate → Implement → Review loop (≤3) → Push → PR → STOP
```

### 0. Preflight

```bash
gh auth status            # gh authed
git status --porcelain    # working tree clean — stop if not
git switch main && git pull
```

Note the project's **test and build commands** (package.json / Makefile /
Cargo.toml / CI). They're the green gate for every step below.

### 1. Select an independent issue  ← the unique part

Dispatch the **selector** subagent (`selector-prompt.md`). It runs
`gh issue list` / `gh issue view` and returns ONE issue solvable without waiting
on any other — no "blocked by / depends on / after #N", not an epic, not already
assigned or carrying an open PR. It returns the number, title, a one-line reason
it's independent, and what "done" looks like.

If nothing qualifies, stop and say so — don't force one.

### 2. Isolate

Invoke **using-git-worktrees**. A plain feature branch is the default:

```bash
git switch -c fix/<N>-<short-slug>     # feat/ for features
```

### 3. Implement

Dispatch a fresh implementer subagent (the **subagent-driven-development**
pattern). Its brief: the **full issue text** (paste it — don't say "go read the
issue"), the definition of done, the project's test/build commands, and one
instruction — **follow the incremental-implementation skill**: thin slices,
tests + build green before moving on, commit each slice. Tests/build green is a
hard gate; it does not report DONE on red.

Handle its status: `NEEDS_CONTEXT`/`BLOCKED` → resolve or stop and ask. Never
push red code.

### 4. Review loop (max 3 rounds)

Each round, run the **code-review** skill on the current working-tree diff at
`high` effort:

```
/code-review high
```

Map its output to blocking vs non-blocking:

- **Blocking (the "major" findings)** — correctness bugs, missing/wrong behavior
  vs the issue, regressions, security holes, broken/missing tests. These gate the
  PR.
- **Non-blocking (the "minor" findings)** — reuse / simplification / efficiency /
  style cleanups. These do **not** gate; carry them into the PR description.

Then:

- **Blocking findings, rounds remain** → fix them and re-review. Use
  `/code-review high --fix` to apply directly, or for larger fixes dispatch a
  fresh subagent told to follow **incremental-implementation** and fix only the
  blocking findings. Re-run tests/build to green, commit, then review again.
- **No blocking findings** → exit the loop; ready to push.
- **3 rounds done, blocking findings remain** → stop. Push nothing. Report what's
  left and what was tried; hand it to the user.

Non-blocking findings never trigger another round. Cap is 3 review→fix cycles.

### 5. Push + PR

Confirm tests/build green, then:

```bash
git push -u origin fix/<N>-<short-slug>
gh pr create --fill --body "Closes #<N>

<one-line summary of the fix>

Review: blocking findings resolved in N round(s).
Non-blocking follow-ups (from code-review):
- [ ] ...
"
```

`Closes #<N>` auto-closes the issue on merge.

### 6. Stop — hand off the merge

Report: PR URL, the issue it closes, how many review rounds ran and what blocking
findings were fixed, the non-blocking follow-ups, and test/build status. Then
**stop**. Don't run `gh pr merge` — the merge is the user's call.

## Stop and ask when

Preflight fails · no independent issue exists · the implementer is BLOCKED ·
blocking findings survive 3 rounds · the fix needs a product decision the issue
doesn't answer.

## Remember

- One issue per run. Open PR, then stop.
- Never `gh pr merge` — the merge is the user's.
- Tests/build green is a hard gate before every push.
- Don't re-explain isolation, implementation, or review — invoke the skill.
- Only blocking findings gate and trigger another round; cap at 3.

## Related

- **using-git-worktrees**, **incremental-implementation**, **code-review**,
  **subagent-driven-development**, **dispatching-parallel-agents** — the skills
  this one orchestrates.
- **to-issues** / **triage** — fill and groom the queue this draws from.
