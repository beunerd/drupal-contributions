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
$databases['default']['default'] = [
  'database' => 'drupal',
  'username' => 'root',
  'password' => '',
  'prefix' => '',
  'host' => 'database',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
];

// Development overrides
$config['system.logging']['error_level'] = 'verbose';
$config['user.role.anonymous']['permissions'][999] = 'access devel information';
$settings['container_yamls'][] = $app_root . '/' . $site_path . '/local.services.yml';
$config['system.performance']['css']['preprocess'] = FALSE;
$config['system.performance']['js']['preprocess'] = FALSE;
$settings['rebuild_access'] = TRUE;
$settings['skip_permissions_hardening'] = TRUE;
$settings['config_sync_directory'] = '/app/config/sync';
// $settings['cache']['bins']['render'] = 'cache.backend.null';
// $settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';

// Kint
include_once('vendor/kint-php/kint/src/Kint.php');
if (class_exists('Kint')) {
  \Kint::$depth_limit = 4;
}

ini_set('memory_limit', '-1');
