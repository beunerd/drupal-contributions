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

# Copy over custom configuration.
mkdir -p web/partials
cp additions/* web/partials/

# Import configuration items.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site cim --partial --source=partials/ -y

# Set default admin theme.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site config-set system.theme admin gin -y

# Return a one-time login link.
web/vendor/drush/drush/drush --root=/app/web --uri=https://drupal-contributions.lndo.site uli