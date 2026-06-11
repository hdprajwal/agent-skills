# Learning Record Format

Learning records live in `learning-records/` and use sequential numbering: `0001-slug.md`, `0002-slug.md`, and so on. Create the directory lazily — only when the first record is written.

They are the teaching equivalent of ADRs: they capture non-obvious lessons, key insights, and stated prior knowledge that steer future sessions. They are how you calculate the zone of proximal development across sessions.

## Template

```md
# {Short title of what was learned or established}

{1-3 sentences: what was learned (or what prior knowledge was established), and why it matters for future sessions.}
```

That's the whole format. A learning record can be a single paragraph. The value is recording *that* this is now known and *why* it changes what to teach next — not in filling out sections.

## Optional sections

Include these only when they add genuine value. Most records won't need them.

- **Status** frontmatter (`active | superseded by 0007`) — useful when an earlier understanding turns out wrong and is replaced.
- **Evidence** — how the user demonstrated understanding (a question answered, an exercise completed, prior experience cited). Useful when the claim might be revisited.
- **Implications** — what this unlocks or rules out for future sessions, when non-obvious.

## When to write one

Write a record when any of these is true:

1. **The user demonstrated genuine understanding of something non-trivial** — not just exposure, but evidence they can use the concept correctly. This sets a new floor for what to teach next.
2. **The user disclosed prior knowledge** — "I already know X." Record it (and the depth claimed) so future sessions don't re-teach it.
3. **A misconception was corrected** — they believed something wrong and now see why. High value: misconceptions predict future stumbling blocks on related topics.
4. **The mission shifted in response to learning** — the user found they care about something different. Update `MISSION.md` and cross-link.

### What does *not* qualify

- Material merely covered. Coverage is not learning — wait for evidence.
- Anything already captured tersely in `GLOSSARY.md`. Don't duplicate.
- Session-by-session activity logs. Records are decision-grade insights, not a journal.

## Numbering

Scan `learning-records/` for the highest existing number and increment by one.

## Supersession

When a later record contradicts an earlier one (understanding deepened or corrected), mark the old one `Status: superseded by 0007` rather than deleting it. The history of how understanding evolved is itself signal.
