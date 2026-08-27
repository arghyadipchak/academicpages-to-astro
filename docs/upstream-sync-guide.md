# Upstream Synchronization & Continuous Migration Guide 🔄

This guide documents the procedures, automation, and best practices for synchronizing this repository (`academicpages-to-astro`) with updates released to the upstream [academicpages](https://github.com/academicpages/academicpages.github.io) Jekyll theme

---

## 🏛️ Architecture Recap

```
academicpages-to-astro/ (Migration Orchestrator)
├── academicpages-jekyll/ [Submodule 1]   # Tracking upstream academicpages.github.io
└── academicpages-astro/  [Submodule 2]   # Clean standalone Astro 7 starter template
```

---

## ⚡ 3-Step Synchronization Protocol

### Step 1: Check & Fetch Upstream

Run the following commands from the root repository:

```bash
# 1. Check current tracked commit
make upstream-status

# 2. Pull latest upstream commits into academicpages-jekyll/
make upstream-update

# 3. View the git diff against the previous version
make upstream-diff
```

---

### Step 2: Translate Changes to Astro 7

Review the files modified in upstream `academicpages-jekyll/` and apply the corresponding changes to `academicpages-astro/`:

| Upstream Change | Target File in `academicpages-astro/` | Key Notes |
| :--- | :--- | :--- |
| **Site config (`_config.yml`)** | `src/data/siteConfig.ts` & `src/data/navigation.ts` | Preserve TypeScript types for author profile, links, and navigation items |
| **Styles (`_sass/*.scss`)** | `src/styles/global.css` | Translate SCSS variables to Tailwind CSS v4 `@theme` design tokens |
| **Layouts (`_layouts/*.html`)** | `src/layouts/` (`BaseLayout.astro`, `SingleLayout.astro`, `ArchiveLayout.astro`) | Maintain the 2-column layout and responsive sticky sidebar structure |
| **Partials (`_includes/*.html`)** | `src/components/` | Convert Liquid tags (`{% if %}`, `{% for %}`) to JSX expressions |
| **Posts/Publications (`_posts/`, `_publications/`)** | `src/content/blog/`, `src/content/publications/` | Ensure frontmatter complies with Zod schemas in `src/content.config.ts` |
| **Static files (`images/`, `files/`)** | `public/images/`, `public/files/` | Static downloads, PDFs, slides, and avatars |

---

### Step 3: Verify & Release

Before committing any updates:

```bash
# 1. Run full quality gate (Lint + Format check + TypeScript check + Production build)
make verify

# 2. Run Playwright automated browser test suite (Desktop & Mobile viewports)
make test
```

Once all checks pass:

```bash
# 1. Commit in the Astro template submodule
git -C academicpages-astro add .
git -C academicpages-astro commit -m "sync: incorporate upstream academicpages update"

# 2. Commit in the root orchestrator
git add academicpages-jekyll academicpages-astro docs/
git commit -m "chore: sync with upstream release"
```

---

## 🛡️ Upstream Safety Rules

1. **No Leakage**: Never commit Jekyll files or sync scripts directly into `academicpages-astro/`
2. **URL Stability**: Always ensure URL permalinks (`/posts/`, `/publications/`, `/talks/`, `/teaching/`, `/cv/`, `/rss.xml`) remain intact
3. **No Untested Commits**: Always run `make verify && make test` before creating a release commit
