# Academic Pages Astro Architecture

This document describes the architectural mapping, content schema, component hierarchy, and routing rules for the Astro implementation.

---

## 0. Key Architectural Decisions (from Alignment Interview)

1. **Demo Content Scope**: Complete sample content migration (all sample posts, publications, talks, teaching, portfolio items, and CV) to establish a full functional baseline
2. **Icons Strategy**: `astro-icon` with `@iconify-json/academicons`, `@iconify-json/fa6-brands`, and `@iconify-json/fa6-solid` (zero-JS, build-time optimized SVGs)
3. **Theming & Dark Mode**: Dedicated Light/Dark toggle with `localStorage` persistence and OS-level preference fallback using Tailwind v4 dark classes with the classic Academic Pages navy/slate palette
4. **Interactive Features**: Instant modal fuzzy search + Leaflet Talkmap component for `/talks/`
5. **URL Preservation**: Strict permalink matching (`/posts/YYYY/MM/title/`, `/publications/:slug/`, `/talks/:slug/`, `/cv/`, etc.)

---

## 1. Jekyll Source Inventory (Task 1.1)

### 1.1 Layouts

- `default.html`: Outer shell, head, masthead, content container, footer, scripts
- `single.html`: Main article layout with 2-column grid (author sidebar on left, content on right), header, citation/paper download links, taxonomies, share links, related posts
- `archive.html`: Collection/listing archive container with sidebar and content
- `archive-taxonomy.html`: Tag and category archive listing
- `talk.html`: Talk layout rendering date, venue, location, talk type, and download links
- `cv-layout.html`: CV layout for rendering CV either via Markdown or JSON
- `splash.html`: Splash / landing page without sidebar
- `compress.html`: Liquid HTML minification (handled natively in Astro/Vite)

### 1.2 Key Includes

- `masthead.html`: Top sticky navigation bar, brand title, dynamic menu links, theme toggle button, responsive collapse
- `author-profile.html`: Sidebar author card with avatar, bio, location, employer, and full suite of academic/code/social links with FontAwesome & Academicons
- `footer.html`: Sticky-bottom footer with follow links, copyright notice, and sitemap link
- `breadcrumbs.html`: Breadcrumb navigation bar
- `archive-single.html` / `archive-single-talk.html` / `archive-single-cv.html`: Teaser cards for publications, posts, talks, and CV entries
- `seo.html` / `head.html`: Metadata, OpenGraph, Twitter card, Canonical URL, favicon definitions
- `social-share.html`: Social sharing buttons for Twitter, Facebook, LinkedIn
- `comments.html`: Comments provider wrapper (Disqus, Staticman, etc.)

### 1.3 Data Files

- `_data/navigation.yml`: Header navigation menu items (Publications, Talks, Teaching, Portfolio, Blog Posts, CV, Guide)
- `_data/authors.yml`: Multi-author profiles override dictionary
- `_data/cv.json`: Structured CV data (education, experience, publications, awards, skills)
- `_data/ui-text.yml`: Localization string table for labels (date, publication, follow, sitemap, etc.)

### 1.4 Static Assets Mapping

- `academicpages-jekyll/images/*` $\rightarrow$ `public/images/*` (Profile avatars, thumbnails, favicons, screenshots)
- `academicpages-jekyll/files/*` $\rightarrow$ `public/files/*` (Downloadable paper PDFs, slide decks, BibTeX `.bib` files)

---

## 2. Directory Structure

```
academicpages-to-astro/
├── academicpages-jekyll/        # Original Jekyll repository (reference submodule)
├── academicpages-astro/         # Migrated standalone Astro repository (target submodule)
├── docs/                        # Architecture, design system, and migration plan
├── public/                      # Static assets (images, pdfs, icons)
│   ├── images/
│   └── files/
├── src/
│   ├── assets/                  # Optimized images / local media
│   ├── components/              # Reusable UI components (.astro)
│   │   ├── AuthorProfile.astro  # Sidebar author bio and social links
│   │   ├── Masthead.astro       # Top navbar with responsive drawer
│   │   ├── NavList.astro        # Navigation link list
│   │   ├── Footer.astro         # Page footer
│   │   ├── ArchiveItem.astro    # Teasers for posts, papers, talks
│   │   ├── Breadcrumbs.astro    # Breadcrumb trail
│   │   ├── HeadSEO.astro        # Meta tags, OpenGraph, Favicons
│   │   ├── ThemeToggle.astro    # Light / Dark theme toggle
│   │   └── Prose.astro          # Markdown typography wrapper
│   ├── content/                 # Astro Content Collections
│   │   ├── blog/                # Posts (from _posts/)
│   │   ├── publications/        # Research papers (from _publications/)
│   │   ├── talks/               # Talks & presentations (from _talks/)
│   │   ├── teaching/            # Courses & teaching (from _teaching/)
│   │   ├── portfolio/           # Projects (from _portfolio/)
│   │   └── pages/               # Standalone markdown pages (about, cv, guide)
│   ├── content.config.ts        # Content Collections schemas (Zod)
│   ├── data/
│   │   ├── siteConfig.ts        # Site metadata, author details, social links
│   │   └── navigation.ts        # Nav menu links
│   ├── layouts/
│   │   ├── BaseLayout.astro     # Core HTML5 shell with head & fonts
│   │   ├── SingleLayout.astro   # Standard single-entry layout with sidebar
│   │   └── ArchiveLayout.astro  # Collection listing / archive layout
│   ├── pages/                   # File-based routing
│   │   ├── index.astro          # Home / About page
│   │   ├── posts/               # Blog archive and single posts
│   │   ├── year-archive.astro   # Year-grouped blog archive
│   │   ├── publications/        # Publications archive and single papers
│   │   ├── talks/               # Talks archive and single talks
│   │   ├── teaching/            # Teaching archive and single courses
│   │   ├── portfolio/           # Portfolio archive and single projects
│   │   ├── cv.astro             # CV page
│   │   ├── markdown.astro       # Markdown & math guide
│   │   ├── 404.astro            # Not found page
│   │   └── rss.xml.ts           # RSS 2.0 Feed
│   └── styles/
│       └── global.css           # Tailwind v4 theme, fonts, reset
├── astro.config.ts
├── eslint.config.ts
├── prettier.config.ts
├── tsconfig.json
└── package.json
```

---

## 3. Collections & Frontmatter Schema Inventory (Task 1.2)

### 3.1 Publications (`src/content/publications/*.md`)

- `title`: `z.string()` (required)
- `date`: `z.coerce.date()` (required)
- `venue`: `z.string().optional()`
- `category`: `z.enum(['books', 'manuscripts', 'conferences']).default('manuscripts')`
- `collection`: `z.literal('publications').default('publications')`
- `permalink`: `z.string().optional()`
- `citation`: `z.string().optional()`
- `paperurl`: `z.string().optional()`
- `codeurl`: `z.string().optional()`
- `slidesurl`: `z.string().optional()`
- `bibtexurl`: `z.string().optional()`
- `excerpt`: `z.string().optional()`

### 3.2 Talks (`src/content/talks/*.md`)

- `title`: `z.string()` (required)
- `date`: `z.coerce.date()` (required)
- `venue`: `z.string().optional()`
- `location`: `z.string().optional()`
- `type`: `z.string().optional()` (e.g. 'Talk', 'Tutorial', 'Keynote')
- `talk_type`: `z.string().optional()`
- `collection`: `z.literal('talks').default('talks')`
- `permalink`: `z.string().optional()`
- `slidesurl`: `z.string().optional()`
- `excerpt`: `z.string().optional()`

### 3.3 Teaching (`src/content/teaching/*.md`)

- `title`: `z.string()` (required)
- `date`: `z.coerce.date()` (required)
- `type`: `z.string().optional()` (e.g. 'Undergraduate course', 'Graduate course')
- `venue`: `z.string().optional()`
- `location`: `z.string().optional()`
- `collection`: `z.literal('teaching').default('teaching')`
- `permalink`: `z.string().optional()`
- `excerpt`: `z.string().optional()`

### 3.4 Blog Posts (`src/content/blog/*.md`)

- `title`: `z.string()` (required)
- `date`: `z.coerce.date()` (required)
- `modified`: `z.coerce.date().optional()`
- `permalink`: `z.string().optional()`
- `tags`: `z.array(z.string()).default([])`
- `categories`: `z.array(z.string()).default([])`
- `excerpt`: `z.string().optional()`
- `read_time`: `z.boolean().default(true)`
- `author_profile`: `z.boolean().default(true)`
- `draft`: `z.boolean().default(false)`

### 3.5 Portfolio (`src/content/portfolio/*.md`)

- `title`: `z.string()` (required)
- `date`: `z.coerce.date().optional()`
- `collection`: `z.literal('portfolio').default('portfolio')`
- `permalink`: `z.string().optional()`
- `excerpt`: `z.string().optional()`

### 3.6 Pages (`src/content/pages/*.md`)

- `title`: `z.string()` (required)
- `permalink`: `z.string().optional()`
- `author_profile`: `z.boolean().default(true)`
- `redirect_from`: `z.array(z.string()).default([])`

---

## 4. URL & Permalink Structure Mapping (Task 1.3)

| Jekyll Source URL                            | Astro Route / Destination                      | Notes / Behavior                                            |
| :------------------------------------------- | :--------------------------------------------- | :---------------------------------------------------------- |
| `/`                                          | `src/pages/index.astro`                        | Home / About page (`_pages/about.md`)                       |
| `/posts/YYYY/MM/title/`                      | `src/pages/posts/[...slug].astro`              | Single blog post permalink                                  |
| `/year-archive/`                             | `src/pages/year-archive.astro`                 | Full reverse-chronological post listing                     |
| `/posts/`                                    | `src/pages/posts/index.astro`                  | Alternative blog index                                      |
| `/publication/:slug` / `/publications/:slug` | `src/pages/publications/[...slug].astro`       | Single publication paper details                            |
| `/publications/`                             | `src/pages/publications/index.astro`           | Categorized publication list (Books, Journals, Conferences) |
| `/talks/:slug`                               | `src/pages/talks/[...slug].astro`              | Single talk details page                                    |
| `/talks/`                                    | `src/pages/talks/index.astro`                  | Chronological talk & presentation list                      |
| `/teaching/:slug`                            | `src/pages/teaching/[...slug].astro`           | Single course description                                   |
| `/teaching/`                                 | `src/pages/teaching/index.astro`               | Teaching portfolio list                                     |
| `/portfolio/:slug`                           | `src/pages/portfolio/[...slug].astro`          | Single portfolio project                                    |
| `/portfolio/`                                | `src/pages/portfolio/index.astro`              | Portfolio grid / list                                       |
| `/cv/`                                       | `src/pages/cv.astro`                           | Curriculum Vitae                                            |
| `/markdown/`                                 | `src/pages/markdown.astro`                     | Academic Pages Markdown & Math syntax guide                 |
| `/feed.xml` / `/rss.xml`                     | `src/pages/rss.xml.ts`                         | Atom / RSS 2.0 XML feed                                     |
| `/sitemap/`                                  | `src/pages/sitemap.astro` & `@astrojs/sitemap` | HTML Sitemap & XML sitemap index                            |
| `/404.html`                                  | `src/pages/404.astro`                          | Error 404 page                                              |

---

## 5. Layout Hierarchy

```
BaseLayout.astro (HTML, HeadSEO, Body)
├── Masthead.astro (Top Navigation Bar + ThemeToggle)
├── 2-Column Container (max-w-7xl mx-auto)
│   ├── Aside: AuthorProfile.astro (Sticky author card on desktop)
│   └── Main:
│       ├── Breadcrumbs.astro
│       └── <slot /> (SingleLayout / ArchiveLayout / Custom Page)
└── Footer.astro (Footer links & copyright)
```
