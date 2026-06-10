# gui-input-automation

Send synthetic **keyboard and mouse** input on **Wayland / Hyprland** — the
"hands" for computer use.

Split by what works best on Wayland:

- **wtype** for keyboard — type text, named keys, modifier combos. Rootless, no
  daemon, no setup.
- **ydotool** for the mouse — absolute/relative moves, clicks, double-click,
  drag, scroll. Needs a one-time `/dev/uinput` + `input` group + `ydotoold`
  setup, which the skill walks through (your user isn't in `input` yet).

Includes the logical-vs-physical **coordinate conversion** you need before
clicking from a screenshot, and safety rules for acting on the real desktop.

Wayland only — `xdotool` does not work here.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill gui-input-automation -g
```

## Requires

`sudo pacman -S wtype ydotool` (both in the official repo). `wtype` works
immediately; `ydotool` needs the one-time setup in the skill.
