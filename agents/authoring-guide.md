# AGENTS.md authoring guide

How **you** write agent context — separate from the per-project [template](../templates/AGENTS.md.template).

## Principles

- **Actionable**: every bullet should change agent behavior
- **Verifiable**: commands are copy-paste tested on your machine
- **Stable**: avoid churning prose; update when the repo actually changes
- **Short**: target 50–150 lines at repo root; split by package in monorepos

## Global vs project

| Scope | Location | Content |
|-------|----------|---------|
| Global taste | `preferences/universal.md` | How you want all agents to behave |
| Project ops | `<repo>/AGENTS.md` | This repo’s commands and boundaries |
| Package ops | `<repo>/packages/foo/AGENTS.md` | Overrides for that package only |

Do **not** put global preferences in every repo’s `AGENTS.md` — sync from configs once.

## Section checklist

Use [templates/AGENTS.md.template](../templates/AGENTS.md.template) and include:

- [ ] Overview (stack, one paragraph)
- [ ] Setup + command table
- [ ] Layout map (only non-obvious dirs)
- [ ] Conventions (only deltas from your universal prefs)
- [ ] Do-not-touch list
- [ ] Testing + PR expectations

## Optional: CONTEXT.md

Keep **commands and boundaries** in `AGENTS.md`. Put **domain jargon** in a root [`CONTEXT.md`](../templates/CONTEXT.md.template) when the project has overloaded terms agents get wrong.

- One preferred term per concept; list rejects under `_Avoid_`
- Project-specific language only — not general programming concepts
- Link it from `AGENTS.md` → Related docs
- Multi-context monorepos: optional `CONTEXT-MAP.md` pointing at per-area glossaries

## Nested AGENTS.md

```
repo/
  AGENTS.md              # workspace scripts, shared CI
  apps/web/AGENTS.md       # Next.js-specific test filter
  packages/api/AGENTS.md   # API integration test env vars
```

Agent working in `apps/web/` should prefer `apps/web/AGENTS.md` for commands that differ from root.

## Linking other tools

| Tool | Equivalent |
|------|------------|
| Cursor | `AGENTS.md` + `.cursor/rules/*.mdc` |
| Claude Code | `CLAUDE.md` (can symlink or duplicate overview) |
| Copilot | Reads `AGENTS.md` in many setups |

Optional symlink (Unix):

```sh
ln -sf templates/AGENTS.md.template AGENTS.md
```

Fill placeholders before committing.

## Maintenance triggers

Update `AGENTS.md` when:

- CI command or package manager changes
- Agent repeats the same mistake twice
- New “generated” or vendor directory must stay read-only
- Default branch or monorepo filter changes
