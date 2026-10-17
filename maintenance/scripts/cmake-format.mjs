/*
 * DO NOT EDIT! Automatically generated from template file:
 * npm-packages-helper/templates/common/maintenance/scripts/cmake-format-liquid.mjs
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

// pip3 install --user cmakelang pyyaml

import { execFileSync } from 'child_process'
import { globSync } from 'glob'
import path from 'path'

const pyUserBase = execFileSync('python3', ['-m', 'site', '--user-base'], {
  encoding: 'utf8',
}).trim()
const cmakeFormatPath = path.join(pyUserBase, 'bin', 'cmake-format')

const version = execFileSync(cmakeFormatPath, ['--version'], {
  encoding: 'utf8',
}).trim()
console.log(`cmake-format ${version}`)

const files = globSync(['**/CMakeLists.txt', '**/*.cmake'], {
  ignore: [
    '**/build/**',
    '**/xpacks/**',
    '**/node_modules/**',
    '**/stm32cubemx/**',
  ],
})

const args = [
  '--config-file',
  'maintenance/config/.cmake-format.py',
  '--in-place',
  ...files,
]

console.log()
console.log(`[${cmakeFormatPath} ${args.join(' ')}]`)

execFileSync(cmakeFormatPath, args, { stdio: 'inherit' })

// ----------------------------------------------------------------------------
