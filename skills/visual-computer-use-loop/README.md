# visual-computer-use-loop

The local equivalent of Claude's **computer use**, on **Hyprland / Wayland**.

Operate the real desktop in a tight **observe → reason → act → verify** loop,
combining three skills: `screen-capture` (see), `gui-input-automation` (click /
type), and `hyprland-control` (windows / workspaces / focus).

Includes coordinate **calibration** for scaled monitors, a **shell-first** rule
(don't click what you can script), **one-action-then-look** discipline, and
**confirm-before-risky-actions** safety. Reach for it only when a task is
genuinely GUI-only.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill visual-computer-use-loop -g
```

## Requires

`grim`, `slurp`, `wtype`, `hyprctl`, `jq` (ready), plus `ydotool` set up for the
mouse (see `gui-input-automation`). Keyboard-only automation works without
`ydotool`.
