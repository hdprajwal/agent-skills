---
name: screen-capture
description: >-
  Take screenshots on Wayland/Hyprland with grim + slurp — full screen, a chosen
  monitor, an interactive region, or the active window — and save to a file or
  pipe to the clipboard. Use whenever an agent needs to see the screen, capture
  UI state, grab a region for analysis, or produce an image to reason over. The
  "eyes" for visual computer use.
allowed-tools: Bash Read
---

# Screen Capture (Wayland / Hyprland)

`grim` captures; `slurp` selects a region interactively; `hyprctl` + `jq` give
geometry for non-interactive captures. Output goes to a file or to `wl-copy`.

Requires `grim` and `slurp` (both present on this machine). Wayland only — `scrot`
/`maim` won't work here.

## Full screen

```bash
grim ~/screenshot.png                 # focused output (or all, depending on setup)
grim -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused).name')" ~/focused-monitor.png
```

## Interactive region (you draw the box)

```bash
grim -g "$(slurp)" ~/region.png
```

## Active window — no interaction

```bash
geom=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
grim -g "$geom" ~/active-window.png
```

## Pick a specific window by class — no interaction

```bash
geom=$(hyprctl clients -j | jq -r '.[] | select(.class=="firefox") | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | head -1)
grim -g "$geom" ~/firefox.png
```

## To the clipboard (no file)

```bash
grim - | wl-copy --type image/png                    # full screen → clipboard
grim -g "$(slurp)" - | wl-copy --type image/png      # region → clipboard
```

## Smaller / compressed (good for feeding to a model)

```bash
grim -t jpeg -q 75 ~/shot.jpg        # JPEG at quality 75
grim -t png -l 6 ~/shot.png          # PNG compression level
```

## Reading it back

After saving, Read the image file to analyze it — that's how the agent "sees"
the result. Keep captures in `/tmp` or a scratch dir and clean up after.

## Gotchas

- **Scaling:** `grim` saves at the output's **physical** pixel resolution. If a
  monitor has `scale ≠ 1` (`hyprctl monitors -j | jq '.[].scale'`), image pixels
  = logical × scale. To turn a pixel you see in the screenshot into a cursor
  coordinate, divide by `scale`. This is the #1 mistake when clicking from a
  screenshot — see visual-computer-use-loop.
- **Multi-monitor:** without `-o`/`-g`, `grim` may stitch all outputs; pass `-o`
  for one monitor or `-g` for an exact box.
- **Timing:** capture *after* the UI has settled; add a brief wait after launching
  or focusing a window before grabbing it.

## Pairs with

- **hyprland-control** — geometry of windows/monitors to capture.
- **visual-computer-use-loop** — capture → reason → act → re-capture.
- **screen-recording** — for motion instead of a still (separate skill).
