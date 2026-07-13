# Phase 4 — Testing

Verification after coding (or **test-first** when plan defines it). Reuse **karpathy-guidelines** goal-driven loops.

## Outcomes

- Success criteria from planning/design are checked off
- Tests and lint from `AGENTS.md` run (or N/A documented)
- Evidence stated: what ran, pass/fail
- Regressions not introduced outside scope

## Test-first (when applicable)

| Request type | Order |
|--------------|--------|
| Bug fix | Repro test → fail → fix → pass |
| New behavior | Tests for contract → fail → implement → pass |
| Refactor | Green before and after; same public behavior |

Work in **vertical slices** (one test → one minimal implementation → repeat). Do not write all tests first, then all code.

## Seams

A **seam** is the public boundary you test at — observe behavior without reaching inside. Before writing tests, list the seams and **confirm with the user**. No tests at unconfirmed seams.

Ask: “What’s the public interface, and which seams should we test?”

## Anti-patterns

- **Implementation-coupled** — mocks internals, tests private methods, or asserts via side channels (e.g. DB) instead of the public interface; breaks on refactors with unchanged behavior
- **Tautological** — expected value recomputed the same way as the code; expected values must come from an independent source (literal, worked example, spec)
- **Horizontal slicing** — bulk tests for imagined shape, then bulk implementation; prefer vertical tracer bullets

## Rules

- Use exact commands from project `AGENTS.md` — do not invent scripts
- Add or update tests for behavior you change, even if not asked (unless repo forbids)
- Report failures with file, test name, and relevant output — not “tests failed”
- Do not disable hooks, skip tests, or weaken assertions without explicit approval
- Fix root cause; no “fix” that only hides the symptom
- Hard bugs: invoke **`diagnosing-bugs`** before long speculative reading

## Verification checklist

- [ ] Unit/integration tests per design test plan
- [ ] Lint / typecheck if defined in `AGENTS.md`
- [ ] Manual steps from design doc (if any) performed or noted skipped
- [ ] No secrets or unrelated files in diff
- [ ] Success criteria in `design.md` updated (status → implemented)

## PR / CI

- PR body includes **what**, **why**, and test plan checklist
- Conventional short commit subjects when committing
- Do not force-push `main`/`master` unless explicitly requested

## Specialist pass (optional)

- Review-only subagent after green local checks
- `babysit` skill for PR + CI loop until merge-ready
- Multi-session: **`handoff`** to compact context for a fresh agent (writes under OS temp)

## Karpathy alignment

**Goal-driven execution**: each plan step should have had a verify line; close the loop before calling the task done. Confirm **seams** first (above), then red → green.
