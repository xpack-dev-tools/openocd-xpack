/*
 * DO NOT EDIT! Automatically generated from template file:
 * npm-packages-helper/templates/common/maintenance/scripts/xcdl-export-liquid.mjs
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

import fs from 'fs'
import path from 'path'
import { fileURLToPath } from 'url'
import { Liquid } from 'liquidjs'
import json5 from 'json5'

// ----------------------------------------------------------------------------

const scriptPath = fileURLToPath(import.meta.url)
const scriptFolderPath = path.dirname(scriptPath)
const scriptName = path.basename(scriptPath)
// The script resides in the `maintenance/scripts` folder.
// Walk two steps up to reach the project folder.
const projectFolderPath = path.dirname(path.dirname(scriptFolderPath))

// ----------------------------------------------------------------------------

const showUsage = () => {
  console.error()
  console.error(`Usage: ${scriptName} [--skip-meson] <xcdl-package.jsonc>`)
  console.error()
  console.error('Options:')
  console.error('  --skip-meson   do not generate the meson.build file')
}

const args = process.argv.slice(2)

const skipMeson = args.includes('--skip-meson')
const positionalArgs = args.filter((arg) => !arg.startsWith('--'))

const unknownOptions = args.filter(
  (arg) => arg.startsWith('--') && arg !== '--skip-meson'
)
if (unknownOptions.length > 0) {
  console.error(`Unknown option(s): ${unknownOptions.join(' ')}`)
  showUsage()
  process.exit(1)
}

if (positionalArgs.length < 1) {
  console.error('Missing mandatory <xcdl-package.jsonc> argument')
  showUsage()
  process.exit(1)
}

if (positionalArgs.length > 1) {
  console.error(`Too many arguments: ${positionalArgs.join(' ')}`)
  showUsage()
  process.exit(1)
}

// ----------------------------------------------------------------------------

const packageJsonPath = path.resolve(projectFolderPath, 'package.json')
if (!fs.existsSync(packageJsonPath)) {
  console.error(`missing mandatory ${packageJsonPath}...`)
  process.exit(1)
}

const xcdlJsoncPath = positionalArgs[0]
if (!fs.existsSync(xcdlJsoncPath)) {
  console.error(`missing mandatory ${xcdlJsoncPath}...`)
  showUsage()
  process.exit(1)
}

// ----------------------------------------------------------------------------

console.log()
console.log(`Processing '${xcdlJsoncPath}'...`)

const xcdlJson = json5.parse(fs.readFileSync(xcdlJsoncPath, 'utf8'))

if (!Array.isArray(xcdlJson.cdlComponents)) {
  console.error(`missing or invalid cdlComponents in '${xcdlJsoncPath}'...`)
  process.exit(1)
}

// Linearise the hierarchy: walk recursively through nested
// cdlComponents, prepending the parent id to each child id
// (separated by '.'), and collect all components into a flat array.
const flattenComponents = (components, parentId) => {
  const result = []
  for (const component of components) {
    const qualifiedId = parentId ? `${parentId}.${component.id}` : component.id
    // Separately extract the options, and no longer put it back.
    const { cdlComponents: children, cdlOptions: options, ...rest } = component
    if (Array.isArray(children) && children.length > 0) {
      const childIds = children.map((child) => `${qualifiedId}.${child.id}`)
      const deps = Array.isArray(rest.dependencies)
        ? [...rest.dependencies, ...childIds]
        : childIds
      result.push({ ...rest, id: qualifiedId, dependencies: deps })
      result.push(...flattenComponents(children, qualifiedId))
    } else {
      result.push({ ...rest, id: qualifiedId })
    }
  }
  return result
}
xcdlJson.cdlComponents = flattenComponents(xcdlJson.cdlComponents, null)

// Topologically sort cdlComponents so that components referenced in
// another component's `dependencies` appear before that component.

// The topological sort uses Kahn's algorithm:
// It builds an in-degree map and a successors map from each component's
// dependencies (filtered to only IDs that exist within cdlComponents).
// Components with no intra-list dependencies are enqueued first, then
// successors are unlocked as their prerequisites are emitted.
// If a cycle is detected (sorted.length !== components.length), the
// script exits with an error.

const components = xcdlJson.cdlComponents

// Set of all component IDs in the list, used to filter dependencies
// to only those that refer to other components within the same list.
const known = new Set(components.map((c) => c.id))

// Map from component ID to the number of intra-list prerequisites
// that have not yet been emitted (initially 0 for every component).
const inDegree = new Map(components.map((c) => [c.id, 0]))

// Map from component ID to the list of component IDs that depend on
// it, i.e., the components that become unblocked once it is emitted.
const successors = new Map(components.map((c) => [c.id, []]))

// Populate inDegree and successors by examining each component's
// dependencies. Only intra-list dependencies (those present in
// `known`) are considered; external references are ignored.
for (const component of components) {
  for (const depId of component.dependencies ?? []) {
    if (known.has(depId)) {
      // depId must appear before component
      successors.get(depId).push(component.id)
      inDegree.set(component.id, inDegree.get(component.id) + 1)
    }
  }
}

// Reverse lookup from ID to the full component object, needed when
// building the sorted output array during the BFS traversal below.
const idToComponent = new Map(components.map((c) => [c.id, c]))

// Seed the queue with every component that has no intra-list
// prerequisites, then collect the final sorted sequence.
const queue = [...inDegree.entries()]
  .filter(([, deg]) => deg === 0)
  .map(([id]) => id)

// Breadth-First Search (BFS) pass of Kahn's algorithm.
// BFS explores the graph level by level using a FIFO queue: all
// nodes whose prerequisites are already satisfied are processed
// before unlocking the next wave of dependents. In each iteration,
// the front node is removed from the queue and appended to `sorted`
// (emitted). Its in-degree contribution is then subtracted from
// every successor; any successor whose in-degree reaches zero has
// had all its prerequisites emitted and is safe to enqueue next.
const sorted = []
while (queue.length > 0) {
  const id = queue.shift()
  sorted.push(idToComponent.get(id))
  for (const successorId of successors.get(id)) {
    const newDeg = inDegree.get(successorId) - 1
    inDegree.set(successorId, newDeg)
    if (newDeg === 0) {
      queue.push(successorId)
    }
  }
}

if (sorted.length !== components.length) {
  console.error('Circular dependency detected in cdlComponents!')
  process.exit(1)
}

xcdlJson.cdlComponents = sorted

// ----------------------------------------------------------------------------

console.log(`Parsing ${path.basename(packageJsonPath)}...`)
const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'))

// ----------------------------------------------------------------------------

const context = {
  libraryFilePath: xcdlJsoncPath,
  package: packageJson,
  xcdl: xcdlJson,
}

console.log()
console.log('Liquid "context":')
console.log(JSON.stringify(context, null, 2))

// ----------------------------------------------------------------------------

const liquidEngine = new Liquid({
  strictFilters: true,
  strictVariables: true,
  lenientIf: true,
})

const liquidSubstitute = (fromFilePath, toFilePath) => {
  const fromRelativeFilePath = path.relative(process.cwd(), fromFilePath)
  const toRelativeFilePath = path.relative(process.cwd(), toFilePath)
  console.log(`liquidjs ${fromRelativeFilePath} -> ${toRelativeFilePath}`)
  const templateContent = fs.readFileSync(fromFilePath, 'utf8')
  const renderedResult = liquidEngine.parseAndRenderSync(
    templateContent,
    context
  )
  fs.writeFileSync(toFilePath, renderedResult)
}

// ----------------------------------------------------------------------------

console.log()
console.log('generating files...')
console.log()

liquidSubstitute(
  path.resolve(scriptFolderPath, 'templates', 'CMakeLists-liquid.txt'),
  path.resolve(projectFolderPath, 'CMakeLists.txt')
)

if (skipMeson) {
  console.log('skipping meson.build (--skip-meson)')
} else {
  liquidSubstitute(
    path.resolve(scriptFolderPath, 'templates', 'meson-liquid.build'),
    path.resolve(projectFolderPath, 'meson.build')
  )
}

// ----------------------------------------------------------------------------

const scriptRelativePath = path.relative(process.cwd(), scriptPath)
const argvs = process.argv.slice(2).join(' ')

console.log()
console.log(`'node ${scriptRelativePath} ${argvs}' done`)

// ----------------------------------------------------------------------------
