---
name: unslop
description: |
  Make any writing sound plain, human, and simple. Use to edit, rewrite, or
  polish text so it reads like a real person wrote it in one sitting — emails,
  posts, messages, outreach, docs, essays, drafts. Strips AI tells and clever
  filler, then rewrites in plain spoken English: short sentences, everyday
  words, honest claims, no swagger. Triggers: "humanize this", "make this sound
  human", "simplify this", "rewrite this plainer", "remove AI", "polish this",
  "make it less like a chatbot".
allowed-tools: Read Write Edit Grep Glob AskUserQuestion
---

# Unslop: make writing plain and human

Take any draft and make it read the way a real person talks: plain, simple, direct. The reader should feel like one person wrote it in one sitting, not like it was workshopped or generated. When in doubt, make it simpler.

This skill does two things in one pass: it removes the signs of AI-generated text, and it rewrites toward a plain spoken voice. Removing AI tells is only half the job — clean but lifeless writing is just as obviously machine-made as slop. The target is plain *and* alive.

## The north star

Read every line back as if you were saying it out loud to a smart, busy person. If you would not say it in a normal conversation, cut it or rewrite it. That single test catches most of what this skill is for.

## The voice (what to aim for)

1. **Plain, spoken English.** Short sentences. Everyday words. Say the plain thing.

2. **No clever or writerly phrasing.** Kill metaphors, turns of phrase, "positioning" lines, and anything that reads like it was written to be quotable. Say the plain thing instead. ("My recent work sits right where you operate" → "I've been working on the same problems you have.")

3. **No jargon, aphorisms, or filler.** Drop corporate words and clever generalizations. Cut throat-clearing ("I would genuinely like to be in that conversation" → "I'd really like to talk").

4. **Confidence comes from facts, not swagger.** State what's true plainly and let it stand. Don't command the reader, don't claim you're better than others, don't perform. "I'm confident I can contribute" is fine. "Give me 15 minutes and I'll show you exactly where I'd plug in" is not. Put a real fact next to any confident line so it's earned.

5. **Never inflate or invent.** Claim only what's literally true. Numbers must be honest and sourced. If you're unsure a claim is accurate, keep it general or flag it for the author — never fabricate sources, anecdotes, quotes, or stats to sound more human.

6. **Explain technical things plainly.** Name the tool, then say what it does in one simple clause. Replace insider terms with what they actually do ("correctness matrix" → "a clear report of what passed and what failed").

## Soul, the plain way

A plain voice is not a flat voice. Sterile, voiceless writing reads as machine-made even when it's technically clean: every sentence the same length, no opinion, no first person, no acknowledgment that anything is hard or uncertain. Reads like a press release.

Add life, but the plain way:

- **Have a point of view, stated calmly.** React to facts, don't just list them. "I keep coming back to..." beats neutral reporting.
- **Vary the rhythm.** Short punchy sentences. Then a longer one that takes its time. Mix it.
- **Use "I" when it fits.** First person is honest, not unprofessional.
- **Acknowledge what's hard or mixed.** Real people have mixed feelings and say so.
- **Be specific about the real thing** instead of reaching for an abstraction.

What "soul" does **not** mean here: edge, controversy, cleverness, hot takes, or performance. Those are their own AI tell and they break the plain voice. The personality comes from honesty and specificity, not from sounding bold. When restraint and "edge" conflict, restraint wins.

## Hard formatting constraints

- **No em dashes or en dashes** (— or –) anywhere. Use commas, periods, or "and"/"but". Hyphens inside compound words (multi-cloud, fast-moving) are fine.
- **No emojis.**
- **No Markdown blockquotes** for anything the user will copy-paste (emails, messages, posts, snippets). Deliver copy-paste content in a plain fenced code block (```text) or plain paragraphs. Blockquotes are only for quoting the user's own prior text back to them.
- **No decorative bold/italic.** No mechanical `**emphasis**` on terms, no inline-header lists.

## Do not touch

Preserve these exactly as-is:

- **Direct quotes** — attributed speech or quotations from real people
- **Code** — inline code, fenced blocks, API references, version numbers, config values
- **Legal language** — terms, disclaimers, compliance text
- **Proper nouns and titles** — names, products, organizations
- **Data and statistics** — numbers, dates, measurements (unless the framing around them is the AI-sounding part)

**Never fabricate.** If the original lacks specifics, keep it general or flag it for the author. Do not invent detail to make text sound more human.

## The process (one pass, then decide)

### Step 1 — Intake
Read the whole draft. Note its purpose and audience. If voice samples or context were provided, pull the patterns from them. Otherwise aim for the plain voice above.

### Step 2 — Single-pass scan
Scan the draft once against the detection catalog in [PATTERNS.md](PATTERNS.md). Flag every tell in one sweep. Do not stop and rewrite between checks — find everything first, then rewrite. Use the quick table below for the fast scan and PATTERNS.md for the detailed before/after of any pattern you're unsure about.

### Step 3 — Decide

**If the draft is already plain and clean:** say so and change nothing. "This reads plainly and clean. Nothing to fix." Do not manufacture edits to justify running the skill. A no-op is a valid, encouraged outcome.

**If there are issues:** don't just list them — rewrite. Resolve every flagged tell and rewrite toward the plain voice. You have full authority to restructure, reorder, cut, and rewrite transitions when it makes the writing plainer and stronger. Preserve the core message and any real facts; everything else is fair game.

When issues compound, fix in this order:
1. Fabrication, inflation, and inaccuracy (non-negotiable — accuracy first)
2. Clever phrasing, swagger, and AI tells (the core voice fixes)
3. Filler and restated points (cuts that tighten)
4. Flow and structure (rewrites that read better aloud)
5. Formatting (em dashes, bold, emoji, blockquotes, lists → prose)

### Step 4 — Anti-AI audit
After the draft rewrite, ask: "What still makes this read as AI-generated or workshopped?" Answer briefly with any remaining tells, then do one more pass to fix them. This catches the rhythm and phrasing that the pattern scan misses.

## Quick-reference catalog

Full before/after for each is in [PATTERNS.md](PATTERNS.md).

| # | Pattern | Severity | Trigger |
|---|---------|----------|---------|
| 1 | Significance inflation | HIGH | testament, pivotal, evolving landscape, vital role |
| 2 | Notability emphasis | MED | active social media presence, leading expert |
| 3 | Superficial -ing phrases | HIGH | highlighting, showcasing, reflecting, ensuring |
| 4 | Promotional language | HIGH | nestled, vibrant, breathtaking, groundbreaking |
| 5 | Vague attributions | HIGH | experts argue, industry reports, observers |
| 6 | Challenges and prospects | MED | despite challenges, future outlook |
| 7 | AI vocabulary | HIGH | delve, landscape, tapestry, leverage, nuanced |
| 8 | Copula avoidance | MED | serves as, stands as, boasts, features |
| 9 | Negative parallelisms | MED | not just X, it's Y; not only...but |
| 10 | Rule of three | MED | three-item lists forced for rhetoric |
| 11 | Synonym cycling | LOW | protagonist/main character/central figure/hero |
| 12 | False ranges | LOW | from X to Y (non-meaningful scale) |
| 13 | Em dash overuse | MED | excessive — or em dash usage |
| 14 | Boldface overuse | LOW | mechanical **emphasis** on terms |
| 15 | Inline-header lists | MED | **Header:** description pattern |
| 16 | Title case headings | LOW | Every Word Capitalized |
| 17 | Emojis | LOW | decorative emoji in headers/bullets |
| 18 | Curly quotes (some models) | LOW | curly quotes instead of straight |
| 19 | Hyphenated word-pair overuse | LOW | cross-functional, data-driven uniformity |
| 20 | Persuasive tropes / signposting | MED | the real question is, let's dive in |
| 21 | Single quotes in prose | LOW | 'single quotes' instead of "double" |
| 22 | Collaborative artifacts | HIGH | I hope this helps, let me know, certainly! |
| 23 | Knowledge-cutoff disclaimers | MED | as of [date], based on available information |
| 24 | Sycophantic tone | HIGH | great question!, you're absolutely right! |
| 25 | Post-action summaries | HIGH | trailing summary of what was just said |
| 26 | Unsolicited ethical caveats | MED | it's worth noting the ethical implications |
| 27 | Second-person lock | MED | persistent "you" address in prose |
| 28 | Markdown overuse in prose | MED | unneeded headers, bullets, bold in flowing text |
| 29 | Filler phrases | MED | in order to, due to the fact that |
| 30 | Excessive hedging | MED | could potentially possibly, might have some |
| 31 | Generic positive conclusions | MED | future looks bright, exciting times ahead |
| 32 | Clever/writerly phrasing | HIGH | quotable "positioning" lines, metaphors for effect |
| 33 | Swagger and commands | HIGH | give me 15 minutes, I'd back myself, trust me |
| 34 | Fake first-person authority | MED | I've seen this play out, I see this constantly |
| 35 | Clever comparative endings | MED | the worst X do Y, the best X do Z |
| 36 | Anaphora / stacked openings | MED | repeated identical sentence openings |
| 37 | Rhetorical-question fragments | MED | The reality? Why does this matter? |
| 38 | "Most"-openers | LOW | sentences starting with "Most people..." |

## Output format

1. **Draft rewrite** — in a fenced code block so it's clean to copy.
2. **What still reads as AI or workshopped?** — brief bullets (or "nothing").
3. **Final rewrite** — the version after the audit pass (skip if the draft needed no further fixes).
4. **Changes made** — a short list of the swaps, especially anything simplified or any claim softened for accuracy. If you had to choose between two honest phrasings and one is slightly stronger, offer the calmer alternative and let the author pick.

If the draft was already clean, skip all of this and just say so.

## Origin

This skill merges three earlier ones: the plain-voice writing rules (the voice target), the humanize de-AI catalog (the detection patterns, based on [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)), and a one-pass quality-gate process (intake → single scan → clean-exit decision → prioritized rewrite). The voice is the north star; the catalog and process serve it.
