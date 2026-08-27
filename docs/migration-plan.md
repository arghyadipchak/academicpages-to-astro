# Academic Pages Migration Plan

This document tracks all migration and enhancement tasks from the Jekyll `academicpages` source to Astro + Tailwind CSS.

---

## Phase 1 — Discovery & Inventory

### Task 1.1: Inventory Jekyll Structure & Assets

- [x] Inspect `_jekyll_source/` directory, files, plugins, and dependencies.
- **Acceptance Criteria**:
  - `docs/architecture.md` lists all Jekyll layouts, includes, collections, data files, and static assets.
  - Image and document paths mapped to Astro equivalents (`public/` and `src/assets/`).

### Task 1.2: Inventory Collections & Frontmatter

- [x] Inspect all items in `_posts/`, `_publications/`, `_talks/`, `_teaching/`, `_portfolio/`, `_pages/`.
- **Acceptance Criteria**:
  - `docs/architecture.md` contains complete schema requirements for each collection type.
  - All date formats, taxonomy fields (tags, categories), author metadata, and custom fields identified.

### Task 1.3: Inventory URL & Permalink Structure

- [x] Map every Jekyll permalink pattern (posts, pages, collections, tags, categories).
- **Acceptance Criteria**:
  - URL mapping table documented in `docs/architecture.md`.
  - Pagination paths and RSS/sitemap endpoints documented.

---

## Phase 2 — Foundation & Design System

### Task 2.1: Project Toolchain & Quality Baseline

- [x] Configure Astro, pnpm, strict TypeScript, ESLint 9, Prettier, and Tailwind CSS v4
- **Acceptance Criteria**:
  - `pnpm verify` executes `lint`, `format:check`, `typecheck`, and `build` cleanly

### Task 2.2: Design Tokens & Global CSS Setup

- [x] Extract colors, fonts, spacing, and reset styles from `_jekyll_source/_sass/` into `src/styles/global.css`
- **Acceptance Criteria**:
  - Academic Pages color palette defined in `@theme` in `src/styles/global.css`
  - Font families (Sans, Serif/Mono) configured
  - Base typography rules match Academic Pages styling
  - Documented in `docs/design-system.md`

### Task 2.3: Global Site Configuration & Nav Data

- [x] Translate `_config.yml` and `_data/navigation.yml` into `src/data/siteConfig.ts` and `src/data/navigation.ts`
- **Acceptance Criteria**:
  - Site title, description, author profile data, navigation links, and social URLs fully typed and accessible

### Task 2.4: Astro Content Collections Schemas

- [x] Implement schemas in `src/content.config.ts` for `posts`, `publications`, `talks`, `teaching`, `portfolio`, `pages`
- **Acceptance Criteria**:
  - Strict Zod schemas validating all required and optional frontmatter fields
  - `pnpm typecheck` passes with sample entries

---

## Phase 3 — Layouts & Core UI Components

### Task 3.1: Base HTML Layout & SEO Head

- [x] Implement `src/layouts/BaseLayout.astro` and `src/components/HeadSEO.astro`
- **Acceptance Criteria**:
  - Valid HTML5 boilerplate, meta tags, OpenGraph/Twitter cards, favicon links
  - Responsive viewport configuration matching Jekyll `_includes/head.html`

### Task 3.2: Masthead / Global Header & Navigation

- [x] Implement `src/components/Masthead.astro` and `src/components/NavList.astro`
- **Acceptance Criteria**:
  - Top navigation bar renders site title and nav items matching Jekyll `_includes/masthead.html`
  - Active page state highlighting
  - Mobile responsive toggle / drawer works seamlessly
  - Browser verification on desktop (1280px) and mobile (375px) passes

### Task 3.3: Author Profile Sidebar

- [x] Implement `src/components/AuthorProfile.astro`
- **Acceptance Criteria**:
  - Avatar image, bio, location, employer, and social/academic links (Google Scholar, ORCID, GitHub, Twitter, Email, etc.)
  - Matches Jekyll `_includes/author-profile.html` styling and responsive behavior (sticky sidebar on desktop, inline/collapsible on mobile)
  - Browser verification passes

### Task 3.4: Global Footer

- [x] Implement `src/components/Footer.astro`
- **Acceptance Criteria**:
  - Copyright text, powered-by links, social links
  - Matches Jekyll `_includes/footer.html`

### Task 3.5: Layout Templates (`SingleLayout.astro`, `ArchiveLayout.astro`)

- [x] Implement `src/layouts/SingleLayout.astro` and `src/layouts/ArchiveLayout.astro`
- **Acceptance Criteria**:
  - 2-column layout (Author Sidebar + Main Content) on desktop
  - Breadcrumbs support matching `_includes/breadcrumbs.html`
  - Responsive stacking on mobile

---

## Phase 4 — Archive Components & Teasers

### Task 4.1: Archive Teaser Components

- [x] Implement `src/components/ArchivePost.astro`, `src/components/ArchivePublication.astro`, `src/components/ArchiveTalk.astro`
- **Acceptance Criteria**:
  - Render title, date, excerpt, venue, citation, links (PDF, Code, Slides, DOI)
  - Matches Jekyll `_includes/archive-single.html` styles for each post type

### Task 4.2: Page Component: About / Homepage (`index.astro`)

- [x] Implement `src/pages/index.astro` using source `_pages/about.md`
- **Acceptance Criteria**:
  - Exact visual match to Academic Pages home/about page
  - Browser verification on desktop and mobile passes

---

## Phase 5 — Content Migration & Dynamic Pages

### Task 5.1: Migrate & Render Posts (`src/pages/posts/`)

- [x] Migrate `_posts/*.md` and implement post listing (`/posts/`) and single post route (`/posts/[...slug]`)
- **Acceptance Criteria**:
  - All posts parse without Zod schema errors
  - Markdown rendered with code highlighting, math/KaTeX, and images
  - URLs match original Jekyll URLs

### Task 5.2: Migrate & Render Publications (`src/pages/publications/`)

- [x] Migrate `_publications/*.md` and implement `/publications/` and `/publications/[...slug]`
- **Acceptance Criteria**:
  - Grouping by publication type or year matching Jekyll behavior
  - Citation copy button or link

### Task 5.3: Migrate & Render Talks & Teaching (`/talks/`, `/teaching/`)

- [x] Migrate `_talks/*.md` and `_teaching/*.md`
- **Acceptance Criteria**:
  - Listing pages and individual talk/teaching pages match reference

### Task 5.4: Migrate & Render Portfolio & CV (`/portfolio/`, `/cv/`)

- [x] Migrate `_portfolio/*.md` and `_pages/cv.md`
- **Acceptance Criteria**:
  - Portfolio grid layout and CV layout match reference

---

## Phase 6 — SEO, RSS, Sitemap & Compatibility

### Task 6.1: RSS Feed & Sitemap

- [x] Implement `src/pages/rss.xml.ts` and `@astrojs/sitemap`
- **Acceptance Criteria**:
  - RSS 2.0 feed validates and contains recent posts and publications
  - `sitemap-index.xml` generated on build

### Task 6.2: 404 Page & Redirects

- [x] Implement `src/pages/404.astro` and verify legacy permalinks
- **Acceptance Criteria**:
  - 404 page styled with site layout

---

## Phase 7 — Final Visual QA & Verification

### Task 7.1: Comprehensive Visual Diffing (Desktop & Mobile)

- [x] Run Playwright comparison between original Academic Pages and Astro build
- **Acceptance Criteria**:
  - Zero layout regressions, font mismatches, or broken assets

### Task 7.2: Accessibility & Performance Audit

- [x] Check color contrast, semantic headings, keyboard navigation, Lighthouse scores
- **Acceptance Criteria**:
  - Zero accessibility violations
  - `pnpm verify` passes cleanly with 0 errors

---

## Phase 8 — Modern UX & Academic Enhancements

### Task 8.1: 1-Click BibTeX Citation Copy & Action Badges

- [x] Implement inline expandable BibTeX viewer with a one-click clipboard copy button on publication cards and single pages
- **Acceptance Criteria**:
  - Clicking "BibTeX" reveals the raw BibTeX snippet with a "Copied!" tooltip feedback
  - Publication links styled as modern interactive pill badges (`[PDF]`, `[Code]`, `[Slides]`, `[DOI]`, `[BibTeX]`)
  - Works without page reloads; zero layout shift

### Task 8.2: Copy Code Button & Heading Anchor Links

- [x] Add copy-to-clipboard functionality to code blocks and hover anchor `#` links to Markdown `<h2>` and `<h3>` headings
- **Acceptance Criteria**:
  - Code blocks have a top-right copy icon with visual confirmation feedback
  - Headings show a subtle `#` anchor link on hover that copies the permalink to clipboard

### Task 8.3: Instant Search Modal (`Cmd+K` / Pagefind)

- [x] Implement a global search modal in `src/components/SearchModal.astro` triggered by a header search icon or `Cmd+K` / `Ctrl+K`
- **Acceptance Criteria**:
  - Search indexes all blog posts, publications, talks, and teaching materials
  - Keyboard navigation (Arrow keys + Enter + Escape) supported
  - Mobile responsive fullscreen search overlay

### Task 8.4: Interactive Publication Category Filters

- [x] Add client-side filter pills on `/publications/` (`All`, `Journal Articles`, `Conference Papers`, `Books`)
- **Acceptance Criteria**:
  - Clicking a filter pill instantly updates the visible list without reloading
  - Active filter state clearly highlighted
  - URL hash updates (e.g. `#/publications#conferences`) for bookmarking

### Task 8.5: Sticky Table of Contents (ToC)

- [x] Implement `src/components/TableOfContents.astro` for long-form blog posts and CV
- **Acceptance Criteria**:
  - Automatically extracts headings from the rendered markdown
  - Highlights the currently active section as the user scrolls
  - Collapsible on mobile viewports

---

## Phase 9 — Content Modernization, Sanitization & Deployment

### Task 9.1: Legacy Content & URL Sanitization
- [x] Modernize sample content across `src/content/pages/` (`about.md`, `markdown.md`, `cv.md`) to document Astro 7 rather than legacy Jekyll setup
- [x] Convert all publication assets (`paperurl`, `slidesurl`, `bibtexurl`) from remote absolute URLs to local static root-relative paths (`/files/...`)
- [x] Add Google Scholar / Highwire Press citation meta tags for automatic academic indexing

### Task 9.2: Submodule Decoupling & Deployment Target
- [x] Ensure `academicpages-astro` has zero references to upstream Jekyll directory structures or migration scripts
- [x] Configure production site domain (`https://arghyadipchak.github.io/academicpages-astro`) and repository (`arghyadipchak/academicpages-astro`)
- [x] Configure automated GitHub Pages deployment workflow in `.github/workflows/ci.yml`

---

## Phase 10 — Advanced Content & Rich Media Rendering Engine

### Task 10.1: KaTeX Mathematics SSR Engine
- [x] Configure server-side mathematical rendering via `remark-math` and `rehype-katex`
- **Acceptance Criteria**:
  - Delimiters `$$...$$`, `\\[...\\]`, and `\\(...\\)` render server-side KaTeX/MathML formulas with zero client-side parser bundle
  - Multiline aligned equations (`\begin{aligned}`) render with crisp vertical alignment

### Task 10.2: Dual-Theme Shiki Token Synchronization
- [x] Configure dual Light/Dark Shiki syntax highlighting (`github-light` & `github-dark`)
- **Acceptance Criteria**:
  - CSS variables synchronize background and token colors under `html[data-theme="dark"]`
  - Inline code (`:not(pre) > code`) is styled separately from code blocks, preserving syntax token colors

### Task 10.3: Diagrams & Interactive Visualizations (Mermaid & Plotly)
- [x] Implement on-demand client-side module loaders in `src/components/ProseEnhancer.astro`
- **Acceptance Criteria**:
  - ` ```mermaid ` blocks dynamically load Mermaid 11 on pages that contain diagrams and render theme-synchronized SVGs
  - ` ```plotly ` blocks dynamically load Plotly.js and render responsive, interactive charts matching the active theme

### Task 10.4: Academic Notice Callouts & IAL Support
- [x] Implement notice callout styling and transformation in `ProseEnhancer.astro` and `src/styles/global.css`
- **Acceptance Criteria**:
  - `{: .notice}`, `{: .notice--info}`, `{: .notice--warning}`, `{: .notice--success}`, `{: .notice--danger}` transform into styled callout boxes
  - Clean fallbacks for standard Markdown blockquotes and GitHub-style alerts

### Task 10.5: Automated E2E Rendering Test Suite
- [x] Add end-to-end assertions in Playwright (`tests/smoke.spec.ts`) validating math, code blocks, copy buttons, notice callouts, and heading anchors
- **Acceptance Criteria**:
  - Automated smoke test suite passes 100% across desktop and mobile viewports

