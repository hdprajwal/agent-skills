# screen-capture

Take screenshots on **Wayland / Hyprland** with `grim` + `slurp` so an agent can
*see* the screen.

Capture the full screen, a specific monitor, an interactive region you draw, or
the active/named window (geometry pulled from `hyprctl`). Save to a file or pipe
straight to the clipboard with `wl-copy`. Includes JPEG/PNG compression options
for feeding images to a model, and the physical-vs-logical pixel **scaling
gotcha** that trips up clicking from a screenshot.

Wayland only — `scrot`/`maim` won't work here.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill screen-capture -g
```

## Requires

`grim`, `slurp`, `jq`, and `wl-clipboard` (for clipboard output).
