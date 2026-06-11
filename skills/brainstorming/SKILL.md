---
name: brainstorming
description: Turn an idea into an approved spec before any code. Use before any creative work — new features, components, behavior changes. Reads context, asks one question at a time, proposes 2-3 approaches, writes a short spec to docs/<topic>-spec.md, and gets sign-off. Hands off to writing-plans. Never writes code before the spec is approved.
allowed-tools: Read Write Edit Bash AskUserQuestion
---

# Brainstorming

Turn a rough idea into a spec you've actually agreed to. Read the context, ask
questions one at a time, propose a few approaches, write a short spec, get
sign-off. No code until then.

## Hard gate

No code, no scaffolding, no implementation skill until you've presented a design
and the user approved it. Holds for every project, however simple it looks —
simple projects are where wrong assumptions waste the most work. A two-sentence
design is fine; you still present it and still get approval.

## The steps

Track these as a task list, in order:

1. **Read the context** — relevant files, docs, recent commits.
2. **Check scope.** If the request is really several independent systems, say so
   now and help split it into sub-projects. Each gets its own spec → plan →
   build cycle. Don't refine details of something that needs splitting first.
3. **Ask one question at a time** — purpose, constraints, success criteria.
   Multiple choice when you can. One question per message.
4. **Propose 2-3 approaches** with trade-offs. Lead with your pick and why.
5. **Present the design** in short sections (a sentence for obvious parts, a
   paragraph for nuanced ones). Cover architecture, components, data flow, error
   handling, testing. Ask after each section. Revise until approved.
6. **Write the spec** to `docs/<topic>-spec.md` and commit it.
7. **Self-review** the spec (below), fix inline.
8. **Ask the user to review the file** before moving on.
9. **Hand off** to writing-plans — and only that.

The terminal state is writing-plans. Don't jump to a frontend or scaffolding
skill from here.

## Consult, don't assume

When you hit a fork the spec doesn't settle, ask — don't pick silently and build
on it. If the user is feeding you changes, take them one at a time and confirm
each. Surfacing a doubt now is cheaper than unwinding the wrong build later.

## Designing for clarity

- Small units, each with one job, talking through clear interfaces, each
  testable on its own. For each: what it does, how you use it, what it depends
  on.
- Can someone tell what a unit does without reading its internals? Can you change
  the internals without breaking callers? If not, fix the boundaries.
- Focused files are easier for an agent to edit reliably. A file growing large
  usually means it's doing too much.

## Existing codebases

Explore the structure and follow its patterns first. If code in your path has a
real problem (a file grown too large, tangled responsibilities), fold a targeted
fix into the design. Don't propose unrelated refactoring.

## Spec self-review

Read it with fresh eyes: any placeholders (TBD/TODO)? sections contradicting
each other? focused enough for one plan? any requirement readable two ways (pick
one, make it explicit)? Fix inline and move on.

## User review gate

`Spec written to docs/<topic>-spec.md. Have a look and tell me what to change
before I turn it into a plan.`

Wait. If they want changes, make them and re-review. Only proceed on approval.

## Principles

- One question at a time. Multiple choice when possible.
- YAGNI — cut what the project doesn't need.
- Always explore 2-3 approaches before settling.
- Validate per section, not one big reveal.
- Keep it short and plain.
