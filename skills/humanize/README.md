# humanize

An AI agent skill that removes signs of AI-generated writing from text, making it sound more natural and human.

LLMs produce text that tends toward the most statistically likely phrasing. The result is recognizable: inflated significance, promotional language, vague attributions, AI vocabulary words, and formulaic structure. This skill detects 31 such patterns and rewrites them, then runs a final anti-AI audit pass to catch anything that slipped through.

## What it checks

**Content patterns**
- Significance inflation ("pivotal moment", "evolving landscape")
- Promotional language ("nestled", "breathtaking", "groundbreaking")
- Superficial -ing analyses ("highlighting", "showcasing", "reflecting")
- Vague attributions ("experts argue", "industry reports")
- Formulaic challenges and prospects sections
- Notability name-dropping without context

**Language patterns**
- AI vocabulary (delve, landscape, tapestry, leverage, nuanced)
- Copula avoidance (serves as, stands as, boasts, features)
- Negative parallelisms, rule of three, synonym cycling, false ranges

**Style patterns**
- Em dash overuse, boldface overuse, inline-header lists
- Title case headings, decorative emojis, curly quotes

**Communication patterns**
- Chatbot artifacts ("I hope this helps!", "Let me know if...")
- Sycophantic tone, knowledge-cutoff disclaimers
- Model-specific tells: post-action summaries, unsolicited ethical caveats, second-person lock, markdown overuse in prose

**Filler and hedging**
- Filler phrases ("in order to", "due to the fact that")
- Excessive hedging, generic positive conclusions

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill humanize -g
```

Works with any agent that supports the [skills.sh](https://skills.sh) ecosystem.

## Usage

Ask your agent naturally:

```
humanize this text: [paste text]
review this draft for AI-sounding language
make this sound less like a chatbot wrote it
```

Or invoke the skill directly:

```
/humanize

[paste your text here]
```

## Output

```
## Draft rewrite

[Rewritten text with AI patterns removed]

## What makes the below so obviously AI generated?

- Remaining tells identified (if any)

## Final rewrite

[Second-pass revision addressing remaining tells]

## Changes made

- Removed significance inflation ("testament", "pivotal moment")
- Replaced vague attributions with specific sources
- Converted inline-header lists to prose
- ...
```

## Credits

Based on the original [humanizer](https://github.com/blader/humanizer) skill by [@blader](https://github.com/blader). The original was built specifically for Claude; this version has been generalized to work with any AI model.

## References

- [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing) - Primary source
- [WikiProject AI Cleanup](https://en.wikipedia.org/wiki/Wikipedia:WikiProject_AI_Cleanup) - Maintaining organization

## License

MIT
