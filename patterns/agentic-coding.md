# Agentic coding patterns (reference)

Condensed from [agents.md](https://agents.md), AAIF / open-agent standards, and common 2025–2026 practice.  
**Your** operational rules: [WORKFLOW.md](../WORKFLOW.md) and [preferences/universal.md](../preferences/universal.md).

## Core ideas

1. **Context is finite** — put only what agents cannot infer into `AGENTS.md`; link the rest.
2. **Closest wins** — nested `AGENTS.md` in monorepo packages overrides root for files under that path.
3. **Docs are control plane** — when an agent errs, update instructions before re-prompting the same fix.
4. **Verify in the loop** — agents should run listed test/lint commands, not assume green builds.
5. **Specialize phases** — explore → plan → implement → review; different modes/models per phase.

## Pattern catalog

### Context layering

| Layer | File | Stability |
|-------|------|-----------|
| Human taste | `preferences/universal.md` | Rarely changes |
| Repo ops | `AGENTS.md` | Per repo, evolves |
| Feature | `design.md` | Per task, archived or deleted |

### Plan → implement

- **Plan mode** (read-only): architecture, file list, risks — no edits.
- **Agent mode**: execute approved plan only.
- Reduces scope creep and bad edits on unfamiliar code.

### Subagent / delegation

- **Explorer**: locate symbols, map directories — return file:line table, no fixes.
- **Builder**: 1–2 file surgical edits.
- **Reviewer**: diff-only feedback, severity tags.
- Parent agent synthesizes; avoids stuffing exploration into main context.

### Skills

- Packaged `SKILL.md` with `name` + `description` frontmatter.
- Trigger on explicit user phrase or strong description match.
- Good for: release checklist, design-map, commit message style, MCP workflows.

### MCP / tools

- Use when truth lives **outside** the repo (live docs, tickets, DB schema).
- Prefer repo `AGENTS.md` commands for build/test — no hallucinated scripts.

### Multi-agent (advanced)

- Coordinator drafts spec → implementor waves → verifier against spec.
- Requires discipline updating spec when implementation diverges.
- Overkill for small tasks; valuable for large refactors.

## Anti-patterns

| Anti-pattern | Why it hurts |
|--------------|--------------|
| 500-line `AGENTS.md` | Burns context every turn; split or link |
| Duplicating README | Drift; agents get conflicting instructions |
| Vague rules (“write clean code”) | Not machine-actionable |
| Auto-generated AGENTS.md never reviewed | Wrong commands, false confidence |
| Heavy model for all tasks | Cost, latency, no benefit |
| Skipping verify phase | Regressions ship |

## AGENTS.md high-value sections

Priority order for new repos:

1. Exact install / test / lint commands (copy-pasteable)
2. “Do not touch” paths
3. Stack one-liner + layout
4. PR/commit expectations
5. Security constraints

## Standards map

| Standard | Role |
|----------|------|
| [AGENTS.md](https://agents.md) | Repo instructions for coding agents |
| [MCP](https://modelcontextprotocol.io) | Tool/data access protocol |
| Cursor Rules `.mdc` | IDE-scoped, glob-based rules |
| Claude `CLAUDE.md` | Claude Code user/project memory |
| Agent Skills `SKILL.md` | Portable procedural workflows |

## Further reading

- https://agents.md — format and examples
- https://github.com/agentsmd/agents.md — spec repo
- Cursor: create-rule / create-skill skills (built-in) for `.mdc` and skills layout
