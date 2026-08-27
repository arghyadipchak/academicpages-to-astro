---
name: jekyll-to-astro
description: Expert runbook and transformation rules for migrating Jekyll Academic Pages (Liquid templates, SCSS skins, collections, frontmatter schemas) to Astro 7 + TypeScript + Tailwind CSS v4
---

# Jekyll to Astro Migration Skill 🎓⚡

Use this skill when converting Jekyll templates, includes, collections, or SCSS to Astro 7 components and Tailwind CSS v4

---

## 1. Syntax & Template Translation

| Jekyll / Liquid | Astro 7 / TypeScript | Notes |
| :--- | :--- | :--- |
| `{% include file.html prop="val" %}` | `<File prop="val" />` | Import component in Astro frontmatter |
| `{{ content }}` | `<slot />` | Standard slot in layout components |
| `{% if page.title %}...{% endif %}` | `{title && ( ... )}` | JSX conditional expression |
| `{% for post in site.posts %}...{% endfor %}` | `{posts.map((post) => ( ... ))}` | Map over typed collection entries |
| `{{ post.date \| date: "%B %d, %Y" }}` | `{new Date(post.data.date).toLocaleDateString(...)}` | Native JS Date formatting |
| `{{ page.url \| relative_url }}` | `import.meta.env.BASE_URL + ...` | Or absolute path routing |
| `{% include base_path %}` | Not needed in Astro | Root-relative paths by default |
| `{{ page.citation }}` | `<div class="citation" set:html={citation} />` | Render HTML citations |

---

## 2. Dual-Submodule Architecture Mapping

```
Upstream Jekyll Reference               Target Astro 7 Implementation
(academicpages-jekyll/)                 (academicpages-astro/)
------------------------                -----------------------------
_config.yml                             src/data/siteConfig.ts & navigation.ts
_layouts/default.html                   src/layouts/BaseLayout.astro
_layouts/single.html                    src/layouts/SingleLayout.astro
_layouts/archive.html                   src/layouts/ArchiveLayout.astro
_includes/masthead.html                 src/components/Masthead.astro
_includes/author-profile.html           src/components/AuthorProfile.astro
_includes/footer.html                   src/components/Footer.astro
_includes/breadcrumbs.html              src/components/Breadcrumbs.astro
_includes/archive-single.html           src/components/ArchivePost.astro
_includes/archive-single-cv.html        src/components/ArchivePublication.astro, etc.
_posts/YYYY-MM-DD-title.md              src/content/blog/YYYY-MM-DD-title.md
_publications/YYYY-MM-DD-title.md       src/content/publications/YYYY-MM-DD-title.md
_talks/YYYY-MM-DD-title.md              src/content/talks/YYYY-MM-DD-title.md
_teaching/YYYY-semester-title.md        src/content/teaching/YYYY-semester-title.md
_portfolio/portfolio-X.md               src/content/portfolio/portfolio-X.md
_pages/*.md                             src/content/pages/*.md & src/pages/*.astro
_sass/_variables.scss                   src/styles/global.css (@theme variables)
images/*                                public/images/*
files/*                                 public/files/*
```

---

## 3. Astro 7 Content Layer API (`src/content.config.ts`)

Astro 7 uses the Content Layer API with `glob` loaders and Zod schemas:

```typescript
import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

export const collections = {
  blog: defineCollection({
    loader: glob({ pattern: '**/*.{md,mdx}', base: './src/content/blog' }),
    schema: z.object({
      title: z.string(),
      date: z.coerce.date(),
      excerpt: z.string().optional(),
      tags: z.array(z.string()).default([]),
      categories: z.array(z.string()).default([]),
      header: z.object({ teaser: z.string().optional() }).optional(),
      draft: z.boolean().default(false),
    }),
  }),
  publications: defineCollection({
    loader: glob({ pattern: '**/*.{md,mdx}', base: './src/content/publications' }),
    schema: z.object({
      title: z.string(),
      collection: z.literal('publications').default('publications'),
      date: z.coerce.date(),
      venue: z.string().optional(),
      citation: z.string().optional(),
      paperurl: z.string().optional(),
      slidesurl: z.string().optional(),
      bibtexurl: z.string().optional(),
      category: z.enum(['manuscripts', 'conferences', 'books']).default('conferences'),
    }),
  }),
};
```

---

## 4. Modern Academic Enhancements (Patterns)

1. **1-Click BibTeX Copy (`ActionBadges.astro`)**:
   - Fetch the raw `.bib` string or pass it into client data attributes
   - Use `navigator.clipboard.writeText(bibtex)` with visual checkmark feedback
2. **Instant Search (`SearchModal.astro` + `api/search.json.ts`)**:
   - Static endpoint generates search index at build time
   - Lightweight modal with `Cmd+K` keyboard shortcut and real-time substring matching
3. **Sticky Scrollspy Table of Contents (`TableOfContents.astro`)**:
   - `IntersectionObserver` observing `h2` and `h3` heading anchors
4. **Interactive Category Filtering**:
   - Tab pills for `#manuscripts`, `#conferences`, `#books` with hash-synced query state

---

## 5. Critical Rendering & Typography Pitfalls & Solutions

1. **Frontmatter Strings vs Markdown AST Math Parsing**:
   - Frontmatter YAML fields (`title`, `excerpt`, `citation`) are plain strings in Astro JSX and bypass `remark-math` / `rehype-katex` markdown pipelines
   - **Solution**: Use build-time KaTeX rendering helper (`src/utils/math.ts`) with `set:html={renderMath(title)}` across all layouts, archive cards, and CV listings
2. **Optical Midpoint & Baseline Alignment for Icon + Text UI**:
   - SVG icons paired with text in flex containers align bounding boxes, causing visible font ascender/descender misalignment (~75% cap-height vs 25% descender area)
   - **Solution**:
     - Standardize fixed-width icon columns (`1.125rem` / `w-4` centered) for sidebar links
     - Apply optical midpoint vertical compensation (`top: -0.5px` with `leading-none`) for action badges and button chips
3. **Reactive Theme Switching for Client Diagrams (Mermaid & Plotly)**:
   - Dynamic dark/light mode toggles must not require full page refreshes to re-render diagrams
   - **Solution**: Dispatch custom `'theme-change'` event on toggle and use a `MutationObserver` on `html[data-theme]` inside `ProseEnhancer.astro` to dynamically re-render Mermaid SVGs and call `Plotly.relayout()`
4. **Sticky Sidebar Scroll Mathematics**:
   - When layout containers have top padding below a sticky masthead (`56px` + `32px` = `88px`), sticky sidebars must have `top: calc(masthead + padding)` (`top-[5.5rem]`) to eliminate initial scroll jump/slide
5. **KaTeX Dual-Tree DOM Isolation & Font Preloading**:
   - Prevent MathML duplicate text collisions with `.katex-mathml { display: none !important; }` in `global.css`
   - Include high-priority KaTeX stylesheet link in `HeadSEO.astro`
6. **Full Semantic HTML Typography Coverage**:
   - Provide complete `.prose` rules for `<q>`, `<cite>`, `<blockquote>`, `<abbr>`, `<kbd>`, `<mark>`, `<ins>`, `<var>`, `<address>`, `<sub>`, and `<sup>`

---

## 6. Quality Verification Loop

Run all quality checks from the project root:

```bash
# Typecheck, lint, format check, and production static build
make verify

# Playwright automated browser test suite (Desktop & Mobile viewports)
make test
```
