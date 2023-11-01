<?php

/**
 * @file
 * Get Drupal source code if we haven't already.
 */

include '/app/config/drupal-branch.php';

exec(
  "git clone --branch $drupalBranch --depth 1 https://git.drupalcode.org/project/drupal.git web"
);
// exec(
//   "mkdir web && cp -r drupal-$drupalBranch/* web"
// );
