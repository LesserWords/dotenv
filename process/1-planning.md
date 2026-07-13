# Phase 1 — Planning

Before design or code. Use **Plan mode** (read-only) for ambiguous or large work.

## Outcomes

- Clear problem statement and constraints
- Explicit **success criteria** (verifiable, not “make it work”)
- Task size: **S** / **M** / **L** (see [WORKFLOW.md](../WORKFLOW.md))
- Written plan with verify step per step when multi-step

## Rules

- State assumptions; ask if uncertain — do not guess silently
- If multiple interpretations exist, list them; do not pick without user input
- If a simpler approach exists, say so before committing to a heavy path
- Push back on scope creep in the request; propose minimal viable slice
- No file edits in this phase (planning only)

## Plan format

```
1. [Step] → verify: [concrete check]
2. [Step] → verify: [concrete check]
```

Examples:

- “Add validation” → “Tests for invalid inputs fail, then pass after implementation”
- “Fix bug” → “Repro test fails on main, passes on branch”

## Artifacts

| Size | Artifact |
|------|----------|
| S | Chat plan only |
| M | Short plan in issue or comment |
| L | Plan in chat + outline in [planning.md.template](../templates/planning.md.template) |

## Skills

- For **M/L** work that is ambiguous or multi-interpretation: run **`grilling`** (or `/grill-me`) before locking the plan — one question at a time until shared understanding.
- Before proposing OpenSpec / Graphify adoption on a brownfield repo, invoke **`repo-assessment-openspec-graphify`** (assessment only — no installs until approval).

## Model hint

Prefer **heavy / thinking** tier for L-sized planning; **default** for M; **fast** only for S with known path. See [preferences/models.md](../preferences/models.md).

## Karpathy alignment

From [karpathy-guidelines](../skills/karpathy-guidelines/SKILL.md): **Think before coding** and **Goal-driven execution** (define success criteria up front).
