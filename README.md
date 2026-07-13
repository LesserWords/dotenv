# dotenv

A personal **dotfiles and dev-environment** repository: editor settings, shell prompts, terminal themes, Git defaults, AI assistant preferences, and a publishable VS Code color theme (**Terpsikhore**).

Everything here is meant to be **copied, symlinked, or included** on a new machine — not installed as a single monolithic app. Pick what you need per platform.

## Quick start

### Windows

From an elevated or Developer Mode shell (symlinks need permission):

```powershell
git clone https://github.com/LesserWords/dotenv.git
cd dotenv
.\setup.ps1          # skips existing real files; use -Force to backup + replace
```

Then wire up the pieces that are not automated (see folder READMEs below):

- **AI tools** — `.\sync.ps1` or `./sync.sh`
- **Git** — include `git/.gitconfig`, then set your real `user.email` locally (template uses `you@example.com`)
- **VS Code** — copy or symlink `vscode/settings.json` and `keybindings.json`
- **Theme** — install from Marketplace or run F5 in `themes/lesser-words-theme/`

### Linux / macOS

```sh
git clone https://github.com/LesserWords/dotenv.git
cd dotenv
chmod +x install.sh
./install.sh         # skips existing real files; use --force to backup + replace
```

`install.sh` symlinks shell, terminal, and npm settings, then reminds you to run `./sync.sh`. Git and VS Code are manual (documented per folder).

### Packages (optional)

Bootstrap CLI apps before dotfiles:

| Platform | File | Command |
|----------|------|---------|
| Windows | `packages/winget-export.json` | `winget import packages/winget-export.json` |
| macOS / Linux | `packages/Brewfile` | `brew bundle install --file=packages/Brewfile` |

## Repository layout

| Folder | What it holds | README |
|--------|----------------|--------|
| [`themes/`](themes/README.md) | Terpsikhore Theme VS Code extension | [themes/README.md](themes/README.md) |
| [`vscode/`](vscode/README.md) | Editor settings, keybindings, extension list | [vscode/README.md](vscode/README.md) |
| [`process/`](process/README.md), [`preferences/`](preferences/universal.md), [`skills/`](skills/README.md), [`templates/`](templates/) | **SSOT** — plan/design/code/test, prefs, `karpathy-guidelines`, templates | [WORKFLOW.md](WORKFLOW.md) |
| [`git/`](git/README.md) | Global `.gitconfig` and `.gitignore_global` | [git/README.md](git/README.md) |
| [`shell/`](shell/README.md) | Bash template, PowerShell profile, Starship | [shell/README.md](shell/README.md) |
| [`terminal/`](terminal/README.md) | Alacritty, Windows Terminal | [terminal/README.md](terminal/README.md) |
| [`tools/`](tools/README.md) | Shared tool config (e.g. npm) | [tools/README.md](tools/README.md) |
| [`packages/`](packages/README.md) | Winget / Homebrew manifests | [packages/README.md](packages/README.md) |

Root scripts:

| File | Role |
|------|------|
| [`setup.ps1`](setup.ps1) | Windows symlinks (PowerShell profile, Windows Terminal, `.npmrc`) |
| [`install.sh`](install.sh) | Linux/macOS symlinks (bash, Starship, Alacritty, `.npmrc`) |
| [`sync.ps1`](sync.ps1) / [`sync.sh`](sync.sh) | Merge AI prefs + process into Claude / Cursor |
| [`.editorconfig`](.editorconfig) | Shared indent/charset defaults — copy to home or per-project |

## Terpsikhore Theme (highlights)

Two variants, both Solarized-inspired:

- **Terpsikhore Light** — cream / beige UI
- **Terpsikhore Dark** — warm brown base with light tan accents

Marketplace: `ext install Terpsikhore.terpsikhore-theme`

Local development: see [themes/lesser-words-theme/README.md](themes/lesser-words-theme/README.md).

## Philosophy

- **Small, explicit files** over one giant config
- **Symlinks where safe** so edits in the repo apply immediately
- **Secrets stay out of git** — edit `user.email` and tokens locally
- **Platform splits** — Windows uses `setup.ps1` + PowerShell; Unix uses `install.sh` + bash

## License

Personal configs — use or fork freely; no warranty.
