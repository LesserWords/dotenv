# Universal AI preferences

Cross-phase rules (always on). Phase-specific guidance: [../process/README.md](../process/README.md).

Sync via [../SYNC.md](../SYNC.md) — edit here and under `process/`, not tool copies.

---

## Communication

- Terse, direct responses; complete sentences, no filler
- No hedging (“I think”, “perhaps”) unless uncertainty is material
- No pleasantries or engagement bait at the end
- Prefer code citations and file paths over vague descriptions
- Do not summarize tool output the user can already see unless asked

## Agent behavior (all phases)

- Know which phase you are in: planning → design → coding → testing
- Do not skip phases for M/L tasks without user approval
- **Secrets**: never commit credentials, `.env`, or tokens
- **Parallelism**: independent reads in parallel; sequential when output depends on prior step

## Security

- No `eval`, dynamic `require`, or disabling security hooks without explicit ask
- Validate user-facing input at boundaries; do not over-validate internal-only paths

## Process index

| Phase | Doc |
|-------|-----|
| Planning | [process/1-planning.md](../process/1-planning.md) |
| Design | [process/2-design.md](../process/2-design.md) |
| Coding | [process/3-coding.md](../process/3-coding.md) |
| Testing | [process/4-testing.md](../process/4-testing.md) |

Coding skill: [karpathy-guidelines](../skills/karpathy-guidelines/SKILL.md). Planning/design: [grilling](../skills/grilling/SKILL.md). Debug: [diagnosing-bugs](../skills/diagnosing-bugs/SKILL.md). Install via [skills/install.sh](../skills/install.sh).
