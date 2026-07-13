# Phase 2 — Design

After planning is approved; before implementation. Produces or updates **design spec**, not production code.

## Outcomes

- Goals, non-goals, and success criteria reflected in [design.md](../templates/design.md.template)
- Approach, boundaries, and “do not touch” zones documented
- Test plan sketched (details finalized in phase 4)
- Open questions resolved or explicitly flagged

## Rules

- Do not implement features in this phase — spec and diagrams only
- Prefer updating the design doc over long chat-only specs
- Link to existing `AGENTS.md` for repo commands; do not duplicate command tables
- For UI/visual refactors: run **design-map** skill first when structure is unknown
- Keep design docs ≤ ~120 lines; link to ADRs or arch docs for depth
- For **M/L** ambiguous designs: run **`grilling`** (or `/grill-me`) before locking the spec
- When domain jargon is dense or agents misname concepts: start or update root **`CONTEXT.md`** from [templates/CONTEXT.md.template](../templates/CONTEXT.md.template)

## Artifacts

| Artifact | Template |
|----------|----------|
| Feature spec | [templates/design.md.template](../templates/design.md.template) |
| Domain glossary | [templates/CONTEXT.md.template](../templates/CONTEXT.md.template) → repo-root `CONTEXT.md` |
| Site structure audit | `design-map` skill → `design-maps/` in target repo |

## Checklist before coding

- [ ] Goals and non-goals stated
- [ ] Success criteria checkboxes are measurable
- [ ] Files-to-change table is plausible
- [ ] Risks noted with mitigations
- [ ] Agent instructions block filled for implementor

## Handoff to coding

Implementor prompt must include:

- Path to `design.md`
- “Follow phase 3 coding rules; verify per phase 4”
- Explicit scope: no items from non-goals
