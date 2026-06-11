#!/usr/bin/env bash
# Symlink every skill in this repo into ~/.claude/skills.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")/../skills" && pwd)"
dest="$HOME/.claude/skills"

mkdir -p "$dest"
for skill in "$src"/*/; do
  ln -sfn "${skill%/}" "$dest/$(basename "$skill")"
done
echo "Linked skills into $dest"
