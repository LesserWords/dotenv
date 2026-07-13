# Language-specific preferences

Coding phase: [../process/3-coding.md](../process/3-coding.md). Project `AGENTS.md` may override per repo.

## TypeScript / JavaScript

- Prefer `type` over `interface` for object shapes unless merging declarations
- `unknown` over `any`; narrow before use
- Exhaustive `switch` / discriminated unions over open-ended string checks
- Prefer named exports; avoid default export unless framework requires it
- Async: `async/await` over raw `.then` chains in new code

## Python

- Type hints on public functions and non-trivial locals
- Prefer `dataclasses` / Pydantic models over untyped dicts for structured data
- f-strings only for formatting
- Virtual env / lockfile per project — do not assume global packages

## CSS / UI

- Match existing token system (Tailwind, CSS modules, etc.)
- No new color/spacing one-offs if design tokens exist
- Accessibility: focus states and semantic HTML unless legacy constrains

## Shell

- POSIX-friendly when scripts are shared; PowerShell for Windows-only automation in this repo
