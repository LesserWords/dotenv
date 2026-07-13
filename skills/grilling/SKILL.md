---
name: grilling
description: >-
  Relentless one-question interview to sharpen a plan, design, or decision until
  shared understanding. Use when the user runs /grilling or /grill-me, or asks to
  stress-test a plan before implementation.
disable-model-invocation: true
license: MIT
---

# Grilling

Interview the user until every branch of the decision tree is resolved and you share an understanding. Do not implement or edit files until they confirm that understanding.

## Rules

1. Ask **one question at a time**. Wait for the answer before the next. Multiple questions at once are forbidden.
2. For each question, give your **recommended answer** (short, opinionated).
3. If a **fact** can be found in the environment (repo, tools, docs), look it up — do not ask.
4. **Decisions** belong to the user — put each one to them and wait.
5. Walk dependencies in order: resolve blockers before dependent choices.
6. Stop and state the shared understanding when the tree is resolved. Wait for explicit confirmation before acting.

## Completion

Done when the user confirms a short summary of decisions, constraints, and non-goals. Then hand off to the appropriate phase (`process/1-planning.md` / `2-design.md`) or implement only if they ask.
