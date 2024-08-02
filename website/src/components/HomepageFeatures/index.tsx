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

import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

type FeatureItem = {
  title: string;
  Svg: React.ComponentType<React.ComponentProps<'svg'>>;
  description: JSX.Element;
};

const FeatureList: FeatureItem[] = [
  {
    title: 'Multi-version, cross-platform',
    Svg: require('@site/static/img/mosaic.svg').default,
    description: (
      <>
        By design, <b>multiple versions</b> of the same tools
        can be installed
        at the same time on the same system. <b>Windows</b>, <b>macOS</b>, <b>GNU/Linux</b> are
        supported. The tools include all
        required libraries and can be installed in any folder.
      </>
    ),
  },
  {
    title: 'Easy to Use & Reproducible',
    Svg: require('@site/static/img/check-badge.svg').default,
    description: (
      <>
        The xPack binaries can be added to projects
        as <b>development dependencies</b>,
        and conveniently installed with <code>xpm install</code>.
        This feature also ensures reproducibility, which is particularly
        beneficial in <b>CI/CD</b> environments.
      </>
    ),
  },
  {
    title: 'Part of the Node.js ecosystem',
    Svg: require('@site/static/img/globe.svg').default,
    description: (
      <>
        The <b>xpm</b> tool complements <b>npm</b> with
        several extra features specific to <b>C/C++ projects</b>.
        This allows the
        binary xPacks to nicely integrate into the Node.js ecosystem,
        while still allowing the binary archives to be installed manually.
      </>
    ),
  },
];

function Feature({title, Svg, description}: FeatureItem) {
  return (
    <div className={clsx('col col--4')}>
      { <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div> }
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures(): JSX.Element {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
