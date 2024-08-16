/*
 * DO NOT EDIT!
 * Automatically generated from xbb-helper/templates/docusaurus/common.
 *
 * This file is part of the xPack project (http://xpack.github.io).
 * Copyright (c) 2024 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software
 * for any purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can
 * be obtained from https://opensource.org/licenses/MIT/.
 */

import customField from '@site/src/libs/customField';

export default function getVersionMinor() {
  // Remove from the beginning to the first dot and, in the remaining string
  // from the first dot to the end.
  return parseInt(customField('upstreamVersion').replace(/^[0-9]*[.]/, '').replace(/[.].*/, ''), 10);
}
