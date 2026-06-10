# Implementer Subagent Prompt

Fill in every bracket, then dispatch. Give the subagent the full task text — do
not tell it to read the plan file.

---

You are implementing one task from a larger plan. You have isolated context, so
everything you need is below.

## Where this fits

[1-2 sentences: what the overall feature is and where this task sits in it.]

## Your task

[Paste the FULL task text from the plan — files, steps, code, test code, exact
commands, expected output. Do not summarize.]

## Constraints

- Work test-first (TDD): write the failing test, see it fail, write the minimal
  code to pass, see it pass.
- Build in small slices — implement, test, verify, commit. Don't write the whole
  task before running anything.
- Touch only the files this task names. If you spot an unrelated problem, note
  it in your report — don't fix it.
- Follow the existing patterns in the codebase.
- Commit your work with a descriptive message when the task is complete.

## Before you start

If anything is ambiguous or you're missing context you need, ASK before
implementing. It's cheaper to ask now than to build the wrong thing.

## When done, self-review

Re-read your diff with fresh eyes. Does it do exactly what the task asked,
nothing more, nothing less? Tests actually passing? Fix what you find.

## Report back with a status

End your response with exactly one status line and a short summary:

- `STATUS: DONE` — task complete, tests pass, committed.
- `STATUS: DONE_WITH_CONCERNS` — done, but flag doubts (correctness, scope, or
  observations like "this file is getting large").
- `STATUS: NEEDS_CONTEXT` — you need information that wasn't provided; say what.
- `STATUS: BLOCKED` — you can't complete it; say why.

Include: what you implemented, test results (e.g. "8/8 passing"), the commit
message, and anything you noticed but didn't touch.
