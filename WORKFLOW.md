# Agentic workflow strategy

Four phases — each has a **process doc** (SSOT) and optional **template**.

| Phase | Process doc | Template | Skills |
|-------|-------------|----------|--------|
| 1. Planning | [process/1-planning.md](process/1-planning.md) | [templates/planning.md.template](templates/planning.md.template) | `grilling` / `grill-me` |
| 2. Design | [process/2-design.md](process/2-design.md) | [templates/design.md.template](templates/design.md.template), [CONTEXT.md.template](templates/CONTEXT.md.template) | `grilling` / `grill-me`, `design-map` |
| 3. Coding | [process/3-coding.md](process/3-coding.md) | — | `karpathy-guidelines`, `diagnosing-bugs` |
| 4. Testing | [process/4-testing.md](process/4-testing.md) | [templates/testing.md.template](templates/testing.md.template) | `karpathy-guidelines`, `diagnosing-bugs` |
| Continuity | — | — | `handoff` |

Cross-cutting: [preferences/universal.md](preferences/universal.md) · Index: [process/README.md](process/README.md)

## Layered context

```
preferences/universal.md     ← always-on (communication, security)
process/1–4.md               ← phase rules (synced to tools)
AGENTS.md (repo)             ← project commands & boundaries
planning.md / design.md      ← per initiative (from templates)
testing.md                   ← verification record (optional)
.cursor/rules/*.mdc          ← file-type overrides
CONTEXT.md (per app repo)    ← optional domain glossary
SKILL.md (skills/)           ← grilling, diagnosing-bugs, karpathy-guidelines, …
```

## Standard loop

| Phase | You | Agent | Artifact |
|-------|-----|-------|----------|
| 1. Planning | Goal, constraints, success criteria | Clarify; no code | [planning.md.template](templates/planning.md.template) |
| 2. Design | Approve spec | Spec only; flag gaps | [design.md.template](templates/design.md.template) |
| 3. Coding | Available for decisions | Implement; **karpathy-guidelines** | PR / diff |
| 4. Testing | Run CI when possible | Verify; report commands run | [testing.md.template](templates/testing.md.template) |
| Learn | Update docs if agent repeated a mistake | — | `AGENTS.md` / `process/*` / `CONTEXT.md` |
| Handoff | Pause mid-work for a new session | `/handoff` → temp markdown | OS temp `agent-handoff-*.md` |

## Task sizing

| Size | Phases |
|------|--------|
| **S** | Planning (light) → Coding → Testing |
| **M** | Planning → Design (short) → Coding → Testing |
| **L** | Full planning → Full design → Coding → Testing + optional review subagent |

## Skills install (versioned in repo)

```sh
./skills/install.sh    # ~/.cursor/skills/karpathy-guidelines → repo copy
```

```powershell
.\skills\install.ps1
```

Registry: [skills/registry.md](skills/registry.md).

## Sync to tools

```sh
./sync.sh --yes --cursor
```

```powershell
.\sync.ps1 -Yes -Cursor
```

See [SYNC.md](SYNC.md).

## Definition of done (phase 4)

- [ ] Success criteria from planning/design checked off
- [ ] [process/4-testing.md](process/4-testing.md) checklist complete
- [ ] `AGENTS.md` commands run (or N/A documented)
- [ ] karpathy-guidelines: goal-driven criteria met
