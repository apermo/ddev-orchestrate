# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - Unreleased

### Added

- `ddev orchestrate` command for full WordPress setup
- `ddev wp` WP-CLI wrapper for `php` project types
- Fragment-based orchestration (download, config, install, activate)
- wp-config.php template with DDEV database credentials
- Multisite support via `WP_MULTISITE` and `WP_MULTISITE_SUBDOMAIN` env vars
- `ddev orchestrate --reset` flag for clean reinstallation
- `25-configure-multisite.sh` fragment for wp-config.php constants
- Network activation for plugins and themes in multisite mode
- BATS test suite
- Database import via `WP_DB_IMPORT` env var with automatic URL replacement
