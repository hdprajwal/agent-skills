# writing-plans

Write an implementation plan so detailed an engineer with **zero context** could
execute it: exact file paths, the actual code, exact commands with expected
output, TDD steps, and frequent commits.

The skill maps the file structure first (where decomposition gets locked in),
breaks the work into 2-5 minute steps, bans placeholders ("TODO", "add error
handling", "similar to Task N"), self-reviews the plan against the spec, then
offers two ways to execute it — `subagent-driven-development` or
`executing-plans`.

Plans are saved to `docs/plans/YYYY-MM-DD-<feature>.md`.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill writing-plans -g
```

## Credit

Adapted from the `writing-plans` skill in
[obra/superpowers](https://github.com/obra/superpowers).
