---
name: writing-flow
description: |
  A 3-step writing flow inspired by Matt Pocock. Each step is its own slash
  command and is "extremely demanding for the user" — you get grilled three
  different ways. Use whenever the user wants to write something where voice
  and structure matter more than speed: essays, blog posts, newsletters,
  opinion pieces, talks, long-form documentation, marketing copy that needs
  to sound human, even fiction.

  Commands:
  - /fragments — mine voice-true fragments from the user (in their words)
  - /walk      — walk a path through fragments beat-by-beat
  - /polish    — final pass: contradictions, repetition, structure, links
allowed-tools: Read Write Edit AskUserQuestion
---

# Writing-flow — a 3-step writing process

A workflow for AI-assisted writing that mimics how serious writers actually work: lots of disconnected raw material, then deliberate assembly, then ruthless editing. Novelists do it with diaries; essayists do it with notebook scraps; technical writers do it with bulleted brain-dumps. The shape is the same.

## Why this exists

The smart zone for AI-assisted **coding** is roughly 100K tokens. The smart zone for AI-assisted **writing** is much smaller — quality starts dropping around 50K tokens. Models start making dumb voice and structural choices long before they run out of context.

The fix is not a longer context window. The fix is splitting the work into three short, fresh-context passes — each one demanding enough on the user that the output stays in their voice instead of regressing to AI mush.

## The three steps

| # | Command | What it does | Output |
|---|---------|--------------|--------|
| 1 | `/fragments` | Grills the user until they produce voice-true fragments **in their own words**. AI never writes the fragment. | `fragments.md` |
| 2 | `/walk` | Walks a path through `fragments.md` beat-by-beat. Marks invented sentences with `[+]`. Grills the user before locking each beat. | `draft.md` |
| 3 | `/polish` | Runs four ordered passes (contradictions, repetition, structure, links) and grills on every issue. Subtractive only — never adds content. | `final.md` |

**Hard rule between steps:** clear context. Each command refuses to start unless the conversation is in a fresh window. Editorial judgment rots fast as context fills.

## When to invoke this skill

Trigger when the user wants to write something and voice or structure matters. Strong signals:

- "Help me write [an essay / a post / a piece / a talk / a chapter]."
- "Let's start something" or "I want to draft X."
- "Get me grilled on this" or "fragments → walk → polish."
- The piece is more than a few paragraphs and the user cares how it sounds.

Skip for:

- One-off replies, comments, or short blurbs where speed beats voice.
- Pure reference docs (API references, config schemas) where there is no voice to preserve.
- Editing already-finished prose — use [`humanize`](../humanize) for cleanup.

If you're not sure, ask one question: "Is voice or structure the thing that matters here?" If yes, this skill. If no, just write directly.

## How to start

Route based on what already exists in the working directory:

- No fragments yet → `/fragments`.
- `fragments.md` exists, fresh context window → `/walk`.
- `draft.md` exists, fresh context window → `/polish`.

If the user is somewhere in the middle and unsure, ask: "Do you have raw fragments yet, a draft, or nothing?" — and route from there.

## What this skill will not do

- Will not run all three steps in one session. The context-clear is load-bearing.
- Will not write fragments on the user's behalf. The user's voice is the spec.
- Will not invent citations, links, or sources during polish.
- Will not promise this is faster than writing without AI. It probably isn't. The promise is higher quality and less frustration.
