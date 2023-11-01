#!/bin/bash
set -e

# Create symlink within lando to the other folder location with modules work.
ln -sfn /user/Sites/drupal-contributions--modules web/modules/custom

# Create symlink that we can actually use to make edits directly from this project.
ln -sfn ../../../drupal-contributions--modules web/modules/custom_host

# Get default modules via composer.
cd /app/web
composer require drupal/admin_toolbar drupal/gin drupal/gin_toolbar drupal/devel drupal/devel_kint_extras kint-php/kint:^3.3
cd ..

# Enable modules and theme.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site en admin_toolbar,devel,devel_kint_extras, -y
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site config-set system.theme admin gin -y

# Copy over custom configuration.
cp additions/core.extensions.yml web/partials/
cp additions/devel.settings.yml web/partials/
cp additions/devel.toolbar.settings.yml web/partials/
cp additions/system.menu.devel.yml web/partials/

# Import configuration items.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site cim --partial --source=partials/ -y

# Return a one-time login link.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site uli
