# session-handoff

Write or restore a handoff note when pausing or switching projects.

Captures a short, current snapshot — goal, what's done/in-progress, branch + last commit, the single concrete next step, pending decisions, key files/commands, and gotchas — to `docs/HANDOFF.md`, built from real git state. On restore, it verifies the note against the repo (the repo wins) before resuming. A snapshot for resuming, not a changelog or a plan.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill session-handoff -g
```

## Requires

git.
