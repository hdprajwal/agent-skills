# council

Convene a decision chamber for a high-stakes, ambiguous call — and get back a verdict, not a menu of options.

It runs the decision through three stages. **Five advisors**, each blind to the conversation, attack the framed question from a different lens: the **contrarian** (what blows up in your face), the **first-principles thinker** (decompose to bedrock, rebuild from zero), the **expansionist** (the upside/downside you're too close to see), the **outsider** (strip the industry context and look from outside), and the **executor** (the one actionable next step). The five proposals are then anonymized, shuffled, and put through a **blind teardown** — one reviewer tries to destroy each without knowing who wrote it. Finally a **fresh, conversation-blind chairman** weighs what survived the attack and issues the verdict.

Eleven subagents in total, so it's reserved for decisions that earn it — there's a reduced-chamber mode for lighter calls. Not for code review, planning, or factual questions.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill council -g
```

## Requires

An agent that can dispatch subagents (the `Agent`/`Task` tool). Otherwise guidance only.
