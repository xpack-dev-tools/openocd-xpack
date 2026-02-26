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

import pluginContentDocs from '@docusaurus/plugin-content-docs';
import { validateOptions as pluginContentDocsValidateOptions } from '@docusaurus/plugin-content-docs';

import pluginDoxygen from '@xpack/docusaurus-plugin-doxygen'
import { validateOptions as pluginDoxygenValidateOptions, extendCliGenerateDoxygen } from '@xpack/docusaurus-plugin-doxygen'

// ----------------------------------------------------------------------------

export function validateOptions({ validate, options }) {
  // console.log(options)

  // Split the options between the Docs plugin and the Doxygen plugin.
  const doxygenPluginOptions = options.doxygenPluginOptions ?? {}

  // Validate the Docs plugin options, with the Doxygen one removed.
  delete options.doxygenPluginOptions
  const actualDocsPluginOptions = pluginContentDocsValidateOptions({ validate, options })

  // Validate the Doxygen plugin options.
  const actualDoxygenPluginOptions = pluginDoxygenValidateOptions({ validate, options: doxygenPluginOptions })

  // Recompose the options. It will be split again below, during initialisation.
  const validatedOptions = {
    ...actualDocsPluginOptions,
    doxygenPluginOptions: actualDoxygenPluginOptions
  }

  // console.log(validatedOptions)
  return validatedOptions
}

// ----------------------------------------------------------------------------

export default async function pluginContentDocsWithDoxygenWrapper(context, options) {

  const doxygenPluginOptions = options.doxygenPluginOptions ?? {}
  // console.log(doxygenPluginOptions)

  delete options.doxygenPluginOptions
  // console.log(options)

  // Instantiate the original docs plugin.
  const pluginContentDocsInstance = await pluginContentDocs(context, options);

  // Instantiate the doxygen plugin.
  const pluginDoxygenInstance = await pluginDoxygen(context, doxygenPluginOptions);

  return {
    // Get all properties from the Docusaurus Docs plugin.
    ...pluginContentDocsInstance,

    // Extend the Docs plugin lifecycle method with the Doxygen plugin one.
    async loadContent() {
      // Run custom logic before to load Doxygen pages; ignore returned data
      await pluginDoxygenInstance.loadContent?.();

      const content = await pluginContentDocsInstance.loadContent?.();
      // console.log(content)

      // Return the Docs plugin content, it'll be processed in contentLoaded()
      return content;
    },

    // https://docusaurus.io/docs/api/plugin-methods/extend-infrastructure#extendCli
    extendCli(cli) {
      extendCliGenerateDoxygen(cli, context, doxygenPluginOptions)
    }

  };
}

// ----------------------------------------------------------------------------
