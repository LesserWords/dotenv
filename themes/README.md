# themes/

VS Code color themes shipped as extensions.

## Structure

```
themes/
└── lesser-words-theme/          # Terpsikhore Theme extension (folder name is legacy)
    ├── package.json             # Extension manifest
    ├── themes/
    │   ├── lesser-words-theme-color-theme.json   # Terpsikhore Light
    │   ├── lesser-words-theme-dark.json          # Terpsikhore Dark
    │   └── solarized-light.json                  # Reference / upstream base
    └── README.md
```

## Quick use

**From Marketplace**

```sh
code --install-extension Terpsikhore.terpsikhore-theme
```

Then: Command Palette → **Preferences: Color Theme** → **Terpsikhore Light** or **Terpsikhore Dark**.

**Local development**

```sh
cd themes/lesser-words-theme
npm install -g @vscode/vsce   # once
code .                        # open folder
# F5 → Extension Development Host
```

Package a `.vsix`:

```sh
vsce package
code --install-extension terpsikhore-theme-0.1.0.vsix
```

Publish: `vsce publish` (requires Marketplace publisher token).

Details: [lesser-words-theme/README.md](lesser-words-theme/README.md).
