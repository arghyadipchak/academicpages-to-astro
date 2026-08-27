# Academic Pages → Astro Migration & Maintenance Constitution 📜

## Objective

This repository (`academicpages-to-astro`) orchestrates the migration and continuous synchronization of the classic [academicpages](https://github.com/academicpages/academicpages.github.io) Jekyll theme to a modern, high-performance **Astro 7 + TypeScript + Tailwind CSS v4** template

---

## Stack & Standards

- **Framework**: Astro 7+
- **Language**: Strict TypeScript (`.ts`, `.astro`)
- **Package Manager**: Exclusively `pnpm` inside `academicpages-astro/`
- **Styling**: Tailwind CSS v4 + `@tailwindcss/typography` with `@theme` design tokens
- **Content**: Astro Content Collections (`src/content.config.ts`) with strict Zod schemas and `glob` loaders
- **Code Quality**: ESLint 9 Flat Config (`eslint.config.ts`), Prettier with Tailwind plugin
- **Testing & Verification**: Comprehensive Playwright automated browser test suite + `astro check` strict typing
- **Root Orchestration**: Minimal, zero-node-dependency `Makefile`

---

## Dual-Submodule Architecture

- **Submodule 1 (`academicpages-jekyll/`)**: The upstream Jekyll reference repository tracking `https://github.com/academicpages/academicpages.github.io.git`
- **Submodule 2 (`academicpages-astro/`)**: The clean, standalone Astro 7 starter template for community use and deployment

> **RULE**: Never add Jekyll-specific artifacts, upstream sync scripts, or migration plans into `academicpages-astro/`. It must remain a pristine, standalone template

---

## Documentation & Formatting Rules

- **No Trailing Periods**: Never end single lines, bullet points, table cell descriptions, or standalone list items with a period (full stop)
- **Concise & Direct**: Keep descriptions punchy and clean

---

## Core Development Loop

For every task or upstream update:

1. **READ**
   - Inspect upstream source files in `academicpages-jekyll/` (`_layouts/`, `_includes/`, `_sass/`, `_data/`, `_config.yml`)
   - Inspect target Astro files in `academicpages-astro/src/`
   - Read relevant documentation in `docs/` (`migration-plan.md`, `architecture.md`, `design-system.md`, `upstream-sync-guide.md`)

2. **PLAN**
   - Identify the minimal focused change required
   - Specify the exact files in `academicpages-astro/` to create or modify
   - Define concrete acceptance criteria

3. **IMPLEMENT**
   - Make the focused change inside `academicpages-astro/`
   - Strictly avoid refactoring unrelated code

4. **CHECK & VERIFY**
   - Run the full quality gate from root: `make verify` (or `pnpm --dir academicpages-astro verify`)
   - Run the automated browser test suite: `make test` (or `pnpm --dir academicpages-astro test`)

5. **BROWSER VERIFY**
   - For UI or styling changes, visually verify in browser using Playwright MCP or preview (`make preview` / `make dev`)
   - Check both Desktop (1280px) and Mobile (393px) viewports

6. **COMPLETE**
   - Commit changes cleanly inside `academicpages-astro/`
   - Update `docs/migration-status.md` when completing milestone tasks

---

## Upstream Synchronization Protocol

When the upstream Jekyll repository updates:

1. **Check Status**: `make upstream-status`
2. **Pull Updates**: `make upstream-update`
3. **Inspect Diff**: `make upstream-diff` (or `git -C academicpages-jekyll diff HEAD@{1}..HEAD`)
4. **Translate Changes**: Use `.agents/skills/upstream-sync/SKILL.md` to map changes into `academicpages-astro/`
5. **Verify**: `make verify && make test`
6. **Commit**: Create atomic commits in `academicpages-astro` and the root orchestrator

---

## Orchestrator Commands (`Makefile`)

| Command | Action |
| :--- | :--- |
| `make dev` | Starts local dev server in `academicpages-astro` at `localhost:4321` |
| `make build` | Compiles static production build to `academicpages-astro/dist/` |
| `make preview` | Serves production build locally |
| `make verify` | Runs quality gate checks (`lint` + `format:check` + `typecheck`) |
| `make test` | Runs Playwright browser test suite across viewports |
| `make format` | Formats all code with Prettier and Tailwind class sorter |
| `make upstream-status` | Inspects submodule commit status |
| `make upstream-update` | Pulls latest commits from upstream Jekyll theme |
| `make upstream-diff` | Displays exact diff from last synced commit |

---

## Stopping Conditions

Stop only when:
- Acceptance criteria are 100% satisfied
- `make verify` passes with **0 errors, 0 warnings, 0 hints**
- `make test` passes with **all tests passing (0 failures)**
- No uncommitted broken state remains
