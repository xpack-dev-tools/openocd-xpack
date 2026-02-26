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

import React from 'react';
import clsx from 'clsx';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import Heading from '@theme/Heading';
import HeadTitle from '@site/src/components/HeadTitle';

import styles from './index.module.css';
import HomepageFeatures from '@site/src/components/HomepageFeatures';
import InstallWithCopy from '@site/src/components/InstallWithCopy';

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero hero--primary', styles.heroBanner)}>
      <HeadTitle title="Welcome to the xPack OpenOCD!" />
      <div className="container">
        <Heading as="h1" className="hero__title">{siteConfig.title}</Heading>
        <p className="hero__subtitle">{siteConfig.tagline}
        <span className="margin-left-platforms">
          <span className="tagline-platform-windows"></span>
          <span className="tagline-platform-apple"></span>
          <span className="tagline-platform-linux"></span>
        </span>
        </p>
        <div className={styles.installWithCopy}>
          <InstallWithCopy>xpm install @xpack-dev-tools/openocd@0.12.0-7.1 --verbose</InstallWithCopy>
        </div>
      </div>
    </header>
  );
}

export default function Home(): JSX.Element {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout
      title="Welcome!"
      description={siteConfig.tagline} >
      <HomepageHeader />
      <main>
        <HomepageFeatures />
      </main>
    </Layout>
  );
}
