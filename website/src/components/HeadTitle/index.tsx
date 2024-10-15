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

// import React from 'react';
import Head from '@docusaurus/Head';

/*
 * Use this component for plain titles, without the site title appended.
 */

export default function HeadTitle({title}): JSX.Element {
  return (
    <Head>
      <title>{title}</title>
      <meta property="og:title" content={title} />
    </Head>
  );
}
