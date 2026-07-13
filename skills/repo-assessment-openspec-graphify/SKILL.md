---
name: repo-assessment-openspec-graphify
description: >-
  Assess a repository for OpenSpec and Graphify readiness together: discovery,
  OpenSpec compatibility, documentation quality, AI instruction readiness,
  Graphify / knowledge-graph feasibility (no install), brownfield integration
  plan, and dry-run file impact — then STOP for approval. Use whenever the user
  mentions OpenSpec, Graphify, knowledge graphs, repo assessment, brownfield
  specs, specification systems, AI readiness audit, architecture discovery
  before adopting specs, or asks whether a codebase should adopt OpenSpec or
  Graphify — even if they never say "assessment" or "dry run."
---

# Repository Assessment — OpenSpec & Graphify

You are acting as a Senior Staff Engineer and AI Platform Architect.

Your objective is **NOT** to immediately install or modify anything. Your first responsibility is to understand the repository and determine whether **OpenSpec** and/or **Graphify** can be integrated safely and effectively.

## Phase 1 — Repository Discovery

Inspect the entire repository and produce a report containing:

* Repository type (monorepo or single project)
* Languages used
* Frameworks
* Package managers
* Build systems
* Applications
* Services
* Shared packages
* Infrastructure folders
* Existing documentation
* Existing AI instruction files
* Existing architecture documentation
* Existing ADRs
* Existing specification systems
* Existing code generation tools

Generate a high-level architecture map showing how the repository is organized.

---

## Phase 2 — Evaluate OpenSpec Compatibility

Determine:

* Is this repository a good candidate for OpenSpec?
* Would OpenSpec improve developer and AI workflows?
* Would it conflict with any existing tooling?
* Which parts of the repository would benefit most?
* What limitations exist?

If there are blockers, explain them.

---

## Phase 3 — Evaluate Documentation

Analyze:

* Documentation quality
* Missing architecture documentation
* Missing API documentation
* Missing onboarding material
* Missing design documentation
* Missing engineering standards

Recommend improvements.

---

## Phase 4 — Evaluate AI Readiness

Determine whether the repository already contains:

* CLAUDE.md
* AGENTS.md
* Copilot instructions
* Cursor rules
* Cline configuration
* Roo configuration
* Codex instructions
* Windsurf configuration
* Repository-specific prompts

If none exist, recommend a reusable AI instruction structure.

---

## Phase 5 — Evaluate Knowledge Graph Readiness (Graphify)

Determine whether a semantic graph (**Graphify** or equivalent) would add value.

Identify entities such as:

* Apps
* Services
* Packages
* APIs
* Database tables
* Workers
* Queues
* Features
* Specifications
* Architecture documents

Describe how they could be connected.

Do not install Graphify.

Only evaluate feasibility.

---

## Phase 6 — Produce an Integration Plan

If OpenSpec and/or Graphify are appropriate, propose for each recommended tool:

* Folder structure
* Initial configuration
* Initial specifications (OpenSpec) or initial graph scope / entity map (Graphify)
* Migration strategy
* Brownfield adoption strategy
* Risks
* Expected benefits

Prefer organizing OpenSpec specifications by business capability rather than technology.

---

## Phase 7 — Dry Run

Simulate the changes that would be made.

List:

* New files
* Modified files
* Deleted files (if any)

Do not make changes.

---

## Phase 8 — Wait for Approval

After completing the assessment, STOP.

Do not create files.
Do not install packages.
Do not commit changes.
Do not modify the repository.

Wait for explicit approval before performing any modifications.

When approval is given, create a second implementation plan before making changes.
