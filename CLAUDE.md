# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Rails 8.1 + MySQL 8.4 CRUD application running in Docker. Uses Propshaft (not Sprockets), importmap (no Node.js), and a custom "Materially" theme built on Bootstrap 5.3 with dartsass-rails.

## Commands

All commands run inside Docker containers:

```bash
# Start services
docker compose up -d

# Stop services
docker compose down

# Rails console
docker compose run --rm web rails console

# Run migrations
docker compose run --rm web rails db:migrate

# Generate scaffold/model/controller
docker compose run --rm web rails g scaffold ModelName field:type

# Build CSS (after SCSS changes)
docker compose run --rm web rails dartsass:build

# Run all tests
docker compose run --rm web rails test

# Run a single test file
docker compose run --rm web rails test test/controllers/posts_controller_test.rb

# Run a single test by line number
docker compose run --rm web rails test test/controllers/posts_controller_test.rb:10

# Lint
docker compose run --rm web bin/rubocop

# Security scan
docker compose run --rm web bin/brakeman
```

## Architecture

- **Asset pipeline**: Propshaft + dartsass-rails. SCSS lives in `app/assets/stylesheets/application.scss`. After editing SCSS, run `rails dartsass:build` — the built CSS goes to `app/assets/builds/`.
- **JavaScript**: importmap-rails (no bundler). Pins are in `config/importmap.rb`. Stimulus controllers in `app/javascript/controllers/`.
- **Frontend**: Hotwire (Turbo + Stimulus). No React/Vue. Pages use server-rendered ERB with Turbo Drive/Frames.
- **Styling**: Bootstrap 5.3 variables are overridden *before* `@import "bootstrap"` in `application.scss`. Custom Materially theme adds sidebar layout, card styles, typography (Poppins font). The bootstrap gem's SCSS path is added in `config/application.rb`.
- **Layout**: `app/views/layouts/application.html.erb` implements a fixed sidebar (280px) + top header + main content area. Views use `content_for :breadcrumb` for breadcrumb navigation.
- **Database**: MySQL 8.4 with utf8mb4 encoding. Connection configured via `DATABASE_HOST` and `DATABASE_PASSWORD` env vars. Production uses separate databases for Solid Cache/Queue/Cable.
- **Docker**: Development Dockerfile uses full `ruby:3.3` image (not slim). Host port 3307 maps to MySQL 3306 (3306 was occupied). Volume-mounted app directory for live code reloading.

## Key Conventions

- Linting follows `rubocop-rails-omakase` (Rails team defaults)
- Test framework is Minitest with parallel workers
- CI runs: brakeman, bundler-audit, importmap audit, rubocop, test, system test
