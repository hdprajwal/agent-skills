---
name: litreview
description: >-
  Run a structured academic literature review — scope the question, search the
  literature, screen for relevance, extract findings into a comparable matrix,
  synthesize themes and gaps, and cite cleanly (BibTeX). Use for research papers,
  related-work sections, grant background, or surveying a field before building.
  Tracks what was searched so the review is reproducible, not cherry-picked.
allowed-tools: Read Write Edit Bash WebSearch WebFetch
---

# Literature Review

A review is only as good as its method. Make the search reproducible and the
synthesis honest about what's missing — don't just collect papers that agree.

## 1. Scope the question

Pin down before searching: the precise question, inclusion/exclusion criteria
(years, venues, methods, language), and what "done" looks like (N papers? a
saturation point where new searches surface nothing new?). Write these down — they
make the review defensible.

## 2. Search

Cast wide across sources; record each query and source so it's reproducible:

- **Semantic Scholar** (`api.semanticscholar.org`) — has a free API for
  title/abstract/citation search and citation graphs.
- **arXiv** (`export.arxiv.org/api`) — preprints, esp. CS/ML/physics.
- **Google Scholar / OpenAlex / PubMed** — broader / domain-specific.
- **Citation chasing** — follow references (backward) and citations (forward) of
  the key papers. Often finds more than keyword search.

Keep a search log: `query | source | date | hits | kept`.

## 3. Screen

Two passes: title/abstract first (drop the clearly irrelevant), then full-text on
survivors against your criteria. Note *why* each rejection happened — that's part
of the method.

## 4. Extract into a matrix

One row per paper, comparable columns. Save as a table (Markdown or CSV):

| Cite key | Year | Problem | Method | Data | Key finding | Limitations | Relevance |
|---|---|---|---|---|---|---|---|

Extract claims faithfully; quote exact numbers; note the paper's own stated
limitations. If you can't get the full text, mark it — don't infer findings from
the abstract alone and present them as established.

## 5. Synthesize

Organize by **theme or approach**, not paper-by-paper (a list of summaries isn't
a review). For each theme: what's the consensus, where do papers disagree, what's
the trend over time. End with **gaps** — what's unanswered, under-studied, or
methodologically weak. The gap is usually the point, especially for a paper's
related-work or a grant's background.

## 6. Cite

Collect BibTeX as you go (Semantic Scholar / arXiv / DOI give it directly). Keep
a `references.bib`. Cite every claim that isn't yours. Match the target venue's
style.

## Honesty rules

- **No fabricated citations.** Every reference must resolve to a real paper —
  verify the DOI/arXiv id. Never invent authors, titles, or numbers.
- **Distinguish** what a paper *showed* from what it *speculated*.
- **Report the search**, including what you didn't find — a gap you didn't search
  for isn't a gap you can claim.
- If coverage is partial (paywalls, time), say so explicitly.
