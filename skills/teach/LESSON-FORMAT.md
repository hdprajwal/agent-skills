# Lesson & Reference Format

Lessons (`lessons/*.html`) and reference docs (`reference/*.html`) are self-contained HTML files. They are the artifacts the user keeps and returns to, so they must be **beautiful** — clean, readable, print-friendly. Think Tufte: generous whitespace, serif body text, restrained color, content over chrome.

Each file is standalone: inline the CSS, no build step, no external JS dependencies (a tiny inline `<script>` for quiz feedback is fine). It must open correctly from `file://` with a double-click.

## Naming

- Lessons: `lessons/0001-<dash-case-name>.html`, incrementing the number each time.
- Reference: `reference/<dash-case-name>.html` (no numbering — these are looked up by name).

## Lesson anatomy

A lesson teaches **one** tightly-scoped thing through the first-principles arc — the user derives, they don't read a conclusion:

1. **Title + the win.** One line naming exactly what the user will be able to do after this lesson.
2. **Mission tie-in.** One sentence connecting this to why they're learning (pull from `MISSION.md`).
3. **The primitives.** The minimum bedrock facts the derivation needs — delivered cleanly and easily, each linked to its source in `RESOURCES.md`. Difficulty here is the enemy.
4. **Strip & interrogate.** Prompt the user to attempt the decomposition and to split each "fact" into *necessarily true* vs *convention*. An interactive reveal, not a paragraph.
5. **Derive.** The user reasons up from the primitives via guided questions — difficulty here is the tool. They attempt each step before the next is revealed; feedback is immediate.
6. **Reconstruct & test.** The user restates the concept as their own derivation and finds where it breaks (edge case or changed primitive).
7. **Primary source.** The single best resource to go deeper.
8. **Links.** HTML anchors to related lessons, `PRINCIPLES.md`, and glossary terms.
9. **Ask your teacher.** A reminder that the agent is their teacher and can clarify anything.

## Quiz & derivation-drill rules

- The user must commit to an answer or a derivation step before the correct one is revealed (a button, a reveal, an input check).
- For multiple-choice: every option is the same length in words — and characters where possible. Formatting must not leak the answer.
- Prefer **derivation drills** over recall quizzes where the topic allows: give the primitives and ask the user to reconstruct the result, or give a claim and ask them to trace it to bedrock.
- Feedback is immediate and explains the *reasoning* — which primitive forces the step — not just right/wrong.

## Reference docs

Reference docs are the compressed essence — cheat sheets, syntax tables, algorithms, pose sequences, routines. Optimise for fast scanning, not narrative: dense tables, short headers, minimal prose. These get revisited far more than lessons, so they earn the most polish.

## Minimal house template

A starting point — adapt per topic, keep it this clean:

```html
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{Lesson title}</title>
<style>
  :root { --ink: #1a1a1a; --muted: #6b6b6b; --rule: #e0ddd6; --accent: #7a1f1f; }
  body { max-width: 38rem; margin: 4rem auto; padding: 0 1.25rem;
         font: 1.125rem/1.65 Georgia, "Iowan Old Style", serif; color: var(--ink); }
  h1 { font-size: 1.9rem; line-height: 1.2; margin: 0 0 .25rem; }
  .win { color: var(--accent); font-style: italic; margin-bottom: 2rem; }
  h2 { font-size: 1.15rem; letter-spacing: .02em; text-transform: uppercase;
       color: var(--muted); border-bottom: 1px solid var(--rule);
       padding-bottom: .3rem; margin-top: 2.5rem; }
  a { color: var(--accent); }
  .quiz { background: #faf8f3; border: 1px solid var(--rule); border-radius: 6px;
          padding: 1rem 1.25rem; margin: 1.5rem 0; }
  .source { font-size: .95rem; color: var(--muted); }
  @media print { body { margin: 1rem auto; } .quiz { break-inside: avoid; } }
</style>
</head>
<body>
  <h1>{Lesson title}</h1>
  <p class="win">After this you'll be able to {the single tangible win}.</p>

  <h2>Why this matters</h2>
  <p>{One sentence tying to the mission.}</p>

  <h2>The primitives</h2>
  <p>{The bedrock facts, clean and easy.} <a class="source" href="{url}">[source]</a></p>

  <h2>Strip &amp; interrogate</h2>
  <div class="quiz">{Ask the user to decompose, and to split necessary vs convention — attempt before reveal.}</div>

  <h2>Derive</h2>
  <div class="quiz">{Guided steps: the user reasons up from the primitives, one step at a time.}</div>

  <h2>Reconstruct &amp; test</h2>
  <div class="quiz">{User restates the derivation and finds where it breaks.}</div>

  <h2>Go deeper</h2>
  <p class="source">Primary source: <a href="{url}">{title}</a></p>
  <p class="source">Stuck on anything? Ask me — I'm your teacher for this.</p>
</body>
</html>
```
