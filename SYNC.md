# Syncing AI config (single source of truth)

Edit **`preferences/`** first. Tool-specific files are **downstream**.

Works on **Windows** (`sync.ps1`) and **Linux / macOS** (`sync.sh`).

Install versioned skills first: [skills/install.sh](skills/install.sh) / [skills/install.ps1](skills/install.ps1).

## Source files (merge order)

| File | Contents |
|------|----------|
| [preferences/universal.md](preferences/universal.md) | Cross-phase communication, security, process index |
| [process/1-planning.md](process/1-planning.md) | Planning phase |
| [process/2-design.md](process/2-design.md) | Design phase |
| [process/3-coding.md](process/3-coding.md) | Coding phase (+ karpathy invoke) |
| [process/4-testing.md](process/4-testing.md) | Testing phase |
| [preferences/languages.md](preferences/languages.md) | TS, Python, CSS, shell |
| [claude/CLAUDE.md](claude/CLAUDE.md) | Models section only (extracted) |
| [preferences/models.md](preferences/models.md) | Model tier strategy (reference, not merged) |

## Targets

| Tool | Destination | What to copy |
|------|-------------|--------------|
| **Cursor (global)** | `~/.cursor/rules/global-standards.mdc` or Settings → Rules | `universal.md` + `languages.md` |
| **Cursor (project)** | `.cursor/rules/*.mdc` | Slices from templates; project facts in `AGENTS.md` |
| **Claude Code** | `~/.claude/CLAUDE.md` | Merged by sync script |
| **Copilot** | Repo `AGENTS.md` + VS Code settings | `AGENTS.md` from template |
| **Any agent** | Repo root `AGENTS.md` | [templates/AGENTS.md.template](templates/AGENTS.md.template) |

## Automated sync (recommended)

### Linux / macOS

```sh
cd /path/to/dotenv
chmod +x sync.sh
./sync.sh              # prompts before writing ~/.claude/CLAUDE.md
./sync.sh --yes        # non-interactive Claude + Cursor global rule
./sync.sh --cursor     # also write ~/.cursor/rules/global-standards.mdc
```

### Windows (PowerShell)

```powershell
cd path\to\dotenv
.\sync.ps1
.\sync.ps1 -Yes -Cursor
```

`sync.ps1` writes Claude only by default; use `-Cursor` (or `sync.sh --cursor` on Unix) for the global `.mdc` file.

## Manual sync

### Claude (`~/.claude/CLAUDE.md`)

```sh
# Linux / macOS — from repo root
{
  echo "# AUTO: synced from dotenv — edit preferences/* instead"
  echo
  cat preferences/universal.md
  echo
  echo "---"
  echo
  cat preferences/languages.md
  echo
  echo "---"
  echo
  awk '/^## Models/{found=1} found' claude/CLAUDE.md
} > ~/.claude/CLAUDE.md
```

```powershell
# Windows
$root = "path\to\dotenv"
@(
  "# AUTO: synced from dotenv — edit preferences/* instead", "",
  (Get-Content "$root\preferences\universal.md" -Raw),
  "---", "",
  (Get-Content "$root\preferences\languages.md" -Raw),
  "---", "",
  ((Get-Content "$root\claude\CLAUDE.md" -Raw) -replace '(?s)^.*?(## Models)','$1')
) | Set-Content "$env:USERPROFILE\.claude\CLAUDE.md"
```

### Cursor global rule (Linux / macOS)

```sh
mkdir -p ~/.cursor/rules
cat > ~/.cursor/rules/global-standards.mdc <<'EOF'
---
description: Global coding standards (synced from dotenv)
alwaysApply: true
---
EOF
cat preferences/universal.md >> ~/.cursor/rules/global-standards.mdc
echo >> ~/.cursor/rules/global-standards.mdc
cat preferences/languages.md >> ~/.cursor/rules/global-standards.mdc
```

### Windows Cursor

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cursor\rules" | Out-Null
# Prefer: .\sync.ps1 -Yes -Cursor — or paste into Settings → Rules
```

## Symlinks (advanced)

```sh
# Per-project AGENTS.md from template
ln -sf /path/to/dotenv/templates/AGENTS.md.template ./AGENTS.md

# Project CLAUDE.md → universal (only if you want repo-level SSOT)
ln -sf /path/to/dotenv/preferences/universal.md ./CLAUDE.md
```

```powershell
New-Item -ItemType SymbolicLink -Path .\CLAUDE.md -Target .\preferences\universal.md
```

## Bootstrap with dotfiles install

From repo root after clone:

```sh
./install.sh            # shell, terminal, npmrc symlinks
./skills/install.sh     # karpathy-guidelines → ~/.cursor/skills/
./sync.sh               # prefs + process phases (prompts before overwrite)
```

```powershell
.\setup.ps1
.\skills\install.ps1
.\sync.ps1
```

## When to sync

- After changing `preferences/*`
- After adding a skill to [skills/registry.md](skills/registry.md)
- New machine: clone dotenv → `install.sh` / `setup.ps1` → `sync.sh` / `sync.ps1`

## Do not sync

- Project-specific `AGENTS.md` (stays in each repo)
- Feature `design.md` files (per task)
- `~/.cursor/skills-cursor/` (Cursor built-ins)
