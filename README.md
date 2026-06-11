# Agent Skills

Modular instruction sets that extend what AI coding agents can do — each one teaches the agent *when* to act and *how* to do a specific task the same way, every time. Installable via [skills.sh](https://skills.sh), works in any agent that supports it.

**20 skills** across four areas: a build-with-an-agent workflow, engineering & research tools, Linux desktop control, and writing.

Jump to: [Development workflow](#development-workflow) · [Engineering & research](#engineering--research) · [Linux desktop](#linux-desktop-hyprland--wayland) · [Writing & content](#writing--content)

## Quick start

Install a single skill globally:

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill <skill-name> -g
```

For example:

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill brainstorming -g
```

<details>
<summary>Install several at once / notes</summary>

Run the command once per skill:

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill writing-plans -g
npx skills add https://github.com/hdprajwal/agent-skills --skill rust-review -g
npx skills add https://github.com/hdprajwal/agent-skills --skill mcp-builder -g
```

Some skills need extra tooling on your machine (e.g. `document-toolkit` needs a few Python libraries; the Linux desktop skills need Wayland tools). Each skill's own `README.md` lists its requirements under **Requires**.

</details>

## Development workflow

A connected pipeline for building software with an agent. Each skill hands off to the next:

```
brainstorm → plan → isolate → execute (incrementally) → review → ship (PR)
```

| Skill | What it does |
|-------|--------------|
| [brainstorming](./skills/brainstorming) | Turns an idea into an approved spec before any code — one question at a time, 2-3 approaches, sign-off |
| [writing-plans](./skills/writing-plans) | Writes a bite-sized plan (exact files, code, commands, TDD steps) an engineer with zero context could run |
| [using-git-worktrees](./skills/using-git-worktrees) | Puts work in an isolated workspace — branch by default, worktree when you need a second checkout |
| [executing-plans](./skills/executing-plans) | Runs a plan inline with review checkpoints; stops and asks when blocked |
| [subagent-driven-development](./skills/subagent-driven-development) | Runs a plan with a fresh subagent per task and a two-stage review (spec, then quality) |
| [incremental-implementation](./skills/incremental-implementation) | Builds in thin vertical slices so the system stays working between increments |
| [dispatching-parallel-agents](./skills/dispatching-parallel-agents) | One focused agent per independent problem, run concurrently |
| [spec-to-issues](./skills/spec-to-issues) | Breaks a spec/PRD into independent tracer-bullet slices and publishes them as an epic + linked GitHub issues (adapter-shaped for other trackers) |
| [issue-to-pr](./skills/issue-to-pr) | Picks one independent GitHub issue, then composes the isolation/implementation/review skills to drive it to an open PR — stops before merge |

## Engineering & research

Tools that fill gaps in the dev/research toolkit, tuned to a Rust + Next/TS + Python + MCP workflow.

| Skill | What it does |
|-------|--------------|
| [mcp-builder](./skills/mcp-builder) | Build/scaffold/review MCP servers in TS (MCP SDK) or Python (FastMCP) — transports, tool design, evals |
| [document-toolkit](./skills/document-toolkit) | Read/extract/fill/generate PDF, DOCX, XLSX from Python (pdfplumber, python-docx, openpyxl) |
| [rust-review](./skills/rust-review) | clippy/fmt/audit, then unsafe, panics, error handling, ownership, idioms, async/tokio pitfalls |
| [api-design](./skills/api-design) | Contract-first design for HTTP endpoints, MCP tools, and library APIs |
| [litreview](./skills/litreview) | Reproducible academic literature review — search log, screening, extraction matrix, synthesis, BibTeX |
| [session-handoff](./skills/session-handoff) | Write/restore a `docs/HANDOFF.md` snapshot when pausing or switching projects |

## Linux desktop (Hyprland / Wayland)

Computer-use skills for driving a Wayland desktop, built and verified on CachyOS + Hyprland. Together they form an observe → act loop:

```
see the screen → control windows → click & type → verify
```

| Skill | What it does |
|-------|--------------|
| [hyprland-control](./skills/hyprland-control) | Query/focus/move/resize/close windows, switch workspaces, launch apps via `hyprctl` |
| [screen-capture](./skills/screen-capture) | Screenshots via `grim`+`slurp` (full / monitor / region / window) — the "eyes" |
| [gui-input-automation](./skills/gui-input-automation) | Synthetic keyboard (`wtype`) and mouse (`ydotool`) input — the "hands" |
| [visual-computer-use-loop](./skills/visual-computer-use-loop) | The full observe → reason → act → verify loop with coordinate calibration |

**Note:** these target Wayland/Hyprland — on X11 the tooling differs (`xdotool`, `wmctrl`, `scrot`). The mouse half of `gui-input-automation` needs a one-time `ydotool` setup, which the skill walks through.

## Writing & content

| Skill | What it does |
|-------|--------------|
| [writing-flow](./skills/writing-flow) | 3-step writing flow (`/fragments`, `/walk`, `/polish`) — grills you three ways with a context clear between each |
| [humanize](./skills/humanize) | Strips signs of AI-generated writing so text reads naturally |
| [shadcn-audit](./skills/shadcn-audit) | Audits shadcn components from third-party registries for malicious code before install |

## How skills work

A skill is a folder the agent reads on demand. The `description` in the frontmatter is what the agent matches against to decide when to load it; the body is the instructions it then follows.

```
skills/<skill-name>/
├─ SKILL.md        # frontmatter (name, description, allowed-tools) + instructions
├─ README.md       # human-facing overview + install + requirements
└─ metadata.json   # version, author, references
```

```
┌─ SKILL.md frontmatter ──────────────────────────────┐
│ name: lowercase-hyphen-name                         │
│ description: what it does + WHEN the agent uses it  │
│ allowed-tools: Read Write Edit Bash ...             │
└─────────────────────────────────────────────────────┘
```

The `description` does the heavy lifting — it should say both what the skill does and the trigger conditions for using it, so the agent reaches for it at the right moment.

## Contributing

To add a new skill:

1. Create a directory under `skills/<skill-name>/`
2. Add a `SKILL.md` with `name` and `description` frontmatter, plus the instructions
3. Add a `README.md` (overview + install + requirements) and a `metadata.json`
4. Open a pull request

## Acknowledgements

Several skills are adapted — re-voiced and trimmed, not copied verbatim — from excellent open-source collections.

**Development workflow:**

- [obra/superpowers](https://github.com/obra/superpowers) by Jesse Vincent — `brainstorming`, `writing-plans`, `executing-plans`, `subagent-driven-development`, `dispatching-parallel-agents`, `using-git-worktrees`.
- [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) by Addy Osmani — `incremental-implementation`.

**Engineering & research:**

- [anthropics/skills](https://github.com/anthropics/skills) — `mcp-builder` and `document-toolkit` (the official `pdf`/`docx`/`xlsx` skills).
- [Jeffallan/claude-skills](https://github.com/Jeffallan/claude-skills) and [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) — surveyed for `rust-review`, `api-design`, `litreview`, `session-handoff`.

All are worth reading in full. Thanks to their authors for sharing them openly.

## License

[MIT](./LICENSE)
