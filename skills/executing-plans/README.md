# executing-plans

Execute a written implementation plan **inline, in the current session**, with
review checkpoints.

Load the plan, review it critically (raise concerns before starting), then run
each task exactly — following its bite-sized steps and running its verifications.
Stop and ask when blocked instead of guessing. Never start on `main`/`master`
without consent.

This is the single-session alternative to `subagent-driven-development`. Reach
for it when tasks are coupled enough that splitting them across subagents would
hurt, or when you just want to stay in one context.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill executing-plans -g
```

## Credit

Adapted from the `executing-plans` skill in
[obra/superpowers](https://github.com/obra/superpowers).
