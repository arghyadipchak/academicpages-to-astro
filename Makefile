.PHONY: help dev build preview typecheck lint format test verify upstream-status upstream-update upstream-diff

help:
	@echo "Academic Pages → Astro (academicpages-to-astro)"
	@echo "----------------------------"
	@echo "make dev             - Start Astro development server"
	@echo "make build           - Build production static site"
	@echo "make verify          - Run full quality gate (lint, format:check, typecheck, build)"
	@echo "make test            - Run Playwright test suite"
	@echo "make upstream-status - Check git submodule status"
	@echo "make upstream-update - Pull latest upstream Jekyll changes"
	@echo "make upstream-diff   - Show diff between synced commit and upstream"

dev:
	pnpm --dir academicpages-astro dev

build:
	pnpm --dir academicpages-astro build

preview:
	pnpm --dir academicpages-astro preview

typecheck:
	pnpm --dir academicpages-astro typecheck

lint:
	pnpm --dir academicpages-astro lint

format:
	pnpm --dir academicpages-astro format

test:
	pnpm --dir academicpages-astro test

verify:
	pnpm --dir academicpages-astro verify

upstream-status:
	git submodule status

upstream-update:
	git submodule update --remote --merge

upstream-diff:
	git -C academicpages-jekyll diff HEAD@{1}..HEAD
