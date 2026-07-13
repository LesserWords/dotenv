# packages/

Machine bootstrap manifests — install **applications and CLIs** before applying dotfiles from the rest of the repo.

## Structure

| File | Platform | Tool |
|------|----------|------|
| `winget-export.json` | Windows | [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/) |
| `Brewfile` | macOS / Linux | [Homebrew](https://brew.sh) + `brew bundle` |

## Quick use

### Windows

```powershell
# From repo root — review JSON first, then:
winget import -i packages\winget-export.json
```

Includes VS Code, Git, PowerShell, Starship, Windows Terminal, and others (see file for full list).

Export your current machine to refresh the manifest:

```powershell
winget export -o packages\winget-export.json
```

### macOS / Linux

```sh
# Install Homebrew if needed: https://brew.sh
brew bundle install --file=packages/Brewfile
```

Uncomment `cask` lines in `Brewfile` for GUI apps (VS Code, fonts, etc.).

## Order of operations on a new PC

1. `packages/` — OS packages
2. `setup.ps1` or `install.sh` — symlinks
3. `git/`, `vscode/`, AI sync (`./sync.sh` / `.\sync.ps1`) — manual copy/include per folder README
