---
name: gui-input-automation
description: >-
  Send synthetic keyboard and mouse input on Wayland/Hyprland — type text, press
  key combos, move the cursor, click, scroll, drag. Use wtype for keyboard
  (no setup, rootless) and ydotool for the mouse (needs a one-time uinput/daemon
  setup the skill walks through). The "hands" for visual computer use. Wayland
  only — xdotool does not work here.
allowed-tools: Bash Read
---

# GUI Input Automation (Wayland / Hyprland)

Two tools, split by what they do best on Wayland:

- **wtype** — keyboard: type text, press keys and modifier combos. Rootless, no
  daemon, uses the virtual-keyboard protocol Hyprland supports. **Prefer this for
  anything keyboard.**
- **ydotool** — mouse: move, click, scroll, drag (and keyboard via uinput if you
  need global input). Needs `/dev/uinput` access and a running `ydotoold`.

Both packages are in the official repo: `sudo pacman -S wtype ydotool`.

## Keyboard with wtype (no setup)

```bash
wtype "hello world"            # type a string into the focused window
wtype -k Return               # press a named key (Tab, Escape, Left, BackSpace…)
wtype -k Tab
wtype -M ctrl c -m ctrl       # Ctrl+C  (-M press modifier, -m release)
wtype -M ctrl -M shift t -m shift -m ctrl   # Ctrl+Shift+T
```

Focus the target window first (see hyprland-control) — input goes to whatever is
focused. Add a small wait after focusing before typing.

## Mouse with ydotool — one-time setup

Your user is **not** in the `input` group yet, so do this once:

```bash
# 1. udev rule so /dev/uinput is group-accessible
echo 'KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"' \
  | sudo tee /etc/udev/rules.d/80-uinput.rules
sudo udevadm control --reload && sudo udevadm trigger

# 2. add yourself to the input group, then RE-LOGIN (or reboot) for it to apply
sudo usermod -aG input "$USER"
```

Then run the daemon (re-run after each login, or enable a service):

```bash
ydotoold &                                   # manual
# if a unit ships with the package:
systemctl --user enable --now ydotool 2>/dev/null || systemctl --user status ydotool
```

Verify it's working:

```bash
ydotool mousemove --absolute -x 100 -y 100   # cursor should jump to (100,100)
```

If the client errors with a socket problem, find the socket ydotoold created and
export it: `export YDOTOOL_SOCKET=$XDG_RUNTIME_DIR/.ydotool_socket` (or
`/tmp/.ydotool_socket`), then retry.

## Mouse actions

```bash
ydotool mousemove --absolute -x 960 -y 540   # move to absolute pixel (compositor space)
ydotool mousemove -x 20 -y 0                 # move relative
ydotool click 0xC0                           # left click   (0xC1 right, 0xC2 middle)
ydotool click --repeat 2 --next-delay 25 0xC0  # double-click
ydotool mousemove -a -x 500 -y 500 && ydotool click 0xC0   # move then click

# drag: press at A, move to B, release
ydotool click 0x40   # press-left only (0x40)
ydotool mousemove -a -x 800 -y 600
ydotool click 0x80   # release-left only (0x80)
```

Button byte = `0x80` press-bit `| 0x40` release-bit `|` button (`0`=left,
`1`=right, `2`=middle). So `0xC0` = full left click, `0x40`=press, `0x80`=release.

## Coordinate space — read this before clicking from a screenshot

`ydotool mousemove --absolute` uses compositor **logical** pixels — the same space
as `hyprctl cursorpos`. A `grim` screenshot is in **physical** pixels. If the
monitor `scale ≠ 1`, convert: `logical = screenshot_pixel / scale`. Get scale
from `hyprctl monitors -j | jq '.[].scale'`. Calibrate once: move to a known
target, screenshot, check the offset. The visual-computer-use-loop skill bakes
this in.

## Safety

- Synthetic input acts on the **real** desktop — it can click anything.
- Confirm before clicks that submit, delete, or pay. Move slowly, one action at a
  time, and verify with a screenshot after each (see visual-computer-use-loop).
- `wtype` is harmless to set up; `ydotool` grants uinput input injection — only
  enable it knowingly.

## Pairs with

- **hyprland-control** — focus the right window before typing.
- **screen-capture** — see the target and confirm the result.
- **visual-computer-use-loop** — the full see-think-act cycle.
