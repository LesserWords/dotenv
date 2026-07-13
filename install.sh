#!/usr/bin/env bash
# Bootstrap script for Linux/macOS to symlink configs.
# Usage: ./install.sh [--force]
# Without --force, existing non-symlink targets are skipped (symlinks are replaced).

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORCE=false

for arg in "$@"; do
  case "$arg" in
    --force|-f) FORCE=true ;;
    -h|--help)
      echo "Usage: $0 [--force]"
      exit 0
      ;;
  esac
done

echo -e "\033[0;36mSetting up Linux/macOS Configurations...\033[0m"
if ! $FORCE; then
  echo "Tip: pass --force to backup and replace existing non-symlink configs."
fi

backup_target() {
  local target=$1
  local bak="${target}.bak.$(date +%Y%m%d%H%M%S)"
  cp -a "$target" "$bak"
  echo "Backup: $bak"
}

link_file() {
  local source=$1
  local target=$2

  [[ -f "$source" ]] || return 0

  if [[ -e "$target" || -L "$target" ]]; then
    if [[ -L "$target" ]]; then
      rm -f "$target"
    elif $FORCE; then
      backup_target "$target"
      rm -rf "$target"
    else
      echo "skip — $target exists (use --force to backup and replace)" >&2
      return 0
    fi
  fi

  mkdir -p "$(dirname "$target")"
  echo "Linking $source to $target"
  ln -s "$source" "$target"
}

# 1. Shell configurations
link_file "$REPO_ROOT/shell/.bashrc_template" "$HOME/.bashrc"
link_file "$REPO_ROOT/shell/starship.toml" "$HOME/.config/starship.toml"

# 2. Terminal
link_file "$REPO_ROOT/terminal/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

# 3. Npmrc
link_file "$REPO_ROOT/tools/.npmrc" "$HOME/.npmrc"

# 4. AI tools reminder
if [[ -f "$REPO_ROOT/sync.sh" ]]; then
  chmod +x "$REPO_ROOT/sync.sh" 2>/dev/null || true
  chmod +x "$REPO_ROOT/skills/install.sh" 2>/dev/null || true
  echo -e "\033[0;33mNext: ./skills/install.sh && ./sync.sh\033[0m"
fi

echo -e "\033[0;32mSetup Complete!\033[0m"
