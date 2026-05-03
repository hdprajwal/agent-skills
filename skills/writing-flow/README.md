# writing-flow

A 3-step writing flow inspired by [Matt Pocock's](https://x.com/mattpocockuk) observation that good AI-assisted writing mimics how serious writers actually work: lots of disconnected raw material, then deliberate assembly, then ruthless editing.

Works for essays, blog posts, newsletters, opinion pieces, talks, long-form documentation, marketing copy that needs to sound human, and fiction. Anything where voice and structure matter.

One skill. Three slash commands. You get grilled three different ways.

## The flow

| # | Command | What it does | Output |
|---|---------|--------------|--------|
| 1 | `/fragments` | Grills the user until they produce voice-true fragments **in their own words**. AI never writes the fragment. | `fragments.md` |
| 2 | `/walk` | Walks a path through `fragments.md` beat-by-beat. Marks invented sentences with `[+]`. Grills the user before locking each beat. | `draft.md` |
| 3 | `/polish` | Runs four ordered passes (contradictions, repetition, structure, links) and grills on every issue. Subtractive only — never adds content. | `final.md` |

**Clear context between every step.** The smart zone for AI-assisted writing tops out around 50K tokens — long before it tops out for code. Each command refuses to start in a stale window.

## Why three commands and not one

Each step needs full attention from the model. Running them in one session means:

- The voice-mining session pollutes the assembly session with assumptions.
- The assembly session pollutes the polish session — by the time you're polishing you've spent attention on every line and can't see the structure.
- Quality drops well before context fills up.

The forced context clear is load-bearing, not optional.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill writing-flow -g
```

## Usage

Start a piece:

```
/fragments

I want to write something about the time I almost quit my job.
```

After the fragments session, **clear context**, then:

```
/walk
```

After the draft is locked, **clear context**, then:

```
/polish
```

Or invoke the skill naturally and let it route you:

```
help me write a piece using the 3-step flow
```

## Rules each command enforces

**`/fragments`**
- One question at a time. AI never writes the fragment — the user does.
- No combining, no editing, no "improving" fragments.
- No encouragement. Just grilling.
- Stops at ~10–20 fragments.

**`/walk`**
- Refuses to start without `fragments.md` and a fresh context window.
- One beat at a time. The next beat doesn't start until the current one is locked.
- Every invented sentence is marked `[+]`.
- Banned AI vocabulary in connective tissue (delve, landscape, tapestry, etc.).
- No generic closing beats.

**`/polish`**
- Refuses to start without `draft.md` and a fresh context window.
- Four ordered passes, no interleaving.
- Subtractive and structural, not generative.
- Never invents links, sources, or citations.
- Ends with a receipt of changes — no editorializing.

## File layout

```
writing-flow/
├── SKILL.md              # Routing logic and overall flow
├── commands/
│   ├── fragments.md      # /fragments
│   ├── walk.md           # /walk
│   └── polish.md         # /polish
└── README.md
```

## What it isn't

- **Not faster than writing without AI.** It probably isn't. The promise is higher quality and less frustration.
- **Not for short replies or pure reference docs.** Use direct prompting for those, or [`humanize`](../humanize) to clean up finished prose.
- **Not a one-shot.** If you skip the context clears, the model will make dumb voice and structural choices and the whole flow falls apart.

## Credits

Based on a 3-step writing flow described by [Matt Pocock](https://x.com/mattpocockuk). Uses the grilling pattern from the `grill-me` skill.

## License

MIT
