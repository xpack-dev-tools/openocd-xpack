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

import { usePluginData } from '@docusaurus/useGlobalData';
import logger from '@docusaurus/logger'
import useBaseUrl from '@docusaurus/useBaseUrl';

export function ReleasesList({ items }): JSX.Element {
  const pluginData = usePluginData('select-releases');

  pluginData.releasesTable.forEach((item) => logger.info(item))
  return (
    <ul>
      {
        pluginData.releasesTable.map(release => (
          <li>
            <a href={ release.permalink }>{ release.title }</a> (<a href={ release.downloadUrl }>download</a>)
          </li>
        ))
      }
    </ul>
  )
}
