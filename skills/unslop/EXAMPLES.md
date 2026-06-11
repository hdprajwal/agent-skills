# Worked examples

Two full runs. Match the rhythm, not the exact words.

## Example 1 — AI-sounding essay → plain

**Before (AI-sounding):**

```text
Great question! Here is an essay on this topic. I hope this helps!

AI-assisted coding serves as an enduring testament to the transformative potential of large language models, marking a pivotal moment in the evolution of software development. In today's rapidly evolving technological landscape, these groundbreaking tools — nestled at the intersection of research and practice — are reshaping how engineers ideate, iterate, and deliver, underscoring their vital role in modern workflows.

At its core, the value proposition is clear: streamlining processes, enhancing collaboration, and fostering alignment. It's not just about autocomplete; it's about unlocking creativity at scale.

Industry observers have noted that adoption has accelerated from hobbyist experiments to enterprise-wide rollouts. While specific details are limited based on available information, it could potentially be argued that these tools might have some positive effect.

In conclusion, the future looks bright. Exciting times lie ahead as we continue this journey toward excellence. Let me know if you'd like me to expand on any section!
```

**Draft rewrite:**

```text
AI coding assistants can make you faster at the boring parts. Not everything, and definitely not architecture.

They're good at boilerplate: config files, test scaffolding, repetitive refactors. They're also good at sounding right while being wrong. I've accepted suggestions that compiled, passed lint, and still missed the point because I stopped paying attention.

The productivity numbers are slippery. GitHub can say Copilot users accept 30% of suggestions, but acceptance isn't correctness, and correctness isn't value. A 2024 Uplevel study found no significant difference in pull-request throughput between teams with and without AI assistants.

None of this makes the tools useless. It makes them tools. If you don't have tests, you can't tell whether a suggestion is right.
```

**What still reads as AI or workshopped?**
- The rhythm is a little too tidy in places (clean contrasts, evenly paced).
- "It makes them tools" is a touch slogan-y.

**Final rewrite:**

```text
AI coding assistants can make you faster at the boring parts. Not architecture.

They're great at boilerplate: config files, test scaffolding, repetitive refactors. They're also great at sounding right while being wrong. I've accepted suggestions that compiled, passed lint, and still missed the point because I stopped paying attention.

The productivity numbers are slippery. GitHub can say Copilot users accept 30% of suggestions, but accepting isn't the same as being correct, and being correct isn't the same as being useful. If you don't have tests, you're basically guessing.
```

**Changes made:**
- Cut chatbot artifacts ("Great question!", "I hope this helps!", "Let me know...")
- Cut significance inflation ("testament", "pivotal moment", "evolving landscape", "vital role")
- Cut promotional language ("groundbreaking", "nestled")
- Cut vague attribution ("Industry observers")
- Cut superficial -ing phrases ("underscoring", "fostering")
- Cut negative parallelism ("It's not just X; it's Y") and rule-of-three
- Removed em dashes, knowledge-cutoff hedging, and the generic upbeat conclusion
- Restored plain "is/are" over "serves as"
- Varied the rhythm so it reads like a person talking, not an assembled argument

## Example 2 — workshopped outreach → plain voice

This is the plain voice the skill aims for: short sentences, no clever lines, confident but not boastful, accurate, a collaborative ask.

**Before (too clever, slight swagger):**

```text
My recent work sits right where you operate. I built a tool for this because once you ship to real users, a slow rollback stops being theoretical. Give me 15 minutes and I'll show you exactly where I'd plug in.
```

**After (plain, honest):**

```text
A lot of my recent work is about keeping deploys safe. I built a small tool that rolls back a bad deploy in seconds with one command, so a broken release doesn't stay live. Would you be open to a quick call to see if there's a fit?
```

**Changes made:**
- "sits right where you operate" → plain statement of what the work is (#32 clever phrasing)
- "a slow rollback stops being theoretical" → "doesn't stay live" (drop the dramatic framing, say the effect)
- "Give me 15 minutes and I'll show you exactly where I'd plug in" → a collaborative, low-pressure ask (#33 swagger)
- Said what the tool does in one plain clause, no jargon (plain technical explanation)
