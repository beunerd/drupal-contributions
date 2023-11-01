#!/bin/bash
set -e

# Create symlink to modules development folder.
ln -sfn /app/modules web/modules/custom

# Get default modules via composer.
cd /app/web
composer config minimum-stability 'dev'
composer config repositories.0 '{"type": "composer", "url": "https://packages.drupal.org/8"}'
composer config repositories.devel_kint_extras '{"type": "package", "package": {"name": "devel_kint_extras/devel_kint_extras", "version": "1.0", "type": "drupal-module", "source": {"url": "https://git.drupalcode.org/issue/devel_kint_extras-3277126.git", "type": "git", "reference": "3277126-support-kint-phpkint-version"}}}'
composer require --prefer-dist --optimize-autoloader drush/drush:11.0.5 drupal/admin_toolbar drupal/gin drupal/gin_toolbar drupal/devel:^4.1 devel_kint_extras/devel_kint_extras:^1.0 kint-php/kint:^4.0 drupal/console -W
cd ..

# Enable modules and theme.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site en admin_toolbar,devel,devel_kint_extras, -y

# Copy over custom configuration.
mkdir -p web/partials
cp additions/* web/partials/

# Import configuration items.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site cim --partial --source=partials/ -y

# Set default admin theme.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site config-set system.theme admin gin -y

# Remove unnecessary config.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site cdel block.block.gin_account_menu -y
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site cdel block.block.gin_main_menu -y
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site cdel block.block.gin_powered -y
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site cdel block.block.gin_search_form_narrow -y
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site cdel block.block.gin_search_form_wide -y
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site cdel block.block.gin_site_branding -y
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site cdel block.block.gin_syndicate -y

# Copy over lando settings.
cp scripts/settings.lando.php web/sites/default/

# Return a one-time login link.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site uli
