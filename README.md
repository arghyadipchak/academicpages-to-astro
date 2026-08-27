# Academic Pages → Astro 🚀

[![Astro 7](https://img.shields.io/badge/Astro-v7-BC52EE?logo=astro&logoColor=white)](https://astro.build/)
[![Tailwind CSS v4](https://img.shields.io/badge/Tailwind_CSS-v4-06B6D4?logo=tailwindcss&logoColor=white)](https://tailwindcss.com/)
[![TypeScript](https://img.shields.io/badge/TypeScript-Strict-3178C6?logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Playwright](https://img.shields.io/badge/Playwright-Automated_Tests-2EAD33)](https://playwright.dev)
[![Commitizen Friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen?logo=git&logoColor=white)](https://commitizen.github.io/cz-cli/)
[![License](https://img.shields.io/github/license/arghyadipchak/academicpages-astro?color=8250DF)](LICENSE)

**`academicpages-to-astro`** is the development orchestrator and engineering blueprint for porting, modernizing, and continuously synchronizing the classic [academicpages](https://github.com/academicpages/academicpages.github.io) Jekyll theme to a lightning-fast, modern **Astro 7 + TypeScript + Tailwind CSS v4** portfolio template

---

## 🎯 Overview & Getting Started

### 🎓 Looking to Build Your Academic Portfolio?

If you are an academic, researcher, or student looking to create your personal homepage, use the standalone starter template:

> [!TIP]
> **Use the Starter Template Directly**:
>
> 🔗 **Repository**: [github.com/arghyadipchak/academicpages-astro](https://github.com/arghyadipchak/academicpages-astro)  
> 🚀 **Quick Start**: Click **"Use this template"** on GitHub, or clone it directly:
>
> ```bash
> git clone https://github.com/arghyadipchak/academicpages-astro.git my-academic-site
> cd my-academic-site
> pnpm install && pnpm dev
> ```

**Key Template Features**:
- **Drop-in Modern Replacement**: 100% aesthetic and structural parity with classic Jekyll AcademicPages
- **Scholarly Profile & Search**: 50+ academic/social handles, instant `Cmd+K` fuzzy search modal, and dynamic publication filters
- **Academic Tooling**: 1-click BibTeX clipboard copying, Google Scholar / Highwire Press metadata, and server-side $\KaTeX$ math
- **Interactive Visuals**: Native Mermaid diagrams, Plotly interactive charts, and responsive tables

---

### 🛠️ About This Orchestrator Repository

This repository (`academicpages-to-astro`) is the **engineering monorepo and synchronization engine** used to:
- Track and synchronize upstream [Jekyll AcademicPages](https://github.com/academicpages/academicpages.github.io) (`academicpages-jekyll/`) with the modern Astro template (`academicpages-astro/`)
- Run automated Playwright browser test suites and quality gates across Desktop and Mobile viewports
- Equip AI pair programmers and maintainers with specialized migration skills and runbooks

---

## 🏛️ Dual-Submodule Architecture

This repository organizes the migration workflow into two distinct Git submodules to guarantee that the user-facing Astro template remains completely decoupled from legacy migration machinery:

```
academicpages-to-astro/ (Root Orchestrator)
├── .gitmodules
├── Makefile                               # Zero-dependency Make commands for dev, test, and sync
├── AGENTS.md                              # AI agent transformation constitution and development rules
├── LICENSE                                # Project MIT license
├── README.md                              # This orchestrator guide
│
├── .agents/skills/                        # Specialized AI assistant skills & runbooks
│   ├── jekyll-to-astro/SKILL.md           # Liquid-to-Astro syntax conversion & layout mappings
│   └── upstream-sync/SKILL.md             # Upstream synchronization protocol
│
├── docs/                                  # Migration roadmap, specs, and status reports
│   ├── architecture.md                    # Technical architecture & subsystem design
│   ├── design-system.md                   # Tailwind v4 token mapping from Minimal Mistakes SCSS
│   ├── migration-plan.md                  # Comprehensive 10-phase migration blueprint
│   ├── migration-status.md                # Task-by-task completion log and milestones
│   └── upstream-sync-guide.md             # Developer runbook for merging upstream updates
│
├── academicpages-jekyll/  [Submodule 1]   # Upstream Jekyll Reference (academicpages/academicpages.github.io)
└── academicpages-astro/   [Submodule 2]   # Clean, Standalone Astro 7 Starter Template
```

---

## 🔄 Upstream Synchronization Workflow

When updates or fixes are released in the upstream Jekyll theme, maintainers synchronize changes using the automated Make targets:

```bash
# 1. Inspect the status of both submodules
make upstream-status

# 2. Pull the latest commits from upstream Jekyll into academicpages-jekyll/
make upstream-update

# 3. Inspect the exact diff between the last synced version and current upstream
make upstream-diff

# 4. Port any relevant changes into academicpages-astro/
#    (Refer to .agents/skills/jekyll-to-astro/SKILL.md for syntax transformation rules)

# 5. Run the full quality verification gate
make verify

# 6. Run the Playwright automated browser test suite
make test
```

---

## 💻 Orchestrator Commands (`Makefile`)

All common operations can be executed from the root using `make`:

| Command | Description |
| :--- | :--- |
| `make dev` | Starts the Astro development server at `http://localhost:4321` |
| `make build` | Compiles the production static site into `academicpages-astro/dist/` |
| `make preview` | Previews the compiled production build locally |
| `make verify` | Runs code quality checks (`lint` + `format:check` + `typecheck`) |
| `make test` | Runs the Playwright automated browser test suite across viewports |
| `make format` | Formats all source code with Prettier and Tailwind class sorter |
| `make upstream-status` | Displays current git commit pointers for submodules |
| `make upstream-update` | Fetches and merges latest commits from upstream Jekyll theme |
| `make upstream-diff` | Shows git diff between current submodule commit and upstream HEAD |

---

## 📄 Documentation Directory

Detailed architectural and engineering documentation is available in [`docs/`](./docs/):

- **[Architecture Specification](docs/architecture.md)** — Layout hierarchy, component tree, and Astro Content Layer design
- **[Design System & Tokens](docs/design-system.md)** — Mapping Minimal Mistakes CSS variables and skins to Tailwind CSS v4 `@theme`
- **[Migration Plan](docs/migration-plan.md)** — 10-phase migration roadmap covering all layouts, pages, collections, and plugins
- **[Migration Status](docs/migration-status.md)** — Historical audit log of completed features and verification milestones
- **[Upstream Sync Guide](docs/upstream-sync-guide.md)** — Detailed runbook for maintaining upstream synchronization

---

## 🙏 Acknowledgements & Attribution

This project is built upon the foundational work of the open-source academic and web communities:

- **[Academic Pages (Jekyll)](https://github.com/academicpages/academicpages.github.io)** — Created by [Stuart Geiger](https://github.com/stuartgeiger) and community contributors (MIT License)
- **[Minimal Mistakes](https://github.com/mmistakes/minimal-mistakes)** — The Jekyll theme by [Michael Rose](https://github.com/mmistakes) upon which Academic Pages was originally built (MIT License)
- **[Astro Framework](https://astro.build)** — Modern web framework designed for content-driven websites (MIT License)
- **[Tailwind CSS](https://tailwindcss.com)** — Utility-first CSS framework (MIT License)

---

## 📜 License

This project is licensed under the [MIT License](LICENSE) © 2026 [Arghyadip Chakraborty](https://github.com/arghyadipchak)
