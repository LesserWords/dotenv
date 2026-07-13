# AGENTS.md — dotenv (configs) repository

Dotfiles and dev-environment configs. AI workflow SSOT lives at repo root: [process/](process/), [preferences/](preferences/), [SYNC.md](SYNC.md).

## Overview

Personal **configs** repo: VS Code/Cursor settings, Terpsikhore theme extension, shell/terminal, Git, and agent preferences & templates. Not an application — no runtime server.

## Commands

| Task | Command |
|------|---------|
| Windows symlink setup | `.\setup.ps1` (repo root) |
| Linux/macOS symlink setup | `./install.sh` |
| Sync AI prefs (Windows) | `.\sync.ps1` |
| Sync AI prefs (Linux/macOS) | `./sync.sh` |
| Package theme VSIX | `cd themes/lesser-words-theme && vsce package` |

## Layout

| Path | Purpose |
|------|---------|
| `process/`, `preferences/`, `skills/`, `templates/` | Agent workflow SSOT |
| `themes/lesser-words-theme/` | Terpsikhore VS Code extension |
| `vscode/` | Editor settings & extension list |
| `git/` | Global gitconfig template |

## Conventions

- Process: [process/](process/) (planning → design → coding → testing)
- Cross-phase: [preferences/universal.md](preferences/universal.md)
- Skill: `karpathy-guidelines` — [skills/install.sh](skills/install.sh)
- Sync: [SYNC.md](SYNC.md)
- Do not commit secrets (emails in gitconfig are template — verify before public fork)

## Do not touch

- `~/.cursor/skills-cursor/` (Cursor built-ins; not in this repo)
- Generated `*.vsix` (gitignored)

## Testing

- Theme JSON: validate with `ConvertFrom-Json` / `vsce package`
- Scripts: run `setup.ps1` / `install.sh` only when user asks

## Related

- [WORKFLOW.md](WORKFLOW.md)
- [templates/design.md.template](templates/design.md.template)
