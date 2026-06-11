---
name: hyprland-control
description: Inspect and control the Hyprland Wayland desktop from the shell via hyprctl — list/query windows, focus/move/resize/close them, switch and move things between workspaces, launch apps onto a target workspace, read monitor and cursor state. Use on Hyprland (Wayland) for any window or workspace management. Not for X11 (use wmctrl/xdotool there).
allowed-tools: Bash Read
---

# Hyprland Control

Drive the Hyprland desktop with `hyprctl`. Everything is queryable as JSON (`-j`)
and pipeable through `jq`, and every action is a `dispatch`.

Only works on Hyprland (`echo $XDG_CURRENT_DESKTOP` → `Hyprland`). On X11 use
`wmctrl`/`xdotool` instead.

## Query state (read-only, always safe)

```bash
hyprctl clients -j        # all windows: class, title, address, at[x,y], size[w,h], workspace, pid
hyprctl activewindow -j   # the focused window
hyprctl workspaces -j     # all workspaces
hyprctl activeworkspace -j
hyprctl monitors -j       # outputs: name, resolution, scale, position, focused
hyprctl cursorpos         # "X, Y" in logical pixels
hyprctl devices -j        # keyboards, mice
```

Useful extractions:

```bash
# active window class + title
hyprctl activewindow -j | jq -r '.class + " — " + .title'
# find a window's address by class
hyprctl clients -j | jq -r '.[] | select(.class=="firefox") | .address'
# list "class | title | workspace" for every window
hyprctl clients -j | jq -r '.[] | "\(.class)\t\(.title)\tws\(.workspace.id)"'
```

A window is targeted by a **selector**: `address:0x…` (most precise),
`class:…`, `initialclass:…`, `title:…`, `initialtitle:…`, or `pid:…`.

## Act (dispatch)

```bash
# focus
hyprctl dispatch focuswindow address:0x55feac7945f0
hyprctl dispatch focuswindow class:org.kde.konsole
hyprctl dispatch movefocus l            # l/r/u/d — focus neighbour

# workspaces
hyprctl dispatch workspace 3            # switch to workspace 3
hyprctl dispatch movetoworkspace 3      # move active window to ws 3 (and follow)
hyprctl dispatch movetoworkspacesilent 3,address:0x…   # move a specific window, don't follow

# move / resize the active (or addressed) window
hyprctl dispatch togglefloating         # floating windows can be placed freely
hyprctl dispatch movewindowpixel "exact 100 100,address:0x…"
hyprctl dispatch resizewindowpixel "exact 1280 800,address:0x…"
hyprctl dispatch fullscreen 1           # 0=full, 1=maximize
hyprctl dispatch closewindow address:0x…

# cursor
hyprctl dispatch movecursor 960 540     # absolute, logical pixels
```

## Launch an app (optionally onto a workspace)

```bash
hyprctl dispatch exec firefox
# launch silently onto workspace 4 without switching to it:
hyprctl dispatch exec "[workspace 4 silent] firefox"
# launch floating, centered:
hyprctl dispatch exec "[float; center] kitty"
```

After launching, poll `hyprctl clients -j` for the new window's address before
acting on it — it isn't there instantly.

## Batch several actions

```bash
hyprctl --batch "dispatch workspace 2 ; dispatch exec kitty ; dispatch movecursor 100 100"
```

## Runtime config tweaks

```bash
hyprctl keyword general:gaps_out 5      # change a setting live (not persisted)
hyprctl reload                          # reload hyprland.conf
```

## Notes & gotchas

- Coordinates are **logical pixels**. If a monitor has `scale ≠ 1`
  (`hyprctl monitors -j | jq '.[].scale'`), logical ≠ physical — matters when
  pairing with screenshots (see the screen-capture and visual-computer-use-loop
  skills).
- Multi-monitor: window `at` is global across all outputs; account for monitor
  `position` offsets.
- Tiled windows ignore pixel moves/resizes — `togglefloating` first.
- Confirm before `closewindow` on anything with unsaved work.

## Pairs with

- **screen-capture** — see what's on screen.
- **gui-input-automation** — click/type into the window you focused.
- **clipboard-and-notifications** — `notify-send` to report what you did.
