---
name: visual-computer-use-loop
description: >-
  Operate the Hyprland desktop the way a human would — look at the screen, decide
  the next action, do it, then look again to confirm. Combines screen-capture
  (see), hyprland-control (windows/workspaces), and gui-input-automation
  (click/type) into one observe → reason → act → verify loop with coordinate
  calibration. Use for GUI tasks no CLI can do.
allowed-tools: Bash Read
---

# Visual Computer-Use Loop (Hyprland / Wayland)

Drive the real desktop in a tight loop: **observe → reason → act → verify.**
This is the local equivalent of Claude's computer use, built from three skills:

- **screen-capture** — the eyes (`grim`/`slurp`).
- **gui-input-automation** — the hands (`wtype` keyboard, `ydotool` mouse).
- **hyprland-control** — windows, workspaces, focus (`hyprctl`).

Use it only when there's no CLI/API path — most tasks (files, git, builds) should
go through the shell, which is faster and more reliable than clicking. Reach for
this for genuinely GUI-only things: a desktop app with no CLI, a stubborn web UI,
visual verification.

## Before the loop: calibrate coordinates (do once per session)

Screenshots are in **physical** pixels; the cursor is in **logical** pixels. If
the monitor is scaled they differ.

```bash
SCALE=$(hyprctl monitors -j | jq -r '.[] | select(.focused).scale')
echo "scale = $SCALE"   # if 1, screenshot pixels == cursor coordinates
```

To click a feature you located at screenshot pixel `(px, py)`:
`cursor_x = px / SCALE`, `cursor_y = py / SCALE` (plus the monitor's `position`
offset on multi-monitor). Sanity-check once: move to a known target, screenshot,
confirm the cursor landed on it.

## The loop

1. **Observe** — capture the relevant area and Read it:
   ```bash
   geom=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
   grim -g "$geom" /tmp/cu.png
   ```
   Then Read `/tmp/cu.png`. Describe what's on screen and where the target is, in
   pixels.

2. **Reason** — decide the single next action and the exact target. State it
   ("click the blue 'Save' button at ~1180,840") before doing it. One action at a
   time.

3. **Act** — the smallest possible step:
   - Focus first: `hyprctl dispatch focuswindow class:…`
   - Keyboard: `wtype "text"` / `wtype -k Return` / `wtype -M ctrl c -m ctrl`
   - Mouse: `ydotool mousemove -a -x $((px/SCALE)) -y $((py/SCALE)) && ydotool click 0xC0`
   - Navigate instead of clicking when you can — workspace switches, `movefocus`,
     and keyboard shortcuts are more reliable than pixel clicks.

4. **Verify** — capture again and Read it. Did the screen change as expected? If
   not, don't repeat blindly — re-observe and rethink. Never fire a second action
   assuming the first worked.

Repeat until the goal is reached or you're stuck.

## Rules

- **Shell first.** If the task can be done in a terminal, do that instead.
- **One action, then look.** No blind action chains — each click/type is followed
  by a screenshot.
- **Confirm risky actions.** Anything that submits, deletes, sends, pays, or is
  hard to undo: ask the user before clicking.
- **Prefer keyboard & window nav over pixel clicks** — they survive layout shifts.
- **Re-calibrate** if the monitor, resolution, or scale changes mid-task.
- **Stop and ask** after 2-3 failed attempts on the same step rather than flailing.
- **Clean up** screenshot files when done.

## Prerequisites

`grim`, `slurp`, `wtype` (ready), and `ydotool` set up for the mouse (see
gui-input-automation for the one-time uinput/daemon setup). Without ydotool you
can still do keyboard-only automation (`wtype`) plus window control (`hyprctl`).

## Pairs with

- **screen-capture**, **gui-input-automation**, **hyprland-control** — the parts.
- **clipboard-and-notifications** — `notify-send` when the task finishes or needs
  you.
