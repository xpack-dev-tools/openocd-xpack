---
title: The xPack OpenOCD

summary: "A binary distribution of OpenOCD"

date: 2020-09-28 17:49:00 +0300

---

[![GitHub package.json version](https://img.shields.io/github/package-json/v/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/package.json)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/openocd.svg?color=blue)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
[![license](https://img.shields.io/github/license/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/LICENSE)

## Overview

The **xPack OpenOCD** is a cross-platform binary distribution of
[OpenOCD](https://openocd.org),
an open source project hosted on
[SourceForge](http://sourceforge.net/p/openocd/code/).

## Features

All binaries are:

- **self-contained** (include all required libraries)
- **file-system relocatable**
(can be installed in any location).

It is perfectly possible to install multiple versions concurrently on the
same system, allowing different projects to be tied to specific versions.

## Benefits

The main advantages of using the **xPack OpenOCD** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure;
  the same procedure is used for all major
  platforms (**Intel Windows** 64-bit,
  **Intel GNU/Linux** 64-bit,
  **Arm GNU/Linux** 64/32-bit,
  **Intel macOS** 64-bit,
  **Apple Silicon macOS** 64-bit)
- a good integration with development environments (no need for Docker images)
- an easy to use solution for **CI** environments

## Compatibility

The **xPack OpenOCD** is fully compatible with the original **OpenOCD**
distribution.

## Install

The details of installing the **xPack OpenOCD** on various platforms are
presented in the separate
[Install](/docs/install/) page.

## Documentation

The original OpenOCD documentation is available in the project web:

- https://openocd.org/pages/documentation.html ([PDF](http://openocd.org/doc-release/pdf/openocd.pdf))

## Support

For the various support options, please read the separate
[Support](/docs/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the
[README-MAINTAINER](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-MAINTAINER.md)
page.
However, the ultimate source for details are the build scripts themselves,
all available from the
[`openocd-xpack.git/scripts`](https://github.com/xpack-dev-tools/openocd-xpack/tree/xpack/scripts/)
folder.

## Releases

The list of releases is available in the [Releases](/docs/releases/) pages.
