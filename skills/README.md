# Agent skills

Procedural knowledge in `SKILL.md` files. **Versioned skills** in this folder are installed to `~/.cursor/skills/` via [install.sh](install.sh) / [install.ps1](install.ps1).

## Conventions

- **User-invoked** (`disable-model-invocation: true`): you type the name / slash command. Zero always-on description load for the agent index tradeoff you remember exists. Use for interviews and session ops (`grilling`, `grill-me`, `handoff`).
- **Model-invoked** (omit that flag): rich description with trigger phrases so the agent can reach the skill alone. Use for discipline that should fire without a slash (`karpathy-guidelines`, `diagnosing-bugs`).
- Keep `SKILL.md` short; push long reference into sibling files only when needed (progressive disclosure).
- One meaning, one place — do not duplicate `process/*.md` rules inside skills; link them.

## By process phase

| Phase | Skills |
|-------|--------|
| Planning | **`grilling`** / **`grill-me`**, **`repo-assessment-openspec-graphify`**, **`message-broker-audit`** |
| Design | **`grilling`** / **`grill-me`**, `design-map` (external), **`repo-assessment-openspec-graphify`**, **`message-broker-audit`** |
| Coding | **`karpathy-guidelines`**, **`diagnosing-bugs`** |
| Testing | **`karpathy-guidelines`**, **`diagnosing-bugs`**, **`message-broker-audit`**, `babysit` (external) |
| Meta / continuity | **`handoff`**, **`skill-creator`** |

## Layout

```
skills/
├── install.sh / install.ps1
├── registry.md
├── karpathy-guidelines/
├── grilling/ · grill-me/
├── diagnosing-bugs/
├── handoff/
├── message-broker-audit/
├── repo-assessment-openspec-graphify/
└── skill-creator/
```

## Install

```sh
chmod +x install.sh && ./install.sh
```

```powershell
.\install.ps1
```

Override target: `CURSOR_SKILLS_DIR=/path ./install.sh`

## Authoring

See Cursor **create-skill** (built-in). New repo skills: add `skills/<name>/SKILL.md`, register in [registry.md](registry.md), run install.

Never write to `~/.cursor/skills-cursor/` (Cursor reserved).

## vs process docs

| Type | Purpose |
|------|---------|
| `process/*.md` | Always-on phase rules (synced via `sync.sh`) |
| `SKILL.md` | Invoked skill for a procedure |

Karpathy content lives in the skill; [process/3-coding.md](../process/3-coding.md) and [process/4-testing.md](../process/4-testing.md) point agents to invoke it.
