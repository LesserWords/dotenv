# shell/

Interactive shell setup: aliases, prompt, and environment variables.

## Structure

| File | Platform | Purpose |
|------|----------|---------|
| `Microsoft.PowerShell_profile.ps1` | Windows | PowerShell 7+ profile (aliases, `$env:EDITOR`, Starship) |
| `.bashrc_template` | Linux / macOS | Bash aliases and Starship init |
| `starship.toml` | All | [Starship](https://starship.rs) prompt theme |

## Quick use

### Windows (automated)

From repo root:

```powershell
.\setup.ps1
```

Links `Microsoft.PowerShell_profile.ps1` → `$PROFILE`.

Requires [Starship](https://starship.rs) for the prompt block to run (`winget install Starship.Starship`).

### Linux / macOS (automated)

```sh
./install.sh
```

Links `.bashrc_template` → `~/.bashrc` and `starship.toml` → `~/.config/starship.toml`.

### Manual

```powershell
# PowerShell — see current profile path
echo $PROFILE
New-Item -ItemType SymbolicLink -Path $PROFILE -Target ".\shell\Microsoft.PowerShell_profile.ps1" -Force
```

```sh
cp shell/.bashrc_template ~/.bashrc
mkdir -p ~/.config && ln -sf "$(pwd)/shell/starship.toml" ~/.config/starship.toml
```

Restart the shell after changes.
