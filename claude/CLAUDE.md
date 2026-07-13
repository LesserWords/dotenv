# Claude Code — global instructions (downstream)

> **SSOT:** [../preferences/universal.md](../preferences/universal.md) + [../process/](../process/README.md)  
> Sync: [../sync.sh](../sync.sh) / [../sync.ps1](../sync.ps1)

Full merged file is written to `~/.claude/CLAUDE.md` by sync. Edit source files above, not the merged output.

## Skills

```sh
./skills/install.sh   # karpathy-guidelines → ~/.cursor/skills/ (Claude can read SKILL.md on disk)
```

## Models

Strategy: [../preferences/models.md](../preferences/models.md)

| Role | Model |
|------|--------|
| Default | claude-sonnet-4-6 |
| Heavy reasoning | claude-opus-4-7 |
| Fast / cheap | claude-haiku-4-5 |

## Workflow

[../WORKFLOW.md](../WORKFLOW.md) — planning → design → coding → testing
