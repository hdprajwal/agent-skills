# incremental-implementation

Build in **thin vertical slices**. Implement one piece, test it, verify it,
commit, then expand. Never implement a whole feature in one pass — each increment
leaves the system working and committed.

Covers the slice strategies (vertical, contract-first, risk-first), a set of
execution rules (simplicity first, scope discipline, one thing at a time, keep it
compilable, feature-flag incomplete work, rollback-friendly commits), and a
per-increment checklist. The discipline that makes large features manageable and
keeps "which of these 500 lines broke it?" from ever happening.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill incremental-implementation -g
```

## Credit

Adapted from the `incremental-implementation` skill in
[addyosmani/agent-skills](https://github.com/addyosmani/agent-skills).
