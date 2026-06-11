---
name: spec-to-issues
description: Break a spec, PRD, or design into independent first-principles tasks and publish them as tracker issues — GitHub for now, adapter-shaped for other platforms. Decomposes into tracer-bullet vertical slices with dependencies and acceptance criteria, gets your approval, then creates an epic + linked child issues. Use to turn a spec into a trackable backlog ("break this spec into issues", "push these as GitHub issues"). Pairs with issue-to-pr.
allowed-tools: Read Write Bash Skill
---

# Spec to Issues

Turn a spec/PRD/design into independently-workable issues on your tracker, so
every later change traces back to a reason. This is the front half of the
lifecycle:

```
brainstorming → spec → [spec-to-issues] → tracker issues → issue-to-pr → PR (Closes #N) → merge
```

**Say at the start:** "Using spec-to-issues — decompose → approve → publish to
<platform>."

## Two layers: decomposition vs. publishing

Keep these separate. **Decomposition is platform-agnostic** — the same vertical
slices whether you use GitHub, GitLab, or Linear. **Publishing goes through an
adapter.** Only the adapter knows the tool's CLI/API.

- **v0 ships the GitHub adapter** (`gh`). It's the only one implemented now.
- To support another platform later, write a new adapter that satisfies the
  same contract (see *Adapter contract* below) — the decomposition steps don't
  change.

Decomposition method follows the tracer-bullet approach from the **to-issues**
skill; the new part here is publishing to a real git remote tracker.

## Process

### 1. Gather the spec

Work from the spec in context. If the user passes a path or URL, read it in full.
If there's no spec yet, stop and point them at **brainstorming** / **to-prd** —
don't invent requirements.

### 2. Explore the codebase (optional)

If you haven't already, skim the code so issue titles and bodies use the
project's real domain vocabulary and respect existing structure. A subagent
(Explore) is good for this.

### 3. Draft vertical slices

Break the spec into **tracer-bullet** issues — each a thin slice that cuts
through ALL layers end-to-end (schema → API → UI → tests), NOT a horizontal
slice of one layer.

<vertical-slice-rules>
- Each slice delivers a narrow but COMPLETE path through every layer.
- A completed slice is demoable or verifiable on its own.
- Prefer many thin slices over a few thick ones.
- Mark each slice AFK (can be built + merged autonomously) or HITL (needs a human
  decision — architecture, design review). Prefer AFK where honest.
</vertical-slice-rules>

For each slice capture: **title**, **type** (AFK/HITL), **blocked by** (which
slices must finish first), **what to build** (end-to-end behavior), and
**acceptance criteria** (checkable).

### 4. Quiz the user — approval gate

Present the breakdown as a numbered list: title · type · blocked-by · user
stories covered. Ask:

- Granularity right? (too coarse / too fine)
- Dependencies correct?
- Any slices to merge or split?
- AFK/HITL marked correctly?

**Iterate until the user approves.** Do not publish before sign-off.

### 5. Preflight the target

Run the adapter's preflight (for GitHub: `gh auth status`, confirm the repo,
ensure labels exist). Stop and ask if it fails.

### 6. Publish

Through the adapter, in **dependency order (blockers first)** so child
references resolve:

1. Create the **epic** tracking issue (title + spec summary + empty checklist).
2. Create each **child** issue with the body template below; set its labels.
3. Update the epic body with a checklist linking every child.

<child-issue-template>
## What to build

<end-to-end behavior of this slice — not layer-by-layer implementation>

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2

## Blocked by

<reference(s) to blocking issue(s), e.g. "#11"> — or "None — can start immediately".

## Epic

<reference to the parent epic issue>
</child-issue-template>

**Labels** (the adapter creates any that are missing):

- `epic` — the tracking issue.
- `ready` — no open blockers; safe to grab now.
- `blocked` — has at least one unfinished blocker.
- `afk` / `hitl` — autonomy class from step 3.

A slice with no blockers gets `ready`; one with blockers gets `blocked`. When a
blocker closes, its dependents should flip `blocked` → `ready` (do this by hand
for v0, or via a future automation).

### 7. Report + hand off

List what was created: the epic and each child (number, title, labels, blocked-by),
and the epic URL. Then point the user at **issue-to-pr** to start working the
`ready` ones, one per run.

## Adapter contract

Any platform adapter must implement these. v0 = GitHub.

| Operation | Meaning |
|-----------|---------|
| `preflight` | Auth is valid, target repo/project identified |
| `ensure_labels(labels)` | Create any missing labels |
| `create_epic(title, body) → id` | Create the tracking issue, return its id |
| `create_issue(title, body, labels) → id` | Create a child, return its id |
| `link_children(epic_id, [child_ids])` | Write the checklist into the epic |

### GitHub adapter (v0)

```bash
# preflight
gh auth status
gh repo view --json nameWithOwner -q .nameWithOwner

# ensure_labels — safe to re-run
for l in epic ready blocked afk hitl; do gh label create "$l" 2>/dev/null || true; done

# create_epic / create_issue — capture the issue number from the printed URL
num=$(gh issue create --title "<title>" --body "<body>" \
        --label "<comma,labels>" | grep -oE '[0-9]+$')

# link_children — rewrite the epic body to include the checklist
gh issue edit <epic-num> --body "<spec summary>

## Slices
- [ ] #<child1> <title>
- [ ] #<child2> <title>
"
```

Create the epic first, then children (so you have real numbers), then
`link_children` to fill the epic checklist. Encode `Blocked by #N` as text in
each child body — that's the same signal **issue-to-pr**'s selector reads, so it
works even before labels are flipped.

### Adding another platform

Write a new adapter section (e.g. GitLab via `glab`, Linear via API) that
implements the contract above. Reuse steps 1–4 and 7 unchanged; only step 5–6
calls swap.

## Stop and ask when

No spec exists yet · preflight fails (not authed, wrong repo) · the breakdown
isn't approved · a dependency cycle appears (two slices block each other — split
one).

## Remember

- Decomposition is platform-agnostic; only the adapter is GitHub-specific.
- Vertical tracer-bullet slices, not horizontal layers.
- Never publish before the user approves the breakdown.
- Publish blockers first so `#N` references resolve.
- `Blocked by #N` text is the contract with issue-to-pr's selector.

## Related

- **to-issues** — the same decomposition method, publishing to the Matt-Pocock
  backlog instead of a git remote.
- **issue-to-pr** — the back half: picks a `ready` issue and drives it to a PR.
- **brainstorming** / **to-prd** — produce the spec this consumes.
