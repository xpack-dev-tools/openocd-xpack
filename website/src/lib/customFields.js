
/*
 * This file is part of the xPack project (http://xpack.github.io).
 * Copyright (c) 2024 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software
 * for any purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can
 * be obtained from https://opensource.org/licenses/MIT/.
 */

// import logger from '@docusaurus/logger'
// import { fileURLToPath } from 'url';
// import path from 'path'
// import fs from 'fs'

// export function _getCustomFields() {
//   const pwd = fileURLToPath(import.meta.url);
//   const filePath = path.join(path.dirname(path.dirname(path.dirname(path.dirname(pwd)))), 'package.json');
//   // logger.info(filePath);
//   const fileContent = fs.readFileSync(filePath);

//   const topPackageJson = JSON.parse(fileContent.toString());
//   const jsonVersion = topPackageJson.version.replace(".pre", "");

//   logger.info(topPackageJson.version)
//   // logger.info(jsonVersion)

//   const npmSubversion = jsonVersion.replace(/^.*[.]/, '')
//   // logger.info(npmSubversion)

//   const rest1 = jsonVersion.replace(/[.][0-9]*$/, '')
//   // logger.info(rest1)

//   const xpackSubversion = rest1.replace(/^.*[-]/, '')
//   // logger.info(xpackSubversion)

//   const upstreamVersion = rest1.replace(/[-][0-9]*$/, '')
//   // logger.info(upstreamVersion)

//   return {
//     jsonVersion,
//     upstreamVersion,
//     xpackSubversion,
//     npmSubversion,
//     version: upstreamVersion,
//     xpack_subversion: xpackSubversion,
//     npm_subversion: npmSubversion,
//   }
// }

export function getCustomFields() {
  return {
    upstreamVersion: '0.12.0',
    xpackSubversion: '3',
    npmSubversion: '1'
  }
}
