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

import util from 'util';

// https://github.com/facebook/docusaurus/pull/9931

export default async function SelectReleasesPlugin(context, options) {
  return {
    name: 'select-releases',
    async allContentLoaded({ allContent, actions }) {

      const allBlogs = allContent['docusaurus-plugin-content-blog']
      // console.log('SelectReleasesPlugin 1 ' + util.inspect(allBlogs))

      const blogPosts = allBlogs.default.blogPosts
      // console.log('SelectReleasesPlugin 2 ' + util.inspect(blogPosts))

      const releasesTable = []
      blogPosts.forEach(post => {
        // console.log('SelectReleasesPlugin 3 ' + util.inspect(post.metadata.tags))
        post.metadata.tags.forEach(tag => {
          if (tag.label.toLowerCase() === 'releases') {
            const permalink = post.metadata.permalink.endsWith('/') ?
                              post.metadata.permalink :
                              post.metadata.permalink + '/'
            // console.log(permalink)
            releasesTable.push({
              title: post.metadata.title,
              permalink,
              downloadUrl: post.metadata.frontMatter['download_url']
            })
          }
        })
      })

      // console.log('SelectReleasesPlugin 4 ' + util.inspect(releasesTable))

      actions.setGlobalData({ releasesTable: releasesTable })
    },
  };
}
