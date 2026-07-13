# Personal skills registry

Versioned in this repo under `skills/<name>/`. Install:

```sh
./skills/install.sh
```

```powershell
.\skills\install.ps1
```

**Invoke:** `user` = only when named / slash-invoked (`disable-model-invocation: true`). `model` = agent may auto-reach from description.

## Versioned (this repo)

| Skill | Path | Phases | Invoke | Trigger |
|-------|------|--------|--------|---------|
| **karpathy-guidelines** | [karpathy-guidelines/](karpathy-guidelines/) | Coding, Testing | model | Writing/refactoring/reviewing code; reduce overcomplication |
| **grilling** | [grilling/](grilling/) | Planning, Design | user | `/grilling` — one-question interview until shared understanding |
| **grill-me** | [grill-me/](grill-me/) | Planning, Design | user | `/grill-me` — alias that runs `grilling` |
| **diagnosing-bugs** | [diagnosing-bugs/](diagnosing-bugs/) | Coding, Testing | model | Diagnose/debug; broken, flaky, slow |
| **handoff** | [handoff/](handoff/) | All | user | `/handoff` — compact session for a fresh agent |
| **repo-assessment-openspec-graphify** | [repo-assessment-openspec-graphify/](repo-assessment-openspec-graphify/) | Planning, Design | model | OpenSpec + Graphify readiness, brownfield assessment — stop for approval |
| **skill-creator** | [skill-creator/](skill-creator/) | — | model | Create/improve skills, evals, description optimization (Anthropic) |
| *(add yours)* | `skills/<name>/` | | | |

## External (reference only — not symlinked by install.sh)

| Skill | Location | Phases | Trigger |
|-------|----------|--------|---------|
| design-map | `~/.claude/skills/design-map/` | Design | `/design-map`, before UI refactor |
| create-rule | `~/.cursor/skills-cursor/create-rule/` | Design, Coding | `.cursor/rules`, AGENTS.md |
| create-skill | `~/.cursor/skills-cursor/create-skill/` | — | New SKILL.md |
| caveman / cavecrew | `~/.claude/plugins/.../caveman/` | All | Token-efficient comms, subagents |
| babysit | `~/.cursor/skills-cursor/babysit/` | Testing | PR merge-ready, CI loop |
| split-to-prs | `~/.cursor/skills-cursor/split-to-prs/` | Coding | Split branch into PRs |

## Add a versioned skill

1. Create `skills/<name>/SKILL.md` (+ optional `LICENSE`)
2. Set `disable-model-invocation: true` for user-only skills; omit it for model-invoked
3. Run `skills/install.sh` or `install.ps1`
4. Add row to **Versioned** table above
5. Link from relevant `process/*.md` if phase-specific

## Project-only skills

| Skill | Repo | Path |
|-------|------|------|
| | | `.cursor/skills/...` |
