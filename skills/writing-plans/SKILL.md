---
name: writing-plans
description: >-
  Turn an approved spec into a bite-sized implementation plan an engineer with
  zero context could execute — exact files, exact code, exact commands,
  Red-Green TDD steps, frequent commits. Use when you have a spec for a
  multi-step task. Saves to docs/<feature>-plan.md and hands off to
  executing-plans or subagent-driven-development.
allowed-tools: Read Write Edit Bash
---

# Writing Plans

Write the plan as if whoever executes it has zero context for this codebase.
Spell out everything: which files, the actual code, how to test it. Hand them
the whole job as small steps. DRY, YAGNI, Red-Green TDD, frequent commits.

**Say at the start:** "Using the writing-plans skill to create the plan."

**Save to:** `docs/<feature>-plan.md` (user preference overrides this).

If you're working in an isolated worktree, it should already exist (via the
using-git-worktrees skill). Otherwise the plan runs on a feature branch.

## Scope check

If the spec covers several independent subsystems, it should have been split
during brainstorming. If not, say so and write one plan per subsystem. Each plan
produces working, testable software on its own.

## Map the files first

Before writing tasks, list which files get created or modified and what each is
responsible for — this locks in the decomposition. One responsibility per file;
files that change together live together; prefer small focused files. In an
existing codebase, follow its patterns; only split a file you're already
modifying if it's grown unwieldy.

## Task granularity

Each step is one action, ~2-5 minutes:

- Write the failing test → run it, confirm it fails → write the minimal code →
  run it, confirm it passes → commit.

## Plan header

```markdown
# [Feature] Implementation Plan

> **For agents:** Use subagent-driven-development (recommended) or
> executing-plans to run this task-by-task. Steps use `- [ ]` checkboxes.

**Goal:** [one sentence]
**Architecture:** [2-3 sentences]
**Stack:** [key libraries/tools]

---
```

## Task structure

Use the project's real tooling — `pnpm` for web/TS, `cargo` for Rust, `go test`
for Go.

````markdown
### Task N: [Component]

**Files:**
- Create: `exact/path/file.ts`
- Modify: `exact/path/existing.ts:123-145`
- Test: `exact/path/file.test.ts`

- [ ] **Step 1 — failing test**

```ts
test('specific behavior', () => {
  expect(fn(input)).toEqual(expected)
})
```

- [ ] **Step 2 — run it, confirm it fails**

Run: `pnpm test file.test.ts`  →  FAIL: "fn is not defined"

- [ ] **Step 3 — minimal implementation**

```ts
export function fn(input) { return expected }
```

- [ ] **Step 4 — run it, confirm it passes**

Run: `pnpm test file.test.ts`  →  PASS

- [ ] **Step 5 — commit**

```bash
git add file.ts file.test.ts && git commit -m "feat: add specific feature"
```
````

(For Rust: `cargo test name`; for Go: `go test ./...`.)

## No placeholders

These are plan failures — never write them:

- "TBD", "TODO", "implement later", "fill in details"
- "Add error handling / validation / edge cases" (show it)
- "Write tests for the above" without the test code
- "Similar to Task N" — repeat the code; tasks get read out of order
- Steps that say what to do without showing how
- Types/functions referenced but defined in no task

## Self-review

Check the plan against the spec with fresh eyes:

1. **Coverage** — point to a task for each spec requirement. Add tasks for gaps.
2. **Placeholders** — search for the red flags above. Fix them.
3. **Type consistency** — do names/signatures in later tasks match earlier ones?
   `clearLayers()` in Task 3 and `clearFullLayers()` in Task 7 is a bug.

Fix inline.

## Execution hand-off

`Plan saved to docs/<feature>-plan.md. Two ways to run it:`

`1. Subagent-driven (recommended) — fresh subagent per task, reviewed between
tasks. Uses subagent-driven-development.`

`2. Inline — run tasks in this session with checkpoints. Uses executing-plans.`

`Either way it finishes on a branch → PR → merge. Which one?`
