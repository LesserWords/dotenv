# terminal/

Terminal emulator appearance and defaults.

## Structure

| File | Emulator | Notes |
|------|----------|--------|
| `windows-terminal-settings.json` | Windows Terminal | Profiles, colors, font — linked by `setup.ps1` |
| `alacritty.toml` | Alacritty | Linux/macOS — linked by `install.sh` |

## Quick use

### Windows Terminal

**Automated** (repo root):

```powershell
.\setup.ps1
```

Symlinks this file to:

`%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`

Close all Terminal windows before running; back up existing `settings.json` first if you care about local tweaks.

**Manual**: copy or symlink `windows-terminal-settings.json` to that path.

### Alacritty

**Automated** (Unix):

```sh
./install.sh
```

**Manual**:

```sh
mkdir -p ~/.config/alacritty
ln -sf /path/to/configs/terminal/alacritty.toml ~/.config/alacritty/alacritty.toml
```

## Tips

- Terminal colors complement **Terpsikhore**; align profile background with your VS Code theme if you want a matched desk.
- After editing JSON/TOML, restart the terminal app — hot reload support varies by version.
