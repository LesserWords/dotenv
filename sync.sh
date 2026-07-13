#!/usr/bin/env bash
# Merges preferences + process phases into ~/.claude/CLAUDE.md and optional Cursor global rule
# Usage: ./sync.sh [--yes] [--cursor]
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUTO_YES=false
SYNC_CURSOR=false

for arg in "$@"; do
  case "$arg" in
    --yes|-y) AUTO_YES=true ;;
    --cursor) SYNC_CURSOR=true ;;
    -h|--help)
      echo "Usage: $0 [--yes] [--cursor]"
      exit 0
      ;;
  esac
done

UNIVERSAL="$ROOT/preferences/universal.md"
LANGUAGES="$ROOT/preferences/languages.md"
CLAUDE_SRC="$ROOT/claude/CLAUDE.md"
CLAUDE_TARGET="${CLAUDE_TARGET:-$HOME/.claude/CLAUDE.md}"
CURSOR_RULE="${CURSOR_RULE:-$HOME/.cursor/rules/global-standards.mdc}"

die() { echo "error: $*" >&2; exit 1; }
[[ -f "$UNIVERSAL" ]] || die "missing $UNIVERSAL"
[[ -f "$LANGUAGES" ]] || die "missing $LANGUAGES"
[[ -f "$CLAUDE_SRC" ]] || die "missing $CLAUDE_SRC"

models="$(awk '/^## Models/{found=1} found' "$CLAUDE_SRC")"

# Ordered process phases
PROCESS_FILES=()
for f in "$ROOT/process/"[0-9]*.md; do
  [[ -f "$f" ]] && PROCESS_FILES+=("$f")
done

append_file() {
  local f="$1"
  [[ -f "$f" ]] || return 0
  printf '\n---\n\n'
  cat "$f"
}

build_body() {
  cat <<EOF
# Claude Code — synced from dotenv
# Source: preferences/universal.md + process/* + languages.md + models
# Re-run: sync.sh — edit preferences/ and process/ instead of this file.

EOF
  cat "$UNIVERSAL"
  local f
  for f in "${PROCESS_FILES[@]}"; do append_file "$f"; done
  append_file "$LANGUAGES"
  printf '\n---\n\n'
  printf '%s\n' "$models"
}

build_cursor_mdc() {
  cat <<'EOF'
---
description: Global standards — planning, design, coding, testing (dotenv)
alwaysApply: true
---

EOF
  cat "$UNIVERSAL"
  local f
  for f in "${PROCESS_FILES[@]}"; do
    printf '\n\n'
    cat "$f"
  done
  printf '\n\n'
  cat "$LANGUAGES"
}

preview="$(build_body)"
echo "=== Preview (first 40 lines) ==="
echo "$preview" | head -n 40
echo ""
echo "Claude target: $CLAUDE_TARGET"

write_claude=false
if $AUTO_YES; then write_claude=true
else
  read -r -p "Write to ~/.claude/CLAUDE.md? [y/N] " reply
  case "$reply" in [yY]|[yY][eE][sS]) write_claude=true ;; esac
fi

if $write_claude; then
  mkdir -p "$(dirname "$CLAUDE_TARGET")"
  if [[ -f "$CLAUDE_TARGET" ]]; then
    bak="${CLAUDE_TARGET}.bak.$(date +%Y%m%d%H%M%S)"
    cp -a "$CLAUDE_TARGET" "$bak"
    echo "Backup: $bak"
  fi
  build_body >"$CLAUDE_TARGET"
  echo "Wrote $CLAUDE_TARGET"
else
  echo "Skipped Claude write."
fi

if $SYNC_CURSOR || $AUTO_YES; then
  mkdir -p "$(dirname "$CURSOR_RULE")"
  if [[ -f "$CURSOR_RULE" ]]; then
    bak="${CURSOR_RULE}.bak.$(date +%Y%m%d%H%M%S)"
    cp -a "$CURSOR_RULE" "$bak"
    echo "Backup: $bak"
  fi
  build_cursor_mdc >"$CURSOR_RULE"
  echo "Wrote $CURSOR_RULE"
else
  echo "Re-run with --cursor for ~/.cursor/rules/global-standards.mdc"
fi

echo "Skills: ./skills/install.sh"
echo "See SYNC.md for AGENTS.md templates."
