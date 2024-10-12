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

import Link from '@docusaurus/Link';

/* When updated, don't forget to add sitemap to robots.txt! */
const PrimaryTools = [
  {
    appName: 'GNU AArch64 Embedded GCC',
    appLcName: 'aarch64-none-elf-gcc'
  },
  {
    appName: 'GNU Arm Embedded GCC',
    appLcName: 'arm-none-eabi-gcc'
  },
  {
    appName: 'LLVM clang',
    appLcName: 'clang'
  },
  {
    appName: 'CMake',
    appLcName: 'cmake'
  },
  {
    appName: 'GCC',
    appLcName: 'gcc'
  },
  {
    appName: 'Meson Build',
    appLcName: 'meson-build'
  },
  {
    appName: 'MinGW-w64 GCC',
    appLcName: 'mingw-w64-gcc'
  },
  {
    appName: 'Ninja Build',
    appLcName: 'ninja-build'
  },
  {
    appName: 'OpenOCD',
    appLcName: 'openocd'
  },
  {
    appName: 'QEMU Arm',
    appLcName: 'qemu-arm'
  },
  {
    appName: 'QEMU RISC-V',
    appLcName: 'qemu-riscv'
  },
  {
    appName: 'GNU RISC-V Embedded GCC',
    appLcName: 'riscv-none-elf-gcc'
  },
  {
    appName: 'Windows Build Tools',
    appLcName: 'windows-build-tools'
  },
]

/* When updated, don't forget to add sitemap to robots.txt! */
const SecondaryTools = [
  {
    appName: 'GNU bison',
    appLcName: 'bison'
  },
  {
    appName: 'flex',
    appLcName: 'flex'
  },
  {
    appName: 'GNU m4',
    appLcName: 'm4'
  },
  {
    appName: 'NixOS PatchELF',
    appLcName: 'patchelf'
  },
  {
    appName: 'pkg-config',
    appLcName: 'pkg-config'
  },
  {
    appName: 'GNU realpath',
    appLcName: 'realpath'
  },
  {
    appName: 'GNU sed',
    appLcName: 'sed'
  },
  {
    appName: 'WineHQ',
    appLcName: 'wine'
  },
]

const WorkInProgressTools = [
  {
    appName: 'GNU Bash',
    appLcName: 'bash'
  },
  {
    appName: 'GNU texinfo',
    appLcName: 'texinfo'
  },
]

function Tool({ appName, appLcName }) {
  return (
    <>
      <div className="padding-vert--sm">
        <div>
          <b><Link to={'https://xpack-dev-tools.github.io/' + appLcName + '-xpack/'}>{appLcName}</Link></b> - <b>xPack {appName}</b>
        </div>
        <div className="padding-top--xs">
          <Link to={'https://github.com/xpack-dev-tools/' + appLcName + '-xpack/releases/'}><img alt="GitHub Release" src={'https://img.shields.io/github/v/release/xpack-dev-tools/' + appLcName + '-xpack'} /></Link>
          &nbsp;<Link to={'https://github.com/xpack-dev-tools/' + appLcName + '-xpack/releases/'}><img alt="GitHub Release Date" src={'https://img.shields.io/github/release-date/xpack-dev-tools/' + appLcName + '-xpack?label=date&color=YellowGreen'} /></Link>
          &nbsp;<Link to={'https://github.com/xpack-dev-tools/' + appLcName + '-xpack/releases/'}><img alt="GitHub Downloads (all assets, all releases)" src={'https://img.shields.io/github/downloads/xpack-dev-tools/' + appLcName + '-xpack/total.svg'} /></Link>
          &nbsp;<Link to={'https://github.com/xpack-dev-tools/' + appLcName + '-xpack/'}><img alt="GitHub Repo stars" src={'https://img.shields.io/github/stars/xpack-dev-tools/' + appLcName + '-xpack'} /></Link>
        </div>
      </div>
    </>
  )
}

function ToolWork({ appName, appLcName }) {
  return (
    <>
      <div>
        <b><Link to={'https://xpack-dev-tools.github.io/' + appLcName + '-xpack/'}>{appLcName}</Link></b> - <b>xPack {appName}</b>
      </div>
    </>
  )
}

function ToolsLeft() {
  return (
    <div className={clsx('col col--6')}>
      <div className="text--center padding-horiz--md padding-vert--lg">
        <Heading as="h2">Main Tools</Heading>
        {PrimaryTools.map((props, idx) => (
          <Tool {...props} />
        ))}
      </div>
    </div>
  );
}

function ToolsRight() {
  return (
    <div className={clsx('col col--6')}>
      <div className="text--center padding-horiz--md padding-vert--lg">
        <Heading as="h2">Supplementary Tools</Heading>
        {SecondaryTools.map((props, idx) => (
          <Tool {...props} />
        ))}
      </div>
      <hr className="hero__hr2" />
      <div className="text--center padding-horiz--md padding-vert--md">
        <Heading as="h2">Work in Progress</Heading>
        {WorkInProgressTools.map((props, idx) => (
          <ToolWork {...props} />
        ))}
      </div>
      <hr className="hero__hr2" />
      <div className="text--center padding-horiz--md padding-vert--md">
        <Heading as="h2">Internal</Heading>
        <b><Link to={'https://github.com/xpack-dev-tools/xbb-helper-xpack'}>xbb-helper</Link></b> - <b>xPack Build Helper</b>
      </div>
    </div>
  );
}

export default function HomepageTools(): JSX.Element {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row padding-bottom--lg">
          <ToolsLeft key={0} />
          <ToolsRight key={1} />
        </div>
      </div>
    </section>
  );
}
