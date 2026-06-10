# brainstorming

Turn a rough idea into an **approved design** before any code is written.

The skill runs a disciplined pre-build conversation: read the project context,
ask clarifying questions one at a time, propose 2-3 approaches with trade-offs,
present the design in sections sized to their complexity, then write a short spec
to `docs/specs/` and get the user to sign off. The only thing it hands off to is
the `writing-plans` skill — never straight to code.

The point: simple-looking projects are exactly where unexamined assumptions
waste the most work. A two-sentence design still beats no design.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill brainstorming -g
```

## Credit

Adapted from the `brainstorming` skill in
[obra/superpowers](https://github.com/obra/superpowers).
