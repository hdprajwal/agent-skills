---
name: council
description: A decision chamber for high-stakes, ambiguous calls. Five specialist advisors (contrarian, first-principles, expansionist, outsider, executor) attack the question independently; a blind second round tears every proposal apart without knowing who wrote it; a fresh chairman delivers a verdict — a decision, not a menu. Use for hard go/no-go and tradeoff calls. Heavy (~11 subagents) — reserve for decisions that earn it.
allowed-tools: Read Bash Agent Task AskUserQuestion
---

# Council — a decision chamber that returns a verdict

For a decision that is genuinely ambiguous *and* high-stakes, one opinion — yours or the chat's — isn't enough. Council runs the decision through three stages:

1. **Five advisors** each attack the question from a different lens, independently and blind to the conversation.
2. **A blind teardown** — every proposal is anonymized, shuffled, and handed to a fresh reviewer who tries to destroy it without knowing who wrote it.
3. **A chairman** — a fresh agent, also blind to the chat — reads all of it and delivers a verdict.

This is **eleven subagents in total**. It is the wrong tool for most decisions. Use it when the call is hard to reverse, the paths are credible and conflicting, and being wrong is expensive. Otherwise answer directly or use a lighter skill.

The output is a **verdict, not an answer** — one decision, the reasoning that survived attack, and what would reverse it.

## When to use

- A hard go / no-go or strategic tradeoff with no obvious winner.
- The decision is expensive to reverse (architecture, hiring, a public commitment, a rewrite).
- The conversation has been circling one answer and you suspect premature consensus.
- The user explicitly wants to be challenged, or asks for "the council."

## When NOT to use

| If you're really trying to… | Use instead |
| --- | --- |
| Break a feature into implementation steps | `writing-plans` |
| Turn a fuzzy idea into an approved spec | `brainstorming` |
| Stress-test one plan you already favor | `grill-me` |
| Design an interface or module contract | `api-design` |
| Review code for bugs, safety, or quality | `/code-review`, `rust-review` |
| Make a low-stakes or easily-reversible call | just decide |
| Answer a straight factual question | just answer |

If the decision doesn't justify ten agents, run a **reduced chamber** (see [Scaling the chamber](#scaling-the-chamber)) or skip the skill.

## Voice — keep it plain

The whole point of the chamber is that *you* can follow the reasoning and judge it yourself. So every agent writes in plain, spoken English — the way you'd explain a decision to a smart friend over coffee, not the way a consultant writes a memo. The rule, applied to advisors, reviewers, and the chairman alike:

- Short sentences. Everyday words.
- No jargon, buzzwords, or hedging. If a technical term is unavoidable, define it in a few words.
- Say the thing directly — no throat-clearing, no "it's important to note," no inflated claims.
- Make the reasoning traceable: plain cause-and-effect, so you can see *why*, not just *what*.

This instruction is baked into each prompt below, because the subagents don't share your `plain-voice` skill — the rule has to travel with the prompt. The verdict especially must read clean on the first pass.

## Stage 0 — Frame the question

Reduce the decision to one explicit prompt the advisors will all answer:

- What are we actually deciding?
- What constraints are fixed?
- What counts as success?

If it's vague, ask **one** clarifying question (AskUserQuestion) before convening. Then gather the **minimal** context the advisors need — relevant files, metrics, constraints. Keep it compact; this exact packet (question + context) is what every Stage 1 advisor receives, and nothing more.

## Stage 1 — The five advisors

Launch all five as **fresh parallel subagents** (`Agent`/`Task`; see `dispatching-parallel-agents`). Each gets the framed question and the compact context packet — **never the conversation transcript**. That blindness is the anti-anchoring mechanism: feed them the chat and you get five rewordings of the answer you already had.

| Advisor | Mandate |
| --- | --- |
| **Contrarian** | The devil's advocate. Assume the decision was made and it failed — explain how. Find the landmines and failure modes, argue against the idea even if privately persuaded. |
| **First-Principles Thinker** | Ignore the framing and the options entirely. Decompose the problem to its fundamental truths, rebuild a recommendation from zero, and don't anchor on how the question was posed — you may land somewhere completely different. |
| **Expansionist** | Zoom out. The proposer is too close to see it. Surface second-order effects, opportunity cost, and the upside *and* downside that are invisible up close — at 10× scale and in three years. |
| **Outsider** | Strip away all industry context, jargon, and insider assumptions. Approach it as someone from a different field would, bring one cross-domain analogy, and name the insider assumption most worth dropping. |
| **Executor** | Skip the philosophy. Name the single most important actionable next step, startable today. Bias hard toward momentum and the smallest reversible move that's right regardless of the final call. |

Prompt shape for each:

```text
You are the [ADVISOR] on a decision council. You are blind to any prior discussion.

Decision:
[framed question]

Context:
[the compact packet — nothing else]

Your mandate:
[the advisor's mandate from the table]

Respond with exactly:
1. Position — your recommendation in 1-2 sentences
2. Reasoning — 3 concise bullets
3. Sharpest point — the one thing your lens sees that the others will miss
4. Biggest risk in YOUR own recommendation

Be direct. No hedging. Do not reference your role by name in the body. Under 300 words.
Write in plain, spoken English: short sentences, everyday words, no jargon or buzzwords. Explain it like you would to a smart friend, not in a memo.
```

## Stage 2 — The blind teardown

Now turn the five proposals over to adversaries who don't know where they came from.

1. **Anonymize.** Strip every proposal of role labels and self-identifying language (delete any "as the executor…", lens-naming, or tells). Relabel them **Proposal A–E**.
2. **Shuffle.** Reorder so position carries no signal.
3. **Dispatch one fresh reviewer per proposal** (parallel). Each reviewer sees only its assigned anonymized proposal — no authorship, no transcript, no sibling proposals.

Why blind: a reviewer who knows "this is the Executor" defers to action bias; one who knows "this is the Outsider" discounts it as naïve. Anonymity forces judging the *argument*, not its source.

Reviewer prompt shape:

```text
You are a reviewer on a decision council. Below is one proposal. You do not know
who wrote it or what perspective produced it. Tear it apart on the merits.

Proposal [X]:
[anonymized proposal]

Respond with exactly:
1. Strongest flaw — where the reasoning is weakest
2. Hidden assumption — what it quietly takes for granted
3. Failure condition — what would have to be true for this to be wrong
4. Survival score — 1 (collapses) to 5 (holds up), one line of justification

Be ruthless and specific. Reward nothing for confidence.
Write in plain, spoken English: short sentences, everyday words, no jargon. State each flaw the way you'd point it out to a colleague, not in a review memo.
```

## Stage 3 — The chairman's verdict

The chairman is a **fresh subagent too** — blind to the conversation, so the verdict isn't colored by the chat's drift or the user's apparent leaning. You (the orchestrator) assemble the board and dispatch it; you do not write the verdict yourself.

Assemble the board: the framed question, the compact context, all five proposals **with their lenses re-attached** (you hold the mapping), and each proposal's teardown paired to it. Then dispatch one chairman:

```text
You are the chairman of a decision council. You are blind to any prior discussion —
judge only the board below.

Decision:
[framed question]

Context:
[the compact packet]

The board — five proposals, each with the lens that produced it and the blind teardown it received:
[Proposal · Contrarian]: …    [Teardown · survival score]: …
[Proposal · First-Principles]: …    [Teardown · survival score]: …
[Proposal · Expansionist]: …    [Teardown · survival score]: …
[Proposal · Outsider]: …    [Teardown · survival score]: …
[Proposal · Executor]: …    [Teardown · survival score]: …

Weigh what SURVIVED attack, not what sounded best. A proposal the teardown gutted
loses, however eloquent. A proposal with a low survival score but one irreplaceable
insight contributes that insight, not the whole. Issue a verdict, not a survey —
do not retreat to "it depends".

Write the whole verdict in plain, spoken English: short sentences, everyday words,
no jargon, buzzwords, or hedging. Someone outside the field should follow your
reasoning on the first read. Show the cause and effect — don't just assert the call,
let the reader see why it follows.

Respond in exactly this shape:

## Verdict: [decision title]
**The call:** [one decisive sentence, in plain words]
**Why:** [2-4 lines — the reasoning that held up, as plain cause-and-effect]
**What nearly killed it:** [the strongest surviving objection, in plain terms — and why it doesn't flip the call, or what guardrail it forces]
**First-principles check:** [did rebuilding from zero agree, or surface a better frame?]
**Do this now:** [the single next action, pressure-tested by the teardown]
**This reverses if:** [the specific new information that would change the verdict]
```

Relay the chairman's verdict to the user **verbatim**. Optionally precede it with a compact **Chamber notes** block — each advisor's one-line position and survival score — so the disagreement stays legible. Add your own commentary only if the user asks; the verdict is the deliverable.

## Independence rules

These are what make the chamber more than five echoes:

- **Stage 1 advisors** get only the framed question + compact context. Never the transcript.
- **Stage 2 reviewers** get a single anonymized, shuffled proposal. No authorship, no transcript, no siblings.
- **Strip self-identifying language** before Stage 2 — a proposal that announces its lens isn't blind.
- **The chairman** is itself a fresh subagent: it sees the whole board (proposals with lenses re-attached + paired teardowns) but never the conversation, so the verdict isn't colored by the chat or the user's apparent preference. The orchestrator assembles the board, dispatches the chairman, and relays the verdict verbatim.

## Scaling the chamber

The full chamber is expensive. Match the ceremony to the stakes:

- **Full (11 subagents)** — irreversible, expensive-to-be-wrong calls.
- **Reduced (3 advisors — Contrarian, First-Principles, Executor — single teardown pass)** — meaningful but recoverable decisions.
- **None** — low stakes or an obvious answer. Just decide.

If the user has opted into the Workflow tool, this pipeline maps cleanly onto it (Stage 1 parallel → anonymize → Stage 2 parallel → chairman). You cannot launch a workflow without that opt-in — default to dispatching agents directly.

## Persisting the verdict

Only when it changes something real:

- Changes active work → update the relevant `docs/` spec or the GitHub/Linear issue.
- Durable architectural choice → record it as an ADR in `docs/adr/`.
- Worth carrying forward → capture via `session-handoff`.

Don't paper-trail every council.

## Multi-round

Default to one pass. If the user wants another, keep the new question focused, include the prior verdict only if necessary, and re-run Stages 1–3 fresh — the value is in repeating the independence, not in accumulating context.

## Anti-patterns

- Running the full chamber on a decision that doesn't earn ten agents.
- Feeding advisors or reviewers the conversation transcript.
- Letting proposals reach Stage 2 with their lens still attached (breaks the blind review).
- A chairman who hedges into "it depends" instead of issuing a verdict.
- A verdict or proposal written in jargon and memo-speak the reader has to decode.
- Weighing proposals by eloquence instead of what survived the teardown.
- Convening around a vague question instead of framing it first.
- Persisting every verdict regardless of whether it changed anything.

## Related skills

- `grill-me` — relentlessly interrogate one plan you already favor (single-track, vs. the chamber's many lenses)
- `brainstorming` — when you need to generate options, not adjudicate between them
- `dispatching-parallel-agents` — the underlying mechanism for launching each stage concurrently
- `teach` (FIRST-PRINCIPLES.md) — the decomposition method the First-Principles advisor uses
