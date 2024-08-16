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

// import util from 'util'
// import logger from '@docusaurus/logger'

// https://github.com/facebook/docusaurus/pull/9931

export default async function SelectReleasesPlugin(context, options) {
  return {
    name: 'select-releases',
    async allContentLoaded({allContent, actions}) {

      const allBlogs = allContent['docusaurus-plugin-content-blog']
      // logger.info('SelectReleasesPlugin 1 ' + util.inspect(allBlogs))

      const blogPosts = allBlogs.default.blogPosts
      // logger.info('SelectReleasesPlugin 2 ' + util.inspect(blogPosts))

      const releasesTable = []
      blogPosts.forEach(post => {
        // logger.info('SelectReleasesPlugin 3 ' + util.inspect(post.metadata.tags))
        post.metadata.tags.forEach(tag => {
          if (tag.label === 'releases') {
            releasesTable.push({
              title: post.metadata.title,
              permalink: post.metadata.permalink,
              downloadUrl: post.metadata.frontMatter['download_url']
            })
          }
        })
      })

      // logger.info('SelectReleasesPlugin 4 ' + util.inspect(releasesTable))

      actions.setGlobalData({releasesTable: releasesTable})
    },
  };
}
