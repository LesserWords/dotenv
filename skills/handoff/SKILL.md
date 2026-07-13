---
name: handoff
description: >-
  Compact the current conversation into a handoff document so another agent can
  continue. Use when the user runs /handoff or asks to hand off / continue in a
  new session.
disable-model-invocation: true
license: MIT
---

# Handoff

Write a handoff document so a fresh agent can continue the work.

## Where to save

Save under the OS temp directory — **not** the workspace:

- Windows: `$env:TEMP\agent-handoff-<short-slug>.md`
- Linux/macOS: `/tmp/agent-handoff-<short-slug>.md`

Print the full path when done.

## Contents

1. **Goal** — what the next session should achieve (use user args if provided)
2. **Status** — done / in progress / blocked
3. **Decisions** — locked choices only
4. **Pointers** — paths/URLs to existing artifacts (`design.md`, `CONTEXT.md`, issues, PRs, commits). Do **not** duplicate their content.
5. **Next steps** — ordered, each with a verify check
6. **Suggested skills** — e.g. `grilling`, `diagnosing-bugs`, `karpathy-guidelines`
7. **Open questions** — unresolved only

## Rules

- Redact secrets, API keys, passwords, and unnecessary PII.
- Prefer links over paste.
- If the user passed a focus argument, tailor the doc to that focus.
