---
name: incremental-implementation
description: Build in thin vertical slices — implement one piece, test it, prove it runs, commit, then expand. Use for any change touching more than one file, when you're about to write a lot of code at once, or when a task feels too big for one step. Each increment leaves the system working and committed.
allowed-tools: Read Write Edit Bash
---

# Incremental Implementation

Build in thin vertical slices. Implement one piece, test it, prove it runs,
commit, then expand. Never build a whole feature in one pass — each increment
leaves the system working and committed. This is what makes large features
manageable.

## When to use

Any multi-file change, building a feature from a task breakdown, refactoring, or
any time you're about to write more than ~100 lines before testing. Skip it for
single-file, single-function changes.

## The cycle

For each slice: **implement** the smallest complete piece → **test** (run the
suite, or write a test) → **verify** it actually runs → **commit** one logical
change → **next slice**, carry forward.

## Slicing

**Vertical (preferred)** — one complete path through the stack per slice:

```
Slice 1: Create  (DB + API + basic UI) → user can create
Slice 2: List    (query + API + UI)    → user can see them
Slice 3: Edit    → user can modify
Slice 4: Delete  → full CRUD
```

**Contract-first** — when backend and frontend move in parallel: define the
types/interfaces first, build each side against the contract, then integrate.

**Risk-first** — prove the riskiest piece first (e.g. the WebSocket connection)
before investing in what's built on top. If it fails, you find out cheaply.

## Rules

**0 — Simplest thing first.** Before coding: what's the simplest thing that
works? After: fewer lines? are these abstractions earning their keep? building
for hypothetical future needs or the current task?

```
✗ Generic EventBus + middleware for one notification → ✓ a function call
✗ Abstract factory for two similar components         → ✓ two components
✗ Config-driven form builder for three forms          → ✓ three forms
```

Three similar lines beat a premature abstraction. Write the naive,
obviously-correct version first; optimize only after correctness is proven.

**0.5 — Scope discipline.** Touch only what the task needs. Don't clean up
adjacent code, refactor imports in files you're not changing, or modernize
syntax in files you're only reading. Spotted something? Note it, don't fix it:

```
NOTICED, NOT TOUCHING:
- src/utils/format.ts has an unused import (unrelated)
→ Want me to file these?
```

**1 — One thing per increment.** Don't mix a new component, a refactor, and a
build-config change in one commit.

**2 — Keep it compilable.** After each increment the project builds and existing
tests pass. Never leave it broken between slices.

**3 — Flag incomplete work.** Gate not-yet-ready features behind a flag so you
can land small pieces without exposing them.

**4 — Safe defaults.** New behavior defaults to conservative/opt-in.

**5 — Rollback-friendly.** Each increment is independently revertable. Don't
delete-and-replace in one commit; migrations get rollback migrations.

## Prove each slice runs

Tests green ≠ working. For the slices that matter, actually run it — start the
app, hit the endpoint, run the CLI; for UI, drive it with agent-browser. The
recurring failure mode is claiming "done" on something that compiles but doesn't
actually work end-to-end.

## Increment checklist

After each increment:

- [ ] One thing, done completely
- [ ] Existing tests pass (`pnpm test` / `cargo test` / `go test ./...`)
- [ ] Build succeeds; types and lint pass
- [ ] The new behavior actually runs
- [ ] Committed with a descriptive message

Run each check after a change that could affect it. After a green run, don't
re-run on unchanged code — it adds nothing.

## Common rationalizations

| Rationalization | Reality |
|---|---|
| "I'll test it all at the end" | Bugs compound. A bug in Slice 1 makes 2-5 wrong. |
| "Faster all at once" | Until something breaks and you can't find which of 500 lines did it. |
| "Too small to commit separately" | Small commits are free; large ones hide bugs. |
| "I'll add the flag later" | If it's incomplete, it shouldn't be user-visible. Flag it now. |
| "This refactor is small enough to include" | Mixed refactor + feature is harder to review and debug. Split them. |

## Red flags

100+ lines without running tests · multiple unrelated changes in one increment ·
"let me just quickly add this too" · skipping verify to go faster · broken build
between increments · abstractions before the third use case · touching files
outside scope "while I'm here".
