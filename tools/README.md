# tools/

Shared configuration for CLI tooling (not shell-specific).

## Structure

| File | Tool | Purpose |
|------|------|---------|
| `.npmrc` | npm | Registry, save prefs, audit defaults |

## Quick use

**Automated**

| Platform | Script | Target |
|----------|--------|--------|
| Windows | `setup.ps1` | `%USERPROFILE%\.npmrc` |
| Linux / macOS | `install.sh` | `~/.npmrc` |

**Manual**

```sh
ln -sf /path/to/configs/tools/.npmrc ~/.npmrc
```

Verify:

```sh
npm config list
```

## Adding more tools

Place dotfiles here (e.g. `.yarnrc.yml`, `pip.conf` template) and extend `setup.ps1` / `install.sh` with a `link_file` call when you want them symlinked automatically.
