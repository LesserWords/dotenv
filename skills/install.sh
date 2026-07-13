#!/usr/bin/env bash
# Symlink versioned skills from skills/*/ to ~/.cursor/skills/
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}"

mkdir -p "$TARGET"

for skill_dir in "$ROOT"/*/; do
  [[ -f "${skill_dir}SKILL.md" ]] || continue
  name="$(basename "$skill_dir")"
  [[ "$name" == "install.sh" ]] && continue
  dest="$TARGET/$name"
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "skip $name — $dest exists and is not a symlink" >&2
    continue
  fi
  ln -sfn "$(cd "$skill_dir" && pwd)" "$dest"
  echo "linked $name → $dest"
done

echo "Done. Skills in: $TARGET"
echo "Also available for Claude Code when SKILL.md is on disk at this path."
