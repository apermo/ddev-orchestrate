#!/usr/bin/env bash

# Run WordPress core installation if not already installed.

if wp core is-installed --path="${WP_PATH}" 2>/dev/null; then
    echo "WordPress already installed."
    return 0
fi

SITE_URL="${DDEV_PRIMARY_URL:-https://${DDEV_HOSTNAME}}"
SITE_TITLE="${DDEV_PROJECT:-WordPress}"

echo "Installing WordPress..."
wp core install \
    --url="${SITE_URL}" \
    --title="${SITE_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --locale="${WP_LOCALE}" \
    --path="${WP_PATH}" \
    --skip-email

echo "WordPress installed at ${SITE_URL}"
