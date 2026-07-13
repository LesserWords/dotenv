# vscode/

Editor preferences for Visual Studio Code (and Cursor, which reads the same settings format).

## Structure

| File | Purpose |
|------|---------|
| `settings.json` | Workbench, editor, terminal, Git UI defaults |
| `keybindings.json` | Custom keyboard shortcuts |
| `extensions.md` | Recommended extensions + one-shot install script |

## Quick use

**Copy** (simple, no symlink):

```powershell
# Windows — adjust path if using Cursor
Copy-Item settings.json "$env:APPDATA\Code\User\settings.json"
Copy-Item keybindings.json "$env:APPDATA\Code\User\keybindings.json"
```

```sh
# macOS
cp settings.json ~/Library/Application\ Support/Code/User/settings.json
cp keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
```

**Symlink** (repo stays source of truth):

```powershell
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Code\User\settings.json" -Target "$PWD\settings.json" -Force
```

**Install extensions** (PowerShell, from repo root):

```powershell
# See extensions.md for the full list
code --install-extension Terpsikhore.terpsikhore-theme
code --install-extension PKief.material-icon-theme
# …
```

Or run the loop in `extensions.md`.

## Notable defaults

- Color theme: **Terpsikhore Dark** (change in `settings.json`)
- Font: JetBrains Mono with ligatures
- Format on save via Prettier
- Minimap off, bracket pair colorization on

Merge with existing settings rather than overwriting blindly if you already have a setup.
