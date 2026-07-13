---
name: diagnosing-bugs
description: >-
  Disciplined diagnosis for hard bugs and performance regressions: tight red
  feedback loop first, then minimise, hypothesise, instrument, fix, regression.
  Use when the user says diagnose/debug, or reports something broken, throwing,
  failing, flaky, or slow.
license: MIT
---

# Diagnosing bugs

Skip phases only when explicitly justified. Read `CONTEXT.md` if present.

## Phase 1 — Tight red loop (do this first)

Build one **agent-runnable** command that goes **red on this exact symptom**. No hypothesis until it exists.

Prefer, in order: failing test → curl/script against running app → CLI + fixture → headless browser → replay captured payload → throwaway harness → bisect/differential loop.

Tighten: faster, sharper assert, deterministic (pin time/seed/network when needed). Flaky bugs: raise reproduction rate until debuggable.

**Done when:** you have run the command at least once, pasted invocation + output, and it is red-capable, deterministic (or high repro rate), and fast.

If you cannot build a loop: stop, list what you tried, ask for env access / artifact / instrumentation permission. Do not theorise without a loop.

## Phase 2 — Reproduce + minimise

Confirm the loop matches the **user's** symptom. Shrink the repro one cut at a time until every remaining piece is load-bearing.

## Phase 3 — Hypothesise

List **3–5 ranked, falsifiable** hypotheses before testing any:

> If \<X\> is the cause, then \<change Y\> makes it disappear / \<change Z\> makes it worse.

Show the list to the user (cheap re-rank). Proceed if they are AFK.

## Phase 4 — Instrument

One variable at a time. Prefer debugger/REPL, then tagged logs (`[DEBUG-xxxx]`). For perf: measure/baseline first, then bisect — do not spray logs.

## Phase 5 — Fix + regression

If a correct **seam** exists (exercises the real bug pattern): failing regression test → fix → pass → re-run Phase 1 on the original scenario. If no correct seam: document that as an architecture finding; still fix via the loop.

## Phase 6 — Cleanup

- [ ] Phase 1 loop green on original symptom
- [ ] Regression test green (or seam gap noted)
- [ ] All `[DEBUG-…]` removed
- [ ] Throwaways deleted
- [ ] Correct hypothesis stated in commit/PR message when committing

Align test placement with [process/4-testing.md](../../process/4-testing.md) seams rules.
