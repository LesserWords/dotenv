# Model selection strategy

Use the **smallest/cheapest model that can complete the task reliably**. Escalate only when stuck or when the task needs deep reasoning.

| Tier | When to use | Examples (2026) |
|------|-------------|------------------|
| **Fast** | Typos, renames, single-file edits, grep-and-fix | Haiku-class, “fast” composer modes |
| **Default** | Most feature work, multi-file refactors, tests | Sonnet-class |
| **Heavy** | Architecture, subtle bugs, large cross-cutting refactors, security review | Opus-class, “thinking” / high-reasoning modes |

## Rules

- Start default; switch up if two reasonable attempts fail on the same blocker
- Switch down for mechanical follow-ups (format, rename, apply review nit)
- Prefer **Plan mode** (read-only) before large ambiguous builds
- Prefer **subagents / Task tool** for broad repo exploration to save main context
- Do not use the heaviest model for docs-only or config-only edits

## Tool mapping

| Tool | Config file | Notes |
|------|-------------|--------|
| Claude Code | `claude/CLAUDE.md` | Model aliases at bottom of file |
| Cursor | Settings → Models | Match tier intent, not exact ID |
| Copilot | VS Code model picker | Lighter for inline complete, heavier for agent |

Update model IDs in `claude/CLAUDE.md` when vendors rename releases; keep **strategy** here.
