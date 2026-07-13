# Phase 3 — Coding

Implementation only after plan (phase 1) and spec (phase 2) when task is M/L. **Invoke skill: `karpathy-guidelines`** for write/refactor work.

## Outcomes

- Minimal diff that satisfies approved scope
- Matches repo conventions and `AGENTS.md`
- Orphans from your edits cleaned up; pre-existing dead code only mentioned, not removed unless asked

## Rules — simplicity & scope

- No features beyond what was asked
- No abstractions for single-use code
- No speculative config/flexibility/error handling for impossible states
- If the solution is much longer than necessary, simplify
- Ask: “Would a senior engineer call this overcomplicated?”

## Rules — surgical edits

- Do not “improve” adjacent code, comments, or formatting
- Do not refactor unrelated broken code — mention it
- Match existing style in touched files
- Every changed line should trace to the user request or the approved design
- Prefer editing existing files over creating new ones
- Read surrounding code before writing

## Code style

- No unnecessary comments; **why** only when non-obvious
- No docstrings unless the project already uses them
- No unused exports or backwards-compat shims
- Explicit over magic; minimal diff
- Trust framework guarantees

## Formatting defaults

| Setting | Value |
|---------|--------|
| Indent | 2 spaces |
| JS/TS quotes | single |
| Python quotes | double |
| Format | Prettier-compatible |

Language details: [preferences/languages.md](../preferences/languages.md).

## Execution

- Run build/test commands from project `AGENTS.md` when touching behavior
- Independent reads in parallel; dependent steps sequential
- Only commit when explicitly asked
- Never commit secrets
- Hard bugs / flaky / perf regressions: invoke **`diagnosing-bugs`** (tight red loop before hypothesising)
- Prefer project **`CONTEXT.md`** terms when naming code and tests

## Model hint

**Default** tier for most implementation; **fast** for mechanical follow-ups; escalate to **heavy** only when stuck on hard bugs.

## Karpathy alignment

Apply [karpathy-guidelines](../skills/karpathy-guidelines/SKILL.md) sections **Simplicity first** and **Surgical changes** on every coding task.
