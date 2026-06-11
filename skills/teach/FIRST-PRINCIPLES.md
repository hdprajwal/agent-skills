# The First-Principles Method

This is the spine of the `teach` skill. Read it before teaching. It defines how to decompose any concept to bedrock, how to make the user derive instead of memorize, and the exact prompts that push them to think this way.

## What "first principles" means

A **first principle** is a fundamental truth that can't be deduced from anything more basic — a definition, an axiom, a physical law, or a direct observation. Reasoning from first principles means building understanding *up* from those truths, justifying each step.

It stands against the two cheap shortcuts the brain prefers:

- **Reasoning by analogy** — "it's like X, so it probably behaves like X." Fast, often right, but it copies X's limits and breaks exactly where the analogy stops holding.
- **Reasoning from authority/convention** — "this is how it's done." Encodes someone else's (possibly stale) conclusion without the reasoning that produced it.

Neither is *wrong* as a tool. The skill is knowing when you're using them, and being able to drop down to bedrock when they fail.

## The four-step arc

Apply this to every concept, in lessons and in conversation.

### 1. Strip to bedrock

Decompose the concept into the smallest set of facts everything else rests on. **Ask the user to try first** — their attempt reveals what they think is fundamental (and what they've quietly assumed).

Guiding question: *"What has to be true for this to work at all? Keep going until you hit something you can't break down further."*

Test for bedrock: can this be reduced further, or is it a definition / law / observation? If it can be reduced, it's not a primitive yet — keep going.

### 2. Interrogate assumptions

For each "fact" surfaced, force the split:

> **Necessarily true**, or **convention / analogy / received wisdom**?

This is where most real learning happens. People carry conventions as if they were laws. When the user discovers that something they assumed was fixed is actually a choice someone made, that's the highest-value moment in the whole skill — **stop and write a learning record.**

Guiding questions:
- *"Is that true because it must be, or because that's how you've seen it done?"*
- *"Who decided that, and what would break if they'd decided differently?"*
- *"Strip that assumption away — does the concept still stand?"*

### 3. Reason upward

Rebuild the concept from the primitives, one justified step at a time — and make the **user** produce the chain. You ask; they derive.

- *"You've got these primitives. What follows from them?"*
- *"Why does that next step hold — which primitive forces it?"*
- When they jump, slow them down: *"What's the step between those two?"*

Hand back anything they can reach. Only supply a step when they're genuinely stuck, and even then, supply the *question* that unlocks it before the answer.

### 4. Reconstruct and test

The user restates the whole concept as their own derivation — bedrock, then the chain up. Then stress-test it:

- *"Where does this break? Find the edge case."*
- *"Change one primitive — what happens to the conclusion?"*
- *"Predict something with it, then check against a source."*

A derivation that survives an edge case the user found themselves is storage-strength learning.

## The pushing prompts

Keep these live in conversation. They are how you train the *habit*, not just teach the topic.

| When the user… | Push with… |
| --- | --- |
| States a conclusion confidently | "Why is that true? Take it down one level." |
| Says "it's like X" | "What's the actual mechanism — does the analogy hold where it counts?" |
| Says "that's just how it's done" | "That's a stopping point, not a reason. Who chose it, and why?" |
| Asks you for the answer | "You have the pieces — what follows? I'll tell you if you're stuck." |
| Accepts a fact from you | "Don't take my word — what would you check to know it's true?" |
| Gets it right | "Good. Now what does this *force* to be true elsewhere?" |

Run the **why-ladder**: ask "why?" repeatedly until you reach bedrock. Three to five rungs usually gets there. The goal isn't to interrogate for sport — it's to make the user feel where the solid ground is.

## Knowing when to stop

First-principles thinking has an obvious failure mode: infinite regress. You can always ask "but why is *that* true?" one more time.

The **mission** sets the floor. Decompose only as deep as the user's goal requires:

- Learning to use a web framework? Bedrock is the request/response cycle and the framework's core contracts — not TCP, not transistors.
- Writing a network stack? Now TCP *is* the bedrock.
- Building a CPU? Keep going to logic gates.

State the floor explicitly at the start of a topic so the user knows where "fundamental enough" sits for *their* mission.

## `PRINCIPLES.md`

Maintain a running list of the fundamentals established for this topic — the bedrock the user has accepted and can build on. New derivations reference it; new lessons start from it.

```md
# {Topic}: First Principles

The fundamental truths this topic is built on. Each is either irreducible or
explicitly chosen as the floor for this mission. Everything in the lessons
derives from these.

## Established

1. **{Principle}** — {one-line statement.} _{why it's bedrock: definition / law / observation / mission-floor.}_ [source]({url})
2. **{Principle}** — {…}

## Overturned assumptions

- ~~{Thing the user assumed was a law}~~ → it's a convention. {What's actually true instead, and what it unlocks.} (see learning-records/0003)

## Floor for this mission

{Where "fundamental enough" sits, and why — tied to MISSION.md.}
```

Rules:
- **Promote a principle only once the user accepts it as bedrock** — ideally after they've interrogated it, not just heard it.
- **Cite it.** A primitive with no source is a guess, and the whole derivation inherits the risk.
- **Record overturned assumptions loudly.** They're the most valuable output — they rewire how the user sees the rest of the topic.
- **Keep it tight.** This is the foundation, not a textbook. If it sprawls, the floor is set too deep for the mission.

## A worked example (compressed)

Topic: *why does adding an index speed up a database query?* Mission: ship a feature, don't reach hardware.

1. **Strip to bedrock.** Ask: what must be true for a query to be slow in the first place? User lands on: data lives in rows, the engine must look at rows to match a condition, looking at a row has a cost.
2. **Interrogate.** "Must the engine look at *every* row?" User assumes yes — that's the convention to break. Necessary truth: it must look at every row *it cannot rule out*. The full scan is a consequence of having no way to rule rows out, not a law.
3. **Reason up.** "If you had the column's values pre-sorted with pointers back to the rows, what could you skip?" User derives: binary-search the sorted structure, jump to matches, skip the rest → that's an index.
4. **Reconstruct and test.** User restates it, then you push: "When would the index *not* help?" They reason to: when the query matches most rows anyway (ruling little out) — and now they understand selectivity without being told it.

The user never memorized "indexes speed up queries." They derived it, found its limit, and can now reason about a join or a composite index from the same primitives.
