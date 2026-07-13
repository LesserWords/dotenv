# Process phases

Workflow split into four phases. **Edit the phase file** for that stage; cross-cutting rules stay in [../preferences/universal.md](../preferences/universal.md).

| Phase | File | Primary artifacts | Key skill |
|-------|------|-------------------|-----------|
| **1. Planning** | [1-planning.md](1-planning.md) | Issue brief, plan, success criteria | `grilling` / `grill-me` |
| **2. Design** | [2-design.md](2-design.md) | `design.md`, optional `CONTEXT.md` | `grilling`, `design-map` (UI) |
| **3. Coding** | [3-coding.md](3-coding.md) | Code diff, `AGENTS.md` commands | `karpathy-guidelines`, `diagnosing-bugs` |
| **4. Testing** | [4-testing.md](4-testing.md) | Tests, CI, verification log | `karpathy-guidelines`, `diagnosing-bugs` |

Templates: [../templates/](../templates/) · Full loop: [../WORKFLOW.md](../WORKFLOW.md)

Sync order (merged into `~/.claude/CLAUDE.md` / Cursor global rule):  
`universal` → `1-planning` → `2-design` → `3-coding` → `4-testing` → `languages` → models
