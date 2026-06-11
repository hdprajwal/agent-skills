# MISSION.md Format

`MISSION.md` lives at the workspace root. It captures the *reason* the user is learning this topic. Every teaching decision — what to teach next, which resources to surface, which exercises to design — traces back to this document.

## Template

```md
# Mission: {Topic}

## Why
{1-3 sentences. The concrete real-world goal the user is chasing. What changes in their life or work when they have this skill? Avoid abstract framings like "to understand X" — push for the underlying outcome.}

## Success looks like
- {A specific, observable thing the user will be able to do}
- {Another specific thing}
- {…}

## Constraints
- {Time, budget, prior commitments, learning preferences — anything that bounds the approach}

## Out of scope
- {Adjacent topics the user explicitly does not want to chase right now — this protects the zone of proximal development}
```

## Rules

- **One mission per workspace.** A workspace is one topic folder (e.g. `.teach/rag/`), not a repo — two unrelated things to learn means two topic folders, which can sit side by side in the same project.
- **Concrete over abstract.** "Run a half marathon by October" beats "get fitter." "Ship a Rust CLI to my team" beats "learn Rust."
- **Push back on vagueness.** If the user can't articulate why, interview them before writing anything. A bad mission is worse than no mission.
- **Revise when reality shifts.** Missions change. When the goal moves, update this file — don't leave a stale mission steering future sessions — and write a learning record noting the change.
- **Keep it short.** If `MISSION.md` runs past a screen, it has stopped being a compass and started being a plan.
