#!/usr/bin/env bats

setup() {
    export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
}

@test "install.yaml exists and is valid" {
    [ -f "$DIR/install.yaml" ]
    grep -q "name: ddev-orchestrate" "$DIR/install.yaml"
}

@test "orchestrate command exists and is executable" {
    [ -x "$DIR/commands/web/orchestrate" ]
}

@test "wp command exists and is executable" {
    [ -x "$DIR/commands/web/wp" ]
}

@test "all fragments exist and are executable" {
    [ -x "$DIR/orchestrate/fragments/00-download-wordpress.sh" ]
    [ -x "$DIR/orchestrate/fragments/10-create-wp-config.sh" ]
    [ -x "$DIR/orchestrate/fragments/20-install-wordpress.sh" ]
    [ -x "$DIR/orchestrate/fragments/25-configure-multisite.sh" ]
    [ -x "$DIR/orchestrate/fragments/30-activate-project.sh" ]
}

@test "wp-config template exists" {
    [ -f "$DIR/orchestrate/templates/wp-config.php.tpl" ]
}

@test "wp-config template contains placeholders" {
    grep -q "{{DB_NAME}}" "$DIR/orchestrate/templates/wp-config.php.tpl"
    grep -q "{{DB_USER}}" "$DIR/orchestrate/templates/wp-config.php.tpl"
    grep -q "{{DB_PASSWORD}}" "$DIR/orchestrate/templates/wp-config.php.tpl"
    grep -q "{{DB_HOST}}" "$DIR/orchestrate/templates/wp-config.php.tpl"
}

@test "fragments are numbered sequentially" {
    ls "$DIR/orchestrate/fragments/" | head -1 | grep -q "^00-"
    ls "$DIR/orchestrate/fragments/" | sed -n '2p' | grep -q "^10-"
    ls "$DIR/orchestrate/fragments/" | sed -n '3p' | grep -q "^20-"
    ls "$DIR/orchestrate/fragments/" | sed -n '4p' | grep -q "^25-"
    ls "$DIR/orchestrate/fragments/" | sed -n '5p' | grep -q "^30-"
}

@test "install.yaml lists all fragments" {
    grep -q "25-configure-multisite.sh" "$DIR/install.yaml"
}

@test "orchestrate command supports --reset flag" {
    grep -q "\-\-reset" "$DIR/commands/web/orchestrate"
}
