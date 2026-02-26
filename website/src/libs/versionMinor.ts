/*
 * DO NOT EDIT!
 * Automatically generated from docusaurus-template-liquid/templates/docusaurus.
 *
 * This file is part of the xPack project (http://xpack.github.io).
 * Copyright (c) 2024-2026 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software
 * for any purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can
 * be obtained from https://opensource.org/licenses/mit.
 */

export default function getVersionMinor(version: string): number {
  // Remove from the beginning to the first dot and, in the remaining string
  // from the first dot to the end.
  return parseInt(version.replace(/^[0-9]*[.]/, '').replace(/[.].*/, ''), 10);
}
