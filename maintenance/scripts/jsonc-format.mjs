/*
 * DO NOT EDIT! Automatically generated from template file:
 * npm-packages-helper/templates/common/maintenance/scripts/jsonc-format-liquid.mjs
 *
 * This file is part of the µOS++ project (https://micro-os-plus.github.io/).
 * Copyright (c) 2026 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can be
 * obtained from https://opensource.org/licenses/mit.
 */

// ----------------------------------------------------------------------------

import { format, applyEdits } from 'jsonc-parser'
import { readFileSync, writeFileSync, statSync, chmodSync, constants } from 'fs'
import { globSync } from 'glob'

// The `xcdl*.json` is included temporarily, until it'll be renamed as jsonc.
const files = globSync(['**/*.jsonc', '**/xcdl*.json'], {
  ignore: [
    '**/node_modules/**',
    '**/xpacks/**',
    '**/builds/**',
    '**/website/**',
  ],
})

for (const file of files) {
  const mode = statSync(file).mode
  chmodSync(file, mode | constants.S_IWUSR)
  const text = readFileSync(file, 'utf8')
  const edits = format(text, undefined, { tabSize: 2, insertSpaces: true })
  const formatted = applyEdits(text, edits)
  writeFileSync(file, formatted)
  chmodSync(file, mode)

  console.log(file)
}

// ----------------------------------------------------------------------------
