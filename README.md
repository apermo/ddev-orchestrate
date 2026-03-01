# ddev-orchestrate

[![CI](https://github.com/apermo/ddev-orchestrate/actions/workflows/ci.yml/badge.svg)](https://github.com/apermo/ddev-orchestrate/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

DDEV addon for WordPress project orchestration. Downloads WordPress, creates configuration, installs, and activates your plugin or theme — all in one command.

## Requirements

- [DDEV](https://ddev.readthedocs.io/) >= 1.24.0
- Project type: `php` (not `wordpress`)

## Installation

```bash
ddev add-on get apermo/ddev-orchestrate
ddev restart
```

## Usage

```bash
ddev start
ddev orchestrate
```

This runs all orchestration fragments in order:

1. **Download WordPress** — Downloads WP core via WP-CLI
2. **Create wp-config.php** — Generates config with DDEV database credentials
3. **Import database** — Imports a SQL dump if `WP_DB_IMPORT` is set (skips steps 4–5)
4. **Install WordPress** — Runs `wp core install` (or `multisite-install`)
5. **Configure multisite** — Writes multisite constants to wp-config.php (if enabled)
6. **Activate project** — Activates plugin or theme based on mode (network-aware)

### Database import

To import an existing database dump instead of a fresh install:

```env
# .ddev/.env
WP_DB_IMPORT=.ddev/db-dump.sql
```

Supports `.sql` and `.sql.gz` files. The path is relative to the project root. After import, the site URL is automatically replaced with the DDEV site URL via `wp search-replace`.

When `WP_DB_IMPORT` is set, the install and multisite-configure fragments are skipped.

### Reset

To switch between single-site and multisite (or do a clean reinstall):

```bash
ddev orchestrate --reset
```

This drops the database, removes wp-config.php, and reruns all fragments from scratch.

### WP-CLI wrapper

Since the project type is `php` (not `wordpress`), use the bundled wrapper:

```bash
ddev wp plugin list
ddev wp theme status
```

## Configuration

Create `.ddev/.env` to customize:

```env
WP_VERSION=latest
WP_LOCALE=en_US
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=admin
WP_ADMIN_EMAIL=admin@example.com
PROJECT_MODE=plugin
```

| Variable | Default | Description |
|----------|---------|-------------|
| `WP_VERSION` | `latest` | WordPress version to install |
| `WP_LOCALE` | `en_US` | WordPress locale |
| `WP_ADMIN_USER` | `admin` | Admin username |
| `WP_ADMIN_PASSWORD` | `admin` | Admin password |
| `WP_ADMIN_EMAIL` | `admin@example.com` | Admin email |
| `PROJECT_MODE` | `plugin` | `plugin` or `theme` |
| `WP_MULTISITE` | `0` | Set to `1` for multisite installation |
| `WP_MULTISITE_SUBDOMAIN` | `0` | Set to `1` for subdomain multisite |
| `WP_DB_IMPORT` | _(empty)_ | Path to SQL dump to import (relative to project root) |

## License

MIT — see [LICENSE](LICENSE) for details.
