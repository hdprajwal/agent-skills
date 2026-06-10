# Agent Skills

A collection of AI agent skills installable via [skills.sh](https://skills.sh).

## Skills

### Writing & content

| Skill | Description |
|-------|-------------|
| [shadcn-audit](./skills/shadcn-audit) | Audits shadcn components from third-party registries for malicious code before installation |
| [humanize](./skills/humanize) | Removes signs of AI-generated writing from text to make it sound more natural and human |
| [writing-flow](./skills/writing-flow) | 3-step writing flow with three slash commands (`/fragments`, `/walk`, `/polish`) — grills the user three different ways with a forced context clear between each step |

### Development workflow

A connected pipeline for building software with an agent: **brainstorm →
plan → isolate → execute (incrementally)**. Each skill hands off to the next.
Adapted from [obra/superpowers](https://github.com/obra/superpowers) and
[addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — see
[Acknowledgements](#acknowledgements).

| Skill | Description |
|-------|-------------|
| [brainstorming](./skills/brainstorming) | Turns an idea into an approved design before any code — questions one at a time, 2-3 approaches, a short spec, and sign-off. Hands off to `writing-plans` |
| [writing-plans](./skills/writing-plans) | Writes a bite-sized implementation plan (exact files, code, commands, TDD steps) an engineer with zero context could execute |
| [executing-plans](./skills/executing-plans) | Executes a written plan inline in the current session with review checkpoints; stops and asks when blocked |
| [subagent-driven-development](./skills/subagent-driven-development) | Executes a plan with a fresh subagent per task and a two-stage review (spec, then quality); ships three reviewer prompt templates |
| [dispatching-parallel-agents](./skills/dispatching-parallel-agents) | Dispatches one focused agent per independent problem and runs them concurrently — for unrelated failures with no shared state |
| [incremental-implementation](./skills/incremental-implementation) | Builds in thin vertical slices — implement, test, verify, commit, expand — so the system stays working between increments |
| [using-git-worktrees](./skills/using-git-worktrees) | Ensures work happens in an isolated workspace; detects existing isolation, prefers native tools, verifies a clean test baseline |

## Install

Install a specific skill:

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill <skill-name> -g
```

For example:

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill shadcn-audit -g
npx skills add https://github.com/hdprajwal/agent-skills --skill humanize -g
npx skills add https://github.com/hdprajwal/agent-skills --skill writing-flow -g
```

## What are agent skills?

Agent skills are modular instruction sets that extend what AI agents can do. Each skill is a markdown file that tells the agent when to activate and how to handle a specific task — consistently, every time.

Skills work across any agent that supports the [skills.sh](https://skills.sh) ecosystem.

## Contributing

Contributions are welcome. To add a new skill:

1. Create a directory under `skills/<skill-name>/`
2. Add a `SKILL.md` with name and description frontmatter
3. Add a `README.md` and `metadata.json`
4. Open a pull request

### Linux desktop (Hyprland / Wayland)

Computer-use skills for driving a Wayland desktop — built and verified on
CachyOS + Hyprland. Together they form an observe → act loop: **see the screen →
control windows → click & type → verify**.

| Skill | Description |
|-------|-------------|
| [hyprland-control](./skills/hyprland-control) | Inspect and control the Hyprland desktop via `hyprctl` — query/focus/move/resize/close windows, switch workspaces, launch apps onto a workspace |
| [screen-capture](./skills/screen-capture) | Screenshots via `grim`+`slurp` (full / monitor / region / active window) to a file or clipboard — the "eyes" for visual computer use |
| [gui-input-automation](./skills/gui-input-automation) | Synthetic keyboard (`wtype`) and mouse (`ydotool`) input — type, key combos, move, click, drag — the "hands" |
| [visual-computer-use-loop](./skills/visual-computer-use-loop) | The full observe → reason → act → verify loop with coordinate calibration; the local equivalent of Claude computer use |

> These target **Wayland/Hyprland**. On X11 the tooling differs (`xdotool`,
> `wmctrl`, `scrot`). `gui-input-automation`'s mouse half needs a one-time
> `ydotool` setup the skill walks through.

### Engineering & research

Skills that fill gaps in the dev/research toolkit — inspired by popular
collections (see [Acknowledgements](#acknowledgements)) and tailored to a
Rust + Next/TS + Python + MCP workflow.

| Skill | Description |
|-------|-------------|
| [mcp-builder](./skills/mcp-builder) | Build/scaffold/review MCP servers in TS (MCP SDK) or Python (FastMCP) — transports, tool design, error shapes, evaluation |
| [document-toolkit](./skills/document-toolkit) | Read/extract/fill/generate PDF, DOCX, XLSX from Python (pdfplumber, python-docx, openpyxl) |
| [rust-review](./skills/rust-review) | Review Rust: clippy/fmt/audit, then unsafe, panics, error handling, ownership, idioms, async/tokio pitfalls |
| [api-design](./skills/api-design) | Contract-first design for HTTP endpoints, MCP tools, and library APIs — naming, errors, pagination, versioning |
| [litreview](./skills/litreview) | Structured, reproducible academic literature review — search log, screening, extraction matrix, theme synthesis, BibTeX |
| [session-handoff](./skills/session-handoff) | Write/restore a `docs/HANDOFF.md` snapshot when pausing or switching between parallel projects |

## Acknowledgements

The development-workflow skills are adapted — re-voiced and trimmed, not copied
verbatim — from two excellent open-source skill collections:

- **[obra/superpowers](https://github.com/obra/superpowers)** by Jesse Vincent —
  source for `brainstorming`, `writing-plans`, `executing-plans`,
  `subagent-driven-development`, `dispatching-parallel-agents`, and
  `using-git-worktrees`.
- **[addyosmani/agent-skills](https://github.com/addyosmani/agent-skills)** by
  Addy Osmani — source for `incremental-implementation`.

The engineering & research skills draw on these collections:

- **[anthropics/skills](https://github.com/anthropics/skills)** — inspiration for
  `mcp-builder` and `document-toolkit` (the official `pdf`/`docx`/`xlsx` skills).
- **[Jeffallan/claude-skills](https://github.com/Jeffallan/claude-skills)** and
  **[alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills)**
  — surveyed for `rust-review`, `api-design`, `litreview`, and `session-handoff`.

All are worth reading in full — they cover far more than the skills adapted here.
Thanks to their authors for sharing them openly.

## License

MIT
