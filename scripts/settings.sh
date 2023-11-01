#!/bin/sh

tee -a web/sites/default/default.settings.php >/dev/null <<'EOF'
if (file_exists($app_root . '/' . $site_path . '/settings.lando.php')) {
  include $app_root . '/' . $site_path . '/settings.lando.php';
}
EOF
