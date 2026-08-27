---
name: upstream-sync
description: Autonomous runbook for pulling upstream Jekyll Academic Pages updates, diffing changes, translating them to the Astro 7 template, and running verification tests
---

# Upstream Synchronization & Continuous Migration Skill 🔄

Use this skill whenever updates are published to the upstream Jekyll theme (`academicpages/academicpages.github.io`)

---

## 1. Upstream Sync Protocol

When instructed to check or sync upstream updates:

### Step 1: Check Current Submodule Status
```bash
make upstream-status
```
Inspect which commit `academicpages-jekyll` is currently tracking

### Step 2: Fetch & Pull Latest Upstream Commits
```bash
make upstream-update
```
This runs `git submodule update --remote --merge` in `academicpages-jekyll/`

### Step 3: Generate the Exact Diff
```bash
make upstream-diff
```
Or inspect the diff directly:
```bash
git -C academicpages-jekyll diff HEAD@{1}..HEAD
```

---

## 2. Change Categorization & Translation Matrix

Review the upstream diff and map changed files to the Astro template:

| Upstream Change Location | Impact / Action Needed in `academicpages-astro/` |
| :--- | :--- |
| **`_config.yml`** | Update `src/data/siteConfig.ts` or `src/data/navigation.ts` |
| **`_layouts/*.html`** | Update corresponding layout in `src/layouts/` (`BaseLayout.astro`, `SingleLayout.astro`, `ArchiveLayout.astro`) |
| **`_includes/*.html`** | Update corresponding component in `src/components/` |
| **`_sass/*.scss`** | Update design tokens in `src/styles/global.css` (@theme) |
| **`_posts/`, `_publications/`, etc.** | Add/update content markdown files in `src/content/<collection>/` |
| **`images/` or `files/`** | Copy new static assets into `public/images/` or `public/files/` |

---

## 3. Verification & Release Cycle

After applying changes:

1. **Verify Code Quality**:
   ```bash
   make verify
   ```
   Ensures 0 ESLint errors, 0 Prettier warnings, 0 `astro check` type errors, and clean static HTML compilation

2. **Verify Browser Functionality**:
   ```bash
   make test
   ```
   Runs the Playwright automated browser test suite across Desktop Chrome and Mobile Chrome viewports

3. **Commit Cleanly in Both Repositories**:
   - In `academicpages-astro/`:
     ```bash
     git -C academicpages-astro add .
     git -C academicpages-astro commit -m "sync: incorporate upstream academicpages update <summary>"
     ```
   - In root `academicpages-to-astro/`:
     ```bash
     git add academicpages-jekyll academicpages-astro docs/
     git commit -m "chore: sync submodules with upstream release <version/hash>"
     ```
