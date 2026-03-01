# ddev-orchestrate

## Project Overview

DDEV addon for WordPress project orchestration. Provides `ddev orchestrate` to set up a full WordPress environment and `ddev wp` as a WP-CLI wrapper for `php` project types.

## Architecture

### Addon structure

```
install.yaml                    # DDEV addon manifest
commands/web/
  orchestrate                   # Main orchestrate command
  wp                            # WP-CLI wrapper
orchestrate/
  fragments/
    00-download-wordpress.sh    # Download WP core
    10-create-wp-config.sh      # Generate wp-config.php
    20-install-wordpress.sh     # Run wp core install
    30-activate-project.sh      # Activate plugin/theme
  templates/
    wp-config.php.tpl           # wp-config template
tests/
  test.bats                     # BATS test suite
```

### Fragment pattern

Fragments run in numeric order (00-, 10-, 20-, 30-). Each is sourced by the orchestrate command and has access to all environment variables. New fragments can be added by dropping numbered scripts into `orchestrate/fragments/`.

### Idempotency

All fragments are safe to re-run. They check for existing state before acting (e.g., skip download if WP is present, skip install if already installed).

## Commands

- `ddev orchestrate` — Run full WordPress setup
- `ddev wp [args]` — WP-CLI wrapper with correct `--path`

## Conventions

- CHANGELOG.md follows Keep a Changelog format
- Releases are automated via GitHub Actions based on CHANGELOG version headings
- Commits follow Conventional Commits specification
- Configuration via `.ddev/.env` environment variables
