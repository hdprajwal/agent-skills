# subagent-driven-development

Execute an implementation plan by dispatching a **fresh subagent per task**, with
a two-stage review after each: spec compliance first, then code quality — looping
each review until it passes before moving on.

Fresh context per task keeps things clean; the review loops keep quality high.
The skill covers model selection per task (cheap for mechanical, capable for
judgment), how to handle each implementer status (`DONE`,
`DONE_WITH_CONCERNS`, `NEEDS_CONTEXT`, `BLOCKED`), and ships three prompt
templates:

- `implementer-prompt.md`
- `spec-reviewer-prompt.md`
- `code-quality-reviewer-prompt.md`

Use it when a plan's tasks are mostly independent and you want to stay in the
current session. For coupled tasks, use `executing-plans` instead.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill subagent-driven-development -g
```

## Credit

Adapted from the `subagent-driven-development` skill in
[obra/superpowers](https://github.com/obra/superpowers).
