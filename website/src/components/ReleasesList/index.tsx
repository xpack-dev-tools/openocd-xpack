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

import {usePluginData} from '@docusaurus/useGlobalData';
import util from 'node:util';
import useBaseUrl from '@docusaurus/useBaseUrl';

export function ReleasesList({items}): JSX.Element {
  const pluginData = usePluginData('select-releases');

  pluginData.releasesTable.forEach((item) => console.log(`${item.permalink} - ${item.title}`))
  return (
    <ul>
      {
        pluginData.releasesTable.length > 0 ?
          pluginData.releasesTable.map(release => (
            <li>
              <a href={release.permalink}>{release.title}</a> {release.downloadUrl ? (<>(<a href={release.downloadUrl}>download</a>)</>) : (<></>)}
            </li>
          )) :
          (
            <li>
              none yet
            </li>
          )
      }
    </ul>
  )
}
