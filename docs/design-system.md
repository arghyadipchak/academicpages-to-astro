# Academic Pages Design System & Tokens

This document details the visual design specifications extracted from `academicpages` (based on Minimal Mistakes) and their Tailwind CSS v4 translation.

---

## 1. Color Palette & Tokens

### Light Theme (Default)

| Token Name          | Jekyll SCSS Variable        | Hex / Value | CSS Custom Property              |
| :------------------ | :-------------------------- | :---------- | :------------------------------- |
| **Primary Accent**  | `$primary-color`            | `#2f7f93`   | `--global-base-color`            |
| **Link Color**      | `--global-link-color`       | `#52adc8`   | `--global-link-color`            |
| **Link Hover**      | `--global-link-color-hover` | `#235f6e`   | `--global-link-color-hover`      |
| **Text Main**       | `$dark-gray`                | `#494e52`   | `--global-text-color`            |
| **Text Muted**      | `$gray`                     | `#7a8288`   | `--global-text-color-light`      |
| **Background Body** | `$background`               | `#ffffff`   | `--global-bg-color`              |
| **Background Alt**  | `$lighter-gray`             | `#f2f3f3`   | `--global-footer-bg-color`       |
| **Border Color**    | `$lighter-gray`             | `#f2f3f3`   | `--global-border-color`          |
| **Dark Border**     | `$light-gray`               | `#bdc1c4`   | `--global-dark-border-color`     |
| **Code Background** | `$code-background`          | `#fafafa`   | `--global-code-background-color` |
| **Code Text**       | `$darker-gray`              | `#313436`   | `--global-code-text-color`       |

### Dark Theme (`html[data-theme="dark"]`, `.dark`)

| Token Name          | Value     | CSS Custom Property              |
| :------------------ | :-------- | :------------------------------- |
| **Primary Accent**  | `#0ea1c5` | `--global-base-color`            |
| **Link Color**      | `#0ea1c5` | `--global-link-color`            |
| **Link Hover**      | `#61afef` | `--global-link-color-hover`      |
| **Text Main**       | `#e5e7eb` | `--global-text-color`            |
| **Text Muted**      | `#9ca3af` | `--global-text-color-light`      |
| **Background Body** | `#282c34` | `--global-bg-color`              |
| **Background Alt**  | `#21252b` | `--global-footer-bg-color`       |
| **Border Color**    | `#3e4451` | `--global-border-color`          |
| **Dark Border**     | `#4b5263` | `--global-dark-border-color`     |
| **Code Background** | `#21252b` | `--global-code-background-color` |
| **Code Text**       | `#abb2bf` | `--global-code-text-color`       |

---

## 2. Typography

- **Body Font**: `-apple-system, BlinkMacSystemFont, "Roboto", "Segoe UI", "Helvetica Neue", "Lucida Grande", Arial, sans-serif`
- **Headings Font**: `-apple-system, BlinkMacSystemFont, "Roboto", "Segoe UI", "Helvetica Neue", "Lucida Grande", Arial, sans-serif`
- **Monospace Font**: `Monaco, Consolas, "Lucida Console", Menlo, monospace`
- **Caption / Quote Font**: `Georgia, Times, serif`
- **Base Font Size**: `16px` (`1rem`)
- **Body Line Height**: `1.6`

---

## 3. Layout Grid & Breakpoints

- **Max Container Width**: `1280px` (`max-w-7xl`)
- **Desktop Breakpoint**: `1024px` (`lg:`)
- **Sidebar Width**: `260px` to `300px` (`w-64` / `w-72`)
- **Content Column**: Flexible (`flex-1 min-w-0`)
- **Gutters**: `1.5rem` (`24px`) on mobile, `2rem` (`32px`) on desktop
- **Masthead Height**: `60px` to `70px`

---

## 4. Component Visual Rules

### Author Profile Sidebar

- Avatar: Rounded-full circle, `120px` to `150px` diameter with subtle border
- Name: Bold, `1.25rem` (`font-bold text-xl`)
- Bio: Text muted, `0.875rem` (`text-sm text-neutral-600 dark:text-neutral-400`)
- Social Links: Vertical icon list with text label, hover transition to accent color

### Masthead (Top Navigation)

- Sticky top navigation with light/dark adaptive background and subtle bottom border
- Site Title: Bold sans-serif (`font-bold text-lg`)
- Nav Items: Horizontal list with active selection indicator (`border-b-2 border-brand-primary` / text accent); responsive dropdown/drawer on mobile
- Theme Toggle: Interactive icon button switching light/dark state

### Archive Item / Teaser

- Title: `text-xl font-semibold` with link styling
- Meta line: Date, venue, or category in `text-sm text-neutral-500`
- Excerpt: Brief prose description
- Links / Badges: Button-style or text links for `[Download Paper]`, `[Download Slides]`, `[Download Bibtex]`, `[Code]`
