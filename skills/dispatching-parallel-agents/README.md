# dispatching-parallel-agents

Dispatch **one focused agent per independent problem** and let them work
concurrently — for several unrelated test failures, multiple broken subsystems,
or parallel investigations with no shared state.

Each agent gets a self-contained brief: scope, goal, constraints (what NOT to
touch), and the output to return. You dispatch them in one turn (multiple `Agent`
calls, or a `Workflow` for clean result collection), then review for conflicts,
run the full suite, and integrate.

Don't use it when failures are related, when you need full system context, or
when agents would touch the same files — there they'd interfere. For executing a
plan's coupled tasks one at a time, use `subagent-driven-development` instead.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill dispatching-parallel-agents -g
```

## Credit

Adapted from the `dispatching-parallel-agents` skill in
[obra/superpowers](https://github.com/obra/superpowers).
