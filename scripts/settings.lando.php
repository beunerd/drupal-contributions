<?php

// @codingStandardsIgnoreFile

// File locations
$settings['file_temp_path'] = '/app/tmp';
$settings['file_private_path'] = '/app/private';
$settings['file_public_path'] = 'sites/default/files';
$settings['file_assets_path'] = 'sites/default/optimized_cache';
$settings['php_storage']['twig']['directory'] = 'sites/default/optimized_cache/php';
$settings['file_scan_ignore_directories'] = [
  'node_modules',
  'bower_components',
];

// Set local db user to be 'root' so that drush can manage db imports properly.
$databases['default']['default']['username'] = 'root';
$databases['default']['default']['password'] = '';

// Development overrides
$config['system.logging']['error_level'] = 'verbose';
$config['user.role.anonymous']['permissions'][999] = 'access devel information';
$settings['container_yamls'][] = DRUPAL_ROOT . '/sites/development.services.yml';
$config['system.performance']['css']['preprocess'] = FALSE;
$config['system.performance']['js']['preprocess'] = FALSE;
$settings['rebuild_access'] = TRUE;
$settings['skip_permissions_hardening'] = TRUE;
$settings['cache']['bins']['render'] = 'cache.backend.null';
$settings['cache']['bins']['page'] = 'cache.backend.null';
$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';

// Configuration
$config['config_split.config_split.local']['status'] = TRUE;
$settings['config_sync_directory'] = '/app/config/sync';

// Kint
include_once('vendor/kint-php/kint/src/Kint.php');
if (class_exists('Kint')) {
  \Kint::$depth_limit = 4;
}
