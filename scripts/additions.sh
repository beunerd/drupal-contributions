#!/bin/bash
set -e

# Create symlink to modules development folder.
ln -sfn /app/modules web/modules/custom

# Get default modules via composer.
cd /app/web
sed -i 's/.*"php".*//' ./composer.json
composer config minimum-stability 'dev'
composer config allow-plugins.cweagans/composer-patches true
composer require --prefer-dist --optimize-autoloader cweagans/composer-patches:^2 drupal/admin_toolbar drupal/gin:^3.0 drupal/gin_toolbar:^1.0 drupal/devel:^5.1 drupal/devel_kint_extras:^1.1 kint-php/kint:^4.0 vlucas/phpdotenv:^5.5 -W
cd /

# Link to custom configuration.
ln -s /app/config/additions /app/web/additions

# Import configuration items.
/app/web/vendor/drush/drush/drush --root=/app/web cim --partial --source=additions/ -y

# Set default admin theme.
/app/web/vendor/drush/drush/drush --root=/app/web config-set system.theme admin gin -y

# Link to lando settings.
ln -s /app/scripts/settings.lando.php /app/web/sites/default/settings.lando.php

tee -a /app/web/sites/default/settings.php >/dev/null <<'EOF'

if (file_exists($app_root . '/' . $site_path . '/settings.lando.php')) {
  include $app_root . '/' . $site_path . '/settings.lando.php';
}
EOF
