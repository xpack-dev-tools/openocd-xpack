---
title: Getting Started with xPack OpenOCD

date: 2020-09-28 17:49:00 +0300

---

[![GitHub package.json version](https://img.shields.io/github/package-json/v/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/package.json)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/openocd.svg?color=blue)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)
[![license](https://img.shields.io/github/license/xpack-dev-tools/openocd-xpack)](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/LICENSE)

## Overview

**xPack OpenOCD** is a standalone cross-platform (Windows, macOS, GNU/Linux)
binary distribution of [OpenOCD](https://openocd.org),
intended for reproducible builds.

OpenOCD, the **Open On-Chip Debugger**, is an open source project hosted on
[SourceForge](http://sourceforge.net/p/openocd/code/).

**xPack OpenOCD** is an open source project hosted on GitHub as
[`xpack-dev-tools/openocd-xpack`](https://github.com/xpack-dev-tools/openocd-xpack);
it provides the platform specific binaries as
[release assets](https://github.com/xpack-dev-tools/openocd-xpack/releases).

In addition to the the binary archives and the package metadata,
this project also includes the
[build scripts](https://github.com/xpack-dev-tools/openocd-xpack/tree/xpack/scripts).

## Features

All binaries are:

- **self-contained** (include all required libraries)
- **file-system relocatable** (can be installed in any location).

Thus it is perfectly possible to install multiple versions concurrently on the
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
- an easy to use solution for **CI/CD** environments

## Compatibility

The **xPack OpenOCD** is fully compatible with the original **OpenOCD**
source distribution.

## Install

The binaries can be installed automatically as **binary xPacks** or manually as
**portable archives**.

The details of installing the **xPack OpenOCD** on various platforms are
presented in the separate
[Install Guide](/docs/install/) page.

## Documentation

The original OpenOCD documentation is available from the project web:

- https://openocd.org/pages/documentation.html [![PDF](/img/pdf-24.png)](https://openocd.org/doc/pdf/openocd.pdf)

## Release schedule

This distribution generally follows the official
[OpenOCD](https://openocd.org), with
additional releases based on the current Git form time to time.

## Support

The quick advice for getting support is to use the
[GitHub Discussions](https://github.com/xpack-dev-tools/openocd-xpack/discussions/).

For additional information, please refer to the
[Help Center](/docs/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/CHANGELOG.md) file.

## Maintainer & Developer info

For information on the workflow used to make releases, please see the
[Maintainer Info](/docs/maintainer-info/) page.

For information on how to build the binaries, please see the
[Developer Info](/docs/developer-info/) page.

However, the ultimate source for details are the build scripts themselves,
all available from the
[`openocd-xpack.git/scripts`](https://github.com/xpack-dev-tools/openocd-xpack/tree/xpack/scripts/)
folder. The scripts include common code from the [`@xpack-dev-tools/xbb-helper`](https://github.com/xpack-dev-tools/xbb-helper-xpack) package.

## License

Unless otherwise stated, the original content is released under the terms of the
[MIT License](https://opensource.org/licenses/mit/),
with all rights reserved to
[Liviu Ionescu](https://github.com/ilg-ul).

The binary distributions include several open-source components; the
corresponding licenses are available in the installed
`distro-info/licenses` folder.

## Releases

The list of releases is available in the [Releases](/docs/releases/) pages.
