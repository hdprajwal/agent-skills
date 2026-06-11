# teach

Learn a topic deeply, from first principles, over multiple sessions — not a one-off explanation.

Say "teach me X" and it sets up a stateful **teaching workspace** dedicated to that topic. Every concept is taught through a first-principles arc: **strip to bedrock** (decompose to the irreducible truths), **interrogate assumptions** (necessary vs just convention), **reason upward** (you derive it from the primitives — it won't hand you the answer), then **reconstruct and test** against an edge case. The goal isn't just to learn the topic; it's to train you to decompose anything yourself.

Difficulty lands where it helps: the raw facts are delivered cleanly and easily, but the reasoning that connects them is yours to do — that effort is what makes it stick. Lessons are written as beautiful, self-contained HTML you keep and revisit, grounded in trusted cited sources rather than the model's guesses.

State lives on disk per topic (`MISSION.md`, `PRINCIPLES.md`, `GLOSSARY.md`, `RESOURCES.md`, `learning-records/`, `lessons/`), so one repo can host several topics side by side — e.g. learning *how RAG works* and *how RAG evaluation works* inside the same codebase — and lessons can cite the real source files.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill teach -g
```

## Requires

A browser to view the generated HTML lessons (`xdg-open`). Web search/fetch is used to gather trusted sources. Otherwise guidance only.
