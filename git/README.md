# git/

Global Git configuration and ignore patterns.

## Structure

| File | Purpose |
|------|---------|
| `.gitconfig` | User identity, aliases, pull/rebase, merge, colors |
| `.gitignore_global` | Patterns ignored in every repo (`core.excludesfile`) |

## Quick use

**Option A — include from existing `~/.gitconfig`** (recommended):

```ini
# ~/.gitconfig
[include]
  path = /path/to/dotenv/git/.gitconfig

[core]
  excludesfile = /path/to/dotenv/git/.gitignore_global
```

On Windows, use a forward-slash path, e.g. `C:/path/to/dotenv/git/.gitconfig`.

**Option B — symlink** (repo is the only config):

```sh
ln -sf /path/to/dotenv/git/.gitconfig ~/.gitconfig
```

**Global ignore file**

Add to `.gitconfig` (or the included file):

```ini
[core]
  excludesfile = ~/.gitignore_global
```

Then symlink or copy `git/.gitignore_global` to `~/.gitignore_global`.

## Before first commit

1. Copy or include this template, then set **your** `user.name` / `user.email` in **local** `~/.gitconfig` (or override after include).
2. Keep real emails out of this repo — the committed template uses `you@example.com`.
3. Do not commit tokens or machine-specific absolute paths.

## Handy aliases (defined here)

| Alias | Command |
|-------|---------|
| `git st` | Short status |
| `git lg` | Graph log |
| `git wip` | Commit **staged** files with message `wip` (does not `git add -A`) |
| `git undo` | Soft reset last commit |

**Caution:** `git wip` only commits what you already staged. That is intentional so secrets are not scooped up by a blind `add -A`.
