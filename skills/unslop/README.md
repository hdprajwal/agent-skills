# unslop

An AI agent skill that makes any writing sound plain, human, and simple. It strips the signs of AI-generated text and rewrites toward a plain spoken voice: short sentences, everyday words, honest claims, no swagger.

It does two things in one pass. It removes AI tells (the recognizable inflated, promotional, formulaic phrasing LLMs produce), and it rewrites toward a plain voice. Removing tells is only half the job, because clean but lifeless writing reads as machine-made too. The target is plain and alive.

This skill merges three earlier ones:

- **plain-voice** — the voice target (plain spoken English, no clever phrasing, no jargon, no swagger, no inflated claims)
- **humanize** — the de-AI detection catalog (based on Wikipedia's "Signs of AI writing")
- a LinkedIn post **quality-gate process** — one-pass scan, a real "it's already clean, change nothing" exit, and a priority order for compounding fixes

The plain voice is the north star. The catalog and process serve it.

## How it works

1. **Intake** — read the whole draft, note purpose and audience.
2. **Single-pass scan** — flag every tell in one sweep against the [catalog](PATTERNS.md).
3. **Decide** — if it's already plain and clean, say so and change nothing. If not, rewrite, fixing accuracy first, then voice, then filler, then flow, then formatting.
4. **Anti-AI audit** — one more pass for the rhythm and phrasing the scan misses.

## What it checks

38 patterns. The first 31 are AI tells (significance inflation, promotional language, superficial -ing phrases, vague attributions, AI vocabulary, copula avoidance, negative parallelisms, rule of three, em dash overuse, chatbot artifacts, sycophancy, post-action summaries, hedging, and more). The last 7 are plain-voice tells — clever phrasing, swagger, fake first-person authority, clever comparative endings, anaphora, rhetorical-question fragments, and "Most"-openers. Full before/after for each is in [PATTERNS.md](PATTERNS.md).

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill unslop -g
```

Works with any agent that supports the [skills.sh](https://skills.sh) ecosystem.

## Usage

Ask naturally:

```
humanize this text: [paste]
make this sound human and simple
simplify this draft
rewrite this plainer, less like a chatbot
```

## Output

A draft rewrite in a clean code block, a short note on what still reads as AI, a final rewrite after the audit, and a brief list of the changes made. If the draft is already clean, it just says so.

## References

- [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
- [WikiProject AI Cleanup](https://en.wikipedia.org/wiki/Wikipedia:WikiProject_AI_Cleanup)

## License

MIT
