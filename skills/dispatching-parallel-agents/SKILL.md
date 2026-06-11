---
name: dispatching-parallel-agents
description: Dispatch one focused agent per independent problem and run them concurrently. Use when facing 2+ tasks with no shared state and no sequential dependency — several unrelated test failures, multiple broken subsystems, a batch of independent issues. Each agent gets a self-contained brief and returns a summary; you review for conflicts and integrate.
allowed-tools: Read Bash Agent Task
---

# Dispatching Parallel Agents

You delegate work to agents with isolated context. Craft each brief precisely so
they stay focused, and keep your own context for coordination — they never
inherit your session history.

When you have several unrelated problems (different test files, different
subsystems, different issues), one-at-a-time wastes time. Each is independent and
can run in parallel.

**Core principle:** one agent per independent problem domain, working at once.

## When to use

- 3+ test files failing with different root causes.
- Multiple subsystems broken independently.
- A batch of independent issues to fix.
- Each problem stands alone, no shared state.

**Don't** when failures are related (fixing one may fix others — investigate
together), you need full system context, you don't yet know what's broken, or
agents would touch the same files (they'd conflict).

## The pattern

**1. Identify independent domains** — group by what's broken:

```
File A → tool approval flow   File B → batch completion   File C → abort
```

**2. One focused brief per agent** — each gets: **scope** (one file/subsystem),
**goal**, **constraints** (what NOT to touch), **output** (what to return).

**3. Dispatch in parallel** — issue all the agent calls in one message so they
run concurrently. Multiple `Agent` calls in a turn, or a `Workflow`
(`parallel(...)`) when you want clean result collection and a barrier.

**4. Review and integrate** — read each summary, check for conflicts (same code
edited twice?), run the full suite (`pnpm test` / `cargo test`), spot-check —
agents can make systematic errors.

## A good brief

Focused, self-contained, specific about output:

```
Fix the 3 failing tests in src/agents/agent-tool-abort.test.ts:
1. "aborts tool with partial output" — expects 'interrupted at' in the message
2. "handles mixed completed/aborted tools" — fast tool aborted, not completed
3. "tracks pendingToolCount" — expects 3 results, gets 0

Looks like timing/race issues. Read the file, find the real root cause, fix by
replacing arbitrary timeouts with event-based waiting (don't just bump timeouts).
Don't change production code outside the abort path.
Return: root cause + what you changed.
```

## Common mistakes

| ❌ | ✅ |
|---|---|
| "Fix all the tests" | "Fix agent-tool-abort.test.ts" |
| "Fix the race condition" — where? | Paste the errors + test names |
| No constraints → refactors everything | "Don't touch production code" |
| "Fix it" — you don't know what changed | "Return root cause + changes" |

## Note on your usual loop

For a batch of GitHub issues, parallel dispatch works when the issues are truly
independent — one agent per issue, each on its own branch, then PR each. If two
issues touch the same files, do them sequentially (subagent-driven-development)
to avoid merge conflicts.

## After they return

Read each summary · check for conflicts · run the full suite · spot-check.

## Related

- **subagent-driven-development** — sequential, one-agent-per-task, for tasks
  that share a codebase.
