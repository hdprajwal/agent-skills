# hyprland-control

Inspect and control the **Hyprland** (Wayland) desktop from the shell via
`hyprctl`.

Query windows, workspaces, monitors, and the cursor as JSON (pipe through `jq`);
then focus / move / resize / close windows by selector, switch and move windows
between workspaces, launch apps onto a target workspace, batch several
dispatches, and tweak config live.

Wayland/Hyprland only — on X11 use `wmctrl`/`xdotool`. Window management is the
half of "computer use" that's reliable without pixel-clicking, so reach for this
before the visual loop.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill hyprland-control -g
```

## Requires

`hyprctl` (ships with Hyprland) and `jq`.
