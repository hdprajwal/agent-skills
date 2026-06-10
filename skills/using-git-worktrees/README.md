# using-git-worktrees

Make sure work happens in an **isolated workspace** before you start a feature or
execute a plan — so your current branch stays clean.

The order is deliberate: detect existing isolation first (with a submodule
guard), then use the harness's native worktree tool if there is one, and only
fall back to manual `git worktree` when there isn't. Project-local worktree dirs
are verified git-ignored before use. Then it runs setup and confirms a clean test
baseline so you can tell new bugs from pre-existing ones.

The recurring lesson: **don't fight the harness** — using `git worktree add` when
a native tool exists creates phantom state the harness can't track.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill using-git-worktrees -g
```

## Credit

Adapted from the `using-git-worktrees` skill in
[obra/superpowers](https://github.com/obra/superpowers).
